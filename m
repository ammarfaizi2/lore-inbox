Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263809AbUDPV1N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263805AbUDPV1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:27:12 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:22687 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263809AbUDPV0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:26:17 -0400
Date: Fri, 16 Apr 2004 22:25:07 +0100
From: Dave Jones <davej@redhat.com>
To: jgarzik@pobox.com
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: yam driver null deref
Message-ID: <20040416212507.GP20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, jgarzik@pobox.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- linux-2.6.5/drivers/net/hamradio/yam.c~	2004-04-16 22:24:00.000000000 +0100
+++ linux-2.6.5/drivers/net/hamradio/yam.c	2004-04-16 22:24:32.000000000 +0100
@@ -919,9 +919,12 @@
 static int yam_close(struct net_device *dev)
 {
 	struct sk_buff *skb;
-	struct yam_port *yp = (struct yam_port *) dev->priv;
+	struct yam_port *yp;
 
-	if (!dev || !yp)
+	if (!dev)
+		return -EINVAL;
+	yp = dev->priv;
+	if (!yp)
 		return -EINVAL;
 	/*
 	 * disable interrupts
