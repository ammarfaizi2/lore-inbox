Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263010AbVD2VqC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263010AbVD2VqC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 17:46:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263009AbVD2VoO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 17:44:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:44469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263016AbVD2Vnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 17:43:35 -0400
Date: Fri, 29 Apr 2005 14:43:21 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: jermar@itbs.cz
Cc: len.brown@intel.com, torvalds@osdl.org, aul.s.diefenbaugh@intel.com,
       jun.nakajima@intel.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: acpi_find_rsdp() diverges from ACPI specification
Message-Id: <20050429144321.3398db9a.rddunlap@osdl.org>
In-Reply-To: <20050429230350.qid9o7yht3qckkg8@mail.hosting123.cz>
References: <20050429230350.qid9o7yht3qckkg8@mail.hosting123.cz>
Organization: OSDL
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Apr 2005 23:03:50 +0200 jermar@itbs.cz wrote:

| Hello,
| 
| I found out that acpi_find_rsdp() tries to find the RSDP structure in an area
| bit larger than the ACPI specification wants. The right interval should start
| at 0xe0000 and end at 0xfffff. The search area is thus 128K+1B large.

The search area is thus 128 KB large, so I agree with the intent of
this patch, except for the +1B.


| Given the semantics of acpi_scan_rsdp(), the second argument should therefore be
| the size, not the end address.

Yes.

| Should there be any comments, please email me directly as I don't regularily
| read LKM.
| 
| Please, apply.
| 
| Jakub
| 
| --- linux-2.6.11.7/arch/i386/kernel/acpi/boot.c 2005-04-07 20:58:17.000000000
| +0200
| +++ linux-2.6.11.7-acpi-patch/arch/i386/kernel/acpi/boot.c      2005-04-29
| 21:39:08.000000000 +0200
| @@ -644,7 +644,7 @@ acpi_find_rsdp (void)
|          */
|         rsdp_phys = acpi_scan_rsdp (0, 0x400);
|         if (!rsdp_phys)
| -               rsdp_phys = acpi_scan_rsdp (0xE0000, 0xFFFFF);
| +               rsdp_phys = acpi_scan_rsdp (0xE0000, 128*1024 + 1);
Just drop the "+ 1".

| 
|         return rsdp_phys;
|  }


---
~Randy
