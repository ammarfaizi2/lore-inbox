Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263756AbUDPVVH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263761AbUDPVVH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:21:07 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:7327 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263756AbUDPVVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:21:03 -0400
Date: Fri, 16 Apr 2004 22:20:04 +0100
From: Dave Jones <davej@redhat.com>
To: jgarzik@pobox.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: baycom_par dereference before check.
Message-ID: <20040416212004.GO20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, jgarzik@pobox.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- linux-2.6.5/drivers/net/hamradio/baycom_par.c~	2004-04-16 22:18:53.000000000 +0100
+++ linux-2.6.5/drivers/net/hamradio/baycom_par.c	2004-04-16 22:19:33.000000000 +0100
@@ -272,9 +272,13 @@
 static void par96_interrupt(int irq, void *dev_id, struct pt_regs *regs)
 {
 	struct net_device *dev = (struct net_device *)dev_id;
-	struct baycom_state *bc = netdev_priv(dev);
+	struct baycom_state *bc;
 
-	if (!dev || !bc || bc->hdrv.magic != HDLCDRV_MAGIC)
+	if (!dev)
+		return;
+
+	bc = netdev_priv(dev);
+	if (!bc || bc->hdrv.magic != HDLCDRV_MAGIC)
 		return;
 
 	baycom_int_freq(bc);
