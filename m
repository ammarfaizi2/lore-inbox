Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261906AbVCZBoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261906AbVCZBoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 20:44:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVCZBoF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 20:44:05 -0500
Received: from omx3-ext.sgi.com ([192.48.171.20]:11403 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261906AbVCZBoA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 20:44:00 -0500
Date: Fri, 25 Mar 2005 17:43:27 -0800
From: Jason Uhlenkott <jasonuhl@sgi.com>
To: Len Brown <len.brown@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       acpi-devel@lists.sourceforge.net
Subject: Re: 2.6.12-rc1-mm3
Message-ID: <20050326014327.GB207782@dragonfly.engr.sgi.com>
References: <20050325002154.335c6b0b.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050325002154.335c6b0b.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 25, 2005 at 12:21:54AM -0800, Andrew Morton wrote:
>  bk-acpi.patch

This doesn't build for SGI sn2:

arch/ia64/kernel/mca.c: In function `ia64_mca_init':
arch/ia64/kernel/mca.c:1394: error: `ACPI_INTERRUPT_CPEI' undeclared (first use in this function)
arch/ia64/kernel/mca.c:1394: error: (Each undeclared identifier is reported only once
arch/ia64/kernel/mca.c:1394: error: for each function it appears in.)
make[1]: *** [arch/ia64/kernel/mca.o] Error 1
make: *** [arch/ia64/kernel] Error 2

This is because we lost CONFIG_ACPI_BOOT -- it now depends on
CONFIG_PM, which we don't have (or want) on sn2.  The following fixes
it, but I'm not sure what the original rationale was.  Len?

Signed-off-by: Jason Uhlenkott <jasonuhl@sgi.com>

Index: linux/drivers/acpi/Kconfig
===================================================================
--- linux.orig/drivers/acpi/Kconfig	2005-03-25 12:22:57.909667494 -0800
+++ linux/drivers/acpi/Kconfig	2005-03-25 16:28:35.793588269 -0800
@@ -3,7 +3,6 @@
 #
 
 menu "ACPI (Advanced Configuration and Power Interface) Support"
-	depends on PM
 	depends on !X86_VISWS
 	depends on !IA64_HP_SIM
 	depends on IA64 || X86
