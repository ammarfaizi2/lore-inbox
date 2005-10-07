Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbVJGOVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbVJGOVj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 10:21:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932667AbVJGOVj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 10:21:39 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43672 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S932666AbVJGOVi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 10:21:38 -0400
Date: Fri, 7 Oct 2005 10:21:17 -0400 (EDT)
From: Steven Rostedt <rostedt@goodmis.org>
X-X-Sender: rostedt@localhost.localdomain
To: Michael Tokarev <mjt@tls.msk.ru>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel freeze (not even an OOPS) on remount-ro+umount when using
 quotas
In-Reply-To: <4346747C.2080903@tls.msk.ru>
Message-ID: <Pine.LNX.4.58.0510071017550.7222@localhost.localdomain>
References: <4346747C.2080903@tls.msk.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 7 Oct 2005, Michael Tokarev wrote:

> This is something that has biten me quite successefully
> in last few days... ;)
>
> To make a long story short:
>
>  # mke2fs -j /dev/hda6
>  # mount -o usrquota /dev/hda6 /mnt
>  # cp -a /home /mnt                # to make some files to work with
>  # quotacheck -uc /mnt
>  # quotaon /mnt
>  # mount -o remount,ro             # this is the important step!
>  # ls -l /mnt /mnt/home            # to do "something" (also important)
>  # umount /mnt
>
> At this time (attempting to umount the read-only filesystem with quotas
> enabled), the machine freezes without any messages on the console.  No
> OOPS, no response, no nothing - until a hard reboot (powercycle).
>
> This happens on 2.6.11, 2.6.12 and 2.6.13 kernels -- ie, with "current"
> kernel release.
>

I just tried this on 2.6.13.1 and was not able to reproduce your hangup.
Have you tried turning on the nmi watchdog with "nmi_watchdog=2 lapic"?

If this blocks interrupts while it spins, you might be able to see what's
happening.  Also if interrupts are not blocked, try out sysrq-t and
friends.

-- Steve

