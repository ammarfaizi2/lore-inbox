Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267628AbTBLUgo>; Wed, 12 Feb 2003 15:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267632AbTBLUgo>; Wed, 12 Feb 2003 15:36:44 -0500
Received: from [195.39.17.254] ([195.39.17.254]:1540 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S267628AbTBLUgn>;
	Wed, 12 Feb 2003 15:36:43 -0500
Date: Tue, 11 Feb 2003 19:47:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: More /proc write fixes
Message-ID: <20030211184714.GA24991@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes writing to some more /proc entries. Please apply,

								Pavel

--- clean/drivers/acpi/thermal.c	2003-02-11 17:40:46.000000000 +0100
+++ linux/drivers/acpi/thermal.c	2003-02-11 17:51:08.000000000 +0100
@@ -946,11 +948,12 @@
 acpi_thermal_write_cooling_mode (
 	struct file		*file,
 	const char		*buffer,
-	size_t			count,
-	loff_t			*data)
+	unsigned long		count,
+	loff_t			*ppos)
 {
 	int			result = 0;
-	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_thermal	*tz = (struct acpi_thermal *) m->private;
 	char			mode_string[12] = {'\0'};
 
 	ACPI_FUNCTION_TRACE("acpi_thermal_write_cooling_mode");
@@ -1006,11 +1009,12 @@
 acpi_thermal_write_polling (
 	struct file		*file,
 	const char		*buffer,
-	size_t			count,
-	loff_t			*data)
+	unsigned long		count,
+	loff_t			*ppos)
 {
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
 	int			result = 0;
-	struct acpi_thermal	*tz = (struct acpi_thermal *) data;
+	struct acpi_thermal	*tz = (struct acpi_thermal *) m->private;
 	char			polling_string[12] = {'\0'};
 	int			seconds = 0;
 

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
