Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263848AbUDPVxF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:53:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263875AbUDPVwz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:52:55 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:13728 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S263848AbUDPVwP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:52:15 -0400
Date: Fri, 16 Apr 2004 22:50:37 +0100
From: Dave Jones <davej@redhat.com>
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: jgarzik@pobox.com, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: rcpci45 dereference fix.
Message-ID: <20040416215037.GV20937@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Francois Romieu <romieu@fr.zoreil.com>, jgarzik@pobox.com,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040416212342.GG25240@redhat.com> <20040416224506.A2769@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040416224506.A2769@electric-eye.fr.zoreil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 16, 2004 at 10:45:06PM +0200, Francois Romieu wrote:

 > rcpci45_init_one() must succeed in order for rcpci45_remove_one() to be
 > issued.
 > 
 > If rcpci45_init_one() succeeds, dev can not be NULL.
 > 
 > So I'd rather see the "if (!dev) {" test removed instead of this change.

Sure.

		Dave

--- drivers/net/rcpci45.c~	2004-04-16 22:22:22.000000000 +0100
+++ drivers/net/rcpci45.c	2004-04-16 22:49:54.000000000 +0100
@@ -131,12 +131,6 @@
 	struct net_device *dev = pci_get_drvdata (pdev);
 	PDPA pDpa = dev->priv;
 
-	if (!dev) {
-		printk (KERN_ERR "%s: remove non-existent device\n",
-				dev->name);
-		return;
-	}
-
 	RCResetIOP (dev);
 	unregister_netdev (dev);
 	free_irq (dev->irq, dev);
