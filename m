Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265514AbSJaXxB>; Thu, 31 Oct 2002 18:53:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265512AbSJaXwj>; Thu, 31 Oct 2002 18:52:39 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:977 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265490AbSJaXvK>;
	Thu, 31 Oct 2002 18:51:10 -0500
Date: Thu, 31 Oct 2002 15:52:25 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
cc: mingo@elte.hu, Erich Focht <efocht@ess.nec.de>
Subject: Re: [PATCH 2.5.45] NUMA Scheduler  (1/2)
Message-ID: <1010470000.1036108344@flay>
In-Reply-To: <1036107098.21647.104.camel@dyn9-47-17-164.beaverton.ibm.com>
References: <1036107098.21647.104.camel@dyn9-47-17-164.beaverton.ibm.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Erich Focht has written scheduler extensions in support of
> NUMA systems.  These extensions are being used at customer
> sites.  I have branched off and done some similar NUMA scheduler
> extensions, though on a much smaller scale.  We have combined
> efforts and produced two patches which provide minimal NUMA
> scheduler capabilities.

Just wanted to add that everyone that's been involved in this is
now in harmonious agreement about this combined solution. If you're
curious as to where the benefits come from, the differences in 
kernel profiles are included below from a 16-way NUMA-Q doing a
kernel compile.

Positive numbers got worse with the patch, negative got better:
(differences below 50 ticks cut off to increase signal:noise ratio)

132 d_lookup
80 strnlen_user
72 atomic_dec_and_lock
...
-50 file_move
-58 pte_alloc_one
-83 __set_page_dirty_buffers
-84 do_wp_page
-109 free_hot_cold_page
-119 clear_page_tables
-128 __copy_to_user
-175 zap_pte_range
-194 buffered_rmqueue
-237 page_remove_rmap
-897 __copy_from_user
-907 do_anonymous_page

As would be expected most of the gain is in the memory management
functions (do_anonymous page is doing pre-zeroing of pages, and
is always the biggest item on these profiles).

M.

