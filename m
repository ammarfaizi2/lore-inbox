Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbVCYUns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbVCYUns (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 15:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVCYUns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 15:43:48 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:49589 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261242AbVCYUnp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 15:43:45 -0500
Subject: resubmit - [PATCH 0/4] sparsemem intro patches
From: Dave Hansen <haveblue@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 25 Mar 2005 12:43:43 -0800
Message-Id: <1111783423.9691.65.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, I noticed that these were dropped out of 2.6.12-mm1:

> -sparsemem-base-teach-discontig-about-sparse-ranges.patch
> -sparsemem-base-simple-numa-remap-space-allocator.patch
> -sparsemem-base-reorganize-page-flags-bit-operations.patch
> -sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch
> 
> This was breaking compilation in various ways on various
> architectures.
> Returned to manufacturer.

I *think* those problems were caused by the actual sparsemem patches
that I posted for RFC, not the base "intro" patches.  (I have fixes for
the problems that you were hitting with the RFC patches ready, too)

I've run these through a bunch of compile tests, including arm and alpha
with and without DISCONTIGMEM, and they seem OK.  They also boot just
fine on a bunch of ppc64 and i386 configurations.  

Can these go back into -mm?

----

The following four patches provide the last needed changes before the
introduction of sparsemem.  For a more complete description of what this
will do, please see this patch:

http://www.sr71.net/patches/2.6.11/2.6.11-bk7-mhp1/broken-out/B-sparse-150-sparsemem.patch

or previous posts on the subject:
http://marc.theaimsgroup.com/?t=110868540700001&r=1&w=2
http://marc.theaimsgroup.com/?l=linux-mm&m=109897373315016&w=2

Three of these are i386-only, but one of them reorganizes the macros
used to manage the space in page->flags, and will affect all platforms.
There are analogous patches to the i386 ones for ppc64, ia64, and
x86_64, but those will be submitted by the normal arch maintainers.

The combination of the four patches has been test-booted on a variety of
i386 hardware, and compiled for ppc64, i386, and x86-64 with about 17
different .configs.  It's also been runtime-tested on ia64 configs (with
more patches on top).

-- Dave

