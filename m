Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261811AbVASSHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261811AbVASSHY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 13:07:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261804AbVASSHX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 13:07:23 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:34433 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S261811AbVASSHR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 13:07:17 -0500
Subject: [PATCH] Fix num_online_nodes() warning on NUMA-Q
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Dave Hansen <haveblue@us.ibm.com>, Andy Whitcroft <andyw@uk.ibm.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1106158027.5548.15.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 19 Jan 2005 10:07:08 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

include/asm-i386/mach-numaq/mach_apic.h complains about an implicit
declaration of num_online_nodes():

In file included from arch/i386/kernel/cpu/intel.c:19:
include/asm-i386/mach-numaq/mach_apic.h: In function `setup_portio_remap':
include/asm-i386/mach-numaq/mach_apic.h:115: warning: implicit declaration of function `num_online_nodes'

This patch gets rid of this warning.  Please apply.

-Matt

diff -Nurp --exclude-from=/home/mcd/.dontdiff linux-2.6.11-rc1-mm1/include/asm-i386/mach-numaq/mach_apic.h linux-2.6.11-rc1-mm1+warn_fix/include/asm-i386/mach-numaq/mach_apic.h
--- linux-2.6.11-rc1-mm1/include/asm-i386/mach-numaq/mach_apic.h	2005-01-18 11:29:06.000000000 -0800
+++ linux-2.6.11-rc1-mm1+warn_fix/include/asm-i386/mach-numaq/mach_apic.h	2005-01-18 15:57:33.000000000 -0800
@@ -3,6 +3,7 @@
 
 #include <asm/io.h>
 #include <linux/mmzone.h>
+#include <linux/nodemask.h>
 
 #define APIC_DFR_VALUE	(APIC_DFR_CLUSTER)
 


