Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030441AbWARUnT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030441AbWARUnT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 15:43:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030440AbWARUnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 15:43:18 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:36578 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030434AbWARUnE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 15:43:04 -0500
Date: Wed, 18 Jan 2006 21:42:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Kristen Accardi <kristen.c.accardi@intel.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com,
       pcihpd-discuss@lists.sourceforge.net, len.brown@intel.com,
       linux-acpi@vger.kernel.org
Subject: Re: [Pcihpd-discuss] Re: [patch 0/4]  Hot Dock/Undock support
Message-ID: <20060118204251.GA1544@elf.ucw.cz>
References: <1137545813.19858.45.camel@whizzy> <20060118130444.GA1518@elf.ucw.cz> <1137609747.31839.6.camel@whizzy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137609747.31839.6.camel@whizzy>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

There's a bug in error handling:

int __init acpiphp_glue_init(void)
{
        int num = 0;

        acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT,
                        ACPI_UINT32_MAX, find_root_bridges, &num,
NULL);

        if (num <= 0)
                return -1;
        else
                acpi_pci_register_driver(&acpi_pci_hp_driver);

        return 0;
}

You register driver here, but if acpiphp_get_num_slots() returns 0
later, you return -ENODEV, aborting load of driver, but without
undergistering that driver. It oopses after a while. Same problem if
init_slots() returns error.

								Pavel
-- 
Thanks, Sharp!
