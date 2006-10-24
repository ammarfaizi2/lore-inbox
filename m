Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWJXI5F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWJXI5F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 04:57:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030236AbWJXI5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 04:57:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:35865 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030235AbWJXI5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 04:57:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=VWjyJpMssQQUoqNiEMOEfg/xEUAsPqbjvIhFDDsZ3LxDwz23fN+8UO7o9QUuCRJhWJg8h5HIGSIVax/Ms3sa2nEDfKju2bLGyQInGwfnWNCWmw4qN0JG8lW0qYaZNRLbZF9U7MWG1/hEbLIKEmlRY3F95lnlBQeLyFTli8YIrT4=
Date: Tue, 24 Oct 2006 17:56:57 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Karsten Keil <kkeil@suse.de>, Kai Germaschewski <kai.germaschewski@gmx.de>,
       Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>,
       akpm@osdl.org
Subject: [PATCH -mm] isdn/gigaset: use bitrev8
Message-ID: <20061024085657.GD7703@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org, Karsten Keil <kkeil@suse.de>,
	Kai Germaschewski <kai.germaschewski@gmx.de>,
	Hansjoerg Lipp <hjlipp@web.de>, Tilman Schmidt <tilman@imap.cc>,
	akpm@osdl.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitrev8 for gigaset isdn driver.

Cc: Karsten Keil <kkeil@suse.de>
Cc: Kai Germaschewski <kai.germaschewski@gmx.de>
Cc: Hansjoerg Lipp <hjlipp@web.de>
Cc: Tilman Schmidt <tilman@imap.cc>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>

 drivers/isdn/gigaset/Kconfig     |    1 +
 drivers/isdn/gigaset/asyncdata.c |    5 +++--
 drivers/isdn/gigaset/common.c    |   37 -------------------------------------
 drivers/isdn/gigaset/gigaset.h   |    4 ----
 drivers/isdn/gigaset/isocdata.c  |    5 +++--
 5 files changed, 7 insertions(+), 45 deletions(-)

Index: work-fault-inject/drivers/isdn/gigaset/common.c
===================================================================
--- work-fault-inject.orig/drivers/isdn/gigaset/common.c
+++ work-fault-inject/drivers/isdn/gigaset/common.c
@@ -33,43 +33,6 @@ MODULE_PARM_DESC(debug, "debug level");
 #define VALID_ID	0x02
 #define ASSIGNED	0x04
 
-/* bitwise byte inversion table */
-__u8 gigaset_invtab[256] = {
-	0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,
-	0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
-	0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8,
-	0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,
-	0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4,
-	0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,
-	0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec,
-	0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,
-	0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2,
-	0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,
-	0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea,
-	0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,
-	0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6,
-	0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,
-	0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee,
-	0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,
-	0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1,
-	0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,
-	0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9,
-	0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,
-	0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5,
-	0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,
-	0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed,
-	0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,
-	0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3,
-	0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,
-	0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb,
-	0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,
-	0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7,
-	0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,
-	0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef,
-	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff
-};
-EXPORT_SYMBOL_GPL(gigaset_invtab);
-
 void gigaset_dbg_buffer(enum debuglevel level, const unsigned char *msg,
 			size_t len, const unsigned char *buf)
 {
Index: work-fault-inject/drivers/isdn/gigaset/gigaset.h
===================================================================
--- work-fault-inject.orig/drivers/isdn/gigaset/gigaset.h
+++ work-fault-inject/drivers/isdn/gigaset/gigaset.h
@@ -876,10 +876,6 @@ static inline void gigaset_rcv_error(str
 	}
 }
 
-
-/* bitwise byte inversion table */
-extern __u8 gigaset_invtab[];	/* in common.c */
-
 /* append received bytes to inbuf */
 int gigaset_fill_inbuf(struct inbuf_t *inbuf, const unsigned char *src,
 		       unsigned numbytes);
Index: work-fault-inject/drivers/isdn/gigaset/isocdata.c
===================================================================
--- work-fault-inject.orig/drivers/isdn/gigaset/isocdata.c
+++ work-fault-inject/drivers/isdn/gigaset/isocdata.c
@@ -14,6 +14,7 @@
 
 #include "gigaset.h"
 #include <linux/crc-ccitt.h>
+#include <linux/bitrev.h>
 
 /* access methods for isowbuf_t */
 /* ============================ */
@@ -487,7 +488,7 @@ static inline int trans_buildframe(struc
 	gig_dbg(DEBUG_STREAM, "put %d bytes", count);
 	write = atomic_read(&iwb->write);
 	do {
-		c = gigaset_invtab[*in++];
+		c = bitrev8(*in++);
 		iwb->data[write++] = c;
 		write %= BAS_OUTBUFSIZE;
 	} while (--count > 0);
@@ -876,7 +877,7 @@ static inline void trans_receive(unsigne
 	while (count > 0) {
 		dst = skb_put(skb, count < dobytes ? count : dobytes);
 		while (count > 0 && dobytes > 0) {
-			*dst++ = gigaset_invtab[*src++];
+			*dst++ = bitrev8(*src++);
 			count--;
 			dobytes--;
 		}
Index: work-fault-inject/drivers/isdn/gigaset/asyncdata.c
===================================================================
--- work-fault-inject.orig/drivers/isdn/gigaset/asyncdata.c
+++ work-fault-inject/drivers/isdn/gigaset/asyncdata.c
@@ -15,6 +15,7 @@
 
 #include "gigaset.h"
 #include <linux/crc-ccitt.h>
+#include <linux/bitrev.h>
 
 //#define GIG_M10x_STUFF_VOICE_DATA
 
@@ -302,7 +303,7 @@ static inline int iraw_loop(unsigned cha
 				inputstate |= INS_skip_frame;
 				break;
 			}
-			*__skb_put(skb, 1) = gigaset_invtab[c];
+			*__skb_put(skb, 1) = bitrev8(c);
 		}
 
 		if (unlikely(!numbytes))
@@ -543,7 +544,7 @@ static struct sk_buff *iraw_encode(struc
 	cp = skb->data;
 	len = skb->len;
 	while (len--) {
-		c = gigaset_invtab[*cp++];
+		c = bitrev8(*cp++);
 		if (c == DLE_FLAG)
 			*(skb_put(iraw_skb, 1)) = c;
 		*(skb_put(iraw_skb, 1)) = c;
Index: work-fault-inject/drivers/isdn/gigaset/Kconfig
===================================================================
--- work-fault-inject.orig/drivers/isdn/gigaset/Kconfig
+++ work-fault-inject/drivers/isdn/gigaset/Kconfig
@@ -5,6 +5,7 @@ config ISDN_DRV_GIGASET
 	tristate "Siemens Gigaset support (isdn)"
 	depends on ISDN_I4L
 	select CRC_CCITT
+	select BITREVERSE
 	help
 	  Say m here if you have a Gigaset or Sinus isdn device.
 
