Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261316AbVC2TRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261316AbVC2TRH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 14:17:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVC2TRG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 14:17:06 -0500
Received: from smtp11.wanadoo.fr ([193.252.22.31]:27458 "EHLO
	smtp11.wanadoo.fr") by vger.kernel.org with ESMTP id S261316AbVC2TQx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 14:16:53 -0500
X-ME-UUID: 20050329191644934.E41EB1C0009C@mwinf1108.wanadoo.fr
From: Guillaume Foliard <guifo@wanadoo.fr>
Organization: _
To: mingo@elte.hu
Subject: [patch] Fix tg3 driver disable interrupts bug for realtime-preempt-2.6.12-rc1-V0.7.41-14
Date: Tue, 29 Mar 2005 21:16:45 +0200
User-Agent: KMail/1.8
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503292116.45480.guifo@wanadoo.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I just noticed you've accepted a patch from Yang Yi dealing with interrupts
in the e1000 drivers on a PREEMPT_RT kernel. I did not yet understood the
problem but I blindly applied the same fix on the tg3 driver to get rid of the
following message :

network driver disabled interrupts: tg3_start_xmit+0x0/0x620


Signed-off-by: Guillaume Foliard <guifo@wanadoo.fr>

--- linux-2.6.12-rc1/drivers/net/tg3.c  2005-03-18 02:34:13 +0100
+++ linux-2.6.12-rc1-RT-V0.7.41-14/drivers/net/tg3.c    2005-03-29 20:25:33 +0200
@@ -3085,9 +3085,9 @@ static int tg3_start_xmit(struct sk_buff
         * So we really do need to disable interrupts when taking
         * tx_lock here.
         */
-       local_irq_save(flags);
+       local_irq_save_nort(flags);
        if (!spin_trylock(&tp->tx_lock)) {
-               local_irq_restore(flags);
+               local_irq_restore_nort(flags);
                return NETDEV_TX_LOCKED;
        }


