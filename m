Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263824AbUGHNIe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbUGHNIe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jul 2004 09:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263804AbUGHND1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jul 2004 09:03:27 -0400
Received: from mail.donpac.ru ([80.254.111.2]:14779 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S264396AbUGHNBc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jul 2004 09:01:32 -0400
Subject: [PATCH 3/5] 2.6.7-mm6, CRC16 renaming in ISDN drivers
In-Reply-To: <10892916843577@donpac.ru>
X-Mailer: gregkh_patchbomb_levon_offspring
Date: Thu, 8 Jul 2004 17:01:27 +0400
Message-Id: <10892916872918@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Andrey Panin <pazke@donpac.ru>

 drivers/isdn/hisax/isdnhdlc.c    |    6 +++---
 drivers/isdn/hisax/st5481_hdlc.c |    6 +++---
 drivers/isdn/tpam/tpam_crcpc.c   |    8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/drivers/isdn/hisax/isdnhdlc.c linux-2.6.7-mm5/drivers/isdn/hisax/isdnhdlc.c
--- linux-2.6.7-mm5.vanilla/drivers/isdn/hisax/isdnhdlc.c	Thu Jul  1 20:58:08 2004
+++ linux-2.6.7-mm5/drivers/isdn/hisax/isdnhdlc.c	Thu Jul  1 22:47:30 2004
@@ -22,7 +22,7 @@
 
 #include <linux/module.h>
 #include <linux/init.h>
-#include <linux/crc16.h>
+#include <linux/crc-ccitt.h>
 #include "isdnhdlc.h"
 
 /*-------------------------------------------------------------------*/
@@ -305,7 +305,7 @@ int isdnhdlc_decode (struct isdnhdlc_var
 			if(hdlc->data_bits==8){
 				hdlc->data_bits = 0;
 				hdlc->data_received = 1;
-				hdlc->crc = crc16_byte(hdlc->crc, hdlc->shift_reg);
+				hdlc->crc = crc_ccitt_byte(hdlc->crc, hdlc->shift_reg);
 
 				// good byte received
 				if (dsize--) {
@@ -482,7 +482,7 @@ int isdnhdlc_encode(struct isdnhdlc_vars
 				break;
 			}
 			if(hdlc->bit_shift==8){
-				hdlc->crc = crc16_byte(hdlc->crc, hdlc->shift_reg);
+				hdlc->crc = crc_ccitt_byte(hdlc->crc, hdlc->shift_reg);
 			}
 			if(hdlc->shift_reg & 0x01){
 				hdlc->hdlc_bits1++;
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/drivers/isdn/hisax/st5481_hdlc.c linux-2.6.7-mm5/drivers/isdn/hisax/st5481_hdlc.c
--- linux-2.6.7-mm5.vanilla/drivers/isdn/hisax/st5481_hdlc.c	Thu Jul  1 20:58:08 2004
+++ linux-2.6.7-mm5/drivers/isdn/hisax/st5481_hdlc.c	Thu Jul  1 22:47:08 2004
@@ -10,7 +10,7 @@
  *
  */
 
-#include <linux/crc16.h>
+#include <linux/crc-ccitt.h>
 #include "st5481_hdlc.h"
 
 
@@ -262,7 +262,7 @@ int hdlc_decode(struct hdlc_vars *hdlc, 
 			if(hdlc->data_bits==8){
 				hdlc->data_bits = 0;
 				hdlc->data_received = 1;
-				hdlc->crc = crc16_byte(hdlc->crc, hdlc->shift_reg);
+				hdlc->crc = crc_ccitt_byte(hdlc->crc, hdlc->shift_reg);
 
 				// good byte received
 				if (dsize--) {
@@ -439,7 +439,7 @@ int hdlc_encode(struct hdlc_vars *hdlc, 
 				break;
 			}
 			if(hdlc->bit_shift==8){
-				hdlc->crc = crc16_byte(hdlc->crc, hdlc->shift_reg);
+				hdlc->crc = crc_ccitt_byte(hdlc->crc, hdlc->shift_reg);
 			}
 			if(hdlc->shift_reg & 0x01){
 				hdlc->hdlc_bits1++;
diff -urpN -X /usr/share/dontdiff linux-2.6.7-mm5.vanilla/drivers/isdn/tpam/tpam_crcpc.c linux-2.6.7-mm5/drivers/isdn/tpam/tpam_crcpc.c
--- linux-2.6.7-mm5.vanilla/drivers/isdn/tpam/tpam_crcpc.c	Thu Jul  1 20:58:09 2004
+++ linux-2.6.7-mm5/drivers/isdn/tpam/tpam_crcpc.c	Thu Jul  1 22:46:06 2004
@@ -27,7 +27,7 @@ Revision History:
 
 ---------------------------------------------------------------------------*/
 
-#include <linux/crc16.h>
+#include <linux/crc-ccitt.h>
 #include "tpam.h"
 
 #define  HDLC_CTRL_CHAR_CMPL_MASK	0x20	/* HDLC control character complement mask */
@@ -85,7 +85,7 @@ void hdlc_encode_modem(u8 *buffer_in, u3
 		/*
 		 *   FCS calculation
 		 */
-		fcs = crc16_byte(fcs, data);
+		fcs = crc_ccitt_byte(fcs, data);
 
 		ESCAPE_CHAR(p_data_out, data);
 	}
@@ -121,7 +121,7 @@ void hdlc_no_accm_encode(u8 *buffer_in, 
 	while (lng_in--) {
 		data = *buffer_in++;
 		/* calculate FCS */
-		fcs = crc16_byte(fcs, data);
+		fcs = crc_ccitt_byte(fcs, data);
 		*p_data_out++ = data;
 	}
 
@@ -151,7 +151,7 @@ u32 hdlc_no_accm_decode(u8 *buffer_in, u
 	while (lng_in--) {
 		data = *buffer_in++;
 		/* calculate FCS */
-		fcs = crc16_byte(fcs, data);
+		fcs = crc_ccitt_byte(fcs, data);
 	}
 
 	if (fcs == HDLC_FCS_OK) 

