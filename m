Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932194AbWCJDoK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932194AbWCJDoK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Mar 2006 22:44:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWCJDoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Mar 2006 22:44:09 -0500
Received: from sv1.valinux.co.jp ([210.128.90.2]:13487 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S932194AbWCJDoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Mar 2006 22:44:08 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Cc: Magnus Damm <magnus@valinux.co.jp>
Message-Id: <20060310034412.8340.90939.sendpatchset@cherry.local>
Subject: [PATCH 00/03] Unmapped: Separate unmapped and mapped pages
Date: Fri, 10 Mar 2006 12:44:08 +0900 (JST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Unmapped patches - Use two LRU:s per zone.

These patches break out the per-zone LRU into two separate LRU:s - one for
mapped pages and one for unmapped pages. The patches also introduce guarantee 
support, which allows the user to set how many percent of all pages per node
that should be kept in memory for mapped or unmapped pages. This guarantee 
makes it possible to adjust the VM behaviour depending on the workload.

Reasons behind the LRU separation:

- Avoid unnecessary page scanning.
  The current VM implementation rotates mapped pages on the active list
  until the number of mapped pages are high enough to start unmap and page out.
  By using two LRU:s we can avoid this scanning and shrink/rotate unmapped 
  pages only, not touching mapped pages until the threshold is reached.

- Make it possible to adjust the VM behaviour.
  In some cases the user might want to guarantee that a certain amount of 
  pages should be kept in memory, overriding the standard behaviour. Separating
  pages into mapped and unmapped LRU:s allows guarantee with low overhead.

I've performed many tests on a Dual PIII machine while varying the amount of
RAM available. Kernel compiles on a 64MB configuration gets a small speedup, 
but the impact on other configurations and workloads seems to be unaffected.

Apply on top of 2.6.16-rc5.

Comments?

/ magnus
