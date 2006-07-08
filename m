Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030328AbWGHUUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWGHUUq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 16:20:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030333AbWGHUUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 16:20:44 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:57863 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1030328AbWGHUU0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 16:20:26 -0400
Date: Sat, 8 Jul 2006 22:20:26 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Dave Jones <davej@redhat.com>
Cc: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Subject: [2.6 patch] X86_GX_SUSPMOD must depend on PCI
Message-ID: <20060708202026.GF5020@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems commit 32ee8c3e470d86588b51dc42ed01e85c5fa0f180 accidentially 
reverted cdc9cc1d740ffc3d8d8207fbf5df9bf05fcc9955, IOW, it reintroduced 
the following compile error with CONFIG_PCI=n:

<--  snip  -->

...
  CC      arch/i386/kernel/cpu/cpufreq/gx-suspmod.o
arch/i386/kernel/cpu/cpufreq/gx-suspmod.c: In function ‘gx_detect_chipset’:
arch/i386/kernel/cpu/cpufreq/gx-suspmod.c:193: error: implicit declaration of function ‘pci_match_id’
arch/i386/kernel/cpu/cpufreq/gx-suspmod.c:193: warning: comparison between pointer and integer
make[3]: *** [arch/i386/kernel/cpu/cpufreq/gx-suspmod.o] Error 1

<--  snip  -->

This patch therefore re-adds the dependency of X86_GX_SUSPMOD on PCI.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.17-mm6-full/arch/i386/kernel/cpu/cpufreq/Kconfig.old	2006-07-08 17:29:40.000000000 +0200
+++ linux-2.6.17-mm6-full/arch/i386/kernel/cpu/cpufreq/Kconfig	2006-07-08 17:29:53.000000000 +0200
@@ -96,6 +96,7 @@
 
 config X86_GX_SUSPMOD
 	tristate "Cyrix MediaGX/NatSemi Geode Suspend Modulation"
+	depends on PCI
 	help
 	 This add the CPUFreq driver for NatSemi Geode processors which
 	 support suspend modulation.

