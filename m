Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261325AbVHAWmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261325AbVHAWmg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 18:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVHAWkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 18:40:04 -0400
Received: from fmr21.intel.com ([143.183.121.13]:16860 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261265AbVHAWhu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 18:37:50 -0400
Date: Mon, 1 Aug 2005 15:36:51 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       zwane@arm.linux.org.uk, ashok.raj@intel.com
Subject: Re: [patch 1/8] x86_64: Reintroduce clustered_apic_check() for x86_64.
Message-ID: <20050801153651.A15609@unix-os.sc.intel.com>
References: <20050801202017.043754000@araj-em64t> <20050801203010.952356000@araj-em64t>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050801203010.952356000@araj-em64t>; from ashok.raj@intel.com on Mon, Aug 01, 2005 at 01:20:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2005 at 01:20:18PM -0700, Ashok Raj wrote:
> Auto selection of bigsmp patch removed this check from a shared common file
> in arch/i386/kernel/acpi/boot.c. We still need to call this to determine 
> the right genapic code for x86_64. 
> 

Thanks venki,

missed the check for lapic and smp_found_config before the call.

Resending patch.

-- 
Cheers,
Ashok Raj
- Open Source Technology Center

Auto selection of bigsmp patch removed this check from a shared common file
in arch/i386/kernel/acpi/boot.c. We still need to call this to determine 
the right genapic code for x86_64. 

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------------------
 arch/x86_64/kernel/setup.c |    2 ++
 1 files changed, 2 insertions(+)

Index: linux-2.6.13-rc4-mm1/arch/x86_64/kernel/setup.c
===================================================================
--- linux-2.6.13-rc4-mm1.orig/arch/x86_64/kernel/setup.c
+++ linux-2.6.13-rc4-mm1/arch/x86_64/kernel/setup.c
@@ -663,6 +663,8 @@ void __init setup_arch(char **cmdline_p)
 	 * Read APIC and some other early information from ACPI tables.
 	 */
 	acpi_boot_init();
+	if (acpi_lapic && smp_found_config)
+		clustered_apic_check();
 #endif
 
 #ifdef CONFIG_X86_LOCAL_APIC
