Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbTLBSBk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 13:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262746AbTLBSBk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 13:01:40 -0500
Received: from host213.137.0.249.manx.net ([213.137.0.249]:32779 "EHLO server")
	by vger.kernel.org with ESMTP id S262719AbTLBSBf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 13:01:35 -0500
Date: Tue, 2 Dec 2003 18:01:33 +0000
From: Matthew Bell <m.bell@bvrh.co.uk>
To: Keith Owens <kaos@ocs.com.au>
Cc: becker@scyld.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][OBVIOUS] 3c515.c: Enable ISAPNP when built as a module.
Message-Id: <20031202180133.442704ea.m.bell@bvrh.co.uk>
In-Reply-To: <1778.1070335215@kao2.melbourne.sgi.com>
References: <20031202024028.49265a8f.m.bell@bvrh.co.uk>
	<1778.1070335215@kao2.melbourne.sgi.com>
Organization: Beach View Residential Home, Ltd.
X-Mailer: Sylpheed version 0.9.6claws (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_server-25041-1070388089-0001-2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_server-25041-1070388089-0001-2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Tue, 02 Dec 2003 14:20:15 +1100
Keith Owens <kaos@ocs.com.au> wrote:

>Your mailer wrapped the lines.

I include the patch as a plain text attachment this time; I hope as you are not
LT this doens't matter :)
 
> Only test CONFIG_ISAPNP || CONFIG_ISAPNP_MODULE, not MODULE.
> CONFIG_foo_MODULE can only be defined when MODULE is defined.
> 
> #if defined(CONFIG_ISAPNP) || defined(CONFIG_ISAPNP_MODULE)

I don't think so; from a brief look trhough Configure and Makefile, this only
happens when CONFIG_ISAPNP is declared as a dependency of the driver in
question. In this case it is optional so we have to check manually.

--=_server-25041-1070388089-0001-2
Content-Type: text/plain; name="3c515.diff"; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="3c515.diff"

--- linux-2.4.19.orig/drivers/net/3c515.c	2002-02-25 19:37:59.000000000 +0000
+++ linux-2.4.19/drivers/net/3c515.c	2002-08-03 18:24:05.000000000 +0100
@@ -370,7 +370,7 @@
 	{ "Default", 0, 0xFF, XCVR_10baseT, 10000},
 };
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined (CONFIG_ISAPNP_MODULE))
 static struct isapnp_device_id corkscrew_isapnp_adapters[] = {
 	{	ISAPNP_ANY_ID, ISAPNP_ANY_ID,
 		ISAPNP_VENDOR('T', 'C', 'M'), ISAPNP_FUNCTION(0x5051),
@@ -462,12 +462,12 @@
 {
 	int cards_found = 0;
 	static int ioaddr;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined (CONFIG_ISAPNP_MODULE))
 	short i;
 	static int pnp_cards;
 #endif
 
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined (CONFIG_ISAPNP_MODULE))
 	if(nopnp == 1)
 		goto no_pnp;
 	for(i=0; corkscrew_isapnp_adapters[i].vendor != 0; i++) {
@@ -530,7 +530,7 @@
 	/* Check all locations on the ISA bus -- evil! */
 	for (ioaddr = 0x100; ioaddr < 0x400; ioaddr += 0x20) {
 		int irq;
-#ifdef CONFIG_ISAPNP
+#if defined(CONFIG_ISAPNP) || (defined (MODULE) && defined (CONFIG_ISAPNP_MODULE))
 		/* Make sure this was not already picked up by isapnp */
 		if(ioaddr == corkscrew_isapnp_phys_addr[0]) continue;
 		if(ioaddr == corkscrew_isapnp_phys_addr[1]) continue;

--=_server-25041-1070388089-0001-2--
