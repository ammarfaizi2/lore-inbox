Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVK1UnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVK1UnI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 15:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVK1UnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 15:43:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:32943 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932239AbVK1UnG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 15:43:06 -0500
Date: Mon, 28 Nov 2005 12:42:49 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Cliff Wickman <cpw@sgi.com>,
       Christoph Lameter <clameter@sgi.com>, lhms-devel@lists.sourceforge.net
Message-Id: <20051128204249.10037.47991.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com>
References: <20051128204244.10037.43868.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/7] Swap Migration: Fix double unlock
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

SwapMig: fix double page unlock

The cleanup patches screwed things up slightly. In case of an unsuccessful
migration a page may be unlocked twice.

Signed-off-by: Christoph Lameter <clameter@sgi.com>


Index: linux-2.6.15-rc2-mm1/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc2-mm1.orig/mm/vmscan.c	2005-11-28 11:06:15.000000000 -0800
+++ linux-2.6.15-rc2-mm1/mm/vmscan.c	2005-11-28 11:23:45.000000000 -0800
@@ -751,6 +751,7 @@ redo:
 			list_move(&page->lru, moved);
 			continue;
 		}
+		goto next;
 
 unlock_page:
 		unlock_page(page);
