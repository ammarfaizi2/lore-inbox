Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262308AbUJ0GVd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262308AbUJ0GVd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 02:21:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261672AbUJ0GNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 02:13:19 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:7331 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261679AbUJ0GJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 02:09:32 -0400
Date: Tue, 26 Oct 2004 23:09:25 -0700
To: LKML <linux-kernel@vger.kernel.org>
Cc: Chris Wedgwood <cw@taniwha.stupidest.org>, achim_leubner@adaptec.com
Subject: [RFC] Rename SECTOR_SIZE to GDTH_SECTOR_SIZE
Message-ID: <20041027060925.GE32396@taniwha.stupidest.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
From: cw@f00f.org (Chris Wedgwood)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The token SECTOR_SIZE is used in multiple places that have (almost)
the same defintion everywhere.

How do people feel about rename this vague token?



===== drivers/scsi/gdth.c 1.44 vs edited =====
--- 1.44/drivers/scsi/gdth.c	2004-09-30 19:44:10 -07:00
+++ edited/drivers/scsi/gdth.c	2004-10-26 17:15:36 -07:00
@@ -2823,9 +2823,9 @@ static int gdth_internal_cache_cmd(int h
         mpd.hd.data_length = sizeof(gdth_modep_data);
         mpd.hd.dev_par     = (ha->hdr[t].devtype&2) ? 0x80:0;
         mpd.hd.bd_length   = sizeof(mpd.bd);
-        mpd.bd.block_length[0] = (SECTOR_SIZE & 0x00ff0000) >> 16;
-        mpd.bd.block_length[1] = (SECTOR_SIZE & 0x0000ff00) >> 8;
-        mpd.bd.block_length[2] = (SECTOR_SIZE & 0x000000ff);
+        mpd.bd.block_length[0] = (GDTH_SECTOR_SIZE & 0x00ff0000) >> 16;
+        mpd.bd.block_length[1] = (GDTH_SECTOR_SIZE & 0x0000ff00) >> 8;
+        mpd.bd.block_length[2] = (GDTH_SECTOR_SIZE & 0x000000ff);
         gdth_copy_internal_data(hanum,scp,(char*)&mpd,sizeof(gdth_modep_data));
         break;
 
@@ -2835,7 +2835,7 @@ static int gdth_internal_cache_cmd(int h
             rdc.last_block_no = 0xffffffff;
         else
             rdc.last_block_no = cpu_to_be32(ha->hdr[t].size-1);
-        rdc.block_length  = cpu_to_be32(SECTOR_SIZE);
+        rdc.block_length  = cpu_to_be32(GDTH_SECTOR_SIZE);
         gdth_copy_internal_data(hanum,scp,(char*)&rdc,sizeof(gdth_rdcap_data));
         break;
 
@@ -2847,7 +2847,7 @@ static int gdth_internal_cache_cmd(int h
 
             TRACE2(("Read capacity (16) hdrive %d\n",t));
             rdc16.last_block_no = cpu_to_be64(ha->hdr[t].size-1);
-            rdc16.block_length  = cpu_to_be32(SECTOR_SIZE);
+            rdc16.block_length  = cpu_to_be32(GDTH_SECTOR_SIZE);
             gdth_copy_internal_data(hanum,scp,(char*)&rdc16,sizeof(gdth_rdcap16_data));
         } else { 
             scp->result = DID_ABORT << 16;
===== drivers/scsi/gdth.h 1.17 vs edited =====
--- 1.17/drivers/scsi/gdth.h	2004-09-30 19:44:10 -07:00
+++ edited/drivers/scsi/gdth.h	2004-10-26 17:15:36 -07:00
@@ -188,7 +188,7 @@
 #define MSG_REQUEST     0                       /* async. event: message */
 
 /* cacheservice defines */
-#define SECTOR_SIZE     0x200                   /* always 512 bytes per sec. */
+#define GDTH_SECTOR_SIZE     0x200                   /* always 512 bytes per sec. */
 
 /* DPMEM constants */
 #define DPMEM_MAGIC     0xC0FFEE11
