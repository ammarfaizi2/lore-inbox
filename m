Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263733AbUGHNCw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263733AbUGHNCw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:02:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUGHNCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:02:51 -0400
Received: from mail.donpac.ru ([80.254.111.2]:10939 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S263733AbUGHNB2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:01:28 -0400
Subject: [PATCH 1/5] 2.6.7-mm6, CRC16 renaming in AX25 drivers
In-Reply-To: <10892916781086@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 8 Jul 2004 17:01:21 +0400
Message-Id: <10892916813150@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Andrey Panin <pazke@donpac.ru>

 drivers/net/hamradio/baycom_epp.c |    6 +++---
 drivers/net/hamradio/hdlcdrv.c    |    6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/drivers/net/hamradio/baycom_epp.c linux-2.6.7-mm5/drivers/net/hamradio/baycom_epp.c
--- linux-2.6.7-mm5.vanilla/drivers/net/hamradio/baycom_epp.c	Thu Jul  1 20:58:11 2004
+++ linux-2.6.7-mm5/drivers/net/hamradio/baycom_epp.c	Thu Jul  1 22:48:50 2004
@@ -58,7 +58,7 @@
 /* prototypes for ax25_encapsulate and ax25_rebuild_header */
 #include <net/ax25.h> 
 #endif /* CONFIG_AX25 || CONFIG_AX25_MODULE */
-#include <linux/crc16.h>
+#include <linux/crc-ccitt.h>
 
 /* --------------------------------------------------------------------- */
 
@@ -281,14 +281,14 @@ static inline void append_crc_ccitt(unsi
 
 static inline int check_crc_ccitt(const unsigned char *buf, int cnt)
 {
-	return (crc16(0xffff, buf, cnt) & 0xffff) == 0xf0b8;
+	return (crc_ccitt(0xffff, buf, cnt) & 0xffff) == 0xf0b8;
 }
 
 /*---------------------------------------------------------------------------*/
 
 static inline int calc_crc_ccitt(const unsigned char *buf, int cnt)
 {
-	return (crc16(0xffff, buf, cnt) ^ 0xffff) & 0xffff;
+	return (crc_ccitt(0xffff, buf, cnt) ^ 0xffff) & 0xffff;
 }
 
 /* ---------------------------------------------------------------------- */
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/drivers/net/hamradio/hdlcdrv.c linux-2.6.7-mm5/drivers/net/hamradio/hdlcdrv.c
--- linux-2.6.7-mm5.vanilla/drivers/net/hamradio/hdlcdrv.c	Thu Jul  1 20:58:11 2004
+++ linux-2.6.7-mm5/drivers/net/hamradio/hdlcdrv.c	Thu Jul  1 22:48:27 2004
@@ -66,7 +66,7 @@
 #include <linux/ip.h>
 #include <linux/udp.h>
 #include <linux/tcp.h>
-#include <linux/crc16.h>
+#include <linux/crc-ccitt.h>
 
 /* --------------------------------------------------------------------- */
 
@@ -105,7 +105,7 @@ static char ax25_nocall[AX25_ADDR_LEN] =
 
 static inline void append_crc_ccitt(unsigned char *buffer, int len)
 {
- 	unsigned int crc = crc16(0xffff, buffer, len) ^ 0xffff;
+ 	unsigned int crc = crc_ccitt(0xffff, buffer, len) ^ 0xffff;
 	*buffer++ = crc;
 	*buffer++ = crc >> 8;
 }
@@ -114,7 +114,7 @@ static inline void append_crc_ccitt(unsi
 
 static inline int check_crc_ccitt(const unsigned char *buf, int cnt)
 {
-	return (crc16(0xffff, buf, cnt) & 0xffff) == 0xf0b8;
+	return (crc_ccitt(0xffff, buf, cnt) & 0xffff) == 0xf0b8;
 }
 
 /*---------------------------------------------------------------------------*/

