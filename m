Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262846AbUKTEXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262846AbUKTEXA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbUKTClp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:41:45 -0500
Received: from baikonur.stro.at ([213.239.196.228]:35009 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S262846AbUKTCbp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:31:45 -0500
Subject: [patch 1/9]  list_for_each_entry: 	arch-um-drivers-chan_kern.c
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:31:42 +0100
Message-ID: <E1CVL2M-0000jL-OW@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org







Make code more readable with list_for_each_reverse.

Signed-off-by: Domen Puncer <domen@coderock.org>
Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc2-bk4-max/arch/um/drivers/chan_kern.c |    4 +---
 1 files changed, 1 insertion(+), 3 deletions(-)

diff -puN arch/um/drivers/chan_kern.c~list-for-each-entry-drivers_chan_kern arch/um/drivers/chan_kern.c
--- linux-2.6.10-rc2-bk4/arch/um/drivers/chan_kern.c~list-for-each-entry-drivers_chan_kern	2004-11-19 17:14:47.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/arch/um/drivers/chan_kern.c	2004-11-19 17:14:47.000000000 +0100
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
