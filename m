Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262155AbTHTSvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 14:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262156AbTHTSvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 14:51:19 -0400
Received: from havoc.gtf.org ([63.247.75.124]:61060 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S262155AbTHTSvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 14:51:16 -0400
Date: Wed, 20 Aug 2003 14:51:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [rfc][patch] increase irq 12 penalty
Message-ID: <20030820185116.GG23984@gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is something that Red Hat ships in its kernel.  I was thinking it
belonged upstream, but was told "Alan rejected it; reason forgotten" :)

Here is the logic for the patch:
> It makes the "pick any IRQ" code in the kernel not pick irq12 by default.
> irq12 is the ps/2 irq that gets emulated by smm on laptops.
> Using that can be sudden death on several machines.
> So the patch makes the cost of using it higher than the other irq's.

Arjan, one of our RH kernel rpm maintainers, also adds:
> for all I know it's totally wrong
> but it fixed some machines and it doesn't seem to break any

So I thought I would send it to lkml for comments.  RH has been carrying
this for a while...


diff -urNp linux-1090/arch/i386/kernel/pci-irq.c linux-1100/arch/i386/kernel/pci-irq.c
--- linux-1090-arch-i386/kernel/pci-irq.c	
+++ linux-1100-arch-i386/kernel/pci-irq.c	
@@ -36,7 +36,7 @@ unsigned int pcibios_irq_mask = 0xfff8;
 
 static int pirq_penalty[16] = {
 	1000000, 1000000, 1000000, 1000, 1000, 0, 1000, 1000,
-	0, 0, 0, 0, 1000, 100000, 100000, 100000
+	0, 0, 0, 0, 2500, 100000, 100000, 100000
 };
 
 struct irq_router {



[note, patch pathnames mangled to prevent immediate application :)]
