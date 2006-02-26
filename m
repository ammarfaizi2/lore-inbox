Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932182AbWBZTIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932182AbWBZTIf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 14:08:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWBZTIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 14:08:35 -0500
Received: from silver.veritas.com ([143.127.12.111]:2611 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S932182AbWBZTIe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 14:08:34 -0500
X-BrightmailFiltered: true
X-Brightmail-Tracker: AAAAAA==
X-IronPort-AV: i="4.02,148,1139212800"; 
   d="scan'208"; a="35018725:sNHT24048068"
Date: Sun, 26 Feb 2006 19:09:04 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Andrew Morton <akpm@osdl.org>
cc: Jesper Juhl <jesper.juhl@gmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] shmem: inline to avoid warning
Message-ID: <Pine.LNX.4.61.0602261903280.17738@goblin.wat.veritas.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 26 Feb 2006 19:08:29.0320 (UTC) FILETIME=[07330880:01C63B08]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shmem.c was named and shamed in Jesper's "Building 100 kernels" warnings:
shmem_parse_mpol is only used when CONFIG_TMPFS parses mount options; and
only called from that one site, so mark it inline like its non-NUMA stub.

Signed-off-by: Hugh Dickins <hugh@veritas.com>
---

 mm/shmem.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- 2.6.16-rc4-git9/mm/shmem.c	2006-02-26 14:43:13.000000000 +0000
+++ linux/mm/shmem.c	2006-02-26 18:53:47.000000000 +0000
@@ -875,7 +875,7 @@ redirty:
 }
 
 #ifdef CONFIG_NUMA
-static int shmem_parse_mpol(char *value, int *policy, nodemask_t *policy_nodes)
+static inline int shmem_parse_mpol(char *value, int *policy, nodemask_t *policy_nodes)
 {
 	char *nodelist = strchr(value, ':');
 	int err = 1;
