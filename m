Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbSJQOL4>; Thu, 17 Oct 2002 10:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261703AbSJQOL4>; Thu, 17 Oct 2002 10:11:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51324 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261690AbSJQOLr>; Thu, 17 Oct 2002 10:11:47 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: ebiederm@xmission.com (Eric W. Biederman), linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.42+ reboot kills Dell Latitude keyboard
References: <15790.30657.234936.840909@kim.it.uu.se>
	<m1zntd1kdg.fsf@frodo.biederman.org>
	<15790.40045.655146.814922@kim.it.uu.se>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Oct 2002 08:14:50 -0600
In-Reply-To: <15790.40045.655146.814922@kim.it.uu.se>
Message-ID: <m1n0pd17ad.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Eric W. Biederman writes:
>  > Mikael Pettersson <mikpe@csd.uu.se> writes:
>  > 
>  > > Dell Latitude CPi laptop. Boot 2.5.42 or .43, then reboot.
>  > > Shortly after the screen is blanked and the BIOS starts, it
>  > > prints a "keyboard error" message and requests an F1 or F2
>  > > response (continue or go into SETUP). Never happened with any
>  > > other kernel on that machine.
>  > > 
>  > > Apparently the 2.5.42+ "let's shut everything down at reboot"
>  > > change
>  > 
>  > There was no such change just a discussion of what the kernel
>  > has been doing since 2.5.8 or so.
>  > 
>  > > put the keyboard controller in a state which is inconsistent
>  > > with the BIOS' expections at a warm boot.
>  > 
>  > There is a bug in device_suspend.  device_shutdown, and device_suspend
>  > where merged and the POWER_DOWN case now removes the drivers which
>  > is a bug.  You may be getting hit with that.
>  > 
>  > Eric Blade has posed a patch fixing that.
> 
> I tried Eric Blade's patch
> <http://marc.theaimsgroup.com/?l=linux-kernel&m=103477012517984&w=2>
> but it didn't make any difference. Same keyboard error as before.
> 
> So either the patch doesn't change what actions are taken on reboot,

Correctly only what actions are taken before reboot, are changed.

> or the keyboard (std SERIO_I8042 + ATKBD PC stuff) driver was also
> broken in the 2.5.41->2.5.42 step.

There is something in the ChangeLog about fixing the keyboard reboot
case.  I don't see where the code changes in the patch but the
keyboard code was touched quite a bit.

So I suspect the keyboard driver also does the wrong thing for
you in this case.

Eric
