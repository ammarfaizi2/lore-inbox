Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263414AbUCTODv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 09:03:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263415AbUCTODv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 09:03:51 -0500
Received: from holomorphy.com ([207.189.100.168]:20104 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263414AbUCTODu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 09:03:50 -0500
Date: Sat, 20 Mar 2004 06:03:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Hugh Dickins <hugh@veritas.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] anobjrmap 1/6 objrmap
Message-ID: <20040320140341.GB2045@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0403190642450.17899-100000@localhost.localdomain> <2663710000.1079716282@[10.10.2.4]> <20040320123009.GC9009@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040320123009.GC9009@dualathlon.random>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 20, 2004 at 01:30:09PM +0100, Andrea Arcangeli wrote:
> I'm working on my code yes, I think my code is finished, I prefer my
> design for the various reasons explained in the other emails (you don't
> swap so you can't appreciate the benefits, you only have to check that
> performs as well as Hugh's code).
> Hugh's and your code is unstable in objrmap, you can find the details in
> the email I sent to Hugh, mine is stable (running such simulation for a
> few days just fine on 4-way xeon, without my objrmap fixes it live locks
> as soon as it hits swap).
> You find my anon_vma in 2.6.5-rc1aa2, it's rock solid, just apply the
> whole patch and compare it with your other below results. thanks.

There's an outstanding issue that's biting people on ppc64, which is
that arch/ppc64/mm/tlb.c uses the mm pointer and virtual addresses that
used to be put into page->mapping and page->index respectively for
pagetable pages to assist updates to the inverted pagetable. Without
leaving that assignment and invalidation of page->mapping and page->index
in place or converting ppc64 to other methods of carrying out its
inverted pagetable updates, ppc64 (e.g. G5 Macs) support is broken.


-- wli
