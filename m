Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261607AbSJNMqK>; Mon, 14 Oct 2002 08:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJNMqK>; Mon, 14 Oct 2002 08:46:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:9881 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261607AbSJNMqK>;
	Mon, 14 Oct 2002 08:46:10 -0400
Date: Mon, 14 Oct 2002 05:45:00 -0700 (PDT)
Message-Id: <20021014.054500.89132620.davem@redhat.com>
To: mingo@elte.hu
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [patch, feature] nonlinear mappings, prefaulting support,
 2.5.42-F8
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0210141334100.17808-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0210141334100.17808-100000@localhost.localdomain>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ingo Molnar <mingo@elte.hu>
   Date: Mon, 14 Oct 2002 14:38:43 +0200 (CEST)

   - TLB flush avoidance: the MAP_FIXED overmapping of larger than 4K cache
     units causes a TLB flush, greatly increasing the overhead of 'basic'
     DB cache operations - both the direct overhead and the secondary costs
     of repopulating the TLB cache are signifiant - and will only increase
     with newer CPUs. remap_file_pages() uses the one-page invalidation
     instruction, which does not destroy the TLB.
   
Maybe on your cpu.

We created the range tlb flushes so that architectures have a chance
of optimizing such operations when possible.

If that isn't happening for small numbers of pages on x86 currently,
that isn't justification for special casing it here in this non-linear
mappings code.

If someone does a remap of 1GB of address space, I sure want the
option of doing a full MM flush if that is cheaper on my platform.

Currently, this part smells of an x86 performance hack, which might
even be suboptimal on x86 for remapping of huge ranges.
