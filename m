Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264644AbSK3VqL>; Sat, 30 Nov 2002 16:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbSK3VqL>; Sat, 30 Nov 2002 16:46:11 -0500
Received: from [195.39.17.254] ([195.39.17.254]:16644 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S264644AbSK3VqK>;
	Sat, 30 Nov 2002 16:46:10 -0500
Date: Sat, 30 Nov 2002 20:49:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
Subject: 2.5.50: echo > /proc/acpi/sleep b0rken
Message-ID: <20021130194934.GA141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I believe this is needed, otherwise echo > /proc/acpi/sleep does not
work. I'm not 200% sure this is correct fix, through, and it
definitely needs to be fixed at *way* more places.
								Pavel

--- clean/drivers/acpi/sleep.c	2002-11-29 21:16:34.000000000 +0100
+++ linux-swsusp/drivers/acpi/sleep.c	2002-11-30 00:27:14.000000000 +0100
@@ -674,7 +675,7 @@
 			ACPI_SYSTEM_FILE_SLEEP));
 	else {
 		entry->proc_fops = &acpi_system_sleep_fops;
-		entry->write_proc = acpi_system_write_sleep;
+		entry->proc_fops->write = acpi_system_write_sleep;
 	}
 
 	/* 'alarm' [R/W] */

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
