Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261228AbVFGELs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261228AbVFGELs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 00:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261690AbVFGELs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 00:11:48 -0400
Received: from magic.adaptec.com ([216.52.22.17]:1485 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S261228AbVFGELq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 00:11:46 -0400
Date: Tue, 7 Jun 2005 09:53:26 +0530 (IST)
From: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
X-X-Sender: tomar@localhost.localdomain
Reply-To: "Tomar, Nagendra" <nagendra_tomar@adaptec.com>
To: linux-kernel@vger.kernel.org
cc: linux-arm-kernel@lists.arm.linux.org.uk
Subject: Zeroed pages returned for heap
Message-ID: <Pine.LNX.4.44.0506070936530.4569-100000@localhost.localdomain>
Organization: Adaptec
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 07 Jun 2005 04:11:20.0296 (UTC) FILETIME=[F58BCE80:01C56B16]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
	The short version first.
Is it OK for an application (a C library implementing malloc/calloc is 
also an application) to assume that the pages returned by the OS for heap 
allocation (either directly thru brk() or thru mmap(MAP_ANONYMOUS)) will 
be zero filled. 

Now a lengthier version.

Linux zero fills all anonymous pages on allocation. This is _required_ for 
the C program BSS sections but _not_ _really_ required for heap pages. For 
heap pages the kernel zero fills them to avoid leaking any important 
information to users. On my target platform (Xscale) the memory access is 
such a big evil that I am constantly thinking of ways to avoid touching 
the damned memory as much as possible without any adverse effect on the 
kernel and applications behaviour. 
	One such way which I want to exploit is to not zero fill the heap 
pages (since mine is an embedded hardware, I do not care much abt leaking 
information out to users), since profiling has shown that the 
xscale_mc_clear_user_page function is taking lots of CPU time. When I 
implement that I see that few applications namely gcc and awk break. It 
seems that either the application or the C library is assuming about the 
pages returned by brk()/MAP_ANON, probably to improve calloc() efficiency 
( I'm not 100% sure on that as I've not yet looked at the code).
For testing I implemented this on x86 first and could boot the complete 
kernel and was able to start X, only that gcc used to crash.

I'll highly appreciate any informative views on this.

Thanx,
Tomar



-- You have moved the mouse. Windows must be restarted for the 
   changes to take effect.

