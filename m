Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269322AbUINMEs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269322AbUINMEs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:04:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269366AbUINMDE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:03:04 -0400
Received: from outmx021.isp.belgacom.be ([195.238.2.202]:4528 "EHLO
	outmx021.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S269322AbUINMCE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:02:04 -0400
Message-ID: <4146DDE8.6060200@246tNt.com>
Date: Tue, 14 Sep 2004 14:02:48 +0200
From: Sylvain Munaut <tnt@246tNt.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040816)
X-Accept-Language: en-us, en
MIME-Version: 1.0
Cc: Linux PPC Dev <linuxppc-dev@ozlabs.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Paul Mackerras <paulus@samba.org>
Subject: [PATCH 9/9] Small updates for Freescale MPC52xx
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
#   2004/09/14 12:39:19+02:00 tnt@246tNt.com
#   ppc: Add Freescale MPC52xx I2C Support using i2c-mpc.c
#   
#   Just adds the necessary OCP def entry.
#   
#   Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
#
# arch/ppc/platforms/mpc5200.c
#   2004/09/14 12:39:00+02:00 tnt@246tNt.com +24 -0
#   ppc: Add Freescale MPC52xx I2C Support using i2c-mpc.c
#
diff -Nru a/arch/ppc/platforms/mpc5200.c b/arch/ppc/platforms/mpc5200.c
--- a/arch/ppc/platforms/mpc5200.c      2004-09-14 12:48:21 +02:00
+++ b/arch/ppc/platforms/mpc5200.c      2004-09-14 12:48:21 +02:00
@@ -16,6 +16,12 @@
 #include <asm/ocp.h>
 #include <asm/mpc52xx.h>

+
+struct ocp_fs_i2c_data mpc5200_i2c_def = {
+        .flags  = FS_I2C_CLOCK_5200,
+};
+
+
 /* Here is the core_ocp struct.
  * With all the devices common to all board. Even if port multiplexing is
  * not setup for them (if the user don't want them, just don't select the
@@ -23,6 +29,24 @@
  * board specific file.
  */
 struct ocp_def core_ocp[] = {
+       {
+               .vendor         = OCP_VENDOR_FREESCALE,
+               .function       = OCP_FUNC_IIC,
+               .index          = 0,
+               .paddr          = MPC52xx_I2C1,
+               .irq            = OCP_IRQ_NA,   /* MPC52xx_IRQ_I2C1 - 
Buggy */
+               .pm             = OCP_CPM_NA,
+               .additions      = &mpc5200_i2c_def,
+       },
+       {
+               .vendor         = OCP_VENDOR_FREESCALE,
+               .function       = OCP_FUNC_IIC,
+               .index          = 1,
+               .paddr          = MPC52xx_I2C2,
+               .irq            = OCP_IRQ_NA,   /* MPC52xx_IRQ_I2C2 - 
Buggy */
+               .pm             = OCP_CPM_NA,
+               .additions      = &mpc5200_i2c_def,
+       },
        {       /* Terminating entry */
                .vendor         = OCP_VENDOR_INVALID
        }

