Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262857AbSJAWSG>; Tue, 1 Oct 2002 18:18:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262863AbSJAWSG>; Tue, 1 Oct 2002 18:18:06 -0400
Received: from [195.39.17.254] ([195.39.17.254]:11780 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262857AbSJAWSD>;
	Tue, 1 Oct 2002 18:18:03 -0400
Date: Tue, 1 Oct 2002 23:40:45 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       Rusty trivial patch monkey Russell 
	<trivial@rustcorp.com.au>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: ACPI sleep: stupid bug reintroduced
Message-ID: <20021001214045.GA1178@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There's extremely stupid bug in sleep.c -- it will only alow user to
enter *unsupported* states. What's even worse that I remember fixing
that once before, and *it was merged to mainline*.

Please, really merge it to all copies so it is not reintroduced again.

[Oh, at it also makes S4 transition fail when SWSUSP support is not
there.]

								Pavel

--- clean/drivers/acpi/sleep.c	2002-09-22 23:46:56.000000000 +0200
+++ linux-swsusp/drivers/acpi/sleep.c	2002-10-01 23:38:48.000000000 +0200
@@ -329,8 +329,8 @@
 	state_string[count] = '\0';
 	
 	state = simple_strtoul(state_string, NULL, 0);
-	
-	if (sleep_states[state])
+
+	if (!sleep_states[state])
 		return_VALUE(-ENODEV);
 
 #ifdef CONFIG_SOFTWARE_SUSPEND
@@ -338,7 +338,10 @@
 		software_suspend();
 		return_VALUE(count);
 	}
+#else
+	return_VALUE(-ENODEV);
 #endif
+
 	status = acpi_suspend(state);
 
 	if (ACPI_FAILURE(status))


-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
