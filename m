Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266882AbUAXHcJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jan 2004 02:32:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266884AbUAXHcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jan 2004 02:32:08 -0500
Received: from dsl081-085-091.lax1.dsl.speakeasy.net ([64.81.85.91]:31873 "EHLO
	mrhankey.megahappy.net") by vger.kernel.org with ESMTP
	id S266882AbUAXHcF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jan 2004 02:32:05 -0500
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.2-rc1-mm2] fs/xfs/xfs_log_recover.c
Cc: akpm@osdl.org, nathans@sgi.com, owner-xfs@oss.sgi.com
Message-Id: <20040124073111.34B2313A354@mrhankey.megahappy.net>
Date: Fri, 23 Jan 2004 23:31:11 -0800 (PST)
From: driver@megahappy.net (Bryan Whitehead)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This fixes a warning on compile of the xfs fs module.

--- fs/xfs/xfs_log_recover.c.orig       2004-01-23 23:17:35.402907768 -0800
+++ fs/xfs/xfs_log_recover.c    2004-01-23 23:19:09.368622808 -0800
@@ -1542,21 +1542,14 @@
                case XFS_LI_BUF:
                        flags = buf_f->blf_flags;
                        break;
                case XFS_LI_6_1_BUF:
                case XFS_LI_5_3_BUF:
                        obuf_f = (xfs_buf_log_format_v1_t*)buf_f;
                        flags = obuf_f->blf_flags;
-                       break;
-               }
-
-               switch (ITEM_TYPE(itemq)) {
-               case XFS_LI_BUF:
-               case XFS_LI_6_1_BUF:
-               case XFS_LI_5_3_BUF:
                        if (!(flags & XFS_BLI_CANCEL)) {
                                xlog_recover_insert_item_frontq(&trans->r_itemq,
                                                                itemq);
                                break;
                        }
                case XFS_LI_INODE:
                case XFS_LI_6_1_INODE:


--
Bryan Whitehead
driver@megahappy.net
