Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262921AbVALADe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262921AbVALADe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 19:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVAKXku
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 18:40:50 -0500
Received: from coderock.org ([193.77.147.115]:2502 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S262933AbVAKXfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 18:35:09 -0500
Subject: [patch 04/11] list_for_each_entry: arch-um-drivers-chan_kern.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, janitor@sternwelten.at,
       jdike@addtoit.com
From: domen@coderock.org
Date: Wed, 12 Jan 2005 00:35:01 +0100
Message-Id: <20050111233501.EB2A91F226@trashy.coderock.org>
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
--- kj/arch/um/drivers/chan_kern.c~list-for-each-entry-drivers_chan_kern	2005-01-10 17:59:42.000000000 +0100
+++ kj-domen/arch/um/drivers/chan_kern.c	2005-01-10 17:59:42.000000000 +0100
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
