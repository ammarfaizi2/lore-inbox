Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262248AbUBXNBT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 08:01:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262250AbUBXNBT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 08:01:19 -0500
Received: from gprs159-197.eurotel.cz ([160.218.159.197]:45952 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S262248AbUBXNBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 08:01:17 -0500
Date: Tue, 24 Feb 2004 14:00:51 +0100
From: Pavel Machek <pavel@suse.cz>
To: Rusty trivial patch monkey Russell <trivial@rustcorp.com.au>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Stefan Seyfried <seife@suse.de>
Cc: acpi-devel@lists.sourceforge.net
Subject: swsusp/s3: Assembly interactions need asmlinkage
Message-ID: <20040224130051.GA8964@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

swsusp/s3 assembly parts, and parts called from assembly are not
properly marked asmlinkage; that leads to double fault on resume when
someone compiles kernel with regparm. Thanks go to Stefan Seyfried for
discovering this. Please apply,
								Pavel

--- tmp/linux/drivers/acpi/hardware/hwsleep.c	2004-02-05 01:53:59.000000000 +0100
+++ linux/drivers/acpi/hardware/hwsleep.c	2004-02-23 21:47:23.000000000 +0100
@@ -205,7 +205,7 @@
  *
  ******************************************************************************/
 
-acpi_status
+acpi_status asmlinkage
 acpi_enter_sleep_state (
 	u8                              sleep_state)
 {
--- tmp/linux/include/linux/suspend.h	2004-02-24 13:21:40.000000000 +0100
+++ linux/include/linux/suspend.h	2004-02-23 20:57:04.000000000 +0100
@@ -82,4 +82,10 @@
 }
 #endif	/* CONFIG_PM */
 
+asmlinkage extern void do_magic(int is_resume);
+asmlinkage extern void do_magic_resume_1(void);
+asmlinkage extern void do_magic_resume_2(void);
+asmlinkage extern void do_magic_suspend_1(void);
+asmlinkage extern void do_magic_suspend_2(void);
+
 #endif /* _LINUX_SWSUSP_H */

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
