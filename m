Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266048AbUBBUEO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 15:04:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266038AbUBBUDg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 15:03:36 -0500
Received: from mailr-2.tiscali.it ([212.123.84.82]:40084 "EHLO
	mailr-2.tiscali.it") by vger.kernel.org with ESMTP id S266000AbUBBUB4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 15:01:56 -0500
Date: Mon, 2 Feb 2004 21:01:56 +0100
From: Kronos <kronos@kronoz.cjb.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: [Compile Regression in 2.4.25-pre8][PATCH 33/42]
Message-ID: <20040202200156.GG6785@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040130204956.GA21643@dreamland.darkstar.lan> <Pine.LNX.4.58L.0401301855410.3140@logos.cnet> <20040202180940.GA6367@dreamland.darkstar.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040202180940.GA6367@dreamland.darkstar.lan>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


pci-pc.c:180:1: warning: "PCI_CONF1_ADDRESS" redefined
pci-pc.c:58:1: warning: this is the location of the previous definition

PCI_CONF1_ADDRESS is defined on line 58 #if CONFIG_MULTIQUAD. It's
redefined on line 180 (outside #if CONFIG_MULTIQUAD). I added an #undef
right before the end of the CONFIG_MULTIQUAD block.

diff -Nru -X dontdiff linux-2.4-vanilla/arch/i386/kernel/pci-pc.c linux-2.4/arch/i386/kernel/pci-pc.c
--- linux-2.4-vanilla/arch/i386/kernel/pci-pc.c	Tue Nov 11 17:51:38 2003
+++ linux-2.4/arch/i386/kernel/pci-pc.c	Sat Jan 31 18:51:22 2004
@@ -175,6 +175,7 @@
 	pci_conf1_write_mq_config_word,
 	pci_conf1_write_mq_config_dword
 };
+#undef PCI_CONF1_ADDRESS
 
 #endif /* !CONFIG_MULTIQUAD */
 #define PCI_CONF1_ADDRESS(bus, dev, fn, reg) \

-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
"Fare l'amore con dieci donne e` fantastico, soprattutto perche` ti
 presentano un sacco di amiche." -- Fabio Di Iorio
