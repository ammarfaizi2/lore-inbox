Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVDWABf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVDWABf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Apr 2005 20:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261368AbVDWABf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Apr 2005 20:01:35 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:21265 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261357AbVDWAAy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Apr 2005 20:00:54 -0400
Date: Sat, 23 Apr 2005 02:00:50 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dwmw2@infradead.org
Cc: jffs-dev@axis.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/jffs2/: make some functions static
Message-ID: <20050423000050.GK4355@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 fs/jffs2/compr_rubin.c |   18 ++++++++++++------
 fs/jffs2/compr_zlib.c  |   12 ++++++++----
 2 files changed, 20 insertions(+), 10 deletions(-)

--- linux-2.6.12-rc2-mm3-full/fs/jffs2/compr_rubin.c.old	2005-04-20 23:28:57.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/jffs2/compr_rubin.c	2005-04-20 23:30:09.000000000 +0200
@@ -228,8 +228,10 @@
 	return rubin_do_compress(BIT_DIVIDER_MIPS, bits_mips, data_in, cpage_out, sourcelen, dstlen);
 }
 #endif
-int jffs2_dynrubin_compress(unsigned char *data_in, unsigned char *cpage_out, 
-		   uint32_t *sourcelen, uint32_t *dstlen, void *model)
+static int jffs2_dynrubin_compress(unsigned char *data_in,
+				   unsigned char *cpage_out, 
+				   uint32_t *sourcelen, uint32_t *dstlen,
+				   void *model)
 {
 	int bits[8];
 	unsigned char histo[256];
@@ -306,15 +308,19 @@
 }		   
 
 
-int jffs2_rubinmips_decompress(unsigned char *data_in, unsigned char *cpage_out, 
-		   uint32_t sourcelen, uint32_t dstlen, void *model)
+static int jffs2_rubinmips_decompress(unsigned char *data_in,
+				      unsigned char *cpage_out, 
+				      uint32_t sourcelen, uint32_t dstlen,
+				      void *model)
 {
 	rubin_do_decompress(BIT_DIVIDER_MIPS, bits_mips, data_in, cpage_out, sourcelen, dstlen);
         return 0;
 }
 
-int jffs2_dynrubin_decompress(unsigned char *data_in, unsigned char *cpage_out, 
-		   uint32_t sourcelen, uint32_t dstlen, void *model)
+static int jffs2_dynrubin_decompress(unsigned char *data_in,
+				     unsigned char *cpage_out, 
+				     uint32_t sourcelen, uint32_t dstlen,
+				     void *model)
 {
 	int bits[8];
 	int c;
--- linux-2.6.12-rc2-mm3-full/fs/jffs2/compr_zlib.c.old	2005-04-20 23:30:31.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/fs/jffs2/compr_zlib.c	2005-04-20 23:31:04.000000000 +0200
@@ -69,8 +69,10 @@
 #define free_workspaces() do { } while(0)
 #endif /* __KERNEL__ */
 
-int jffs2_zlib_compress(unsigned char *data_in, unsigned char *cpage_out, 
-		   uint32_t *sourcelen, uint32_t *dstlen, void *model)
+static int jffs2_zlib_compress(unsigned char *data_in,
+			       unsigned char *cpage_out, 
+			       uint32_t *sourcelen, uint32_t *dstlen,
+			       void *model)
 {
 	int ret;
 
@@ -135,8 +137,10 @@
 	return ret;
 }
 
-int jffs2_zlib_decompress(unsigned char *data_in, unsigned char *cpage_out,
-		      uint32_t srclen, uint32_t destlen, void *model)
+static int jffs2_zlib_decompress(unsigned char *data_in,
+				 unsigned char *cpage_out,
+				 uint32_t srclen, uint32_t destlen,
+				 void *model)
 {
 	int ret;
 	int wbits = MAX_WBITS;

