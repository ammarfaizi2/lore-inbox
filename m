Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266851AbTATTky>; Mon, 20 Jan 2003 14:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266844AbTATTkN>; Mon, 20 Jan 2003 14:40:13 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11012 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S266851AbTATTjg>;
	Mon, 20 Jan 2003 14:39:36 -0500
Date: Sun, 19 Jan 2003 22:46:42 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>
Subject: Ask devices to powerdown before S3 sleep
Message-ID: <20030119214642.GA27885@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

SUSPEND_RESUME phase is needed for turning off IO-APIC. [I believe
SUSPEND_DISABLE should be so simple that errors just should not be
there, and besides we would not know how to safely enable devices from
such weird state, anyway]. Please apply,

								Pavel

--- clean/drivers/acpi/sleep.c	2003-01-05 22:58:25.000000000 +0100
+++ linux-swsusp/drivers/acpi/sleep.c	2003-01-19 21:27:00.000000000 +0100
@@ -143,6 +143,10 @@
 			return error;
 		}
 
+		error = device_suspend(state, SUSPEND_DISABLE);
+		if (error)
+			panic("Sorry, devices really should know how to disable\n");
+
 		/* flush caches */
 		ACPI_FLUSH_CPU_CACHE();

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
