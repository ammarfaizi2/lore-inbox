Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030424AbVIAV45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030424AbVIAV45 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 17:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030426AbVIAV45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 17:56:57 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:56967 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030425AbVIAV45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 17:56:57 -0400
Date: Thu, 1 Sep 2005 23:56:49 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: [PATCH 0/10] m68k/thread_info merge
Message-ID: <Pine.LNX.4.61.0509012211010.8099@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch series brings the m68k closer to a working state. It consists 
of two basic parts, the first five patches do the minimal changes to get 
m68k compiling in mainline, the last five patches do a cleanup of the 
kernel API.

The patches are against -mm, but the only conflict for the second patch to 
mainline is caused by this change in sched-cleanups.patch:

-		unsigned long * n = (unsigned long *) (p->thread_info+1);
+		unsigned long *n = (unsigned long *) (p->thread_info+1);

so either way it's easy to deal with.

The first four patches were done by Al and I mostly fixed the m68k 
specific parts, the other changes are:
patch 2: Rename setup_thread_info into setup_thread_stack to better 
reflect what it really does and adjust the arguments to reduce ordering 
requirements.
patch 3: move the thread_info.h include to preempt.h as this is the one 
that needs current_thread_info().

The second part reduces the role of thread_info and makes the thread stack 
more visible. The main change of these patches is the change from the 
thread_info to the stack field in task_struct to abstract away the direct 
access to the thread_info. I have been very careful with these changes 
(e.g. I manually reverted the patches and compared the result to prevent 
typos), so I'm quite sure these patches don't introduce any new problems.

There is one final patch pending to remove the thread_info field (and fix 
the users only in -mm), I'll send it when the other patches have been 
merged with an extra warning to linux-arch, so archs can catch up with the 
changes, if they should have larger unmerged patches. This is the only 
patch which could produce compile problem in case I might have missed 
something, but these will be easy to deal with.

bye, Roman
