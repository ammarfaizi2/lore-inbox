Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753838AbWKFVhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753838AbWKFVhY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 16:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753835AbWKFVhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 16:37:24 -0500
Received: from smtp.osdl.org ([65.172.181.4]:37827 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1753836AbWKFVhV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 16:37:21 -0500
Date: Mon, 6 Nov 2006 13:36:36 -0800
From: Judith Lebzelter <judith@osdl.org>
To: linuxppc-dev@ozlabs.org
Cc: paulus@au.ibm.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] 2.6.19-rc4-mm2 iseries net_device compile issue
Message-ID: <20061106213636.GA1339@shell0.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

2.6.19-rc4-mm2 has this error for 'powerpc' allmodconfig:

drivers/net/iseries_veth.c: In function 'veth_probe_one':
drivers/net/iseries_veth.c:1103: error: 'struct net_device' has no member named 'class_dev'

This patch fixes the error.

Signed-off-by: Judith Lebzelter <judith@osdl.org>
---
Files edited:
drivers/net/iseries_veth.c
---

Index: linux/drivers/net/iseries_veth.c
===================================================================
--- linux.orig/drivers/net/iseries_veth.c	2006-11-02 13:59:38.000000000 -0800
+++ linux/drivers/net/iseries_veth.c	2006-11-02 14:05:44.000000000 -0800
@@ -1100,7 +1100,7 @@
 	}
 
 	kobject_init(&port->kobject);
-	port->kobject.parent = &dev->class_dev.kobj;
+	port->kobject.parent = &dev->dev.kobj;
 	port->kobject.ktype  = &veth_port_ktype;
 	kobject_set_name(&port->kobject, "veth_port");
 	if (0 != kobject_add(&port->kobject))
