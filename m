Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030534AbWBNJr1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030534AbWBNJr1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:47:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030537AbWBNJr1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:47:27 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:53390 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1030534AbWBNJrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:47:25 -0500
Message-ID: <43F1A753.2020003@jp.fujitsu.com>
Date: Tue, 14 Feb 2006 18:48:03 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Andrew Morton <akpm@osdl.org>, Kyle McMartin <kyle@mcmartin.ca>
Subject: [PATCH] unify pfn_to_page take3 [0/23] 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, this is unify-pfn_to_page patch take3. thank you for comments on
previous version.

This patch consolidates definitions of pfn_to_page/page_to_pfn which are
defined by each arch to generic one. Most of archs can use it.
This patch is against 2.6.16-rc3 and totally rewritten.

Changelog v2 -> v3
  - linux/memory_model.h is moved to asm-generic/memory_model.h
  - If an arch can use generic funcs, it includes asm-generic/memory_model.h.
    If not, it doesn't include them. (m68k, m68knommu, ia64 + virtual_mem_map)
  - remvoed CONFIG_ARCH_PFN_TO_PAGE
  - CONFIG_DONT_INLINE_PFN_TO_PAGE was renamed to CONFIG_OUT_OF_LINE_PFN_TO_PAGE
    This is used by x86_64+DISCONTIGMEM and sparc64.

Changelog: v1->v2
  - linux/memory_model.h is added. this defines pfn<->page translation.
  - new config options (set by arch) CONFIG_DONT_INLINE_PFN_TO_PAGE
    and CONFIG_ARCH_HAS_PFN_TO_PAGE are added.
  - SPARSEMEM's page_to_pfn is moved to linux/memory_model.h

-- Kame.

