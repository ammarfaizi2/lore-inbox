Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262801AbVAFJ7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbVAFJ7g (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 04:59:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262802AbVAFJ7e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 04:59:34 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:37048 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S262801AbVAFJ72 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 04:59:28 -0500
Date: Thu, 6 Jan 2005 10:59:20 +0100
From: Jan Kasprzak <kas@fi.muni.cz>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH, repost] cosa.c intialization crash
Message-ID: <20050106095920.GE6961@fi.muni.cz>
References: <20041202124022.GE11992@fi.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041202124022.GE11992@fi.muni.cz>
User-Agent: Mutt/1.4.1i
X-Muni-Spam-TestIP: 147.251.48.42
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Linus, please apply the attached patch (I am reposting this again).
Without this, the cosa driver crashes immediately during insmod.

Original mail:

	The attached patch fixes crash on insmod of the cosa.ko module
- the sppp_attach() was called too early when dev->priv has not been
set up yet. Linus, please apply.

Signed-off-by: Jan "Yenya" Kasprzak <kas@fi.muni.cz>

--- linux-2.6.10-rc2/drivers/net/wan/cosa.c.orig	2004-12-02 13:33:00.650293092 +0100
+++ linux-2.6.10-rc2/drivers/net/wan/cosa.c	2004-11-15 02:26:39.000000000 +0100
@@ -642,11 +642,11 @@
 		return;
 	}
 	chan->pppdev.dev = d;
-	sppp_attach(&chan->pppdev);
 	d->base_addr = chan->cosa->datareg;
 	d->irq = chan->cosa->irq;
 	d->dma = chan->cosa->dma;
 	d->priv = chan;
+	sppp_attach(&chan->pppdev);
 	if (register_netdev(d)) {
 		printk(KERN_WARNING "%s: register_netdev failed.\n", d->name);
 		sppp_detach(d);
-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
> Whatever the Java applications and desktop dances may lead to, Unix will <
> still be pushing the packets around for a quite a while.      --Rob Pike <
