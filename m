Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261938AbVCHJmi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261938AbVCHJmi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 04:42:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261934AbVCHJmd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 04:42:33 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:14264 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261933AbVCHJm1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 04:42:27 -0500
Message-ID: <422D737F.2020807@suse.de>
Date: Tue, 08 Mar 2005 10:42:23 +0100
From: Stefan Seyfried <seife@suse.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@suse.cz>
Cc: "Li, Shaohua" <shaohua.li@intel.com>, Andrew Morton <akpm@zip.com.au>,
       Bruno Ducrot <ducrot@poupinou.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       "Brown, Len" <len.brown@intel.com>
Subject: Re: [ACPI] s4bios: does anyone use it?
References: <16A54BF5D6E14E4D916CE26C9AD305750155EBB0@pdsmsx402.ccr.corp.intel.com> <20050308091856.GB16436@elf.ucw.cz>
In-Reply-To: <20050308091856.GB16436@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Hi!
> 
>> >Okay, so we had 2 users in past but have 0 users now? :-).
>> I wonder how could anyone use S4BIOS in 2.6.11. S4 and S4b all came into
>> 'enter_state'. and in acpi_sleep_init:
>> 
>> 		if (i == ACPI_STATE_S4) {
>> 			if (acpi_gbl_FACS->S4bios_f) {
>> 				sleep_states[i] = 1;
>> 				printk(" S4bios");
>> 				acpi_pm_ops.pm_disk_mode =
>> PM_DISK_FIRMWARE;
>> 			}
>> 			if (sleep_states[i])
>> 				acpi_pm_ops.pm_disk_mode =
>> PM_DISK_PLATFORM;
>> 		}
>> That means we actually can't set PM_DISK_FIRMWARE (always set
>> PM_DISK_PLATFORM). Is this intended? If no, .pm_disk_mode should be a
>> mask.
> 
> pm_disk_mode is settable using /sys/power/disk, no?

No, it isn't. That was my original point: you can write "firmware" into
it, but it has no effect. This probably was a side-effect of the "make
firmware mode not default" patch from a year ago.
But the real question is: what is firmware mode good for today? Is there
a single machine where firmware mode once worked, but swsusp does not
work today?

> Anyway, what about this, then?
> 
> --- clean/Documentation/feature-removal-schedule.txt	2005-01-22 21:24:50.000000000 +0100
> +++ linux/Documentation/feature-removal-schedule.txt	2005-03-08 10:18:05.000000000 +0100

Fine with me. I think it cannot work since ~one year (when we changed
the default from "firmware if available" to "shutdown always", the code
piece cited above) and nobody complained until now, so it won't be
missed IMO.
-- 
Stefan Seyfried, QA / R&D Team Mobile Devices, SUSE LINUX Nürnberg.

"Any ideas, John?"
"Well, surrounding them's out."
