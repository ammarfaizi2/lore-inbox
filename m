Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261614AbULZFSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbULZFSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 00:18:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbULZFSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 00:18:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:42987 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261614AbULZFSB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 00:18:01 -0500
Message-ID: <41CE4837.5080701@osdl.org>
Date: Sat, 25 Dec 2004 21:12:23 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
CC: linux-kernel@vger.kernel.org, akpm <akpm@osdl.org>
Subject: [PATCH] parport_pc: don't mix module parameter styles
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <cqle2s$hrm$1@sea.gmane.org>
In-Reply-To: <cqle2s$hrm$1@sea.gmane.org>
Content-Type: multipart/mixed;
 boundary="------------090408060607010008020903"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------090408060607010008020903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Alexander E. Patrakov wrote:
> 
> Here it boots and works, but I can't say that I have done any serious
> testing. The following message appears in the kernel log:
> 
> Dec 25 11:38:09 lfs parport_pc: Ignoring new-style parameters in presence of
> obsolete ones
> Dec 25 11:38:09 lfs parport_pc: VIA 686A/8231 detected
> Dec 25 11:38:09 lfs parport_pc: probing current configuration
> Dec 25 11:38:09 lfs parport_pc: Current parallel port base: 0x378
> Dec 25 11:38:09 lfs parport0: PC-style at 0x378 (0x778), irq 7, using FIFO
> [PCSPP,TRISTATE,COMPAT,ECP]
> Dec 25 11:38:09 lfs parport_pc: VIA parallel port: io=0x378, irq=7
> 
> I don't understand the first line, and it wasn't there in 2.6.9. Could you
> please explain what it means? I don't pass any parameters to the module. I
> use module-init-tools version 3.0 although I know it is not the latest.

Somehow parport_pc.c ended up with mixed old-style and
new-style module parameters, but mixing them is not
allowed.

Use module_param() instead of MODULE_PARM() -- cannot be mixed.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
  drivers/parport/parport_pc.c |    4 ++--
  1 files changed, 2 insertions(+), 2 deletions(-)

--------------090408060607010008020903
Content-Type: text/x-patch;
 name="parport_modprm.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="parport_modprm.patch"


Use module_param() instead of MODULE_PARM() -- cannot be mixed.

Signed-off-by: Randy Dunlap <rddunlap@osdl.org>

diffstat:=
 drivers/parport/parport_pc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff -Naurp ./drivers/parport/parport_pc.c~parport_modprm ./drivers/parport/parport_pc.c
--- ./drivers/parport/parport_pc.c~parport_modprm	2004-12-24 13:35:39.000000000 -0800
+++ ./drivers/parport/parport_pc.c	2004-12-25 21:03:35.123264504 -0800
@@ -3176,7 +3176,6 @@ static int __init parport_init_mode_setu
 #ifdef MODULE
 static const char *irq[PARPORT_PC_MAX_PORTS];
 static const char *dma[PARPORT_PC_MAX_PORTS];
-static char *init_mode;
 
 MODULE_PARM_DESC(io, "Base I/O address (SPP regs)");
 module_param_array(io, int, NULL, 0);
@@ -3192,8 +3191,9 @@ MODULE_PARM_DESC(verbose_probing, "Log c
 module_param(verbose_probing, int, 0644);
 #endif
 #ifdef CONFIG_PCI
+static char *init_mode;
 MODULE_PARM_DESC(init_mode, "Initialise mode for VIA VT8231 port (spp, ps2, epp, ecp or ecpepp)");
-MODULE_PARM(init_mode, "s");
+module_param(init_mode, charp, 0);
 #endif
 
 static int __init parse_parport_params(void)

--------------090408060607010008020903--
