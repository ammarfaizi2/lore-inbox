Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318200AbSHDS4J>; Sun, 4 Aug 2002 14:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318199AbSHDS4J>; Sun, 4 Aug 2002 14:56:09 -0400
Received: from [195.39.17.254] ([195.39.17.254]:17024 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S318200AbSHDS4H>;
	Sun, 4 Aug 2002 14:56:07 -0400
Date: Sun, 4 Aug 2002 20:58:28 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Grover <andrew.grover@intel.com>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: 2.5.30 ACPI: fixing compilation
Message-ID: <20020804185827.GA15828@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This fixes compilation and is actually right since we can't get SMP
machine suspending, anyway. We'll have to bring all other CPUs down
for suspend in future. Please apply,
								Pavel

--- clean/drivers/acpi/system.c	Mon Jul 29 20:02:23 2002
+++ linux-swsusp/drivers/acpi/system.c	Sun Aug  4 20:57:01 2002
@@ -256,7 +256,7 @@
 	acpi_status		status = AE_ERROR;
 	unsigned long		flags = 0;
 
-	save_flags(flags);
+	local_irq_save(flags);
 	
 	switch (state)
 	{
@@ -270,7 +270,7 @@
 		do_suspend_lowlevel(0);
 		break;
 	}
-	restore_flags(flags);
+	local_irq_restore(flags);
 
 	return status;
 }



-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
