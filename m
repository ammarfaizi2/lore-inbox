Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261267AbVCFBhT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVCFBhT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 20:37:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVCFBhT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 20:37:19 -0500
Received: from a26.t1.student.liu.se ([130.236.221.26]:29860 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S261267AbVCFBhF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 20:37:05 -0500
Message-ID: <422A5EBD.3050307@drzeus.cx>
Date: Sun, 06 Mar 2005 02:37:01 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_hades.drzeus.cx-27594-1110073108-0001-2"
To: Russell King <rmk+lkml@arm.linux.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>, Ian Molton <spyro@f2s.com>,
       Richard Purdie <rpurdie@rpsys.net>
Subject: Re: [PATCH][MMC][1/6] Secure Digital (SD) support : protocol
References: <422701A0.8030408@drzeus.cx> <20050305113730.B26541@flint.arm.linux.org.uk> <4229A4B4.1000208@drzeus.cx> <20050305124420.A342@flint.arm.linux.org.uk> <422A5E1C.2050107@drzeus.cx>
In-Reply-To: <422A5E1C.2050107@drzeus.cx>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_hades.drzeus.cx-27594-1110073108-0001-2
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Protocol definitions.

The basic commands needed for the later patches. The R1_APP_CMD seems to 
be misdefined in protocol.h so this patch changes it.


--=_hades.drzeus.cx-27594-1110073108-0001-2
Content-Type: text/x-patch; name="mmc-sd-protocol.patch"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mmc-sd-protocol.patch"

Index: linux-sd/include/linux/mmc/mmc.h
===================================================================
--- linux-sd/include/linux/mmc/mmc.h	(revision 135)
+++ linux-sd/include/linux/mmc/mmc.h	(working copy)
@@ -37,6 +37,7 @@
 #define MMC_RSP_R1B	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_BUSY)
 #define MMC_RSP_R2	(MMC_RSP_LONG|MMC_RSP_CRC)
 #define MMC_RSP_R3	(MMC_RSP_SHORT)
+#define MMC_RSP_R6	(MMC_RSP_SHORT|MMC_RSP_CRC)
 
 	unsigned int		retries;	/* max number of retries */
 	unsigned int		error;		/* command error */
Index: linux-sd/include/linux/mmc/protocol.h
===================================================================
--- linux-sd/include/linux/mmc/protocol.h	(revision 135)
+++ linux-sd/include/linux/mmc/protocol.h	(working copy)
@@ -76,6 +76,16 @@
 #define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1  */
 #define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1b */
 
+/* SD commands                           type  argument     response */
+  /* class 8 */
+/* This is basically the same command as for MMC with some quirks. */
+#define SD_SEND_RELATIVE_ADDR     3   /* ac                      R6  */
+
+  /* Application commands */
+#define SD_APP_SET_BUS_WIDTH      6   /* ac   [1:0] bus width    R1  */
+#define SD_APP_OP_COND           41   /* bcr  [31:0] OCR         R3  */
+#define SD_APP_SEND_SCR          51   /* adtc                    R1  */
+
 /*
   MMC status in R1
   Type
@@ -113,7 +123,7 @@
 #define R1_STATUS(x)            (x & 0xFFFFE000)
 #define R1_CURRENT_STATE(x)    	((x & 0x00001E00) >> 9)	/* sx, b (4 bits) */
 #define R1_READY_FOR_DATA	(1 << 8)	/* sx, a */
-#define R1_APP_CMD		(1 << 7)	/* sr, c */
+#define R1_APP_CMD		(1 << 5)	/* sr, c */
 
 /* These are unpacked versions of the actual responses */
 

--=_hades.drzeus.cx-27594-1110073108-0001-2--
