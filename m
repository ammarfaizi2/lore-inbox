Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293727AbSCKNdq>; Mon, 11 Mar 2002 08:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293733AbSCKNdc>; Mon, 11 Mar 2002 08:33:32 -0500
Received: from mail.gmx.de ([213.165.64.20]:5997 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S293727AbSCKNdO>;
	Mon, 11 Mar 2002 08:33:14 -0500
Content-Type: text/plain; charset=US-ASCII
From: Wolly <wwolly@gmx.net>
To: andrew.grover@intel.com, acpi-devel@lists.sourceforge.net
Subject: [patch] minimal ACPI bugfix
Date: Mon, 11 Mar 2002 14:31:10 +0100
X-Mailer: KMail [version 1.2.1]
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020311133323Z293727-890+124826@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Avoid creating multiple /proc entries when (buggy) ACPI
BIOS tables erroneously list both fixed- and generic-
feature buttons."
While the function already prints a disgnostic message 
on this and registers the new button dir in /proc, it fails to 
remove the old one. 

This is a trivial patch which actually does that. 
ACPI maintainer Andy, please approve that. 

Regards,
Wolly

Patch is against 2.4.18 kernel;
patched file sm_osl.c is in drivers/acpi/ospm/button/

---------------------------<patch>---------------------------
diff -u bn_osl.c bn_osl.c-patched 
--- bn_osl.c	Mon Mar 11 14:06:56 2002
+++ bn_osl.c-patched	Mon Mar 11 14:02:27 2002
@@ -96,6 +96,7 @@
 			break;
 		case BN_TYPE_FIXED:
 			printk(KERN_WARNING "ACPI: Multiple power buttons detected, ignoring fixed-feature\n");
+			remove_proc_entry(BN_PROC_POWER_BUTTON, bn_proc_root);
 		default:
 			printk(KERN_INFO "ACPI: Power Button (CM) found\n");
 			bn_power_button = BN_TYPE_GENERIC;
