Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263769AbUHOQly@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263769AbUHOQly (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 12:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265932AbUHOQlx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 12:41:53 -0400
Received: from gprs213-217.eurotel.cz ([160.218.213.217]:25472 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263769AbUHOQlw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 12:41:52 -0400
Date: Sun, 15 Aug 2004 18:40:12 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: Fix platform mode on swsusp
Message-ID: <20040815164012.GA851@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

When machine supports both S4 and S4bios, S4bios mode is prefered and
it is not possible to enter S4 by swsusp.  echo platform > disk then
does nothing. This makes S4 take precedence over S4bios if only one of
them would be available as the result.

[As a side note, I believe that 'echo "disk" > state' is wrong
interface for S4bios, as it requires completely different setup from
the user.]

Please apply,
								Pavel

--- clean-mm/drivers/acpi/sleep/main.c	2004-07-28 23:39:47.000000000 +0200
+++ linux-mm/drivers/acpi/sleep/main.c	2004-08-15 18:39:01.000000000 +0200
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
