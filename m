Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbVHHWae@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbVHHWae (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 18:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932303AbVHHWae
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 18:30:34 -0400
Received: from coderock.org ([193.77.147.115]:28547 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S932302AbVHHWad (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 18:30:33 -0400
Message-Id: <20050808223020.035914000@homer>
References: <20050808222936.090422000@homer>
Date: Tue, 09 Aug 2005 00:29:38 +0200
From: domen@coderock.org
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, Maximilian Attems <janitor@sternwelten.at>,
       domen@coderock.org
Subject: [patch 02/16] net/ppp-generic: list_for_each_entry
Content-Disposition: inline; filename=list-for-each-entry-drivers_net_ppp_generic.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Domen Puncer <domen@coderock.org>



Make code more readable with list_for_each_entry.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Signed-off-by: Domen Puncer <domen@coderock.org>
---
 ppp_generic.c |   21 ++++++---------------
 1 files changed, 6 insertions(+), 15 deletions(-)

Index: quilt/drivers/net/ppp_generic.c
===================================================================
--- quilt.orig/drivers/net/ppp_generic.c
+++ quilt/drivers/net/ppp_generic.c
@@ -1232,8 +1232,7 @@ static int ppp_mp_explode(struct ppp *pp
 	navail = 0;	/* total # of usable channels (not deregistered) */
 	hdrlen = (ppp->flags & SC_MP_XSHORTSEQ)? MPHDRLEN_SSN: MPHDRLEN;
 	i = 0;
-	list = &ppp->channels;
-	while ((list = list->next) != &ppp->channels) {
+	list_for_each(list, &ppp->channels) {
 		pch = list_entry(list, struct channel, clist);
 		navail += pch->avail = (pch->chan != NULL);
 		if (pch->avail) {
@@ -1731,7 +1730,7 @@ static void
 ppp_receive_mp_frame(struct ppp *ppp, struct sk_buff *skb, struct channel *pch)
 {
 	u32 mask, seq;
-	struct list_head *l;
+	struct channel *ch;
 	int mphdrlen = (ppp->flags & SC_MP_SHORTSEQ)? MPHDRLEN_SSN: MPHDRLEN;
 
 	if (!pskb_may_pull(skb, mphdrlen) || ppp->mrru == 0)
@@ -1785,8 +1784,7 @@ ppp_receive_mp_frame(struct ppp *ppp, st
 	 * The list of channels can't change because we have the receive
 	 * side of the ppp unit locked.
 	 */
-	for (l = ppp->channels.next; l != &ppp->channels; l = l->next) {
-		struct channel *ch = list_entry(l, struct channel, clist);
+	list_for_each_entry(ch, &ppp->channels, clist) {
 		if (seq_before(ch->lastseq, seq))
 			seq = ch->lastseq;
 	}
@@ -2272,10 +2270,8 @@ static struct compressor_entry *
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
@@ -2541,20 +2537,15 @@ static struct channel *
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

--
