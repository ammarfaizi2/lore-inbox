Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbUKYAld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbUKYAld (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 19:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbUKYAiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 19:38:50 -0500
Received: from mail.dif.dk ([193.138.115.101]:9612 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262909AbUKYAh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 19:37:28 -0500
Date: Thu, 25 Nov 2004 01:39:46 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Marc Zyngier <maz@wild-wind.fr.eu.org>
Subject: [patch][trivial] avoid signed/unsigned comparison in
 drivers/eisa/eisa-bus.c::eisa_name_device()
Message-ID: <Pine.LNX.4.61.0411250130540.3447@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is trivial and of questional importance, but I'll submit it 
none-the-less - feel free to drop/ignore.

The patch changes the 'i' variable in eisa_name_device() to be unsigned 
for no other reason than to avoid this warning when building with gcc -W :
drivers/eisa/eisa-bus.c: In function `eisa_name_device':
drivers/eisa/eisa-bus.c:62: warning: comparison between signed and unsigned

whether this variable is a signed or unsigned int will not make any actual 
difference, but I thought it would be nice to have one less warning to go 
through when building with -W - especially when it won't do any harm nor 
obfuscate the code to make the change (and you could argue that since we 
are looping through a table that cannot have any negative indices, the 
index 'i' is logically unsigned).

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-rc2-bk9-orig/drivers/eisa/eisa-bus.c linux-2.6.10-rc2-bk9/drivers/eisa/eisa-bus.c
--- linux-2.6.10-rc2-bk9-orig/drivers/eisa/eisa-bus.c	2004-11-17 01:19:37.000000000 +0100
+++ linux-2.6.10-rc2-bk9/drivers/eisa/eisa-bus.c	2004-11-25 01:29:59.000000000 +0100
@@ -58,7 +58,7 @@ static int is_forced_dev (int *forced_ta
 static void __init eisa_name_device (struct eisa_device *edev)
 {
 #ifdef CONFIG_EISA_NAMES
-	int i;
+	unsigned int i;
 	for (i = 0; i < EISA_INFOS; i++) {
 		if (!strcmp (edev->id.sig, eisa_table[i].id.sig)) {
 			strlcpy (edev->pretty_name,


