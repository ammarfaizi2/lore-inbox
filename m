Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1032268AbWLGOu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1032268AbWLGOu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Dec 2006 09:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032269AbWLGOu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Dec 2006 09:50:27 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:3065 "EHLO dspnet.fr.eu.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1032268AbWLGOuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Dec 2006 09:50:25 -0500
Date: Thu, 7 Dec 2006 15:50:24 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
       "Hack inc." <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] PCI MMConfig: Only call unreachable_devices() when type 1 is available.
Message-ID: <20061207145024.GB45089@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Andi Kleen <ak@suse.de>, linux-pci@atrey.karlin.mff.cuni.cz,
	"Hack inc." <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>
References: <20061207143603.GA41804@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061207143603.GA41804@dspnet.fr.eu.org>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

unreachable_devices compares between the results of pci configuration
accesses through type1 and mmconfig, so it should be called only if
type1 actually works in the first place.

Signed-off-by: Olivier Galibert <galibert@pobox.com>
---
 arch/i386/pci/mmconfig-shared.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/arch/i386/pci/mmconfig-shared.c b/arch/i386/pci/mmconfig-shared.c
index 4ca3f5a..7a8a498 100644
--- a/arch/i386/pci/mmconfig-shared.c
+++ b/arch/i386/pci/mmconfig-shared.c
@@ -82,7 +82,8 @@ void __init pci_mmcfg_init(int type)
 	}
 
 	if (pci_mmcfg_arch_init()) {
-		unreachable_devices();
+		if (type == 1)
+			unreachable_devices();
 		pci_probe = (pci_probe & ~PCI_PROBE_MASK) | PCI_PROBE_MMCONF;
 	}
 }
-- 
1.4.4.1.g278f

