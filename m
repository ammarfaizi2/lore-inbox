Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261974AbVASXSE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261974AbVASXSE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 18:18:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261969AbVASXRh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 18:17:37 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:18650 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261971AbVASXPr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 18:15:47 -0500
Subject: Re: [PATCH] Fix num_online_nodes() warning on NUMA-Q
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Dave Hansen <haveblue@us.ibm.com>,
       Andy Whitcroft <andyw@uk.ibm.com>,
       Patrick Mansfield <patmans@us.ibm.com>
In-Reply-To: <1106158027.5548.15.camel@arrakis>
References: <1106158027.5548.15.camel@arrakis>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1106176542.9732.18.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 19 Jan 2005 15:15:42 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-01-19 at 10:07, Matthew Dobson wrote:
> include/asm-i386/mach-numaq/mach_apic.h complains about an implicit
> declaration of num_online_nodes():
> 
> In file included from arch/i386/kernel/cpu/intel.c:19:
> include/asm-i386/mach-numaq/mach_apic.h: In function `setup_portio_remap':
> include/asm-i386/mach-numaq/mach_apic.h:115: warning: implicit declaration of function `num_online_nodes'
> 
> This patch gets rid of this warning.  Please apply.
> 
> -Matt

Another compilation warning/error related to the recent
num_online_nodes() work was discovered.  This rollup patch fixes both
the above warning and the warnings/errors in arch/i386/pci/numa.c
discovered by Pat Mansfield.

-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.11-rc1-mm1/arch/i386/pci/numa.c linux-2.6.11-rc1-mm1+warn_fix/arch/i386/pci/numa.c
--- linux-2.6.11-rc1-mm1/arch/i386/pci/numa.c	2005-01-18 11:28:33.000000000 -0800
+++ linux-2.6.11-rc1-mm1+warn_fix/arch/i386/pci/numa.c	2005-01-19 15:07:24.000000000 -0800
@@ -4,6 +4,7 @@
 
 #include <linux/pci.h>
 #include <linux/init.h>
+#include <linux/nodemask.h>
 #include "pci.h"
 
 #define BUS2QUAD(global) (mp_bus_id_to_node[global])
diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.11-rc1-mm1/include/asm-i386/mach-numaq/mach_apic.h linux-2.6.11-rc1-mm1+warn_fix/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.6.11-rc1-mm1/include/asm-i386/mach-numaq/mach_apic.h	2005-01-18 11:29:06.000000000 -0800
+++ linux-2.6.11-rc1-mm1+warn_fix/include/asm-i386/mach-numaq/mach_apic.h	2005-01-18 15:57:33.000000000 -0800
@@ -3,6 +3,7 @@
 
 #include <asm/io.h>
 #include <linux/mmzone.h>
+#include <linux/nodemask.h>
 
 #define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
 


