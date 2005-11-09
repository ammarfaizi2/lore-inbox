Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030514AbVKIF5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030514AbVKIF5p (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 00:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030513AbVKIF5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 00:57:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:8874 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030515AbVKIF5p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 00:57:45 -0500
Date: Wed, 9 Nov 2005 00:57:39 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: fix sparse warning in horizon atm driver.
Message-ID: <20051109055739.GA630@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

these vars get fed u32's, and are OR'd with u32's.
Chances are they were meant to be u32's.

I don't have hardware to test this, but I can't fathom
why a u16 would be used here.

drivers/atm/horizon.c:1564:12: warning: cast truncates bits from constant value (40000000 becomes 0)
drivers/atm/horizon.c:1565:12: warning: cast truncates bits from constant value (40000000 becomes 0)
drivers/atm/horizon.c:1569:12: warning: cast truncates bits from constant value (80000000 becomes 0)
drivers/atm/horizon.c:1570:12: warning: cast truncates bits from constant value (80000000 becomes 0)

Signed-off-by: Dave Jones <davej@redhat.com>

--- linus/drivers/atm/horizon.c~	2005-11-09 00:51:50.000000000 -0500
+++ linus/drivers/atm/horizon.c	2005-11-09 00:55:36.000000000 -0500
@@ -1511,8 +1511,8 @@ static inline short setup_idle_tx_channe
     // a.k.a. prepare the channel and remember that we have done so.
     
     tx_ch_desc * tx_desc = &memmap->tx_descs[tx_channel];
-    u16 rd_ptr;
-    u16 wr_ptr;
+    u32 rd_ptr;
+    u32 wr_ptr;
     u16 channel = vcc->channel;
     
     unsigned long flags;
