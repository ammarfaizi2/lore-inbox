Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261855AbTA1Xc3>; Tue, 28 Jan 2003 18:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTA1Xc3>; Tue, 28 Jan 2003 18:32:29 -0500
Received: from air-2.osdl.org ([65.172.181.6]:12672 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261855AbTA1Xc2>;
	Tue, 28 Jan 2003 18:32:28 -0500
Subject: [PATCH] (0/4) 2.5.59 fast reader/writer lock for gettimeofday
From: Stephen Hemminger <shemminger@osdl.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andrew Morton <akpm@digeo.com>, Andrea Arcangeli <andrea@suse.de>,
       Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: Open Source Devlopment Lab
Message-Id: <1043797302.10150.298.camel@dell_ss3.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 28 Jan 2003 15:41:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 The following set of patches provides a faster specialized
reader/writer primitive which then is used to provide lockless
version of gettimeofday. It is an update to my earlier patch
(http://lwn.net/Articles/7388/) based on feed back from Andrea Arcangeli
in the 2.4-aa kernel and Andrew Morton in 2.5.59-mm6.

This solves the denial-of-service problem of repeated gettimeofday
readers, starving timer tick update. This has been observed by several
people.

As an added benefit, it improves the performance of gettimeofday by 18%
from 1100 clocks to 900 clocks (on my SMP P4 Xeon) using the sysenter
version of glibc.

This mechanism is general. There has been some discussion
that it could also be used to solve the problem
of atomic updates to composite values like i_size.

Please consider including this for 2.5.  The patch is broken into
generic, i386, ia64, and other archiecture pieces.  The i386 and ia64 
versions have been tested.  The other arch's are simple edits.  x86_64
has NOT been done, but this could replace the vxtime[] sequence number
there.

Thanks

--
Stephen Hemminger <shemminger@osdl.org>
Open Source Devlopment Lab

