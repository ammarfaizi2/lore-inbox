Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965278AbWIFXG2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965278AbWIFXG2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:06:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965124AbWIFXF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:05:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:29133 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965070AbWIFXDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:06 -0400
Date: Wed, 6 Sep 2006 15:57:32 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Chen-Li Tien <cltien@gmail.com>, David Miller <davem@davemloft.net>,
       Adrian Bunk <bunk@stusta.de>
Subject: [patch 27/37] PKTGEN: Fix oops when used with balance-tlb bonding
Message-ID: <20060906225732.GB15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pktgen-fix-oops-when-used-with-balance-tlb-bonding.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Chen-Li Tien <cltien@gmail.com>

Signed-off-by: Chen-Li Tien <cltien@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Adrian Bunk <bunk@stusta.de>


---
 net/core/pktgen.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.17.11.orig/net/core/pktgen.c
+++ linux-2.6.17.11/net/core/pktgen.c
@@ -2149,6 +2149,8 @@ static struct sk_buff *fill_packet_ipv4(
 	skb->mac.raw = ((u8 *) iph) - 14 - pkt_dev->nr_labels*sizeof(u32);
 	skb->dev = odev;
 	skb->pkt_type = PACKET_HOST;
+	skb->nh.iph = iph;
+	skb->h.uh = udph;
 
 	if (pkt_dev->nfrags <= 0)
 		pgh = (struct pktgen_hdr *)skb_put(skb, datalen);

--
