Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262756AbVENMpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262756AbVENMpE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 May 2005 08:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262758AbVENMpD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 May 2005 08:45:03 -0400
Received: from mail.donpac.ru ([80.254.111.2]:6307 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S262756AbVENMo5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 May 2005 08:44:57 -0400
Subject: [PATCH 2.6.12-rc4-mm1 2/3] DMI, remove central blacklist
In-Reply-To: <11160746962011@donpac.ru>
Date: Sat, 14 May 2005 16:44:56 +0400
Message-Id: <11160746964048@donpac.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Since last dmi quirk looks useless (it just prints 404 compliant url)
we can finally remove central dmi blacklist.

Signed-off-by: Andrey Panin <pazke@donpac.ru>

 arch/i386/kernel/dmi_scan.c |   45 --------------------------------------------
 1 files changed, 1 insertion(+), 44 deletions(-)

diff -urdpNX dontdiff linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/dmi_scan.c linux-2.6.12-rc4-mm1/arch/i386/kernel/dmi_scan.c
--- linux-2.6.12-rc4-mm1.vanilla/arch/i386/kernel/dmi_scan.c	2005-05-04 15:26:52.000000000 +0400
+++ linux-2.6.12-rc4-mm1/arch/i386/kernel/dmi_scan.c	2005-05-04 15:27:36.000000000 +0400
@@ -160,50 +160,10 @@ static void __init dmi_save_ident(struct
 }
 
 /*
- * Ugly compatibility crap.
- */
-#define dmi_blacklist	dmi_system_id
-#define NO_MATCH	{ DMI_NONE, NULL}
-#define MATCH		DMI_MATCH
-
-/*
- * Toshiba keyboard likes to repeat keys when they are not repeated.
- */
-
-static __init int broken_toshiba_keyboard(struct dmi_blacklist *d)
-{
-	printk(KERN_WARNING "Toshiba with broken keyboard detected. If your keyboard sometimes generates 3 keypresses instead of one, see http://davyd.ucc.asn.au/projects/toshiba/README\n");
-	return 0;
-}
-
-
-
-/*
- *	Process the DMI blacklists
- */
- 
-
-/*
- *	This will be expanded over time to force things like the APM 
- *	interrupt mask settings according to the laptop
- */
- 
-static __initdata struct dmi_blacklist dmi_blacklist[]={
-
-	{ broken_toshiba_keyboard, "Toshiba Satellite 4030cdt", { /* Keyboard generates spurious repeats */
-			MATCH(DMI_PRODUCT_NAME, "S4030CDT/4.3"),
-			NO_MATCH, NO_MATCH, NO_MATCH
-			} },
-
-	{ NULL, }
-};
-
-/*
  *	Process a DMI table entry. Right now all we care about are the BIOS
  *	and machine entries. For 2.5 we should pull the smbus controller info
  *	out of here.
  */
-
 static void __init dmi_decode(struct dmi_header *dm)
 {
 #ifdef DMI_DEBUG
@@ -253,10 +213,7 @@ static void __init dmi_decode(struct dmi
 
 void __init dmi_scan_machine(void)
 {
-	int err = dmi_iterate(dmi_decode);
-	if(err == 0)
- 		dmi_check_system(dmi_blacklist);
-	else
+	if (dmi_iterate(dmi_decode))
 		printk(KERN_INFO "DMI not present.\n");
 }
 

