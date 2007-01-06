Return-Path: <linux-kernel-owner+w=401wt.eu-S1751137AbXAFCeV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbXAFCeV (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 21:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751148AbXAFCd5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 21:33:57 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53913 "EHLO
	sous-sol.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751136AbXAFCdt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 21:33:49 -0500
Message-Id: <20070106023541.777137000@sous-sol.org>
References: <20070106022753.334962000@sous-sol.org>
User-Agent: quilt/0.45-1
Date: Fri, 05 Jan 2007 18:28:30 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>,
       Michael Krufky <mkrufky@linuxtv.org>, torvalds@osdl.org, akpm@osdl.org,
       alan@lxorguk.ukuu.org.uk, David Miller <davem@davemloft.net>,
       Jan Andersson <jan.andersson@ieee.org>,
       William Lee Irwin III <wli@holomorphy.com>
Subject: [patch 37/50] sparc32: add offset in pci_map_sg()
Content-Disposition: inline; filename=sparc32-add-offset-in-pci_map_sg.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.
------------------

From: Jan Andersson <jan.andersson@ieee.org>

Add sg->offset to sg->dvma_address in pci_map_sg() on sparc32.  Without the
offset, transfers to buffers that do not begin on a page boundary will not
work as expected.

Signed-off-by: Jan Andersson <jan.andersson@ieee.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: William Lee Irwin III <wli@holomorphy.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Linus Torvalds <torvalds@osdl.org>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>

---
 arch/sparc/kernel/ioport.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.19.1.orig/arch/sparc/kernel/ioport.c
+++ linux-2.6.19.1/arch/sparc/kernel/ioport.c
@@ -728,7 +728,8 @@ int pci_map_sg(struct pci_dev *hwdev, st
 	/* IIep is write-through, not flushing. */
 	for (n = 0; n < nents; n++) {
 		BUG_ON(page_address(sg->page) == NULL);
-		sg->dvma_address = virt_to_phys(page_address(sg->page));
+		sg->dvma_address =
+			virt_to_phys(page_address(sg->page)) + sg->offset;
 		sg->dvma_length = sg->length;
 		sg++;
 	}

--
