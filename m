Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267767AbUI1UIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267767AbUI1UIO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 16:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267777AbUI1UIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 16:08:14 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:45317 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S267767AbUI1UIM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 16:08:12 -0400
Date: Tue, 28 Sep 2004 14:54:55 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: akpm@osdl.org
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [patch 2.6.9-rc2] 3c59x: do not mask reset of aism logic at rmmod
Message-ID: <20040928145455.C12480@tuxdriver.com>
Mail-Followup-To: akpm@osdl.org, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some (earlier?) versions of the 3c905(B) card get confused and refuse to
work again after the 3c59x module is removed (even after reloading the
module).  Changing vortex_remove_one() to allow the auto-initialize
state machine logic to be reset when the module is removed alleviates
this problem.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
--- 
See http://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=133388 for more
details.

If anyone can suggest a better way to fix this problem, please do so.
I'll be happy to pursue it.

 drivers/net/3c59x.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

This patch should apply (with a little fuzz) to 2.4 as well...

--- linux-2.6/drivers/net/3c59x.c.orig
+++ linux-2.6/drivers/net/3c59x.c
@@ -3162,7 +3162,7 @@ static void __devexit vortex_remove_one 
 			pci_restore_state(VORTEX_PCI(vp), vp->power_state);
 	}
 	/* Should really use issue_and_wait() here */
-	outw(TotalReset|0x14, dev->base_addr + EL3_CMD);
+	outw(TotalReset|0x04, dev->base_addr + EL3_CMD);
 
 	pci_free_consistent(pdev,
 						sizeof(struct boom_rx_desc) * RX_RING_SIZE
