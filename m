Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268150AbTCFRHl>; Thu, 6 Mar 2003 12:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268147AbTCFRHg>; Thu, 6 Mar 2003 12:07:36 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:4446
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S268131AbTCFRHc>; Thu, 6 Mar 2003 12:07:32 -0500
Date: Thu, 6 Mar 2003 12:15:44 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Mike Anderson <andmike@us.ibm.com>, "" <Andries.Brouwer@cwi.nl>,
       "" <torvalds@transmeta.com>, "" <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
In-Reply-To: <1046968304.1746.20.camel@mulgrave>
Message-ID: <Pine.LNX.4.50.0303061213400.25282-100000@montezuma.mastecende.com>
References: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl>
 <20030306064921.GA1425@beaverton.ibm.com>
 <Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com>
 <20030306083054.GB1503@beaverton.ibm.com>
 <Pine.LNX.4.50.0303060331030.25282-100000@montezuma.mastecende.com>
 <20030306085506.GB2222@beaverton.ibm.com>
 <Pine.LNX.4.50.0303060354550.25282-100000@montezuma.mastecende.com>
 <20030306091824.GA2577@beaverton.ibm.com> 
 <Pine.LNX.4.50.0303060455560.25282-100000@montezuma.mastecende.com>
 <1046968304.1746.20.camel@mulgrave>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, James Bottomley wrote:

> This log implies the error handling finished after the BDR.  That looks
> like the system doesn't have Mike's latest patch for the logic reversal
> problem in scsi_eh_ready_devs, could you check this?

static void scsi_eh_ready_devs(struct Scsi_Host *shost,
                              struct list_head *work_q,
                              struct list_head *done_q)
{
       if (scsi_eh_bus_device_reset(shost, work_q, done_q))
               if (scsi_eh_bus_reset(shost, work_q, done_q))
                       if (scsi_eh_host_reset(work_q, done_q))
                               scsi_eh_offline_sdevs(work_q, done_q);
}

That is what i currently have, i'll try a boot with;

-               if (scsi_eh_bus_reset(shost, work_q, done_q))
+               if (!scsi_eh_bus_reset(shost, work_q, done_q))

Thanks,
	Zwane
-- 
function.linuxpower.ca
