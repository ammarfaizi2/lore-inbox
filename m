Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262869AbUKTFCJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262869AbUKTFCJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:02:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbUKTCjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:39:48 -0500
Received: from baikonur.stro.at ([213.239.196.228]:57485 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263091AbUKTCbu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:31:50 -0500
Subject: [patch 3/9]  list_for_each_entry: 	drivers-net-ppp_generic.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:31:48 +0100
Message-ID: <E1CVL2S-0000nb-Va@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







Make code more readable with list_for_each_entry.
Compile tested.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>

---

 linux-2.6.10-rc2-bk4-max/drivers/net/ppp_generic.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

diff -puN drivers/net/ppp_generic.c~list-for-each-entry-drivers_net_ppp_generic drivers/net/ppp_generic.c
--- linux-2.6.10-rc2-bk4/drivers/net/ppp_generic.c~list-for-each-entry-drivers_net_ppp_generic	2004-11-19 17:14:51.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/drivers/net/ppp_generic.c	2004-11-19 17:14:51.000000000 +0100
@@ -1228,8 +1228,7 @@ static int ppp_mp_explode(struct ppp *pp
 
 	nch = 0;
 	hdrlen = (ppp->flags & SC_MP_XSHORTSEQ)? MPHDRLEN_SSN: MPHDRLEN;
-	list = &ppp->channels;
-	while ((list = list->next) != &ppp->channels) {
+	list_for_each(list, &ppp->channels) {
 		pch = list_entry(list, struct channel, clist);
 		nch += pch->avail = (skb_queue_len(&pch->file.xq) == 0);
 		/*
@@ -1688,7 +1687,7 @@ static void
 ppp_receive_mp_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 {
 	u32 mask, seq;
-	struct list_head *l;
+	struct channel *ch;
 	int mphdrlen = (ppp->flags & SC_MP_SHORTSEQ)? MPHDRLEN_SSN: MPHDRLEN;
 
 	if (!pskb_may_pull(skb, mphdrlen + 1) || ppp->mrru == 0)
@@ -1742,8 +1741,7 @@ ppp_receive_mp_frame(struct ppp *ppp, st
 	 * The list of channels can't change because we have the receive
 	 * side of the ppp unit locked.
 	 */
-	for (l = ppp->channels.next; l != &ppp->channels; l = l->next) {
-		struct channel *ch = list_entry(l, struct channel, clist);
+	list_for_each_entry(ch, &ppp->channels, clist) {
 		if (seq_before(ch->lastseq, seq))
 			seq = ch->lastseq;
 	}
@@ -2229,10 +2227,8 @@ static struct compressor_entry *
 find_comp_entry(int proto)
 {
 	struct compressor_entry *ce;
-	struct list_head *list = &compressor_list;
 
-	while ((list = list->next) != &compressor_list) {
-		ce = list_entry(list, struct compressor_entry, list);
+	list_for_each_entry(ce, &compressor_list, list) {
 		if (ce->comp->compress_proto == proto)
 			return ce;
 	}
@@ -2502,20 +2498,15 @@ static struct channel *
 ppp_find_channel(int unit)
 {
 	struct channel *pch;
-	struct list_head *list;
 
-	list = &new_channels;
-	while ((list = list->next) != &new_channels) {
-		pch = list_entry(list, struct channel, list);
+	list_for_each_entry(pch, &new_channels, list) {
 		if (pch->file.index == unit) {
 			list_del(&pch->list);
 			list_add(&pch->list, &all_channels);
 			return pch;
 		}
 	}
-	list = &all_channels;
-	while ((list = list->next) != &all_channels) {
-		pch = list_entry(list, struct channel, list);
+	list_for_each_entry(pch, &all_channels, list) {
 		if (pch->file.index == unit)
 			return pch;
 	}
_
