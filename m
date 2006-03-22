Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422677AbWCWUlW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422677AbWCWUlW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Mar 2006 15:41:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932190AbWCWUky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Mar 2006 15:40:54 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:50421 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932181AbWCWUkY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Mar 2006 15:40:24 -0500
Message-Id: <20060323203521.261957000@dyn-9-152-242-103.boeblingen.de.ibm.com>
References: <20060323203423.620978000@dyn-9-152-242-103.boeblingen.de.ibm.com>
User-Agent: quilt/0.44-1
Date: Thu, 23 Mar 2006 00:00:03 +0100
From: Arnd Bergmann <abergman@de.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: cbe-oss-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: [patch 03/13] powerpc: update cell platform detection
Content-Disposition: inline; filename=cell-detect.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All future firmware should have 'CBEA' in the compatible
property in order to tell us that we are running on the
cell platform, so check for that as well as the now
deprecated value we have been using so far.

Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index d34fe53..fc1f169 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -1503,7 +1503,8 @@ static int __init prom_find_machine_type
 #ifdef CONFIG_PPC64
 			if (strstr(p, RELOC("Momentum,Maple")))
 				return PLATFORM_MAPLE;
-			if (strstr(p, RELOC("IBM,CPB")))
+			if (strstr(p, RELOC("IBM,CPB"))||
+			    strstr(p, RELOC("CBEA")))
 				return PLATFORM_CELL;
 #endif
 			i += sl + 1;

--

