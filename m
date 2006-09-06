Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965284AbWIFXKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965284AbWIFXKe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWIFXIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:08:55 -0400
Received: from mail.kroah.org ([69.55.234.183]:27085 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S965068AbWIFXDD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:03:03 -0400
Date: Wed, 6 Sep 2006 15:57:28 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, bunk@stusta.de
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, cltien@gmail.com,
       "David S. Miller" <davem@davemloft.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 26/37] PKTGEN: Make sure skb->{nh,h} are initialized in fill_packet_ipv6() too.
Message-ID: <20060906225728.GA15922@kroah.com>
References: <20060906224631.999046890@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="pktgen-make-sure-skb-nh-h-are-initialized-in-fill_packet_ipv6-too.patch"
In-Reply-To: <20060906225444.GA15922@kroah.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: David S. Miller <davem@sunset.davemloft.net>

[PKTGEN]: Make sure skb->{nh,h} are initialized in fill_packet_ipv6() too.

Mirror the bug fix from fill_packet_ipv4()

Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 net/core/pktgen.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.17.11.orig/net/core/pktgen.c
+++ linux-2.6.17.11/net/core/pktgen.c
@@ -2460,6 +2460,8 @@ static struct sk_buff *fill_packet_ipv6(
 	skb->protocol = protocol;
 	skb->dev = odev;
 	skb->pkt_type = PACKET_HOST;
+	skb->nh.ipv6h = iph;
+	skb->h.uh = udph;
 
 	if (pkt_dev->nfrags <= 0)
 		pgh = (struct pktgen_hdr *)skb_put(skb, datalen);

--
