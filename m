Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268349AbUHQSFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268349AbUHQSFk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268362AbUHQSFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:05:39 -0400
Received: from mx1.redhat.com ([66.187.233.31]:18587 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268349AbUHQSFi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:05:38 -0400
Date: Tue, 17 Aug 2004 11:02:48 -0700
From: "David S. Miller" <davem@redhat.com>
To: dev_null@anet.ne.jp
Cc: a5497108@anet.ne.jp, marcelo.tosatti@cyclades.com,
       linux-kernel@vger.kernel.org
Subject: Re: TG3 doesn't work in kernel 2.4.27
Message-Id: <20040817110248.4c2f7cd8.davem@redhat.com>
In-Reply-To: <200408172129.AJH50391.692B5188@anet.ne.jp>
References: <20040817110002.32088.38168.Mailman@linux.us.dell.com>
	<200408172129.AJH50391.692B5188@anet.ne.jp>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Aug 2004 21:30:06 +0900
Tetsuo Handa <a5497108@anet.ne.jp> wrote:

> I compiled as a UP kernel but it wasn't the cause.
> Also, I patched the above fix on 2.4.27-rc4 and
> compiled as a UP kernel, but didn't work.

Just add this patch, it will fix the problem but it
is not the nicest fix.  I'll work on a better one.

It just disables the new Sun code, and uses the old
fiber handling for 5704.

===== drivers/net/tg3.c 1.193 vs edited =====
--- 1.193/drivers/net/tg3.c	2004-08-16 18:01:30 -07:00
+++ edited/drivers/net/tg3.c	2004-08-16 18:46:58 -07:00
@@ -5415,13 +5398,13 @@
 	 * is enabled.
 	 */
 	tw32_f(MAC_LOW_WMARK_MAX_RX_FRAME, 2);
-
+#if 0
 	if (GET_ASIC_REV(tp->pci_chip_rev_id) == ASIC_REV_5704 &&
 	    (tp->tg3_flags2 & TG3_FLG2_PHY_SERDES)) {
 		/* Use hardware link auto-negotiation */
 		tp->tg3_flags2 |= TG3_FLG2_HW_AUTONEG;
 	}
-
+#endif
 	err = tg3_setup_phy(tp, 1);
 	if (err)
 		return err;
