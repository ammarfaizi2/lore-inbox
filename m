Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272241AbTHID5q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Aug 2003 23:57:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272244AbTHID5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Aug 2003 23:57:46 -0400
Received: from relais.videotron.ca ([24.201.245.36]:20944 "EHLO
	VL-MO-MR004.ip.videotron.ca") by vger.kernel.org with ESMTP
	id S272241AbTHID5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Aug 2003 23:57:44 -0400
Date: Fri, 08 Aug 2003 23:57:41 -0400
From: Stephane Ouellette <ouellettes@videotron.ca>
Subject: [PATCH]   Unused variable warning in fs/ext3/super.c if CONFIG_QUOTA
 is not defined
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <3F347135.8070900@videotron.ca>
MIME-version: 1.0
Content-type: multipart/mixed; boundary="Boundary_(ID_NrHDOfu+ZCkB/lHiBzJUvw)"
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Boundary_(ID_NrHDOfu+ZCkB/lHiBzJUvw)
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT

Folks,

    the following two patches fix a compile warning in fs/ext3/super.c 
if CONFIG_QUOTA is not defined.

    The patches apply against 2.4.22-rc1-ac1  and  2.6.0-test2.

Stephane Ouellette


--Boundary_(ID_NrHDOfu+ZCkB/lHiBzJUvw)
Content-type: text/plain; name=super.c-2.4.22-rc1-ac1.diff; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=super.c-2.4.22-rc1-ac1.diff

--- linux-2.4.22-rc1-ac1-orig/fs/ext3/super.c	Fri Aug  8 22:34:32 2003
+++ linux-2.4.22-rc1-ac1-fixed/fs/ext3/super.c	Fri Aug  8 23:48:54 2003
@@ -449,7 +449,10 @@
 }
 
 static struct dquot_operations ext3_qops;
+
+#ifdef CONFIG_QUOTA
 static int (*old_sync_dquot)(struct dquot *dquot);
+#endif
 
 static struct super_operations ext3_sops = {
 	read_inode:	ext3_read_inode,	/* BKL held */

--Boundary_(ID_NrHDOfu+ZCkB/lHiBzJUvw)
Content-type: text/plain; name=super.c-2.6.0-test2.diff; CHARSET=US-ASCII
Content-transfer-encoding: 7BIT
Content-disposition: inline; filename=super.c-2.6.0-test2.diff

--- linux-2.6.0-test2-orig/fs/ext3/super.c	2003-07-27 13:09:04.000000000 -0400
+++ linux-2.6.0-test2-fixed/fs/ext3/super.c	2003-08-08 23:52:42.000000000 -0400
@@ -2000,7 +2000,9 @@
 /* Blocks: quota info + (4 pointer blocks + 1 entry block) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
 #define EXT3_V0_QFMT_BLOCKS 27
 
+#ifdef CONFIG_QUOTA
 static int (*old_sync_dquot)(struct dquot *dquot);
+#endif
 
 static int ext3_sync_dquot(struct dquot *dquot)
 {

--Boundary_(ID_NrHDOfu+ZCkB/lHiBzJUvw)--
