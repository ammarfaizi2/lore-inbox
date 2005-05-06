Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261278AbVEFWWR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261278AbVEFWWR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 May 2005 18:22:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261283AbVEFWWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 May 2005 18:22:16 -0400
Received: from lexus.itbs.cz ([217.11.254.38]:15987 "EHLO lexus.itbs.cz")
	by vger.kernel.org with ESMTP id S261278AbVEFWVx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 May 2005 18:21:53 -0400
Message-ID: <427BEDF7.3010508@itbs.cz>
Date: Sat, 07 May 2005 00:21:43 +0200
From: Jakub Jermar <jermar@itbs.cz>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: akpm@osdl.org
Cc: len.brown@intel.com, "Randy.Dunlap" <rddunlap@osdl.org>, torvalds@osdl.org,
       aul.s.diefenbaugh@intel.com, jun.nakajima@intel.com,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: acpi_find_rsdp() diverges from ACPI specification
References: <20050429230350.qid9o7yht3qckkg8@mail.hosting123.cz> <20050429144321.3398db9a.rddunlap@osdl.org>
In-Reply-To: <20050429144321.3398db9a.rddunlap@osdl.org>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here I resend corrected patch for acpi_find_rsdp().
Please, apply this patch.


--- linux-2.6.11.7/arch/i386/kernel/acpi/boot.c 2005-04-07 20:58:17.000000000 +0200
+++ linux-2.6.11.7-acpi-patch/arch/i386/kernel/acpi/boot.c      2005-04-29 21:39:08.000000000 +0200
@@ -644,7 +644,7 @@ acpi_find_rsdp (void)
          */
         rsdp_phys = acpi_scan_rsdp (0, 0x400);
         if (!rsdp_phys)
-               rsdp_phys = acpi_scan_rsdp (0xE0000, 0xFFFFF);
+               rsdp_phys = acpi_scan_rsdp (0xE0000, 128*1024);

         return rsdp_phys;
  }

Best regards,
Jakub


Randy.Dunlap wrote:
> On Fri, 29 Apr 2005 23:03:50 +0200 jermar@itbs.cz wrote:
> 
> | Hello,
> | 
> | I found out that acpi_find_rsdp() tries to find the RSDP structure in an area
> | bit larger than the ACPI specification wants. The right interval should start
> | at 0xe0000 and end at 0xfffff. The search area is thus 128K+1B large.
> 
> The search area is thus 128 KB large, so I agree with the intent of
> this patch, except for the +1B.
> 
> 
> | Given the semantics of acpi_scan_rsdp(), the second argument should therefore be
> | the size, not the end address.
> 
> Yes.
> 
> | Should there be any comments, please email me directly as I don't regularily
> | read LKM.
> | 
> | Please, apply.
> | 
> | Jakub
> | 
> | --- linux-2.6.11.7/arch/i386/kernel/acpi/boot.c 2005-04-07 20:58:17.000000000
> | +0200
> | +++ linux-2.6.11.7-acpi-patch/arch/i386/kernel/acpi/boot.c      2005-04-29
> | 21:39:08.000000000 +0200
> | @@ -644,7 +644,7 @@ acpi_find_rsdp (void)
> |          */
> |         rsdp_phys = acpi_scan_rsdp (0, 0x400);
> |         if (!rsdp_phys)
> | -               rsdp_phys = acpi_scan_rsdp (0xE0000, 0xFFFFF);
> | +               rsdp_phys = acpi_scan_rsdp (0xE0000, 128*1024 + 1);
> Just drop the "+ 1".
> 
> | 
> |         return rsdp_phys;
> |  }
> 
> 
> ---
> ~Randy
