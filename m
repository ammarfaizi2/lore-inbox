Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423428AbWBBJwJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423428AbWBBJwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423429AbWBBJwJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:52:09 -0500
Received: from mtagate4.de.ibm.com ([195.212.29.153]:45711 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1423428AbWBBJwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:52:07 -0500
Date: Thu, 2 Feb 2006 10:52:01 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] s390: compile fix: missing defines in asm-s390/io.h
Message-ID: <20060202095201.GA22815@osiris.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: mutt-ng/devel (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Compile fix: add missing __raw_read* and __raw_write* defines to
include/asm-s390/io.h.
These are mandatory since patch c27a0d75b33c030965cc97d3d7f571107a673fb4
was merged.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 include/asm-s390/io.h |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/asm-s390/io.h b/include/asm-s390/io.h
index 71f55eb..b05825d 100644
--- a/include/asm-s390/io.h
+++ b/include/asm-s390/io.h
@@ -90,10 +90,16 @@ extern void iounmap(void *addr);
 #define readb_relaxed(addr) readb(addr)
 #define readw_relaxed(addr) readw(addr)
 #define readl_relaxed(addr) readl(addr)
+#define __raw_readb readb
+#define __raw_readw readw
+#define __raw_readl readl
 
 #define writeb(b,addr) (*(volatile unsigned char *) __io_virt(addr) = (b))
 #define writew(b,addr) (*(volatile unsigned short *) __io_virt(addr) = (b))
 #define writel(b,addr) (*(volatile unsigned int *) __io_virt(addr) = (b))
+#define __raw_writeb writeb
+#define __raw_writew writew
+#define __raw_writel writel
 
 #define memset_io(a,b,c)        memset(__io_virt(a),(b),(c))
 #define memcpy_fromio(a,b,c)    memcpy((a),__io_virt(b),(c))
