Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266350AbUA2Tz4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jan 2004 14:55:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266354AbUA2Tzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jan 2004 14:55:55 -0500
Received: from gprs103-63.eurotel.cz ([160.218.103.63]:42370 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S266350AbUA2Tzs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jan 2004 14:55:48 -0500
Date: Thu, 29 Jan 2004 20:55:34 +0100
From: Pavel Machek <pavel@suse.cz>
To: Michael Schierl <schierlm@gmx.de>
Cc: Stephen Rothwell <fr@canb.auug.org.au>, linux-laptop@vger.kernel.org,
       linux-kernel@vger.kernel.org, mochel@digitalimplant.org
Subject: Re: [PATCH] [APM] Is this the correct way to fix suspend bug introduced in 2.6.0-test4?
Message-ID: <20040129195534.GH480@elf.ucw.cz>
References: <13zy7qdcyz1q7$.50e5l3rpbsyx$.dlg@40tude.net> <20040128174655.GE1200@elf.ucw.cz> <40195A95.C675952C@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40195A95.C675952C@gmx.de>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > if you think that's okay like that, please submit that to the guy who is
> > > responsible for 2.6 (is it Linus or Andrew? did not follow lkml
> > > recently).
> > 
> > Andrew.
> 
> Thanks. BTW: I did not get any response from Stephen Rothwell (the guy
> who is listed as maintainer for APM in the MAINTAINERS file). How long
> should I wait for a response? Or should I simply submit the patch to
> Andrew?

I'd submit patch to andrew, Cc: stephen. -mm series should get enough
testing, and this is not to big patch.

[The patch looks good to me, btw.]
									Pavel


> Michael
> --- linux-2.6.2-rc2-mm1/arch/i386/kernel/apm.c.old	Thu Jan 29 16:22:03 2004
> +++ linux-2.6.2-rc2-mm1/arch/i386/kernel/apm.c	Thu Jan 29 16:22:07 2004
> @@ -1201,6 +1201,7 @@ static int suspend(int vetoable)
>  	}
>  
>  	device_suspend(3);
> +	device_power_down(3);
>  
>  	/* serialize with the timer interrupt */
>  	write_seqlock_irq(&xtime_lock);
> @@ -1234,6 +1235,7 @@ static int suspend(int vetoable)
>  	if (err != APM_SUCCESS)
>  		apm_error("suspend", err);
>  	err = (err == APM_SUCCESS) ? 0 : -EIO;
> +	device_power_up();
>  	device_resume();
>  	pm_send_all(PM_RESUME, (void *)0);
>  	queue_event(APM_NORMAL_RESUME, NULL);
> @@ -1252,6 +1254,7 @@ static void standby(void)
>  {
>  	int	err;
>  
> +	device_power_down(3);
>  	/* serialize with the timer interrupt */
>  	write_seqlock_irq(&xtime_lock);
>  	/* If needed, notify drivers here */
> @@ -1261,6 +1264,7 @@ static void standby(void)
>  	err = set_system_power_state(APM_STATE_STANDBY);
>  	if ((err != APM_SUCCESS) && (err != APM_NO_ERROR))
>  		apm_error("standby", err);
> +	device_power_up();
>  }
>  
>  static apm_event_t get_event(void)


-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
