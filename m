Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274929AbTHFKhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 06:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274935AbTHFKhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 06:37:24 -0400
Received: from smtp-out1.iol.cz ([194.228.2.86]:46251 "EHLO smtp-out1.iol.cz")
	by vger.kernel.org with ESMTP id S274929AbTHFKhU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 06:37:20 -0400
Date: Wed, 6 Aug 2003 12:37:02 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: [PM] Unbreak S3
Message-ID: <20030806103702.GA701@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

SOFTWARE_SUSPEND/ACPI_SLEEP split was not ideal. As ACPI_SLEEP is now
independant, #ifdef is wrong. Please apply,
								Pavel

--- /usr/src/tmp/linux/drivers/acpi/sleep/main.c	2003-08-06 12:25:17.000000000 +0200
+++ /usr/src/linux/drivers/acpi/sleep/main.c	2003-08-06 12:12:58.000000000 +0200
@@ -191,12 +191,11 @@
 		status = acpi_enter_sleep_state(state);
 		break;
 
-#ifdef CONFIG_SOFTWARE_SUSPEND
 	case ACPI_STATE_S2:
 	case ACPI_STATE_S3:
 		do_suspend_lowlevel(0);
 		break;
-#endif
+
 	case ACPI_STATE_S4:
 		do_suspend_lowlevel_s4bios(0);
 		break;

-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
