Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265119AbUHQLHN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265119AbUHQLHN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 07:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268180AbUHQLHN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 07:07:13 -0400
Received: from gprs214-89.eurotel.cz ([160.218.214.89]:1664 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S265119AbUHQLHF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 07:07:05 -0400
Date: Tue, 17 Aug 2004 13:05:30 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp: do not disable platform swsusp because S4bios is available
Message-ID: <20040817110530.GA3161@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Currently, when both S4 and S4bios are available, swsusp always
chooses S4bios and makes S4 unavailable. Bad idea as S4bios needs
completely different setup.... Please apply,
								Pavel

--- clean-mm/drivers/acpi/sleep/main.c	2004-08-17 12:21:43.000000000 +0200
+++ linux-mm/drivers/acpi/sleep/main.c	2004-08-17 12:22:45.000000000 +0200
@@ -217,7 +217,8 @@
 				sleep_states[i] = 1;
 				printk(" S4bios");
 				acpi_pm_ops.pm_disk_mode = PM_DISK_FIRMWARE;
-			} else if (sleep_states[i])
+			} 
+			if (sleep_states[i])
 				acpi_pm_ops.pm_disk_mode = PM_DISK_PLATFORM;
 		}
 	}

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
