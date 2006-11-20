Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966355AbWKTSNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966355AbWKTSNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 13:13:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966339AbWKTSNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 13:13:21 -0500
Received: from moutng.kundenserver.de ([212.227.126.177]:57594 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S934211AbWKTSHB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 13:07:01 -0500
Message-Id: <20061120180521.245775000@arndb.de>
References: <20061120174454.067872000@arndb.de>
User-Agent: quilt/0.45-1
Date: Mon, 20 Nov 2006 18:44:57 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>,
       Dwayne Grant McConnell <decimal@us.ibm.com>,
       Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [PATCH 03/22] spufs: Change %llx to 0x%llx.
Content-Disposition: inline; filename=spufs-change-llx-to-0x-llx.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dwayne Grant McConnell <decimal@us.ibm.com>
This patches changes /npc, /decr, /decr_status, /spu_tag_mask, 
/event_mask, /event_status, and /srr0 files to provide output according to 
the format string "0x%llx" instead of "%llx".

Before this patch some files used "0x%llx" and other used "%llx" which is 
inconsistent and potentially confusing. A user might assume "%llx" numbers 
were decimal if they happened to not contain any a-f digits. This change 
will break any code cannot tolerate a leading 0x in the file contents. The 
only known users of these files are the libspe but there might also be 
some scripts which access these files. This risk is deemed acceptable for 
future consistency.

Signed-off-by: Dwayne Grant McConnell <decimal@us.ibm.com>
Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

---
Dwayne Grant McConnell <decimal@us.ibm.com>
Lotus Notes Mail: Dwayne McConnell [Mail]/Austin/IBM@IBMUS
Lotus Notes Calendar: Dwayne McConnell [Calendar]/Austin/IBM@IBMUS

Index: linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/cell/spufs/file.c
+++ linux-2.6/arch/powerpc/platforms/cell/spufs/file.c
@@ -1391,7 +1391,8 @@ static u64 spufs_npc_get(void *data)
 	spu_release(ctx);
 	return ret;
 }
-DEFINE_SIMPLE_ATTRIBUTE(spufs_npc_ops, spufs_npc_get, spufs_npc_set, "%llx\n")
+DEFINE_SIMPLE_ATTRIBUTE(spufs_npc_ops, spufs_npc_get, spufs_npc_set,
+			"0x%llx\n")
 
 static void spufs_decr_set(void *data, u64 val)
 {
@@ -1413,7 +1414,7 @@ static u64 spufs_decr_get(void *data)
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_decr_ops, spufs_decr_get, spufs_decr_set,
-			"%llx\n")
+			"0x%llx\n")
 
 static void spufs_decr_status_set(void *data, u64 val)
 {
@@ -1435,7 +1436,7 @@ static u64 spufs_decr_status_get(void *d
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_decr_status_ops, spufs_decr_status_get,
-			spufs_decr_status_set, "%llx\n")
+			spufs_decr_status_set, "0x%llx\n")
 
 static void spufs_spu_tag_mask_set(void *data, u64 val)
 {
@@ -1457,7 +1458,7 @@ static u64 spufs_spu_tag_mask_get(void *
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_spu_tag_mask_ops, spufs_spu_tag_mask_get,
-			spufs_spu_tag_mask_set, "%llx\n")
+			spufs_spu_tag_mask_set, "0x%llx\n")
 
 static void spufs_event_mask_set(void *data, u64 val)
 {
@@ -1479,7 +1480,7 @@ static u64 spufs_event_mask_get(void *da
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_event_mask_ops, spufs_event_mask_get,
-			spufs_event_mask_set, "%llx\n")
+			spufs_event_mask_set, "0x%llx\n")
 
 static void spufs_srr0_set(void *data, u64 val)
 {
@@ -1501,7 +1502,7 @@ static u64 spufs_srr0_get(void *data)
 	return ret;
 }
 DEFINE_SIMPLE_ATTRIBUTE(spufs_srr0_ops, spufs_srr0_get, spufs_srr0_set,
-			"%llx\n")
+			"0x%llx\n")
 
 static u64 spufs_id_get(void *data)
 {

--

