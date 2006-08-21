Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWHUSsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWHUSsg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 14:48:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750735AbWHUSsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 14:48:33 -0400
Received: from cantor2.suse.de ([195.135.220.15]:54716 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750738AbWHUSs2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 14:48:28 -0400
Date: Mon, 21 Aug 2006 11:46:39 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org,
       David Miller <davem@davemloft.net>
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       Chris Wedgwood <reviews@ml.cw.f00f.org>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
       acme@ghostprotocols.net, Stephen Hemminger <shemminger@osdl.org>
Subject: [patch 08/20] ipx: header length validation needed
Message-ID: <20060821184639.GI21938@kroah.com>
References: <20060821183818.155091391@quad.kroah.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="ipx-header-length-validation-needed.patch"
In-Reply-To: <20060821184527.GA21938@kroah.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------
From: Stephen Hemminger <shemminger@osdl.org>

This patch will linearize and check there is enough data.
It handles the pprop case as well as avoiding a whole audit of
the routing code.

Signed-off-by: Stephen Hemminger <shemminger@osdl.org>

---
 net/ipx/af_ipx.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.17.8.orig/net/ipx/af_ipx.c
+++ linux-2.6.17.8/net/ipx/af_ipx.c
@@ -1647,7 +1647,8 @@ static int ipx_rcv(struct sk_buff *skb, 
 	ipx_pktsize	= ntohs(ipx->ipx_pktsize);
 	
 	/* Too small or invalid header? */
-	if (ipx_pktsize < sizeof(struct ipxhdr) || ipx_pktsize > skb->len)
+	if (ipx_pktsize < sizeof(struct ipxhdr)
+	   || !pskb_may_pull(skb, ipx_pktsize))
 		goto drop;
                         
 	if (ipx->ipx_checksum != IPX_NO_CHECKSUM &&

--
