Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266218AbUH3Ei4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266218AbUH3Ei4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 00:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266281AbUH3Ei4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 00:38:56 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:53489 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S266218AbUH3Eiz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 00:38:55 -0400
Date: Mon, 30 Aug 2004 00:43:17 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Matt Mackall <mpm@selenic.com>, Andi Kleen <ak@suse.de>
Subject: [PATCH][0/3] Completely out of line spinlocks (i386, x86_64)
Message-ID: <Pine.LNX.4.58.0408292257190.24992@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-- from previous announce --
Pulled from the -tiny tree, the focus of this patch is for reduced kernel
image size but in the process we benefit from improved cache performance
since it's possible for the common text to be present in cache. This is
probably more of a win on shared cache multiprocessor systems like
P4/Xeon HT. It's been benchmarked with bonnie++ on 2x and 4x PIII (my
ideal target would be a 4x+ logical cpu Xeon).

Changes have been made based on feedback from various people, most notably
profiling support for readprofile and oprofile.
--

Changes from the last release include using fastcall and normal C
functions for the out of line spinlock code. There was an additional
suggestion by Linus to move the preempt code out of line too but i think
that may be too invasive for this first step.

Results from a dbench run on 2, 4 and 8x systems are available at
http://www.zwane.ca/cool-locks-stp but based on those results there is no
observable performance regression.

Size differences on x86_64:
   text    data     bss     dec     hex filename
4864192 1452156  523632 6839980  685eac vmlinux-after
4881677 1449436  523632 6854745  689859 vmlinux-before

Size differences on i386:
   text    data     bss     dec     hex filename
6287428  868142  326864 7482434  722c42 vmlinux-after
6321421  871138  326864 7519423  72bcbf vmlinux-before
