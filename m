Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266681AbUFWVMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266681AbUFWVMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 17:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262476AbUFWVLx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 17:11:53 -0400
Received: from holomorphy.com ([207.189.100.168]:17285 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266676AbUFWVHs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 17:07:48 -0400
To: linux-kernel@vger.kernel.org
From: William Lee Irwin III <wli@holomorphy.com>
Subject: [oom]: [0/4] fix OOM deadlock running OAST
Message-ID: <0406231407.HbLbJbXaHbKbWa5aJb1a4aKb0a3aKb1a0a2aMbMbYa3aLbMb3aJbWaJbXaMbLb1a342@holomorphy.com>
CC: akpm@osdl.org
Date: Wed, 23 Jun 2004 14:07:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While running OAST to test 2.6's maximum client capacity, the kernel
deadlocked instead of properly OOM'ing. The obvious cause was the
line if (nr_swap_pages > 0) in out_of_memory(), which fails to account
for pinned allocations. This can't simply be removed. The following
patches attempt to give the kernel the ability to discriminate between
pinned and unpinned allocations in order to determine whether this
check is appropriate. They furthermore also add reporting of wired
memory on a global and per-zone basis.


-- wli
