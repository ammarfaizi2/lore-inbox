Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267963AbUHPVmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267963AbUHPVmQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 17:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267967AbUHPVmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 17:42:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43234 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267963AbUHPVkq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 17:40:46 -0400
Date: Mon, 16 Aug 2004 14:38:24 -0700
From: "David S. Miller" <davem@redhat.com>
To: Tetsuo Handa <a5497108@anet.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27 (David S. Miller)
Message-Id: <20040816143824.15238e42.davem@redhat.com>
In-Reply-To: <200408162049.FFF09413.8592816B@anet.ne.jp>
References: <20040816110000.1120.31256.Mailman@lists.us.dell.com>
	<200408162049.FFF09413.8592816B@anet.ne.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Aug 2004 20:51:03 +0900
Tetsuo Handa <a5497108@anet.ne.jp> wrote:

>  From 2.4.26 till 2.4.27-rc3 were all OK.
> This trouble happens with 2.4.27-rc4 and later.

It's Sun's buggy 5704 Fiber auto-negotiation changes.

Here is a hacky possible fix, can you try it?

===== drivers/net/tg3.c 1.190 vs edited =====
--- 1.190/drivers/net/tg3.c	2004-07-21 14:14:20 -07:00
+++ edited/drivers/net/tg3.c	2004-08-16 14:24:53 -07:00
@@ -5266,6 +5266,8 @@
 	tw32_f(MAC_LOW_WMARK_MAX_RX_FRAME, 2);
 
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704 &&
+	    !(tp->pci_chip_rev_id == CHIPREV_ID_5704_A0 ||
+	      tp->pci_chip_rev_id == CHIPREV_ID_5704_A1) &&
 	    tp->phy_id == PHY_ID_SERDES) {
 		/* Enable hardware link auto-negotiation */
 		u32 digctrl, txctrl;
