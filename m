Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132038AbRCVOrv>; Thu, 22 Mar 2001 09:47:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132037AbRCVOrk>; Thu, 22 Mar 2001 09:47:40 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:42463 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S132035AbRCVOrd>;
	Thu, 22 Mar 2001 09:47:33 -0500
Message-ID: <3ABA103A.CB07012D@mandrakesoft.com>
Date: Thu, 22 Mar 2001 09:46:18 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre6 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Eli Carter <eli.carter@inet.com>
Cc: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] pcnet32 compilation fix for 2.4.3pre6
In-Reply-To: <200103220638.HAA16050@green.mif.pg.gda.pl> <3ABA00BB.A9C2DF1B@mandrakesoft.com> <3ABA0E89.D3D965B7@inet.com>
Content-Type: multipart/mixed;
 boundary="------------93853769FCB2CB44EFE95D65"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------93853769FCB2CB44EFE95D65
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Eli Carter wrote:
> The "!(addr[0]&1)" part of the test already catches the ff's case, so
> that is redundant.
> Using 6 bytes instead of 7 is an improvement.

oops.  Thanks, updated patch attached.  My patch also adds inline source
docs, and uses 'static inline' instead of 'static __inline__', two small
style improvements.
-- 
Jeff Garzik       | May you have warm words on a cold evening,
Building 1024     | a full mooon on a dark night,
MandrakeSoft      | and a smooth road all the way to your door.
--------------93853769FCB2CB44EFE95D65
Content-Type: text/plain; charset=us-ascii;
 name="etherdev.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="etherdev.patch"

Index: include/linux/etherdevice.h
===================================================================
RCS file: /cvsroot/gkernel/linux_2_4/include/linux/etherdevice.h,v
retrieving revision 1.1.1.14.4.2
diff -u -r1.1.1.14.4.2 etherdevice.h
--- include/linux/etherdevice.h	2001/03/21 14:10:50	1.1.1.14.4.2
+++ include/linux/etherdevice.h	2001/03/22 14:44:51
@@ -46,6 +46,22 @@
 	memcpy (dest->data, src, len);
 }
 
+/**
+ * is_valid_ether_addr - Determine if the given Ethernet address is valid
+ * @addr: Pointer to a six-byte array containing the Ethernet address
+ *
+ * Check that the Ethernet address (MAC) is not 00:00:00:00:00:00, is not
+ * a multicast address, and is not FF:FF:FF:FF:FF:FF.
+ *
+ * Return true if the address is valid.
+ */
+static inline int is_valid_ether_addr( u8 *addr )
+{
+	const char zaddr[6] = {0,};
+
+	return !(addr[0]&1) && memcmp( addr, zaddr, 6);
+}
+
 #endif
 
 #endif	/* _LINUX_ETHERDEVICE_H */

--------------93853769FCB2CB44EFE95D65--

