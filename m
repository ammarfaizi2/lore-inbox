Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269340AbUINMCe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269340AbUINMCe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:02:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269364AbUINMBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:01:12 -0400
Received: from outmx020.isp.belgacom.be ([195.238.2.201]:34993 "EHLO
	outmx020.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269366AbUINMAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:00:44 -0400
Message-ID: <4146DDA7.1060304@246tNt.com>
Date: Tue, 14 Sep 2004 14:01:43 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 8/9] Small updates for Freescale MPC52xx
References: <4146D833.8040703@246tNt.com>
In-Reply-To: <4146D833.8040703@246tNt.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/09/14 12:30:28+02:00 tnt@246tNt.com
#   ppc: Allow the Freescale MPC52xx to NAP when idle on LITE5200 platform
#  
#   NAP allows some powersave. It's provided mainly as an example on how 
to do it.
#   However, when a BDI is plugged it causes early crashes so be aware !
#  
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/platforms/lite5200.c
#   2004/09/14 12:30:11+02:00 tnt@246tNt.com +7 -0
#   ppc: Allow the Freescale MPC52xx to NAP when idle on LITE5200 platform
#
diff -Nru a/arch/ppc/platforms/lite5200.c b/arch/ppc/platforms/lite5200.c
--- a/arch/ppc/platforms/lite5200.c     2004-09-14 12:48:13 +02:00
+++ b/arch/ppc/platforms/lite5200.c     2004-09-14 12:48:13 +02:00
@@ -36,6 +36,8 @@
 #include <asm/mpc52xx.h>


+extern int powersave_nap;
+
 /* Board data given by U-Boot */
 bd_t __res;
 EXPORT_SYMBOL(__res);  /* For modules */
@@ -123,6 +125,11 @@
        /* No ISA bus AFAIK */
        isa_io_base             = 0;
        isa_mem_base            = 0;
+
+       /* Powersave */
+#ifndef CONFIG_BDI_SWITCH      /* NAP & BDI is a bad combination ... */
+       powersave_nap = 1;      /* We allow this platform to NAP */
+#endif

        /* Setup the ppc_md struct */
        ppc_md.setup_arch       = lite5200_setup_arch;

