Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932404AbWHWLfj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932404AbWHWLfj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 07:35:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbWHWLfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 07:35:08 -0400
Received: from ns.miraclelinux.com ([219.118.163.66]:64600 "EHLO
	mail01.miraclelinux.com") by vger.kernel.org with ESMTP
	id S932401AbWHWLe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 07:34:59 -0400
Message-Id: <20060823113243.210352005@localhost.localdomain>
Date: Wed, 23 Aug 2006 20:32:43 +0900
From: Akinobu Mita <mita@miraclelinux.com>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, okuji@enbug.org
Subject: [patch 0/5] RFC: fault-injection capabilities
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

5. see what really happens.

The idea is taken from failmalloc (http://www.nongnu.org/failmalloc/).
Andrew Morton gave me interesting suggestions.

--
