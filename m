Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261574AbVCFXtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261574AbVCFXtd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261580AbVCFXrb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:47:31 -0500
Received: from coderock.org ([193.77.147.115]:59311 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261564AbVCFWg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:36:57 -0500
Subject: [patch 08/14] list_for_each_entry: arch-um-drivers-chan_kern.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, janitor@sternwelten.at,
       jdike@addtoit.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:40 +0100
Message-Id: <20050306223640.8A5C41F1FF@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Make code more readable with list_for_each_reverse.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
Acked-by: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/arch/um/drivers/chan_kern.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/um/drivers/chan_kern.c~list-for-each-entry-drivers_chan_kern arch/um/drivers/chan_kern.c
--- kj/arch/um/drivers/chan_kern.c~list-for-each-entry-drivers_chan_kern	2005-03-05 16:09:00.000000000 +0100
+++ kj-domen/arch/um/drivers/chan_kern.c	2005-03-05 16:09:00.000000000 +0100
@@ -218,7 +218,6 @@ void enable_chan(struct list_head *chans
 
 void close_chan(struct list_head *chans)
 {
-	struct list_head *ele;
 	struct chan *chan;
 
 	/* Close in reverse order as open in case more than one of them
@@ -226,8 +225,7 @@ void close_chan(struct list_head *chans)
 	 * state.  Then, the first one opened will have the original state,
 	 * so it must be the last closed.
 	 */
-        for(ele = chans->prev; ele != chans; ele = ele->prev){
-                chan = list_entry(ele, struct chan, list);
+	list_for_each_entry_reverse(chan, chans, list) {
 		if(!chan->opened) continue;
 		if(chan->ops->close != NULL)
 			(*chan->ops->close)(chan->fd, chan->data);
_
