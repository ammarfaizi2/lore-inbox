Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279040AbRKAO5h>; Thu, 1 Nov 2001 09:57:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279053AbRKAO51>; Thu, 1 Nov 2001 09:57:27 -0500
Received: from pak218.pakuni.net ([207.91.34.218]:45062 "EHLO linuxtr.net")
	by vger.kernel.org with ESMTP id <S279040AbRKAO5Q>;
	Thu, 1 Nov 2001 09:57:16 -0500
Date: Thu, 1 Nov 2001 11:36:21 -0600 (CST)
From: Mike Phillips <mikep@linuxtr.net>
To: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] Olympic driver bug fix
Message-ID: <Pine.LNX.4.10.10111011129150.6182-100000@www.linuxtr.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to panic the kernel with the olympic driver by setting the
mtu to a low value. This bug only surfaced after the fix to stop pkacets
being dropped by the socket code.

Simply one liner, patch is against 2.4.13.

Please apply, thanks

Mike Phillips
Linux Token Ring Project
http://www.linuxtr.net


--- linux.orig/drivers/net/tokenring/olympic.c.orig	Fri Oct 12 08:39:43 2001
+++ linux-2.4.13/drivers/net/tokenring/olympic.c	Fri Oct 12 08:47:20 2001
@@ -737,7 +737,7 @@
 			} else {	
 			
 				if (buffer_cnt == 1) {
-					skb = dev_alloc_skb(olympic_priv->pkt_buf_sz) ; 
+					skb = dev_alloc_skb(max_t(int, olympic_priv->pkt_buf_sz,length)) ; 
 				} else {
 					skb = dev_alloc_skb(length) ; 
 				}
@@ -1722,4 +1722,4 @@
 module_init(olympic_pci_init) ; 
 module_exit(olympic_pci_cleanup) ; 
 
-MODULE_LICENSE("GPL");
\ No newline at end of file
+MODULE_LICENSE("GPL");

