Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161027AbWARWBH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161027AbWARWBH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:01:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWARWBH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:01:07 -0500
Received: from fmr19.intel.com ([134.134.136.18]:24010 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161029AbWARWBF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:01:05 -0500
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
From: Kristen Accardi <kristen.c.accardi@intel.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
In-Reply-To: <20060118204251.GA1544@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy>
	 <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy>
	 <20060118204251.GA1544@elf.ucw.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Jan 2006 13:43:00 -0800
Message-Id: <1137620581.31839.21.camel@whizzy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
X-OriginalArrivalTime: 18 Jan 2006 21:40:07.0034 (UTC) FILETIME=[BFBFC5A0:01C61C77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-18 at 21:42 +0100, Pavel Machek wrote:
> Hi!
> 
> There's a bug in error handling:
> 
> int __init acpiphp_glue_init(void)
> {
>         int num = 0;
> 
>         acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
>                         ACPI_UINT32_MAX, find_root_bridges, &num,
> NULL);
> 
>         if (num <= 0)
>                 return -1;
>         else
>                 acpi_pci_register_driver(&acpi_pci_hp_driver);
> 
>         return 0;
> }
> 
> You register driver here, but if acpiphp_get_num_slots() returns 0
> later, you return -ENODEV, aborting load of driver, but without
> undergistering that driver. It oopses after a while. Same problem if
> init_slots() returns error.
> 
> 								Pavel

This one needs some more thought on how to fix, because I'm not certain
if we have the code in place to back out of this once we find root
bridges that exist.  it might be easy, but it might not be. 

