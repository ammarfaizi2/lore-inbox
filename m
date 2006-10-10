Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWJJOVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWJJOVg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 10:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWJJOVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 10:21:36 -0400
Received: from ns1.suse.de ([195.135.220.2]:59056 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750792AbWJJOVg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 10:21:36 -0400
From: Nick Piggin <npiggin@suse.de>
To: Linux Memory Management <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Nick Piggin <npiggin@suse.de>
Message-Id: <20061010121314.19693.75503.sendpatchset@linux.site>
Subject: [rfc] 2.6.19-rc1-git5: consolidation of file backed fault handlers
Date: Tue, 10 Oct 2006 16:21:32 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset is against 2.6.19-rc1-mm1 up to
numa-add-zone_to_nid-function-swap_prefetch.patch (ie. no readahead stuff,
which causes big rejects and would be much easier to fix in readahead
patches than here). Other than this feature, the -mm specific stuff is
pretty simple (mainly straightforward filesystem conversions).

Changes since last round:
- trimmed the cc list, no big changes since last time.
- fix the few buglets preventing it from actually booting
- reinstate filemap_nopage and filemap_populate, because they're exported
  symbols even though no longer used in the tree. Schedule for removal.
- initialise fault_data one field at a time (akpm)
- change prototype of ->fault so it takes a vma (hch)

Has passed an allyesconfig on G5, and booted and stress tested (on ext3
and tmpfs) on 2x P4 Xeon with my userspace tester (which I will send in
a reply to this email). (stress tests run with the set_page_dirty_buffers
fix that is upstream).

Please apply.

Nick

--
SuSE Labs
