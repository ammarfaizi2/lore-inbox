Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131207AbRCGV4H>; Wed, 7 Mar 2001 16:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131210AbRCGVz6>; Wed, 7 Mar 2001 16:55:58 -0500
Received: from zikova.cvut.cz ([147.32.235.100]:61189 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S131207AbRCGVzn>;
	Wed, 7 Mar 2001 16:55:43 -0500
Date: Wed, 7 Mar 2001 22:54:35 +0100
From: Petr Vandrovec <vandrove@vc.cvut.cz>
To: alan@lxorguk.ukuu.org.uk
Cc: linux-kernel@vger.kernel.org, urban@teststation.com
Subject: [PATCH] ncpfs and CONFIG_DEBUG_SLAB
Message-ID: <20010307225435.B1907@vana.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
   if you are going to apply patch I saw today morning on linux-kernel
to disable redzoning on SLAB_HWCACHE aligned areas, drop this one into
wastebasket.
   If not, please apply this. When CONFIG_DEBUG_SLAB is enbled,
dentries do not live on 16bytes boundary, but on x*8 + 4 :-( So I
can validate only two low bits.
   This patch is for 2.4.2-ac13 with applied patch I sent just few
minutes ago.
   Urban's smbfs has same problem, as it uses almost same validate
code...
					    Thanks,
						Petr Vandrovec
						vandrove@vc.cvut.cz


--- linux/fs/ncpfs/dir.c	Wed Mar  7 22:40:12 2001
+++ linux/fs/ncpfs/dir.c	Wed Mar  7 21:09:36 2001
@@ -332,7 +332,11 @@
 {
 	unsigned long dent_addr = (unsigned long) dentry;
 	const unsigned long min_addr = PAGE_OFFSET;
+#ifdef CONFIG_DEBUG_SLAB
+	const unsigned long align_mask = 0x03;
+#else
 	const unsigned long align_mask = 0x0F;
+#endif
 	unsigned int len;
 
 	if (dent_addr < min_addr)
