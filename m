Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964893AbWBUWvV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964893AbWBUWvV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 17:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964890AbWBUWvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 17:51:21 -0500
Received: from courier.cs.helsinki.fi ([128.214.9.1]:18662 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S964888AbWBUWvF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 17:51:05 -0500
Subject: Re: 2.6.16-rc4: known regressions
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Greg KH <gregkh@suse.de>
Cc: Adrian Bunk <bunk@stusta.de>, Robert Love <rml@novell.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>, kay.sievers@suse.de
In-Reply-To: <20060220010205.GB22738@suse.de>
References: <Pine.LNX.4.64.0602171438050.916@g5.osdl.org>
	 <20060217231444.GM4422@stusta.de>
	 <84144f020602190306o3149d51by82b8ccc6108af012@mail.gmail.com>
	 <20060219145442.GA4971@stusta.de> <1140383653.11403.8.camel@localhost>
	 <20060220010205.GB22738@suse.de>
Date: Wed, 22 Feb 2006 00:51:01 +0200
Message-Id: <1140562261.11278.6.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.4.2.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-02-19 at 17:02 -0800, Greg KH wrote:
> If you revert this one patch, on top of a clean 2.6.16-rc4, do things
> start working for you again?

Okey dokey, bisecting with mrproper took little longer than expected but
I found the bad changeset:

033b96fd30db52a710d97b06f87d16fc59fee0f1 is first bad commit
diff-tree 033b96fd30db52a710d97b06f87d16fc59fee0f1 (from 0f76e5acf9dc788e664056dda1e461f0bec93948)
Author: Kay Sievers <kay.sievers@suse.de>
Date:   Fri Nov 11 06:09:55 2005 +0100

    [PATCH] remove mount/umount uevents from superblock handling

    The names of these events have been confusing from the beginning
    on, as they have been more like claim/release events. We needed these
    events for noticing HAL if storage devices have been mounted.

    Thanks to Al, we have the proper solution now and can poll()
    /proc/mounts instead to get notfied about mount tree changes.

    Signed-off-by: Kay Sievers <kay.sievers@suse.de>
    Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

:040000 040000 0397ffe6fdbffa290e2d22f5f59c5a8cc2861ef0 44e4df27174f1dfb125481f9ce4471edaa93c57d M      fs
:040000 040000 94178115d8c608d6247bed322efeddf19047ad99 55655fc60af26aed51a7d3ddee452c859ec3c501 M      include
:040000 040000 40bd1625895ddca1d39381887587f4465abed222 397331a2cd3077cd3f41901f4af74ab6ad3fb13a M      lib

Reverting the above from yesterday's git head fixes the problem for me
and I get my Ipod icon in Gnome again. I am running udev 079, dbus 060,
hal 0.5.5.1, and gnome-volume-manager 1.5.4 on Gentoo/x86. The patch
should probably be reverted for 2.6.16 because it breaks userspace.

				Pekka

