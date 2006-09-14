Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbWINKUc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbWINKUc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 06:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750751AbWINKUc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 06:20:32 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:59723 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1750716AbWINKUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 06:20:31 -0400
Message-Id: <20060914102012.251231177@localhost.localdomain>
Date: Thu, 14 Sep 2006 18:20:12 +0800
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, Don Mullis <dwm@meer.net>
Subject: [patch 0/8] fault-injection capabilities (v3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from last version

- add stacktrace filter
- drop process-filter from boot-time setup
- build fixes from Don Mullis
- add documentation and some scripts

---

This patch set provides some fault-injection capabilities.

- kmalloc() failures

- alloc_pages() failures

- disk IO errors

We can see what really happens if those failures happen.

In order to enable these fault-injection capabilities:

1. Enable relevant config options (CONFIG_FAILSLAB, CONFIG_PAGE_ALLOC,
   CONFIG_MAKE_REQUEST) and runtime configuration kernel module
   (CONFIG_FAULT_INJECTION_DEBUGFS)

2. build and boot with this kernel

3. modprobe fault-inject-debugfs

4. configure fault-injection capabilities behavior by debugfs

For example about kmalloc failures:

/debug/failslab/probability

	specifies how often it should fail in percent.

/debug/failslab/interval

	specifies the interval of failures.

/debug/failslab/times

	specifies how many times failures may happen at most.

/debug/failslab/space

	specifies the size of free space where memory can be allocated
	safely in bytes.

/debug/failslab/process-filter

	specifies whether process filter is enabled or not.
	it allows failing only permitted processes by /proc/<pid>/make-it-fail

/debug/failslab/stacktrace-depth

	specifies the maximum stacktrace depth walking allowed.
	a value '0' means stacktrace filter is disabled.

/debug/failslab/address-start
/debug/failslab/address-end

	specifies the range of virtual address.
	it allows failing only if the stacktrace hits in this range.

5. see what really happens.

