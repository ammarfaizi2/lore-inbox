Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267986AbTAMSan>; Mon, 13 Jan 2003 13:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267995AbTAMSan>; Mon, 13 Jan 2003 13:30:43 -0500
Received: from covert.black-ring.iadfw.net ([209.196.123.142]:64775 "EHLO
	covert.brown-ring.iadfw.net") by vger.kernel.org with ESMTP
	id <S267986AbTAMSal>; Mon, 13 Jan 2003 13:30:41 -0500
Date: Mon, 13 Jan 2003 12:39:30 -0600
From: Art Haas <ahaas@airmail.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PnP fix for latest BK Kernel
Message-ID: <20030113183930.GA2336@pcdebian.artsapartment.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I need the following to avoid the following errors when trying to build
the latest BK-Kernel ...

drivers/built-in.o(.init.text+0x2dfb): In function `isapnp_init':
: undefined reference to `isapnp_card_protocol'
drivers/built-in.o(.init.text+0x2e04): In function `isapnp_init':
: undefined reference to `isapnp_card_protocol'
drivers/built-in.o(.init.text+0x2e76): In function `isapnp_init':
: undefined reference to `isapnp_card_protocol'

The "isapnp_card_protocol" structure was removed in revision 1.25 of
core.c, but it's usage was readded in revision 1.27. The command

"bk revtool drivers/pnp/isapnp/core.c"

will show this.

There is also difference between rev 1.25.1.1 and 1.28 with using
subsys_initcall() -vs- device_initcall(). I don't know which should be
used.

Art Haas

===== drivers/pnp/isapnp/core.c 1.28 vs edited =====
--- 1.28/drivers/pnp/isapnp/core.c	Sun Jan 12 13:47:36 2003
+++ edited/drivers/pnp/isapnp/core.c	Mon Jan 13 11:41:54 2003
@@ -1125,7 +1125,7 @@
 	isapnp_build_device_list();
 	cards = 0;
 
-	protocol_for_each_card(&isapnp_card_protocol,card) {
+	protocol_for_each_card(&isapnp_protocol,card) {
 		cards++;
 		if (isapnp_verbose) {
 			printk(KERN_INFO "isapnp: Card '%s'\n", card->name[0]?card->name:"Unknown");
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
