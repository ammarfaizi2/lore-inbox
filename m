Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVCHFZV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVCHFZV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:25:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCHFZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:25:20 -0500
Received: from fmr19.intel.com ([134.134.136.18]:17333 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S261268AbVCHFZL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:25:11 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [ACPI] s4bios: does anyone use it?
Date: Tue, 8 Mar 2005 13:24:13 +0800
Message-ID: <16A54BF5D6E14E4D916CE26C9AD305750155EBB0@pdsmsx402.ccr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [ACPI] s4bios: does anyone use it?
Thread-Index: AcUjVp4V5JJm4C+rRj+5yG/BRi1MFQARzmfQ
From: "Li, Shaohua" <shaohua.li@intel.com>
To: "Pavel Machek" <pavel@suse.cz>, "Bruno Ducrot" <ducrot@poupinou.org>
Cc: "kernel list" <linux-kernel@vger.kernel.org>,
       "ACPI mailing list" <acpi-devel@lists.sourceforge.net>, <seife@suse.de>,
       "Brown, Len" <len.brown@intel.com>
X-OriginalArrivalTime: 08 Mar 2005 05:24:15.0412 (UTC) FILETIME=[11BA4740:01C5239F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
>> >
>> > Is there single user of s4bios? It used to work for me 4 notebooks
>> > ago, but I never really used it.
>>
>> I don't have anymore my toshiba laptop where S4 bios was first
>> implemented.
>>
>> > I think I'm the only person that ever
>> > seen it working, but I could be wrong.
>>
>> You are indeed wrong.
>
>Okay, so we had 2 users in past but have 0 users now? :-).
I wonder how could anyone use S4BIOS in 2.6.11. S4 and S4b all came into
'enter_state'. and in acpi_sleep_init:

		if (i == ACPI_STATE_S4) {
			if (acpi_gbl_FACS->S4bios_f) {
				sleep_states[i] = 1;
				printk(" S4bios");
				acpi_pm_ops.pm_disk_mode =
PM_DISK_FIRMWARE;
			}
			if (sleep_states[i])
				acpi_pm_ops.pm_disk_mode =
PM_DISK_PLATFORM;
		}
That means we actually can't set PM_DISK_FIRMWARE (always set
PM_DISK_PLATFORM). Is this intended? If no, .pm_disk_mode should be a
mask.

Thanks,
Shaohua
