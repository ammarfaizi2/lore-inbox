Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265966AbUFOVWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbUFOVWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 17:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUFOVWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 17:22:38 -0400
Received: from mail.dif.dk ([193.138.115.101]:51625 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S265966AbUFOVWg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 17:22:36 -0400
Date: Tue, 15 Jun 2004 23:21:44 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel@vger.kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>, Dave Jones <davej@codemonkey.org.uk>
Subject: [PATCH] Very Trivial - make "After * identify, caps:" messages line
 up
Message-ID: <Pine.LNX.4.56.0406152310390.9908@jjulnx.backbone.dif.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Visually it's much easier to read/compare messages such as these

Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify, caps: 0183f9ff c1c7f9ff 00000000 00000000

if the numbers line up like this

Jun 15 19:09:02 dragon kernel: CPU:     After generic identify, caps: 0183f9ff c1c7f9ff 00000000 00000000
Jun 15 19:09:02 dragon kernel: CPU:     After vendor identify,  caps: 0183f9ff c1c7f9ff 00000000 00000000

/Very/ minor, trivial thing, yes, but those messages have been annoying my
eyes for a while now so I desided to make them line up - so, here's the
patch that does that (not sure if a signed-off-by line is needed even for
trivial stuff like this, but I assume it should go with everything, so...)
Patch is against 2.6.7-rc3-mm2

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.7-rc3-mm2-orig/arch/i386/kernel/cpu/common.c	2004-06-09 03:34:40.000000000 +0200
+++ linux-2.6.7-rc3-mm2/arch/i386/kernel/cpu/common.c	2004-06-15 23:11:41.000000000 +0200
@@ -338,7 +338,7 @@ void __init identify_cpu(struct cpuinfo_
 	if (this_cpu->c_identify) {
 		this_cpu->c_identify(c);

-	printk(KERN_DEBUG "CPU:     After vendor identify, caps: %08lx %08lx %08lx %08lx\n",
+	printk(KERN_DEBUG "CPU:     After vendor identify,  caps: %08lx %08lx %08lx %08lx\n",
 		c->x86_capability[0],
 		c->x86_capability[1],
 		c->x86_capability[2],


--
Jesper Juhl <juhl-lkml@dif.dk>

