Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261788AbUK2Ukv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261788AbUK2Ukv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 15:40:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUK2Ukv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 15:40:51 -0500
Received: from gprs214-92.eurotel.cz ([160.218.214.92]:18569 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261788AbUK2Ukt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 15:40:49 -0500
Date: Mon, 29 Nov 2004 21:40:37 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc1 broke apmd
Message-ID: <20041129204037.GA3867@elf.ucw.cz>
References: <200411291138.iATBcBiR007342@harpo.it.uu.se> <20041129125313.GB3291@elf.ucw.cz> <16811.11073.511847.968733@alkaid.it.uu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16811.11073.511847.968733@alkaid.it.uu.se>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

>  > > Starting with 2.6.10-rc1, date and time on my old APM-based
>  > > laptop is messed up after a resume. Specifically, Emacs and
>  > > xclock both make a huge forward leap and then stop updating
>  > > their current time displays.
>  > > 
>  > > The cause is the "jiffies += sleep_length * HZ;" addition
>  > > to arch/i386/kernel/time.c:time_resume() which is in conflict
>  > > with the hwlock --hctosys that the APM daemon normally does
>  > > at resume.
>  > 
>  > I do not understand why they interfere... time_resume should fix
>  > system time, then userland sets it to the right value, again. Unless
>  > these two happen in paralel (they should not), nothing bad should happen.
>  > 
>  > Can you try to suspend, wait, launch hwclock --hctosys manually?
> 
> I disabled apmd's automatic hwlock --hctosys and ran it manually
> after resume + 5 seconds: no problem. I suspect that apmd runs
> really early at resume and that's why it interferes with time_resume.

You may workaround it be sleep 1 before hwclock --hctosys, I
guess. But debugging it would be even better :-). Do we freeze
processes during apm suspend? If not, we should...
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
