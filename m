Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261292AbVDBWgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261292AbVDBWgj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 17:36:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261304AbVDBWgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 17:36:39 -0500
Received: from mail.dif.dk ([193.138.115.101]:20642 "EHLO saerimmer.dif.dk")
	by vger.kernel.org with ESMTP id S261292AbVDBWgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 17:36:36 -0500
Date: Sun, 3 Apr 2005 00:38:54 +0200 (CEST)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Maciej Soltysiak <solt2@dns.toxicfilms.tv>
Cc: "James P. Ketrenos" <ipw2100-admin@linux.intel.com>, netdev@oss.sgi.com,
       "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org
Subject: Re: [2.6.12-rc1-mm4] swapped memset arguments
In-Reply-To: <74334709.20050402233007@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.4.62.0504030035190.2525@dragon.hyggekrogen.localhost>
References: <74334709.20050402233007@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Apr 2005, Maciej Soltysiak wrote:

> Hi,
> 
> out of boredom I grepped 2.6.12-rc1-mm4 for swapped memset arguments.
> I found one:
> 
> # grep -nr "memset.*\,\(\ \|\)0\(\ \|\));" *
> net/ieee80211/ieee80211_tx.c:226:       memset(txb, sizeof(struct ieee80211_txb), 0);  
> 
And here's a patch : 


Fix swapped memset() arguments in  net/ieee80211/ieee80211_tx.c  
found by Maciej Soltysiak.

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm4-orig/net/ieee80211/ieee80211_tx.c	2005-03-31 21:20:08.000000000 +0200
+++ linux-2.6.12-rc1-mm4/net/ieee80211/ieee80211_tx.c	2005-04-03 00:34:22.000000000 +0200
@@ -223,7 +223,7 @@ struct ieee80211_txb *ieee80211_alloc_tx
 	if (!txb)
 		return NULL;
 
-	memset(txb, sizeof(struct ieee80211_txb), 0);
+	memset(txb, 0, sizeof(struct ieee80211_txb));
 	txb->nr_frags = nr_frags;
 	txb->frag_size = txb_size;
 


