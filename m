Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932086AbWINWny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932086AbWINWny (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 18:43:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932087AbWINWny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 18:43:54 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:22923 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S932086AbWINWnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 18:43:53 -0400
Subject: Re: [Bug] 2.6.18-rc6-mm2 i386 trouble finding RSDT in
	get_memcfg_from_srat
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: dave hansen <haveblue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Vivek goyal <vgoyal@in.ibm.com>,
       ebiederm@xmission.com, andrew <akpm@osdl.org>
In-Reply-To: <1158271274.24414.6.camel@localhost.localdomain>
References: <1158113895.9562.13.camel@keithlap>
	 <1158269696.15745.5.camel@keithlap>
	 <1158271274.24414.6.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Thu, 14 Sep 2006 15:43:50 -0700
Message-Id: <1158273830.15745.14.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-09-14 at 15:01 -0700, Dave Hansen wrote:
> Keith, can you get printouts of the phys_addrs it is trying to use
> there?  In fact, can you print out all of the calls to all of the
> functions and all of their arguments in that file?
The call to boot_ioremap is always the same

(works)
 BIOS-e820: 0000000000000000 - 000000000009c400 (usable)
 BIOS-e820: 000000000009c400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000eff91840 (usable)
 BIOS-e820: 00000000eff91840 - 00000000eff9c340 (ACPI data)
 BIOS-e820: 00000000eff9c340 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001d0000000 (usable)
Node: 0, start_pfn: 0, end_pfn: 156
Node: 0, start_pfn: 256, end_pfn: 982929
Node: 0, start_pfn: 1048576, end_pfn: 1900544
get_memcfg_from_srat: assigning address to rsdp fdfc0
RSD PTR  v0 [IBM   ]
rsdp->rsdt_address eff9c2c0
boot_ioremap phys_addr = eff9c2c0 long = 44
boot_ioremap and I return c04da2c0
rsdt = c04da2c0 header is RSDT4
Begin SRAT table scan....
.... 

(no works)
 BIOS-e820: 0000000000000000 - 000000000009c400 (usable)
 BIOS-e820: 000000000009c400 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 00000000eff91840 (usable)
 BIOS-e820: 00000000eff91840 - 00000000eff9c340 (ACPI data)
 BIOS-e820: 00000000eff9c340 - 00000000f0000000 (reserved)
 BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
 BIOS-e820: 0000000100000000 - 00000001d0000000 (usable)
Node: 0, start_pfn: 0, end_pfn: 156
Node: 0, start_pfn: 256, end_pfn: 982929
Node: 0, start_pfn: 1048576, end_pfn: 1900544
get_memcfg_from_srat: assigning address to rsdp fdfc0
RSD PTR  v0 [IBM   ]
rsdp->rsdt_address eff9c2c0
boot_ioremap phys_addr = eff9c2c0 long = 44
boot_ioremap and I return c13db2c0
rsdt = c13db2c0 header is
ACPI: RSDT signature incorrect
failed to get NUMA memory information from SRAT table
NUMA - single node, flat memory mode
...


> Also, it might be possible that this data somehow got pushed above the
> 8MB boundary.  Getting me those addresses will let me check that.

I think the kernel starts @ 16mb with i386 kdump.  

Thanks,
  Keith 

