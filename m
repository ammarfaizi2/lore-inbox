Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262517AbUCRLC4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 06:02:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUCRLCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 06:02:55 -0500
Received: from m244.net81-65-141.noos.fr ([81.65.141.244]:45799 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S261748AbUCRLBW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 06:01:22 -0500
Date: Thu, 18 Mar 2004 12:01:19 +0100
From: Stelian Pop <stelian@popies.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: akpm@osdl.org
Subject: [PATCH 2.6] netpoll for pcnet_cs
Message-ID: <20040318110119.GL2781@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	akpm@osdl.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch adds netpoll support to pcnet_cs. Tested with
the netconsole facility.

Please apply.

Stelian.

===== drivers/net/pcmcia/pcnet_cs.c 1.31 vs edited =====
--- 1.31/drivers/net/pcmcia/pcnet_cs.c	Tue Feb 10 01:54:48 2004
+++ edited/drivers/net/pcmcia/pcnet_cs.c	Wed Mar 17 12:21:28 2004
@@ -722,6 +722,10 @@
     link->dev = &info->node;
     link->state &= ~DEV_CONFIG_PENDING;
 
+#ifdef CONFIG_NET_POLL_CONTROLLER
+    dev->poll_controller = ei_poll;
+#endif
+
     if (register_netdev(dev) != 0) {
 	printk(KERN_NOTICE "pcnet_cs: register_netdev() failed\n");
 	link->dev = NULL;
-- 
Stelian Pop <stelian@popies.net>
