Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVAMAij@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVAMAij (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:38:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261493AbVAMAf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:35:28 -0500
Received: from smtp100.rog.mail.re2.yahoo.com ([206.190.36.78]:49545 "HELO
	smtp100.rog.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S261393AbVAMAbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:31:34 -0500
From: Shawn Starr <shawn.starr@rogers.com>
Organization: sh0n.net
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [2.6.10][Suspend] - Time problems
Date: Wed, 12 Jan 2005 19:31:27 -0500
User-Agent: KMail/1.7.1
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
References: <200501110235.37039.shawn.starr@rogers.com> <200501122344.11508.rjw@sisk.pl> <20050112225011.GQ1408@elf.ucw.cz>
In-Reply-To: <20050112225011.GQ1408@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200501121931.27976.shawn.starr@rogers.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll just bump to 2.6.11-rc1, Rafael, not that one

In either case, it won't be a problem in a few moments. :)

Shawn.

On January 12, 2005 17:50, Pavel Machek wrote:
> Hi!
>
> > > > When resuming from suspend, I noticed the clock is waay off (its
> > > > 10:16pm,
> >
> > it
> >
> > > > shows 2:34AM EST time). This is even after a reboot the bios now
> > > > shows
> >
> > wrong
> >
> > > > time?
> > >
> > > Yes, see for example thread "2.6.10-mm2: swsusp regression
> > > [update]". Nigel has some patch that should fix it...
> >
> > Do you mean patches in the "[RFC] Patches to reduce delay in
> > arch/kernel/time.c" thread?
>
> I meant this one... (cut&pasted, apply by hand). But it seems to be
> included in 2.6.11-rc1. I'm now confused.
>         Pavel
>
> diff -ruNp 910-original-time-patch-old/arch/i386/kernel/time.c
> 910-original-time-patch-new/arch/i386/kernel/time.c
> --- 910-original-time-patch-old/arch/i386/kernel/time.c 2004-12-27
> +++ 910-original-time-patch-new/arch/i386/kernel/time.c 2005-01-08
> @@ -343,12 +343,13 @@ static int timer_resume(struct sys_devic
>                 hpet_reenable();
>  #endif
>         sec = get_cmos_time() + clock_cmos_diff;
> -       sleep_length = get_cmos_time() - sleep_start;
> +       sleep_length = (get_cmos_time() - sleep_start) * HZ;
>         write_seqlock_irqsave(&xtime_lock, flags);
>         xtime.tv_sec = sec;
>         xtime.tv_nsec = 0;
>         write_sequnlock_irqrestore(&xtime_lock, flags);
> -       jiffies += sleep_length * HZ;
> +       jiffies += sleep_length;
> +       wall_jiffies += sleep_length;
>         return 0;
>  }
