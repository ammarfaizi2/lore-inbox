Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269531AbUJGAzU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269531AbUJGAzU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 20:55:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269495AbUJGAzT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 20:55:19 -0400
Received: from ozlabs.org ([203.10.76.45]:60335 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S269531AbUJGAyr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 20:54:47 -0400
Date: Thu, 7 Oct 2004 10:52:25 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       linuxppc64-dev@ozlabsorg, linux-kernel@vger.kernel.org
Subject: [PPC64] Kconfig cleanups
Message-ID: <20041007005225.GB25012@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc64-dev@ozlabsorg,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, please apply:

Now that the PPC64 code supports more platforms than just pSeries and
iSeries, some p/i specific Kconfig options need to be updated
accordingly.

Signed-off-by: David Gibson <dwg@au1.ibm.com>

Index: working-2.6/arch/ppc64/Kconfig
===================================================================
--- working-2.6.orig/arch/ppc64/Kconfig	2004-09-28 10:22:13.000000000 +1000
+++ working-2.6/arch/ppc64/Kconfig	2004-10-07 10:26:53.466075056 +1000
@@ -215,7 +215,7 @@
 
 config PPC_RTAS
 	bool "Proc interface to RTAS"
-	depends on !PPC_ISERIES
+	depends on PPC_PSERIES
 
 config RTAS_FLASH
 	tristate "Firmware flash interface"
@@ -227,6 +227,7 @@
 
 config LPARCFG
 	tristate "LPAR Configuration Data"
+	depends on PPC_PSERIES || PPC_ISERIES
 	help
 	Provide system capacity information via human readable
 	<key word>=<value> pairs through a /proc/ppc64/lparcfg interface.
@@ -273,7 +274,7 @@
 
 config HOTPLUG_CPU
 	bool "Support for hot-pluggable CPUs"
-	depends on SMP && HOTPLUG && EXPERIMENTAL
+	depends on SMP && HOTPLUG && EXPERIMENTAL && PPC_PSERIES
 	---help---
 	  Say Y here to be able to turn CPUs off and on.
 

-- 
David Gibson			| For every complex problem there is a
david AT gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson
