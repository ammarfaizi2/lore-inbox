Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751918AbWG0SQG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751918AbWG0SQG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 14:16:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751916AbWG0SQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 14:16:05 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:64015 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751918AbWG0SQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 14:16:04 -0400
Date: Thu, 27 Jul 2006 20:16:03 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, Edgar Hucek <hostmaster@ed-soft.at>
Cc: linux-kernel@vger.kernel.org
Subject: [-mm patch] arch/i386/pci/mmconfig.c: fixes
Message-ID: <20060727181603.GA23554@stusta.de>
References: <20060727015639.9c89db57.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727015639.9c89db57.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 01:56:39AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.18-rc2-mm1:
>...
> +add-force-of-use-mmconfig.patch
>...
>  x86 updates
>...

This patch contains the following fixes:
- add an #include <asm/setup.h> for getting the prototype of 
  add_memory_region()
  since add_memory_region() has two "long long" parameters, it's
  possible this might fix runtime corruption problems
- make the needlessly global pci_mmcfg_force() static
 
Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/i386/pci/mmconfig.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.18-rc2-mm1-full/arch/i386/pci/mmconfig.c.old	2006-07-27 16:18:48.000000000 +0200
+++ linux-2.6.18-rc2-mm1-full/arch/i386/pci/mmconfig.c	2006-07-27 16:19:42.000000000 +0200
@@ -15,6 +15,7 @@
 #include <linux/dmi.h>
 #include <linux/efi.h>
 #include <asm/e820.h>
+#include <asm/setup.h>
 #include "pci.h"
 
 /* aperture is up to 256MB but BIOS may reserve less */
@@ -225,7 +226,7 @@
  * Check force MMCONFIG.
  */
 
-int __init pci_mmcfg_force(void)
+static int __init pci_mmcfg_force(void)
 {
 	if (efi_enabled) {
 		if (dmi_check_system(pci_mmcfg_dmi_system_apple)) {

