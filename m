Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWAYUDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWAYUDh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jan 2006 15:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWAYUDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jan 2006 15:03:37 -0500
Received: from fmr21.intel.com ([143.183.121.13]:11475 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S932151AbWAYUDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jan 2006 15:03:36 -0500
Date: Wed, 25 Jan 2006 12:02:53 -0800
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org
Cc: ak@muc.de, linux-kernel@vger.kernel.org, kaos@sgi.com,
       randy.d.dunlap@intel.com
Subject: wrongly marked __init/__initdata for CPU hotplug
Message-ID: <20060125120253.A30999@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

attached patch is 2 more cases i found via running the reference_init.pl
script. These were easy to spot just knowing the file names. There is 
one another about init/main.c that i cant exactly zero in. (partly 
because i dont know how to interpret the data thats spewed out of the tool).

If there is a small example on how to co-related the data and find the culprit
would be real handy. 

Maybe Keith could help parse/give an example for me.

PS: There is another tool i noticed from Randy Dunlap that claims is fixed
for 2.6, and it give me couple more pci functions.

I still get the following:

[araj@araj-sfield linux-2.6.16-rc1-mm2]$ perl scripts/reference_init.pl
Finding objects, 1137 objects, ignoring 0 module(s)
Finding conglomerates, ignoring 139 conglomerate(s)
Scanning objects
Error: ./drivers/char/hw_random.o .data refers to 0000000000000028 R_X86_64_64       .init.text
Error: ./drivers/char/hw_random.o .data refers to 0000000000000050 R_X86_64_64       .init.text+0x00000000000000a0
Error: ./drivers/char/hw_random.o .data refers to 0000000000000078 R_X86_64_64       .init.text+0x000000000000017a
Error: ./init/main.o .text refers to 00000000000001dc R_X86_64_PC32     .init.data+0x000000000000015b
Done

-- 
Cheers,
Ashok Raj
- Open Source Technology Center


data/functions wrongly marked as __init with cpu hotplug.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
-----------------------------------------------
 arch/x86_64/kernel/mce.c      |    2 +-
 drivers/acpi/processor_idle.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.16-rc1-mm2/arch/x86_64/kernel/mce.c
===================================================================
--- linux-2.6.16-rc1-mm2.orig/arch/x86_64/kernel/mce.c
+++ linux-2.6.16-rc1-mm2/arch/x86_64/kernel/mce.c
@@ -380,7 +380,7 @@ static void __cpuinit mce_cpu_features(s
  */
 void __cpuinit mcheck_init(struct cpuinfo_x86 *c)
 {
-	static cpumask_t mce_cpus __initdata = CPU_MASK_NONE;
+	static cpumask_t mce_cpus = CPU_MASK_NONE;
 
 	mce_cpu_quirks(c); 
 
Index: linux-2.6.16-rc1-mm2/drivers/acpi/processor_idle.c
===================================================================
--- linux-2.6.16-rc1-mm2.orig/drivers/acpi/processor_idle.c
+++ linux-2.6.16-rc1-mm2/drivers/acpi/processor_idle.c
@@ -94,7 +94,7 @@ static int set_max_cstate(struct dmi_sys
 	return 0;
 }
 
-static struct dmi_system_id __initdata processor_power_dmi_table[] = {
+static struct dmi_system_id __cpuinitdata processor_power_dmi_table[] = {
 	{ set_max_cstate, "IBM ThinkPad R40e", {
 	  DMI_MATCH(DMI_BIOS_VENDOR,"IBM"),
 	  DMI_MATCH(DMI_BIOS_VERSION,"1SET60WW")}, (void *)1},
