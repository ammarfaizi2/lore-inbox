Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbVBIDC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbVBIDC3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 22:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261767AbVBIDB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 22:01:56 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:24840 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261765AbVBIDAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 22:00:24 -0500
Date: Wed, 9 Feb 2005 04:00:21 +0100
From: Adrian Bunk <bunk@stusta.de>
To: kkeil@suse.de, kai.germaschewski@gmx.de
Cc: isdn4linux@listserv.isdn4linux.de, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/isdn/tpam/: possible cleanups
Message-ID: <20050209030021.GF2978@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the following possible cleanups:
- tpam_hdlc.c: make the needlessly global variable stuffs static
- tpam_nco.c: remove the unused global function build_ADestroyNCOReq

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/isdn/tpam/tpam.h      |    1 -
 drivers/isdn/tpam/tpam_hdlc.c |    2 +-
 drivers/isdn/tpam/tpam_nco.c  |   27 ---------------------------
 3 files changed, 1 insertion(+), 29 deletions(-)

--- linux-2.6.11-rc3-mm1-full/drivers/isdn/tpam/tpam_hdlc.c.old	2005-02-09 03:39:54.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/tpam/tpam_hdlc.c	2005-02-09 03:40:02.000000000 +0100
@@ -548,7 +548,7 @@
 
 
 static WORD * stuffs[] = { stuff0, stuff1, stuff2, stuff3, stuff4, stuff5 };
-WORD * destuffs[] = { destuff0, destuff1, destuff2, destuff3, destuff4, destuff5 };
+static WORD * destuffs[] = { destuff0, destuff1, destuff2, destuff3, destuff4, destuff5 };
 
 
 /*- AuverTech Telecom -------------------------------------------------------+
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/tpam/tpam.h.old	2005-02-09 03:40:16.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/tpam/tpam.h	2005-02-09 03:40:21.000000000 +0100
@@ -181,7 +181,6 @@
 
 /* Function prototypes from tpam_nco.c */
 extern struct sk_buff *build_ACreateNCOReq(const u8 *);
-extern struct sk_buff *build_ADestroyNCOReq(u32);
 extern struct sk_buff *build_CConnectReq(u32, const u8 *, u8);
 extern struct sk_buff *build_CConnectRsp(u32);
 extern struct sk_buff *build_CDisconnectReq(u32);
--- linux-2.6.11-rc3-mm1-full/drivers/isdn/tpam/tpam_nco.c.old	2005-02-09 03:40:29.000000000 +0100
+++ linux-2.6.11-rc3-mm1-full/drivers/isdn/tpam/tpam_nco.c	2005-02-09 03:42:52.000000000 +0100
@@ -131,33 +131,6 @@
 }
 
 /*
- * Build a ADestroyNCOReq message.
- *
- * 	ncoid: the NCO id.
- *
- * Return: the sk_buff filled with the NCO packet, or NULL if error.
- */
-struct sk_buff *build_ADestroyNCOReq(u32 ncoid) {
-	struct sk_buff *skb;
-	u8 *tlv;
-
-	pr_debug("TurboPAM(build_ADestroyNCOReq): ncoid=%lu\n",
-		(unsigned long)ncoid);
-
-	/* build the NCO packet */
-	if (!(skb = build_NCOpacket(ID_ADestroyNCOReq, 6, 0, 0, 0)))
-		return NULL;
-	
-	/* add the parameters */
-	tlv = (u8 *)skb_put(skb, 6);
-	*tlv = PAR_NCOID;
-	*(tlv+1) = 4;
-	*((u32 *)(tlv+2)) = ncoid;
-
-	return skb;
-}
-
-/*
  * Build a CConnectReq message.
  *
  * 	ncoid: the NCO id.

