Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267027AbTBTVsH>; Thu, 20 Feb 2003 16:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267029AbTBTVsH>; Thu, 20 Feb 2003 16:48:07 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:57864 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S267027AbTBTVsE>; Thu, 20 Feb 2003 16:48:04 -0500
Date: Thu, 20 Feb 2003 22:56:38 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       kernel list <linux-kernel@vger.kernel.org>, torvalds@transmeta.com
Subject: enable mem= to mark memory as acpi-reserved
Message-ID: <20030220215638.GA18387@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This enables user to mark memory acpi-reserved; this is needed to get
acpi working on PaceBlade tablet (it has broken e820 tables). Second
diff makes printk output better aligned so it is possible to compare
RAM maps by eyes. Please apply,

								Pavel

--- linux/arch/i386/kernel/setup.c	2003-02-11 17:50:57.000000000 +0100
+++ linux-tablet/arch/i386/kernel/setup.c	2003-02-20 18:03:03.000000000 +0100
@@ -546,6 +546,9 @@
 				if (*from == '@') {
 					start_at = memparse(from+1, &from);
 					add_memory_region(start_at, mem_size, E820_RAM);
+				} else if (*from == '#') {
+					start_at = memparse(from+1, &from);
+					add_memory_region(start_at, mem_size, E820_ACPI);
 				} else {
 					limit_regions(mem_size);
 					userdef=1;
@@ -576,7 +582,7 @@
 	*cmdline_p = command_line;
 	if (userdef) {
 		printk(KERN_INFO "user-defined physical RAM map:\n");
-		print_memory_map("user");
+		print_memory_map("user     ");
 	}
 }
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
