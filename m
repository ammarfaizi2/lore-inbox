Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261224AbSJQJ2q>; Thu, 17 Oct 2002 05:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261242AbSJQJ2q>; Thu, 17 Oct 2002 05:28:46 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:34940 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S261224AbSJQJ2p>; Thu, 17 Oct 2002 05:28:45 -0400
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] 2.5.42+ reboot kills Dell Latitude keyboard
References: <15790.30657.234936.840909@kim.it.uu.se>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 17 Oct 2002 03:32:11 -0600
In-Reply-To: <15790.30657.234936.840909@kim.it.uu.se>
Message-ID: <m1zntd1kdg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mikael Pettersson <mikpe@csd.uu.se> writes:

> Dell Latitude CPi laptop. Boot 2.5.42 or .43, then reboot.
> Shortly after the screen is blanked and the BIOS starts, it
> prints a "keyboard error" message and requests an F1 or F2
> response (continue or go into SETUP). Never happened with any
> other kernel on that machine.
> 
> Apparently the 2.5.42+ "let's shut everything down at reboot"
> change

There was no such change just a discussion of what the kernel
has been doing since 2.5.8 or so.

> put the keyboard controller in a state which is inconsistent
> with the BIOS' expections at a warm boot.

There is a bug in device_suspend.  device_shutdown, and device_suspend
where merged and the POWER_DOWN case now removes the drivers which
is a bug.  You may be getting hit with that.

Eric Blade has posed a patch fixing that.

Or else there is a change in the ->remove() method of one your drivers.

> 
> First the disks-spun-down-at-reboot bug and now this. Sigh.

Someone implemented that in the IDE driver deliberately.  I haven't
a clue why but it happened.

Eric
