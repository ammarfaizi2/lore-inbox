Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131841AbRCVGjP>; Thu, 22 Mar 2001 01:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131846AbRCVGjF>; Thu, 22 Mar 2001 01:39:05 -0500
Received: from green.mif.pg.gda.pl ([153.19.42.8]:45579 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S131841AbRCVGjC>; Thu, 22 Mar 2001 01:39:02 -0500
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200103220638.HAA16050@green.mif.pg.gda.pl>
Subject: [PATCH] pcnet32 compilation fix for 2.4.3pre6
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 22 Mar 2001 07:38:30 +0100 (CET)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        linux-kernel@vger.kernel.org (kernel list)
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  It looks like a not fully merged patch from Alan's tree:

drivers/net/net.o: In function `pcnet32_open':
drivers/net/net.o(.text+0x3bb9): undefined reference to `is_valid_ether_addr'
drivers/net/net.o: In function `pcnet32_probe1':
drivers/net/net.o(.text.init+0x5fa): undefined reference to `is_valid_ether_addr'


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla/include/linux/etherdevice.h linux.ac/include/linux/etherdevice.h
--- linux.vanilla/include/linux/etherdevice.h	Fri Oct 27 20:22:34 2000
+++ linux.ac/include/linux/etherdevice.h	Fri Feb 16 11:10:22 2001
@@ -45,6 +45,14 @@
 	memcpy (dest->data, src, len);
 }
 
+/* Check that the ethernet address (MAC) is not 00:00:00:00:00:00 and is not
+ * a multicast address.  Return true if the address is valid.
+ */
+static __inline__ int is_valid_ether_addr( u8 *addr )
+{
+	return !(addr[0]&1) && memcmp( addr, "\0\0\0\0\0\0", 6);
+}
+
 #endif
 
 #endif	/* _LINUX_ETHERDEVICE_H */

-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  phone (48)(58) 347 14 61
Faculty of Applied Phys. & Math.,   Technical University of Gdansk
