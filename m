Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262765AbUACMiK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 07:38:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262913AbUACMiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 07:38:10 -0500
Received: from gprs214-81.eurotel.cz ([160.218.214.81]:55424 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S262765AbUACMiE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 07:38:04 -0500
Date: Sat, 3 Jan 2004 13:39:29 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       len.brown@intel.com
Subject: two acpi_disable's are bad for kernel
Message-ID: <20040103123929.GA401@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

acpi_disable() is there already to disable interrupts. Its bad idea to
have two functions of same name. Please apply,

								Pavel

Index: linux.new/arch/i386/kernel/dmi_scan.c
===================================================================
--- linux.new.orig/arch/i386/kernel/dmi_scan.c	2003-12-25 13:28:48.000000000 +0100
+++ linux.new/arch/i386/kernel/dmi_scan.c	2003-12-25 13:29:08.000000000 +0100
@@ -506,7 +507,7 @@
 
 extern int acpi_disabled, acpi_force;
 
-static __init __attribute__((unused)) int acpi_disable(struct dmi_blacklist *d) 
+static __init __attribute__((unused)) int disable_acpi(struct dmi_blacklist *d) 
 { 
 	if (!acpi_force) { 
 		printk(KERN_NOTICE "%s detected: acpi off\n",d->ident); 
@@ -880,7 +881,7 @@
 	 *	Boxes that need ACPI disabled
 	 */
 
-	{ acpi_disable, "IBM Thinkpad", {
+	{ disable_acpi, "IBM Thinkpad", {
 			MATCH(DMI_BOARD_VENDOR, "IBM"),
 			MATCH(DMI_BOARD_NAME, "2629H1G"),
 			NO_MATCH, NO_MATCH }},

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
