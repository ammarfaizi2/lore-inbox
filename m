Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261482AbVEDUVV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261482AbVEDUVV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 16:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261488AbVEDUVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:21:21 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:46045
	"EHLO pinky.shadowen.org") by vger.kernel.org with ESMTP
	id S261482AbVEDUVK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:21:10 -0400
To: akpm@osdl.org
Subject: [0/6] SPARSEMEM memory model patches
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, apw@shadowen.org,
       haveblue@us.ibm.com, kravetz@us.ibm.com
Message-Id: <E1DTQMa-0002UX-OU@pinky.shadowen.org>
From: Andy Whitcroft <apw@shadowen.org>
Date: Wed, 04 May 2005 21:20:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After long testing outside -mm we believe that the SPARSEMEM patches
are ready for wider testing, please consider for -mm.

SPARSEMEM essentially is a replacement for DISCONTIGMEM providing
support for non-contigious memory but with the advantage of
handling both inter- and intra-node memory holes.  The goal of the
implementation was to design a clean memory memory model covering
the needs of both UMA and NUMA discontigouos memory layouts whilst
providing a basis for hotplug.  This should allow us to consolidate
the implementation of various "discontiguous" memory model whilst
trying to fix its short comings.  Ultimatly it should allow us to
remove DISCONTIGMEM.

Following this mail are 6 patches which provide SPARSEMEM for i386,
they introduce SPARSEMEM as an alternative to DISCONTIGMEM without
removing it:

[1/6] generify early_pfn_to_nid
[2/6] generify memory present
[3/6] sparsemem memory model
[4/6] sparsemem memory model for i386
[5/6] sparsemem swiss cheese numa layouts
[6/6] sparsemem hotplug base

These patches have been compiled, booted and tested on 2.6.12-rc2
(plus the -mm patches listed below).  They have been compile and boot
tested against 2.6.12-rc3-mm2.  They do assume a number of patches
already incorporated into -mm including the latest configuration
updates from Dave Hansen <haveblue@us.ibm.com>.

remove-non-discontig-use-of-pgdat-node_mem_map.patch
resubmit-sparsemem-base-early_pfn_to_nid-works-before-sparse-is-initialized.patch
resubmit-sparsemem-base-simple-numa-remap-space-allocator.patch
resubmit-sparsemem-base-reorganize-page-flags-bit-operations.patch
resubmit-sparsemem-base-teach-discontig-about-sparse-ranges.patch
create-mm-kconfig-for-arch-independent-memory-options.patch
make-each-arch-use-mm-kconfig.patch
update-all-defconfigs-for-arch_discontigmem_enable.patch
introduce-new-kconfig-option-for-numa-or-discontig.patch
sparsemem-fix-minor-defaults-issue-in-mm-kconfig.patch
mm-kconfig-kill-unused-arch_flatmem_disable.patch
mm-kconfig-hide-memory-model-selection-menu.patch

Comments/feedback appreciated.

-apw
