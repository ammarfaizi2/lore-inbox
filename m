Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbUCLBq3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 20:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbUCLBq3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 20:46:29 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:15118
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S261891AbUCLBq2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 20:46:28 -0500
Date: Fri, 12 Mar 2004 02:47:10 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Hugh Dickins <hugh@veritas.com>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       linux-kernel@vger.kernel.org
Subject: Re: anon_vma RFC2
Message-ID: <20040312014710.GO30940@dualathlon.random>
References: <20040311135608.GI30940@dualathlon.random> <Pine.LNX.4.44.0403112043420.2120-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0403112043420.2120-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 11, 2004 at 09:54:01PM +0000, Hugh Dickins wrote:
> Could you post a patch against 2.6.3 or 2.6.4?  Your objrmap patch

I uploaded my latest status, there are three patches, the first is
Dave's objrmap, the second is your anobjrmap-1, the third is my anon_vma
work that removes the pte_chains all over the kernel.

my patch is not stable yet, it crashes during swapping and the debugging
code catches bug even before swapping (which is good):

 0  0      0 404468  11900  41276    0    0     0     0 1095    61  0  0 100  0
 0  0      0 404468  11900  41276    0    0     0     0 1108    71  0  0 100  0
procs -----------memory---------- ---swap-- -----io---- --system-- ----cpu----
 r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy id wa
 1  0      0 404468  11908  41268    0    0     0   136 1102    59  0  0 100  0
 1  0      0 310972  11908  41268    0    0     0     0 1100    50  2  7 91  0
 1  0      0  66748  11908  41268    0    0     0     0 1085    30  6 19 75  0
 1  1    128   2648    216  14132    0  128     0   256 1118   139  3 16 73  8
 1  2  77084   1332    232   2188    0 76952   308 76952 1162   255  1 10 54 35

I hope to make it work tomorrow, then the next two things to do are the
pagetable walk in the nonlinear (currently it's pinned) and the rbtree
(or prio_tree) for the i_mmap{,shared}. Then it will be complete and
mergeable.

	http://www.us.kernel.org/pub/linux/kernel/people/andrea/patches/v2.6/2.6.3/objrmap
