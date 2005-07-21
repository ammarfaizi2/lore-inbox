Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261759AbVGUTUZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261759AbVGUTUZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 15:20:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbVGUTUZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 15:20:25 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:56200 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261759AbVGUTUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 15:20:23 -0400
Date: Thu, 21 Jul 2005 21:20:15 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
Cc: B.Zolnierkiewicz@elka.pw.edu.pl,
       kernel list <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [RFT] solve "swsusp plays yoyo" with disks
Message-ID: <20050721192015.GA6367@atrey.karlin.mff.cuni.cz>
References: <20050705172953.GA18748@elf.ucw.cz> <42DFAD1C.80004@stud.feec.vutbr.cz> <42DFBFA8.5060800@stud.feec.vutbr.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42DFBFA8.5060800@stud.feec.vutbr.cz>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi!

> >>I'd like to get this tested under as many configurations as
> >>possible. With this, your hdd should no longer do "yoyo" (spindown,
> >>spinup, spindown) during suspend...
> >
> >
> >It looks like the patch is now in -mm (I use 2.6.13-rc3-mm1).
> >But my disks still yoyo during suspend. What more is needed? Some patch 
> >to ide-disk.c ?
> 
> I think I've found the problem.
> The attached patch stops the disks from spinning down and up on suspend.
> The patch applies to 2.6.13-rc3-mm1.
> 
> Signed-off-by: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>

Thanks, applied, I'll eventually propagate it.

							Pavel

> diff -Nurp -X dontdiff.new linux-mm/drivers/ide/ide-io.c linux-mm.mich/drivers/ide/ide-io.c
> --- linux-mm/drivers/ide/ide-io.c	2005-06-30 01:00:53.000000000 +0200
> +++ linux-mm.mich/drivers/ide/ide-io.c	2005-07-21 16:59:46.000000000 +0200
> @@ -150,7 +150,7 @@ static void ide_complete_power_step(ide_
>  
>  	switch (rq->pm->pm_step) {
>  	case ide_pm_flush_cache:	/* Suspend step 1 (flush cache) complete */
> -		if (rq->pm->pm_state == 4)
> +		if (rq->pm->pm_state == PM_EVENT_FREEZE)
>  			rq->pm->pm_step = ide_pm_state_completed;
>  		else
>  			rq->pm->pm_step = idedisk_pm_standby;


-- 
Boycott Kodak -- for their patent abuse against Java.
