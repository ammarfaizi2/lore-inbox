Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266777AbUHMS4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266777AbUHMS4Z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 14:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266807AbUHMS4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 14:56:25 -0400
Received: from fep02fe.ttnet.net.tr ([212.156.4.132]:36828 "EHLO
	fep02.ttnet.net.tr") by vger.kernel.org with ESMTP id S266777AbUHMS4Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 14:56:16 -0400
Message-ID: <411D0E9C.7010707@ttnet.net.tr>
Date: Fri, 13 Aug 2004 21:55:24 +0300
From: "O.Sezer" <sezeroz@ttnet.net.tr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: tr, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [PATCH 2.4] various size fixes
Content-Type: multipart/mixed;
	boundary="------------090602090909030506030501"
X-ESAFE-STATUS: Mail clean
X-ESAFE-DETAILS: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090602090909030506030501
Content-Type: text/plain;
	charset=ISO-8859-9;
	format=flowed
Content-Transfer-Encoding: quoted-printable

Misc size fixes which also cure some compiler warnings.

=D6zkan Sezer


--------------090602090909030506030501
Content-Type: text/plain;
	name="SIZE-fixes1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename="SIZE-fixes1.diff"

--- 27rc5~/include/linux/scc.h	2001-04-12 22:20:31.000000000 +0300
+++ 27rc5/include/linux/scc.h	2004-08-07 14:09:39.000000000 +0300
@@ -200,7 +200,7 @@
 	unsigned char fulldup;		/* Full Duplex mode 0=CSMA 1=DUP 2=ALWAYS KEYED */
 	unsigned char waittime;		/* Waittime before any transmit attempt */
 	unsigned int  maxkeyup;		/* Maximum time to transmit (seconds) */
-	unsigned char mintime;		/* Minimal offtime after MAXKEYUP timeout (seconds) */
+	unsigned int  mintime;		/* Minimal offtime after MAXKEYUP timeout (seconds) */
 	unsigned int  idletime;		/* Maximum idle time in ALWAYS KEYED mode (seconds) */
 	unsigned int  maxdefer;		/* Timer for CSMA channel busy limit */
 	unsigned char tx_inhibit;	/* Transmit is not allowed when set */	
--- 27rc5~/drivers/hotplug/cpqphp_pci.c	2003-11-28 20:26:20.000000000 +0200
+++ 27rc5/drivers/hotplug/cpqphp_pci.c	2004-08-07 14:09:39.000000000 +0300
@@ -387,7 +387,8 @@
 
 static int PCI_ScanBusForNonBridge(struct controller *ctrl, u8 bus_num, u8 * dev_num)
 {
-	u8 tdevice;
+	u16 tdevice;
 	u32 work;
 	u8 tbus;
 
--- 27rc5~/drivers/isdn/eicon/fourbri.c	2001-09-30 22:26:05.000000000 +0300
+++ 27rc5/drivers/isdn/eicon/fourbri.c	2004-08-07 14:09:39.000000000 +0300
@@ -337,7 +337,8 @@
 static int diva_server_4bri_start(card_t *card, byte *channels)
 {
 	byte *ctl;
-	byte *shared, i;
+	byte *shared;
+	int i;
 	int adapter_num;
 
 	DPRINTF(("divas: start Diva Server 4BRI"));
--- 27rc5~/drivers/net/tokenring/3c359.c	2003-06-13 17:51:35.000000000 +0300
+++ 27rc5/drivers/net/tokenring/3c359.c	2004-08-07 14:09:39.000000000 +0300
@@ -389,7 +389,7 @@
     	struct xl_private *xl_priv = (struct xl_private *)dev->priv ;
 	u8 *xl_mmio = xl_priv->xl_mmio ; 
 	unsigned long t ; 
-	u16 i ; 
+	u32 i ;
     	u16 result_16 ; 
 	u8 result_8 ;
 	u16 start ; 


--------------090602090909030506030501--
