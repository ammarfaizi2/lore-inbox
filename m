Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932612AbVHTBAg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbVHTBAg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Aug 2005 21:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932775AbVHTBAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Aug 2005 21:00:35 -0400
Received: from mo00.iij4u.or.jp ([210.130.0.19]:45773 "EHLO mo00.iij4u.or.jp")
	by vger.kernel.org with ESMTP id S932612AbVHTBAf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Aug 2005 21:00:35 -0400
Date: Sat, 20 Aug 2005 10:00:07 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: akpm@osdl.org
Cc: yuasa@hh.iij4u.or.jp, linux-kernel@vger.kernel.org,
       Jesper Juhl <jesper.juhl@gmail.com>
Subject: [PATCH] fix warning of TANBAC_TB0219 in drivers/char/Kconfig
Message-Id: <20050820100007.719cf942.yuasa@hh.iij4u.or.jp>
In-Reply-To: <9a87484905081911036dcedf57@mail.gmail.com>
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	<9a87484905081911036dcedf57@mail.gmail.com>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 19 Aug 2005 20:03:26 +0200
Jesper Juhl <jesper.juhl@gmail.com> wrote:

> On 8/19/05, Andrew Morton <akpm@osdl.org> wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
> > 
> 
> menuconfig complains a little :
> 
> $ make menuconfig
> scripts/kconfig/mconf arch/i386/Kconfig
> drivers/char/Kconfig:847:warning: 'select' used by config symbol
> 'TANBAC_TB0219' refer to undefined symbol 'PCI_VR41XX'
> 
> otherwise things seem to be ok here.
> 

Here is a patch for this warning fix.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff rc6-mm1-orig/arch/mips/Kconfig rc6-mm1/arch/mips/Kconfig
--- rc6-mm1-orig/arch/mips/Kconfig	2005-08-20 08:32:28.000000000 +0900
+++ rc6-mm1/arch/mips/Kconfig	2005-08-20 08:41:42.000000000 +0900
@@ -91,8 +91,6 @@
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select HW_HAS_PCI
-	select PCI
-	select PCI_VR41XX
 
 config ROCKHOPPER
 	bool "Support for Rockhopper baseboard"
@@ -133,8 +131,6 @@
 config TANBAC_TB0226
 	bool "Support for TANBAC Mbase(TB0226)"
 	depends on TANBAC_TB022X
-	select PCI
-	select PCI_VR41XX
 	select GPIO_VR41XX
 	help
 	  The TANBAC Mbase(TB0226) is a MIPS-based platform manufactured by TANBAC.
@@ -147,8 +143,6 @@
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select HW_HAS_PCI
-	select PCI
-	select PCI_VR41XX
 
 config ZAO_CAPCELLA
 	bool "Support for ZAO Networks Capcella"
@@ -157,12 +151,12 @@
 	select DMA_NONCOHERENT
 	select IRQ_CPU
 	select HW_HAS_PCI
-	select PCI
-	select PCI_VR41XX
 
 config PCI_VR41XX
 	bool "Add PCI control unit support of NEC VR4100 series"
-	depends on MACH_VR41XX && PCI
+	depends on MACH_VR41XX && HW_HAS_PCI
+	default y
+	select PCI
 
 config VRC4173
 	tristate "Add NEC VRC4173 companion chip support"
diff -urN -X dontdiff rc6-mm1-orig/drivers/char/Kconfig rc6-mm1/drivers/char/Kconfig
--- rc6-mm1-orig/drivers/char/Kconfig	2005-08-20 08:32:35.000000000 +0900
+++ rc6-mm1/drivers/char/Kconfig	2005-08-20 09:41:43.000000000 +0900
@@ -843,8 +843,6 @@
 config TANBAC_TB0219
 	tristate "TANBAC TB0219 base board support"
 	depends TANBAC_TB022X
-	select PCI
-	select PCI_VR41XX
 
 menu "Ftape, the floppy tape device driver"
 
