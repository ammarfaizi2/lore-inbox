Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261715AbSJMUiQ>; Sun, 13 Oct 2002 16:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261736AbSJMUiQ>; Sun, 13 Oct 2002 16:38:16 -0400
Received: from h-64-105-34-19.SNVACAID.covad.net ([64.105.34.19]:23169 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261715AbSJMUiP>; Sun, 13 Oct 2002 16:38:15 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 13 Oct 2002 13:44:01 -0700
Message-Id: <200210132044.NAA02608@baldur.yggdrasil.com>
To: eblade@blackmagik.dynup.net
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend device
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Blade wrote:
>On Sun, 2002-10-13 at 15:24, Adam J. Richter wrote:
>>        [...] I think the new behavior in IDE
>> of spinning down the hard drives on suspend is correct.  The problem
>> is that the warm reboot system call is trying to suspend all of the
>> devices before a warm reboot for no reason.  [...]

>Adam,
>  I'm not sure the proper thing to do is necessarily remove the
>device_shutdown() call.

	If, by this, you are saying that you have in mind some reason
why this should not be done, then please explain.

>  Please try this patch [...]

	Your patch does not apply and I don't see how renaming
a constant in essentially every place that it is referenced would
change the behavior of the code in a way releveant to the problem
that I described.

	I don't see a problem with device_shutdown spinning down the
IDE hard disks.  What I have a problem with, and what my patch fixes,
is the relatively new behavior of the warm reboot system call calling
device_shutdown.  Why was this added?  The reboot notifier chain is
already called for devices that need some preparation before it is
safe to reboot or halt.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
