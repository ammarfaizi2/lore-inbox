Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263079AbVAFWIp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263079AbVAFWIp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 17:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263071AbVAFWHt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 17:07:49 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:55564 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263064AbVAFWGi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 17:06:38 -0500
Date: Thu, 6 Jan 2005 23:06:30 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] efs: make a struct static (fwd)
Message-ID: <20050106220629.GB28628@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The patch forwarded below still applies and compiles against 2.6.10-mm2.

Please apply.


----- Forwarded message from Adrian Bunk <bunk@stusta.de> -----

Date:	Sun, 12 Dec 2004 03:10:54 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] efs: make a struct static


...


The patch below makes a needessly global struct in the efs code static.


diffstat output:
 fs/efs/super.c         |   20 ++++++++++++++++++++
 include/linux/efs_vh.h |   17 -----------------
 2 files changed, 20 insertions(+), 17 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc2-mm4-full/include/linux/efs_vh.h.old	2004-12-12 00:28:23.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/include/linux/efs_vh.h	2004-12-12 00:30:45.000000000 +0100
@@ -47,23 +47,6 @@
 struct pt_types {
 	int	pt_type;
 	char	*pt_name;
-} sgi_pt_types[] = {
-	{0x00,		"SGI vh"},
-	{0x01,		"SGI trkrepl"},
-	{0x02,		"SGI secrepl"},
-	{0x03,		"SGI raw"},
-	{0x04,		"SGI bsd"},
-	{SGI_SYSV,	"SGI sysv"},
-	{0x06,		"SGI vol"},
-	{SGI_EFS,	"SGI efs"},
-	{0x08,		"SGI lv"},
-	{0x09,		"SGI rlv"},
-	{0x0A,		"SGI xfs"},
-	{0x0B,		"SGI xfslog"},
-	{0x0C,		"SGI xlv"},
-	{0x82,		"Linux swap"},
-	{0x83,		"Linux native"},
-	{0,		NULL}
 };
 
 #endif /* __EFS_VH_H__ */
--- linux-2.6.10-rc2-mm4-full/fs/efs/super.c.old	2004-12-12 00:29:46.000000000 +0100
+++ linux-2.6.10-rc2-mm4-full/fs/efs/super.c	2004-12-12 00:30:32.000000000 +0100
@@ -32,6 +32,26 @@
 	.fs_flags	= FS_REQUIRES_DEV,
 };
 
+static struct pt_types sgi_pt_types[] = {
+	{0x00,		"SGI vh"},
+	{0x01,		"SGI trkrepl"},
+	{0x02,		"SGI secrepl"},
+	{0x03,		"SGI raw"},
+	{0x04,		"SGI bsd"},
+	{SGI_SYSV,	"SGI sysv"},
+	{0x06,		"SGI vol"},
+	{SGI_EFS,	"SGI efs"},
+	{0x08,		"SGI lv"},
+	{0x09,		"SGI rlv"},
+	{0x0A,		"SGI xfs"},
+	{0x0B,		"SGI xfslog"},
+	{0x0C,		"SGI xlv"},
+	{0x82,		"Linux swap"},
+	{0x83,		"Linux native"},
+	{0,		NULL}
+};
+
+
 static kmem_cache_t * efs_inode_cachep;
 
 static struct inode *efs_alloc_inode(struct super_block *sb)

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

