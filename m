Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266038AbUBBUEP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:04:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266010AbUBBUDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:03:25 -0500
Received: from mailr-1.tiscali.it ([212.123.84.81]:13951 "EHLO
	mailr-1.tiscali.it") by vger.kernel.org with ESMTP id S265956AbUBBUB2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:01:28 -0500
X-BrightmailFiltered: true
Date: Mon, 2 Feb 2004 21:01:27 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 32/42]
Message-ID: <20040202200127.GF6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ns83820.c:1708: warning: `ns83820_probe_phy' defined but not used

ns83820_probe_phy is still incomplete. Wrap it with #ifdef
PHY_CODE_IS_FINISHED as in other part of the driver.

diff -Nru -X dontdiff linux-2.4-vanilla/drivers/net/ns83820.c linux-2.4/drivers/net/ns83820.c
--- linux-2.4-vanilla/drivers/net/ns83820.c	Sat Jan 31 15:54:42 2004
+++ linux-2.4/drivers/net/ns83820.c	Sat Jan 31 18:38:16 2004
@@ -1704,6 +1704,7 @@
 	return data;
 }
 
+#ifdef PHY_CODE_IS_FINISHED
 static void ns83820_probe_phy(struct ns83820 *dev)
 {
 	static int first;
@@ -1757,6 +1758,7 @@
 		dprintk("version: 0x%04x 0x%04x\n", a, b);
 	}
 }
+#endif
 
 static int __devinit ns83820_init_one(struct pci_dev *pci_dev, const struct pci_device_id *id)
 {

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
It can't rain forever,
but you can die before seeing the sun again.
