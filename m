Return-Path: <linux-kernel-owner+w=401wt.eu-S964922AbWLMM5c@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964922AbWLMM5c (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:57:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964925AbWLMM5c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:57:32 -0500
Received: from nic.NetDirect.CA ([216.16.235.2]:46516 "EHLO
	rubicon.netdirect.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964922AbWLMM5b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:57:31 -0500
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 07:57:31 EST
X-Originating-Ip: 74.109.98.100
Date: Wed, 13 Dec 2006 07:44:55 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
cc: trivial@kernel.org
Subject: [PATCH] kbuild: Replace remaining "depends" with "depends on"
Message-ID: <Pine.LNX.4.64.0612130735450.31075@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck: not spam, SpamAssassin (not cached,
	score=-16.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Replace the very few remaining "depends" Kconfig directives with
"depends on".

Signed-off-by: Robert P. J. Day <rpjday@mindspring.com>

---

  Given the recent patch that was applied to make this transformation,
might as well finish it off and deal with those last three cases.

  At this point, all Kconfig files should contain *only* "depends on"
and neither "depends" nor "requires", so whoever is responsible for
the care and feeding of the parser might consider dropping support for
those latter directives if there's no overwhelming rationale to keep
supporting them.

  Unlike in Perl, "there's more than one way to do it" doesn't apply
equally well to kernel source.  :-)

 arch/arm/Kconfig    |    2 +-
 arch/arm/mm/Kconfig |    2 +-
 arch/v850/Kconfig   |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index aa1d400..c418e72 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -392,7 +392,7 @@ source arch/arm/mm/Kconfig

 config IWMMXT
 	bool "Enable iWMMXt support"
-	depends CPU_XSCALE || CPU_XSC3
+	depends on CPU_XSCALE || CPU_XSC3
 	default y if PXA27x
 	help
 	  Enable support for iWMMXt context switching at run time if
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index aade2f7..3c2f979 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -525,7 +525,7 @@ config CPU_BIG_ENDIAN
 	  of your chipset/board/processor.

 config CPU_HIGH_VECTOR
-	depends !MMU && CPU_CP15 && !CPU_ARM740T
+	depends on !MMU && CPU_CP15 && !CPU_ARM740T
 	bool "Select the High exception vector"
 	default n
 	help
diff --git a/arch/v850/Kconfig b/arch/v850/Kconfig
index f0d4d72..aeddaa7 100644
--- a/arch/v850/Kconfig
+++ b/arch/v850/Kconfig
@@ -214,7 +214,7 @@ menu "Processor type and features"
    # Some platforms pre-zero memory, in which case the kernel doesn't need to
    config ZERO_BSS
    	  bool
-	  depends !V850E2_SIM85E2C
+	  depends on !V850E2_SIM85E2C
 	  default y

    # The crappy-ass zone allocator requires that the start of allocatable
