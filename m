Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268952AbTBZWUJ>; Wed, 26 Feb 2003 17:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268957AbTBZWUJ>; Wed, 26 Feb 2003 17:20:09 -0500
Received: from [195.39.17.254] ([195.39.17.254]:3332 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S268952AbTBZWUI>;
	Wed, 26 Feb 2003 17:20:08 -0500
Date: Wed, 26 Feb 2003 21:38:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       Andrew Grover <andrew.grover@intel.com>
Subject: mem= option for broken bioses
Message-ID: <20030226203841.GC346@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I've seen broken bios that did not mark acpi tables in e820
tables. This allows user to override it. Please apply,

							Pavel

--- linux/arch/i386/kernel/setup.c	2003-02-11 17:50:57.000000000 +0100
+++ linux-tablet/arch/i386/kernel/setup.c	2003-02-20 18:03:03.000000000 +0100
@@ -546,6 +546,12 @@
 				if (*from == '@') {
 					start_at = memparse(from+1, &from);
 					add_memory_region(start_at, mem_size, E820_RAM);
+				} else if (*from == '#') {
+					start_at = memparse(from+1, &from);
+					add_memory_region(start_at, mem_size, E820_ACPI);
+				} else if (*from == '$') {
+					start_at = memparse(from+1, &from);
+					add_memory_region(start_at, mem_size, E820_RESERVED);
 				} else {
 					limit_regions(mem_size);
 					userdef=1;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
