Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTHUVLq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 17:11:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262979AbTHUVLq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 17:11:46 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:13539 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262976AbTHUVLn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 17:11:43 -0400
Message-ID: <3F453576.7020605@pobox.com>
Date: Thu, 21 Aug 2003 17:11:18 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: "Brown, Len" <len.brown@intel.com>
CC: torvalds@osdl.org, "Grover, Andrew" <andrew.grover@intel.com>,
       zwane@linuxpower.ca, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 'noapic' already handled elsewhere
References: <BF1FE1855350A0479097B3A0D2A80EE009FCA0@hdsmsx402.hd.intel.com>
In-Reply-To: <BF1FE1855350A0479097B3A0D2A80EE009FCA0@hdsmsx402.hd.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brown, Len wrote:
> Jeff,
> This won't work.
> acpi_boot_init() is called from setup_arch(), which is called from
> start_kernel() _before_ parse_options().  Ie. ACPI needs to consume this
> flag before __setup() is invoked.


Thanks for the correction.  I'll resend the earlier 
s/LOCAL_APIC/IO_APIC/ patch then.

Just found another ACPI bug in 2.6:

> config ACPI_HT
>         bool "ACPI Processor Enumeration for HT"
>         depends on (X86 && X86_LOCAL_APIC)
>         default y
[...]
> config ACPI
>         bool "Full ACPI Support"
>         depends on !X86_VISWS
>         depends on !IA64_HP_SIM
>         depends on IA64 || (X86 && ACPI_HT)


So CONFIG_ACPI is not allowed on uniprocessor anymore, _and_ it requires 
HyperThreading code?  ;-)  No wonder CONFIG_ACPI didn't appear for my 
uniprocessor Pentium3 'make oldconfig'  ;-)

(ACPI requires ACPI_HT, which requires LOCAL_APIC)

Another reason why I was saying that CONFIG_ACPI should be the toplevel 
config option (even if CONFIG_ACPI never actually appears in any code, 
but only in Kconfig)...

	Jeff



