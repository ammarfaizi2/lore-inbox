Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751417AbWIYSmJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751417AbWIYSmJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:42:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751459AbWIYSmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:42:09 -0400
Received: from mga05.intel.com ([192.55.52.89]:13426 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751417AbWIYSmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:42:07 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,215,1157353200"; 
   d="scan'208"; a="137075916:sNHT3714377625"
Date: Mon, 25 Sep 2006 11:23:32 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Dave Jones <davej@redhat.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       Ismail Donmez <ismail@pardus.org.tr>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: New section mismatch warning on latest linux-2.6 git tree
Message-ID: <20060925112332.A30077@unix-os.sc.intel.com>
References: <EB12A50964762B4D8111D55B764A8454A41360@scsmsx413.amr.corp.intel.com> <20060925182347.GB9683@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060925182347.GB9683@redhat.com>; from davej@redhat.com on Mon, Sep 25, 2006 at 02:23:47PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2006 at 02:23:47PM -0400, Dave Jones wrote:
> 
> That's the patch that has caused this situation.
> Andrew had it in -mm until recently, when I merged it into cpufreq.git.
> And now, Linus has pulled it into mainline.
> 
> 	Dave
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Patch below resolves this section mismatch issue.

Please apply.

Thanks,
Venki

Make the sections proper and get rid of section mismatch warnings.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.18-rc4/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.18-rc4.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ linux-2.6.18-rc4/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -569,13 +569,13 @@ static int acpi_cpufreq_early_init(void)
  */
 static int bios_with_sw_any_bug;
 
-static int __init sw_any_bug_found(struct dmi_system_id *d)
+static int sw_any_bug_found(struct dmi_system_id *d)
 {
 	bios_with_sw_any_bug = 1;
 	return 0;
 }
 
-static struct dmi_system_id __initdata sw_any_bug_dmi_table[] = {
+static struct dmi_system_id sw_any_bug_dmi_table[] = {
 	{
 		.callback = sw_any_bug_found,
 		.ident = "Supermicro Server X6DLP",
Index: linux-2.6.18-rc4/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
===================================================================
--- linux-2.6.18-rc4.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
+++ linux-2.6.18-rc4/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
@@ -386,7 +386,7 @@ static int centrino_cpu_early_init_acpi(
  * than OS intended it to run at. Detect it and handle it cleanly.
  */
 static int bios_with_sw_any_bug;
-static int __init sw_any_bug_found(struct dmi_system_id *d)
+static int sw_any_bug_found(struct dmi_system_id *d)
 {
 	bios_with_sw_any_bug = 1;
 	return 0;
