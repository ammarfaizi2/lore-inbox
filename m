Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932287AbWAZKcQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932287AbWAZKcQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 05:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbWAZKcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 05:32:16 -0500
Received: from uproxy.gmail.com ([66.249.92.202]:31555 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932287AbWAZKcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 05:32:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=OE93BY34GNAs6JZDtg2/SsCxNEDIMkK8WRBOSXfCJr8KyQxK8w83Z5IbCZpBlqhocaIkUtUkymenPli/RUGI7bgT/ueOsuRFWMaUv20MFHjlLrlfKQnjwyqWseqSBywcfGwXXNJ9YxAVufjTim5+7SekT/CiZModo+mmgiZoWP0=
Date: Thu, 26 Jan 2006 13:50:01 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Cc: Domen Puncer <domen@coderock.org>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Remove arch/ppc/syslib/ppc4xx_pm.c
Message-ID: <20060126105001.GA9288@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>

Remove nowhere referenced file ("grep ppc4xx_pm -r ." didn't find anything).

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 arch/ppc/syslib/ppc4xx_pm.c |   47 --------------------------------------------
 1 file changed, 47 deletions(-)

--- a/arch/ppc/syslib/ppc4xx_pm.c
+++ b/arch/ppc/syslib/ppc4xx_pm.c
@@ -1,47 +0,0 @@
-/*
- * Author: Armin Kuster <akuster@mvista.com>
- *
- * 2002 (c) MontaVista, Software, Inc.  This file is licensed under
- * the terms of the GNU General Public License version 2.  This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- *
- * This an attempt to get Power Management going for the IBM 4xx processor.
- * This was derived from the ppc4xx._setup.c file
- */
-
-#include <linux/config.h>
-#include <linux/init.h>
-
-#include <asm/ibm4xx.h>
-
-void __init
-ppc4xx_pm_init(void)
-{
-
-	unsigned int value = 0;
-
-	/* turn off unused hardware to save power */
-#ifdef CONFIG_405GP
-	value |= CPM_DCP;	/* CodePack */
-#endif
-
-#if !defined(CONFIG_IBM_OCP_GPIO)
-	value |= CPM_GPIO0;
-#endif
-
-#if !defined(CONFIG_PPC405_I2C_ADAP)
-	value |= CPM_IIC0;
-#ifdef CONFIG_STB03xxx
-	value |= CPM_IIC1;
-#endif
-#endif
-
-
-#if !defined(CONFIG_405_DMA)
-	value |= CPM_DMA;
-#endif
-
-	mtdcr(DCRN_CPMFR, value);
-
-}

