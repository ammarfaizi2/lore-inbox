Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751096AbVKNMDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbVKNMDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 07:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbVKNMDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 07:03:45 -0500
Received: from science.horizon.com ([192.35.100.1]:32839 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751096AbVKNMDp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 07:03:45 -0500
Date: 14 Nov 2005 07:03:37 -0500
Message-ID: <20051114120337.3088.qmail@science.horizon.com>
From: linux@horizon.com
To: ak@suse.de
Subject: Re: Balancing near the locking cliff, with some numbers
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> open:
> locks: 106 sems: 32 atomics: 50 rwlocks: 30 irqsaves: 89 barriers: 47
> read:
> locks: 52 sems: 0 atomics: 16 rwlocks: 12 irqsaves: 69 barriers: 11
> write:
> locks: 38 sems: 4 atomics: 20 rwlocks: 8 irqsaves: 42 barriers: 12
> page fault:
> locks: 4 sems: 2 atomics: 2 rwlocks: 0 irqsaves: 9 barriers: 0
> 
> open: open a file on ext3
> read: read a cache cold file from disk
> write: write a new file
> page fault: fault in an empty page

> It read random files from /usr/X11R6/bin to get something out of cache.
> The bin directory was likely all in dcache and the directory lpages in buffer 
> cache.

This is very interesting data, thank you!
This is using the standard IDE driver?
And the path names were absolute?

What would be really nice is a full trace of the locks acquired so we
can look for specific problems.  (I can see the OpenSolaris folks puffing
up to crow about dtrace already.)

Barring that, a few variants like hot-cache cases, different file systems
(includig tmpfs), and different device drivers would be informative.
(You could also try the different ext3 journalling modes.)


I'm not sre quite how you did this, but assuming you just installed global
counters via macros and ran the test by booting with init=, you could do
a bit better with a hook that would log 1000 filename/line number pairs,
stopping when the log was full, and another to read and clear the log.
