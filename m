Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317967AbSFSSWF>; Wed, 19 Jun 2002 14:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317968AbSFSSWE>; Wed, 19 Jun 2002 14:22:04 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:40159 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317967AbSFSSWD>;
	Wed, 19 Jun 2002 14:22:03 -0400
Date: Wed, 19 Jun 2002 20:21:47 +0200
From: Jens Axboe <axboe@suse.de>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Martin Dalecki <dalecki@evision-ventures.com>
Subject: Re: Oops on 2.5.23 and IDE
Message-ID: <20020619182147.GG812@suse.de>
References: <Pine.LNX.4.44.0206191810310.1263-100000@netfinity.realnet.co.sz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0206191810310.1263-100000@netfinity.realnet.co.sz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 19 2002, Zwane Mwaikambo wrote:
> Hi Martin,
> 	IDE seems to be doing odd things.
> 
> >>EIP; c0117318 <schedule+28/4f0>   <=====
> Trace; c0117c6a <wait_for_completion+11a/1d0>
> Trace; c0117820 <default_wake_function+0/40>
> Trace; c0117820 <default_wake_function+0/40>
> Trace; c022e1ae <ide_do_drive_cmd+18e/1b0>
> Trace; c01bc082 <vsnprintf+2a2/420>
> Trace; c022e439 <ide_raw_taskfile+59/60>
> Trace; c02302f4 <do_recalibrate+54/70>
> Trace; c022e1d0 <special_intr+0/210>
> Trace; c0234e75 <ide_dma_intr+115/120>
> Trace; c0231138 <ata_irq_request+148/230>
> Trace; c0234d60 <ide_dma_intr+0/120>
> 
> 
> int ide_do_drive_cmd()
> {
> [...]
> 	if (action == ide_wait) {
>                 wait_for_completion(&wait);     /* wait for it to be serviced */
>                 return rq->errors ? -EIO : 0;   /* return -EIO if errors */
>         }
> [...]
> }
> 
> Was that function really designed to be called from interrupt context?

With action other than ide_wait sure, using ide_wait of course not.

-- 
Jens Axboe

