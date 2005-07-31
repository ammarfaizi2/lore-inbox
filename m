Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261896AbVGaVKt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261896AbVGaVKt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 17:10:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261906AbVGaVKt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 17:10:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:17594 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261896AbVGaVKr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 17:10:47 -0400
Date: Sun, 31 Jul 2005 23:10:20 +0200
From: Pavel Machek <pavel@ucw.cz>
To: James Bruce <bruce@andrew.cmu.edu>
Cc: Lee Revell <rlrevell@joe-job.com>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Power consumption HZ100, HZ250, HZ1000: new numbers
Message-ID: <20050731211020.GB27433@elf.ucw.cz>
References: <20050730004924.087a7630.Ballarin.Marc@gmx.de> <1122678943.9381.44.camel@mindpipe> <20050730120645.77a33a34.Ballarin.Marc@gmx.de> <1122746718.14769.4.camel@mindpipe> <20050730195116.GB9188@elf.ucw.cz> <1122753864.14769.18.camel@mindpipe> <20050730201049.GE2093@elf.ucw.cz> <42ED32D3.9070208@andrew.cmu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42ED32D3.9070208@andrew.cmu.edu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >First numbers were 0.5W on idle system; that shows what kind of
> >powersaving can be done. Powersaving is no longer possible when artsd
> >is not running, but that should not be used as argument against it.
> 
> It was an idle system with no display, zero daemons running, and the 
> hard drive off.  In other words, a machine that nobody could use which 
> might as well be hibrinating.  While it was an important test to find 
> out the most one could hope to save, its unrealistic for an actual usage 
> case.  The later test was more realistic, and not suprisingly showed 
> quite a bit less power savings.

Then the second test was probably flawed, possibly because we have
some more work to do. No display is irrelevant, HZ=100 will still save
0.5W with running display. Spinning disk also does not produce CPU
load (and we *will* want to have disk spinned down). No daemons... if
some daemon wakes every msec, we want to fix the daemon. 

> I really like having 250HZ as an _option_, but what I don't see is why 
> it should be the _default_.  I believe this is Lee's position as
> Last I checked, ACPI and CPU speed scaling were not enabled by default; 

Kernel defaults are irelevant; distros change them anyway. [But we
probably want to enable ACPI and cpufreq by default, because that
matches what 99% of users will use.]

> I have a fixed-framerate app that had to busywait in the days of 2.4.x. 
>  It was nice in 2.6.x to not have to busywait, but with 250HZ that code 
> will be coming back again.  And unfortunately this app can't be made 
> variable-framerate, as it is simulating video hardware.  The same goes 
> for apps playing movies/animations; Sometimes programs just need a 
> semi-accurate sleep, and can't demand root priveledges to get it.

I really don't think default HZ in kernel config is such a big
deal. You'll want to support HZ=100 on 2.6.X, anyway...

> In a sense I feel this whole thing boils down to the fact that we don't 
> have something like "make laptop-config" and "make server-config".  I'm 
> glad we could save 5.2% of the power for a laptop user by changing
> the 

defconfig on i386 is Linus' configuration. Maybe server-config and
laptop-config would be good idea...
								Pavel
-- 
if you have sharp zaurus hardware you don't need... you know my address
