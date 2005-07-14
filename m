Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261822AbVGNQdm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261822AbVGNQdm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 12:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGNQb2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 12:31:28 -0400
Received: from fmr23.intel.com ([143.183.121.15]:28138 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S261600AbVGNQaf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 12:30:35 -0400
Date: Thu, 14 Jul 2005 09:30:26 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Len Brown <len.brown@intel.com>, Kevin Radloff <radsaq@gmail.com>,
       Rajesh Shah <rajesh.shah@intel.com>
Subject: [PATCH] Fix the recent C-state with FADT regression
Message-ID: <20050714093025.A1694@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Attached patch fixes the recent C-state based on FADT regression reported by
Kevin.

Please apply.

Thanks,
Venki


Fix the regression with c1_default_handler on some systems where C-states come
from FADT.

Thanks to Kevin Radloff for identifying the issue and also root causing on 
exact line of code that is causing the issue.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

diff -purN  linux-2.6.13-rc1-mm1//drivers/acpi/processor_idle.c.org linux-2.6.13-rc1-mm1//drivers/acpi/processor_idle.c
--- linux-2.6.13-rc1-mm1//drivers/acpi/processor_idle.c.org	2005-07-14 23:19:45.038854688 -0700
+++ linux-2.6.13-rc1-mm1//drivers/acpi/processor_idle.c	2005-07-14 23:21:47.292269344 -0700
@@ -881,7 +881,7 @@ static int acpi_processor_get_power_info
 	result = acpi_processor_get_power_info_cst(pr);
 	if ((result) || (acpi_processor_power_verify(pr) < 2)) {
 		result = acpi_processor_get_power_info_fadt(pr);
-		if (result)
+		if ((result) || (acpi_processor_power_verify(pr) < 2))
 			result = acpi_processor_get_power_info_default_c1(pr);
 	}
 
