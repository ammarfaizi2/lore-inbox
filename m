Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268286AbTCFSCB>; Thu, 6 Mar 2003 13:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268290AbTCFSCA>; Thu, 6 Mar 2003 13:02:00 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:18113 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S268281AbTCFSB4>; Thu, 6 Mar 2003 13:01:56 -0500
Date: Thu, 6 Mar 2003 10:14:09 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: James Bottomley <James.Bottomley@SteelEye.com>, Andries.Brouwer@cwi.nl,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
Message-ID: <20030306181408.GC1203@beaverton.ibm.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	James Bottomley <James.Bottomley@SteelEye.com>,
	Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org,
	SCSI Mailing List <linux-scsi@vger.kernel.org>
References: <20030306083054.GB1503@beaverton.ibm.com> <Pine.LNX.4.50.0303060331030.25282-100000@montezuma.mastecende.com> <20030306085506.GB2222@beaverton.ibm.com> <Pine.LNX.4.50.0303060354550.25282-100000@montezuma.mastecende.com> <20030306091824.GA2577@beaverton.ibm.com> <Pine.LNX.4.50.0303060455560.25282-100000@montezuma.mastecende.com> <1046968304.1746.20.camel@mulgrave> <Pine.LNX.4.50.0303061213400.25282-100000@montezuma.mastecende.com> <1046971303.1998.23.camel@mulgrave> <Pine.LNX.4.50.0303061238210.25282-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303061238210.25282-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo [zwane@linuxpower.ca] wrote:
> On Thu, 6 Mar 2003, James Bottomley wrote:
> 
> > Actually, all three if's need nots in front:
> > 
> > diff -Nru a/drivers/scsi/scsi_error.c b/drivers/scsi/scsi_error.c
> > --- a/drivers/scsi/scsi_error.c	Thu Mar  6 11:21:22 2003
> > +++ b/drivers/scsi/scsi_error.c	Thu Mar  6 11:21:22 2003
> > @@ -1490,9 +1490,9 @@
> >  			       struct list_head *work_q,
> >  			       struct list_head *done_q)
> >  {
> > -	if (scsi_eh_bus_device_reset(shost, work_q, done_q))
> > -		if (scsi_eh_bus_reset(shost, work_q, done_q))
> > -			if (scsi_eh_host_reset(work_q, done_q))
> > +	if (!scsi_eh_bus_device_reset(shost, work_q, done_q))
> > +		if (!scsi_eh_bus_reset(shost, work_q, done_q))
> > +			if (!scsi_eh_host_reset(work_q, done_q))
> >  				scsi_eh_offline_sdevs(work_q, done_q);
> >  }
> 
> Ok patched 2.5.63 is back to booting as 2.5.62, would you like any more 
> information?
> 

I believe we have all the information we need.

Thanks for sending the previous data and trying the patch.

I still need to understand the error signature for Andries as it sounds
different then what you are seeing.

-andmike
--
Michael Anderson
andmike@us.ibm.com

