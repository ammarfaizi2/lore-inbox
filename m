Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261684AbVDRGIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261684AbVDRGIz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 02:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDRGIz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 02:08:55 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:41232 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S261684AbVDRGIv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 02:08:51 -0400
Date: Mon, 18 Apr 2005 16:07:44 +1000
To: Shaun Reitan <mailinglists@unix-scripts.com>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: kernel panic - not syncing: Fatal exception in interupt
Message-ID: <20050418060744.GA5057@gondor.apana.org.au>
References: <d2vu0u$oog$1@sea.gmane.org> <Pine.LNX.4.61.0504060209200.15520@montezuma.fsmlabs.com> <03f201c53aeb$a42d1270$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504070207430.12823@montezuma.fsmlabs.com> <023b01c53f3b$a8083e20$0201a8c0@ndciwkst01> <Pine.LNX.4.61.0504120612210.14171@montezuma.fsmlabs.com> <d3ugtr$gml$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <d3ugtr$gml$1@sea.gmane.org>
User-Agent: Mutt/1.5.6+20040907i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Apr 17, 2005 at 08:32:42PM +0000, Shaun Reitan wrote:
> OK, finally got a full dump from the serial console!  Here is it!

This was fixed about a month ago.  Here is the patch that did it.

Perhaps it's time to include this in 2.6.11.*?

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1.2009.20.2"

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2005/03/14 21:22:31-08:00 bdschuym@pandora.be 
#   [EBTABLES]: Fix smp race.
#   
#   The patch below fixes an smp race that happens on such systems under
#   heavy load.
#   This bug was reported and solved by Steve Herrell
#   <steve_herrell@yahoo.ca>
#   
#   Signed-off-by: Bart De Schuymer <bdschuym@pandora.be>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
# net/bridge/netfilter/ebtables.c
#   2005/03/14 21:22:13-08:00 bdschuym@pandora.be +2 -1
#   [EBTABLES]: Fix smp race.
#   
#   The patch below fixes an smp race that happens on such systems under
#   heavy load.
#   This bug was reported and solved by Steve Herrell
#   <steve_herrell@yahoo.ca>
#   
#   Signed-off-by: Bart De Schuymer <bdschuym@pandora.be>
#   Signed-off-by: David S. Miller <davem@davemloft.net>
# 
diff -Nru a/net/bridge/netfilter/ebtables.c b/net/bridge/netfilter/ebtables.c
--- a/net/bridge/netfilter/ebtables.c	2005-04-18 15:59:25 +10:00
+++ b/net/bridge/netfilter/ebtables.c	2005-04-18 15:59:25 +10:00
@@ -179,9 +179,10 @@
 	struct ebt_chainstack *cs;
 	struct ebt_entries *chaininfo;
 	char *base;
-	struct ebt_table_info *private = table->private;
+	struct ebt_table_info *private;
 
 	read_lock_bh(&table->lock);
+	private = table->private;
 	cb_base = COUNTER_BASE(private->counters, private->nentries,
 	   smp_processor_id());
 	if (private->chainstack)

--EeQfGwPcQSOJBaQU--
