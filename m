Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317317AbSFGTLx>; Fri, 7 Jun 2002 15:11:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317323AbSFGTLw>; Fri, 7 Jun 2002 15:11:52 -0400
Received: from [195.39.17.254] ([195.39.17.254]:13985 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S317317AbSFGTLw>;
	Fri, 7 Jun 2002 15:11:52 -0400
Date: Fri, 7 Jun 2002 13:38:42 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
        ACPI mailing list <acpi-devel@lists.sourceforge.net>,
        Andrew Grover <andrew.grover@intel.com>
Subject: uCleanup in acpi
Message-ID: <20020607113841.GA1343@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

No need to have *two* define_bools.

(BTW how do I tell system not to use acpi boot? It dies on boot on one
machine with ACPI turned on, before printk() works...)

Andrew, please apply.
								Pavel

--- clean/drivers/acpi/Config.in	Mon Jun  3 11:43:29 2002
+++ linux-swsusp/drivers/acpi/Config.in	Fri Jun  7 13:37:13 2002
@@ -12,10 +12,9 @@
       bool         'CPU Enumeration Only' CONFIG_ACPI_HT_ONLY
     fi
 
-    if [ "$CONFIG_ACPI_HT_ONLY" = "y" ]; then
-      define_bool CONFIG_ACPI_BOOT		y
-    else
-      define_bool CONFIG_ACPI_BOOT		y
+    define_bool CONFIG_ACPI_BOOT		y
+
+    if [ "$CONFIG_ACPI_HT_ONLY" != "y" ]; then
       define_bool CONFIG_ACPI_BUS		y
       define_bool CONFIG_ACPI_INTERPRETER	y
       define_bool CONFIG_ACPI_EC		y

-- 
(about SSSCA) "I don't say this lightly.  However, I really think that the U.S.
no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
