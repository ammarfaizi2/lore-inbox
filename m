Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271105AbUJVBNe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271105AbUJVBNe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 21:13:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271020AbUJVBGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 21:06:39 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:35077 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S271168AbUJVA7r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:59:47 -0400
Date: Thu, 21 Oct 2004 21:00:47 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       romieu@fr.zoreil.com
Subject: [patch netdev-2.6 1/2] r8169: endian-swap return of rtl8169_tx_vlan_tag()
Message-ID: <20041022010046.GB1945@tuxdriver.com>
Mail-Followup-To: netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
	jgarzik@pobox.com, romieu@fr.zoreil.com
References: <20041022005737.GA1945@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041022005737.GA1945@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Endian-swap return of rtl8169_tx_vlan_tag() in rtl8169_start_xmit()

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 drivers/net/r8169.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- netdev-2.6/drivers/net/r8169.c.netdev	2004-10-21 14:48:38.753676111 -0400
+++ netdev-2.6/drivers/net/r8169.c	2004-10-21 14:49:04.874988962 -0400
@@ -1906,7 +1906,7 @@ static int rtl8169_start_xmit(struct sk_
 
 	tp->tx_skb[entry].len = len;
 	txd->addr = cpu_to_le64(mapping);
-	txd->opts2 = rtl8169_tx_vlan_tag(tp, skb);
+	txd->opts2 = cpu_to_le32(rtl8169_tx_vlan_tag(tp, skb));
 
 	wmb();
 
