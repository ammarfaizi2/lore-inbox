Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262001AbVBUOs2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262001AbVBUOs2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 09:48:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVBUOs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 09:48:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38924 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261991AbVBUOrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 09:47:49 -0500
Date: Mon, 21 Feb 2005 15:47:48 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/net/lp486e.c: make some code static
Message-ID: <20050221144748.GB3187@stusta.de>
References: <20050217205454.GI6194@stusta.de> <42193DA2.9050606@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42193DA2.9050606@pobox.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 20, 2005 at 08:47:14PM -0500, Jeff Garzik wrote:
>...
> >+#if 0
> >+static char *CUcmdnames[8] = { "NOP", "IASetup", "Configure", 
> >"MulticastList",
> >+			       "Tx", "TDR", "Dump", "Diagnose" };
> >+#endif
> 
> Need const.


Updated patch:


<--  snip  -->


This patch makes some needlessly global code static and makes
CUcmdnames const.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/net/lp486e.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

--- linux-2.6.11-rc3-mm2-full/drivers/net/lp486e.c.old	2005-02-16 16:08:34.000000000 +0100
+++ linux-2.6.11-rc3-mm2-full/drivers/net/lp486e.c	2005-02-16 16:15:33.000000000 +0100
@@ -112,8 +112,10 @@
 	CmdDiagnose = 7
 };
 
-char *CUcmdnames[8] = { "NOP", "IASetup", "Configure", "MulticastList",
-			"Tx", "TDR", "Dump", "Diagnose" };
+#if 0
+static const char *CUcmdnames[8] = { "NOP", "IASetup", "Configure", "MulticastList",
+				     "Tx", "TDR", "Dump", "Diagnose" };
+#endif
 
 /* Status word bits */
 #define	STAT_CX		0x8000	/* The CU finished executing a command
@@ -960,7 +962,7 @@
 		(unsigned char) add[12], (unsigned char) add[13]);
 }
 
-int __init lp486e_probe(struct net_device *dev) {
+static int __init lp486e_probe(struct net_device *dev) {
 	struct i596_private *lp;
 	unsigned char eth_addr[6] = { 0, 0xaa, 0, 0, 0, 0 };
 	unsigned char *bios;


