Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261898AbVCHJTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261898AbVCHJTX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261920AbVCHJTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:19:22 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29088 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261898AbVCHJTR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:19:17 -0500
Date: Tue, 8 Mar 2005 10:18:56 +0100
From: Pavel Machek <pavel@suse.cz>
To: "Li, Shaohua" <shaohua.li@intel.com>, Andrew Morton <akpm@zip.com.au>
Cc: Bruno Ducrot <ducrot@poupinou.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>, seife@suse.de,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [ACPI] s4bios: does anyone use it?
Message-ID: <20050308091856.GB16436@elf.ucw.cz>
References: <16A54BF5D6E14E4D916CE26C9AD305750155EBB0@pdsmsx402.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305750155EBB0@pdsmsx402.ccr.corp.intel.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Okay, so we had 2 users in past but have 0 users now? :-).
> I wonder how could anyone use S4BIOS in 2.6.11. S4 and S4b all came into
> 'enter_state'. and in acpi_sleep_init:
> 
> 		if (i == ACPI_STATE_S4) {
> 			if (acpi_gbl_FACS->S4bios_f) {
> 				sleep_states[i] = 1;
> 				printk(" S4bios");
> 				acpi_pm_ops.pm_disk_mode =
> PM_DISK_FIRMWARE;
> 			}
> 			if (sleep_states[i])
> 				acpi_pm_ops.pm_disk_mode =
> PM_DISK_PLATFORM;
> 		}
> That means we actually can't set PM_DISK_FIRMWARE (always set
> PM_DISK_PLATFORM). Is this intended? If no, .pm_disk_mode should be a
> mask.

pm_disk_mode is settable using /sys/power/disk, no? Anyway, what about
this, then?

--- clean/Documentation/feature-removal-schedule.txt	2005-01-22 21:24:50.000000000 +0100
+++ linux/Documentation/feature-removal-schedule.txt	2005-03-08 10:18:05.000000000 +0100
@@ -15,3 +15,8 @@
 	against the LSB, and can be replaced by using udev.
 Who:	Greg Kroah-Hartman <greg@kroah.com>
 
+What:	ACPI S4bios support
+When:	May 2005
+Why:	Noone uses it, and it probably does not work, anyway. swsusp is
+	faster, more reliable, and people are actually using it.
+Who:	Pavel Machek <pavel@suse.cz>


								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
