Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268383AbTAMXEB>; Mon, 13 Jan 2003 18:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268388AbTAMXEB>; Mon, 13 Jan 2003 18:04:01 -0500
Received: from h-64-105-35-9.SNVACAID.covad.net ([64.105.35.9]:62097 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S268383AbTAMXEA>; Mon, 13 Jan 2003 18:04:00 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Mon, 13 Jan 2003 15:12:37 -0800
Message-Id: <200301132312.PAA31291@baldur.yggdrasil.com>
To: jgarzik@pobox.com, perex@suse.cz
Subject: Re: 2.5.57 missing isapnp_card_protocol
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, 13 Jan 2003, Jeff Garzik wrote:
>On Mon, Jan 13, 2003 at 02:09:49PM -0800, Adam J. Richter wrote:
>> 	Linux-2.5.57 deletes the definition of isapnp_card_protocol
>> and then adds some references to it.  So, the kernel does not link
>> if you have enabled ISA PnP support.  I'm not sure whether
>> isapnp_card_protocol is supposed to be removed or not.

>That's the fault of some random driver that hasn't been updated to the
>new isapnp API yet...

	A random driver like linux-2.5.57/drivers/isapnp/core.c, line
1128, which was changed _from_ referencing isapnp_protocol _to_
referencing isapnp_card_protocol?  Also, if isapnp_card_protocol is
supposed to be deleted, then presumably so should its extern
declaration at line 106 of the same file.

	Come to think of it, core.c is the only file that references
isapnp_card_protocol in 2.5.57.  _If_ isapnp_card_protocol really
should be deleted, then here is a patch for it.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."

--- linux-2.5.57/drivers/pnp/isapnp/core.c	2003-01-13 10:17:35.000000000 -0800
+++ linux/drivers/pnp/isapnp/core.c	2003-01-13 15:04:17.000000000 -0800
@@ -102,7 +102,6 @@
 /* some prototypes */
 
 static int isapnp_config_prepare(struct pnp_dev *dev);
-extern struct pnp_protocol isapnp_card_protocol;
 extern struct pnp_protocol isapnp_protocol;
 
 static inline void write_data(unsigned char x)
@@ -1125,7 +1124,7 @@
 	isapnp_build_device_list();
 	cards = 0;
 
-	protocol_for_each_card(&isapnp_card_protocol,card) {
+	protocol_for_each_card(&isapnp_protocol,card) {
 		cards++;
 		if (isapnp_verbose) {
 			printk(KERN_INFO "isapnp: Card '%s'\n", card->name[0]?card->name:"Unknown");
