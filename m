Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932084AbWHaKIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWHaKIr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbWHaKIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:08:47 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:7188 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S1751425AbWHaKIp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:08:45 -0400
Message-Id: <20060831100756.866727476@localhost.localdomain>
Date: Thu, 31 Aug 2006 19:07:56 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, akpm@osdl.org, okuji@enbug.org
Subject: [patch 0/6] RFC: fault-injection capabilities (v2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from last version

- use lightweight random simulator instead of get_random_int()
- added per queue filter for disk IO failures
  (/sys/blocks/sda/sda1/make-it-fail, /sys/blocks/sda/make-it-fail)
- added process filter
  (/debug/{failslab,fail_page_alloc,fail_make_request}/process-filter,
   /proc/<pid>/make-it-fail)

---
This patch set provides some fault-injection capabilities.

- kmalloc failures

- alloc_pages() failures

- disk IO errors

We can see what really happens if those failures happen.

In order to enable these fault-injection capabilities:

1. Enable relevant config options (CONFIG_FAILSLAB, CONFIG_PAGE_ALLOC,
   CONFIG_MAKE_REQUEST) and runtime configuration kernel module
   (CONFIG_SHOULD_FAIL_KNOBS)

2. build and boot with this kernel

3. modprobe should_fail_knob

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

	enable process filter.

5. see what really happens.
