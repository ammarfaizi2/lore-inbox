Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261908AbTBXWku>; Mon, 24 Feb 2003 17:40:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261963AbTBXWkt>; Mon, 24 Feb 2003 17:40:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12548 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S261908AbTBXWks>;
	Mon, 24 Feb 2003 17:40:48 -0500
Date: Mon, 24 Feb 2003 23:50:28 +0100
From: Pavel Machek <pavel@ucw.cz>
To: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>, andy@Elf.ucw.cz
Subject: seq_file damage still not fixed in 2.5.63
Message-ID: <20030224225028.GA16141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

...this patch was dropped on the floor somewhere. Please apply,

							Pavel

--- clean/drivers/acpi/processor.c	2003-02-15 18:51:17.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-02-15 18:52:17.000000000 +0100
@@ -1356,7 +1356,8 @@
         loff_t			*data)
 {
 	int			result = 0;
-	struct acpi_processor	*pr = (struct acpi_processor *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_processor	*pr = (struct acpi_processor *)m->private;
 	char			state_string[12] = {'\0'};
 
 	ACPI_FUNCTION_TRACE("acpi_processor_write_throttling");
@@ -1418,7 +1419,8 @@
 	loff_t			*data)
 {
 	int			result = 0;
-	struct acpi_processor	*pr = (struct acpi_processor *) data;
+        struct seq_file 	*m = (struct seq_file *)file->private_data;
+	struct acpi_processor	*pr = (struct acpi_processor *)m->private;
 	char			limit_string[25] = {'\0'};
 	int			px = 0;
 	int			tx = 0;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
