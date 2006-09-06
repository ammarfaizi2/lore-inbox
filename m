Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932216AbWIFWgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932216AbWIFWgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 18:36:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751765AbWIFWgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 18:36:17 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:1425 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751764AbWIFWgP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 18:36:15 -0400
From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [PATCH 2.6.18-rc6 00/10] Kernel memory leak detector 0.10
Date: Wed, 06 Sep 2006 23:35:36 +0100
To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
Message-Id: <20060906223536.21550.55411.stgit@localhost.localdomain>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a new version (0.10) of the kernel memory leak detector. See
the Documentation/kmemleak.txt file for a more detailed
description. The patches are downloadable from (the whole patch or the
broken-out series):

http://homepage.ntlworld.com/cmarinas/kmemleak/patch-2.6.18-rc6-kmemleak-0.10.bz2
http://homepage.ntlworld.com/cmarinas/kmemleak/broken-out/patches-kmemleak-0.10.tar.bz2

What's new in this version:

- replaced the pointers radix tree with a hash table to avoid the
  locking dependencies caused by the radix tree memory allocations
- fixed locking dependency problems by no longer holding the
  memleak_lock when allocating/freeing memory from kmemleak and also
  using RCU
- changed the naming of tracked memory blocks from "pointer" to
  "object"
- code clean-up

To do:

- testing on a wider range of platforms and configurations
- support for ioremap tracking (once the generic ioremap patches are
  merged)
- eliminate the task stacks scanning (if possible, by marking the
  allocated blocks as temporary until the return to user-space -
  Ingo's suggestion)
- precise type identification (after first assessing the efficiency of
  the current method as it requires changes to the kernel API)

-- 
Catalin
