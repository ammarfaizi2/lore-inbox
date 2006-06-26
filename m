Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933091AbWFZWQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933091AbWFZWQh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933094AbWFZWQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:16:37 -0400
Received: from web50102.mail.yahoo.com ([206.190.38.30]:5014 "HELO
	web50102.mail.yahoo.com") by vger.kernel.org with SMTP
	id S933091AbWFZWQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:16:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=q2Ne+BqAP2c4YBVKNprv3qaUBdGtnejzOllMpVi/SoKvjKFwYuzR74fGxj+OX/Tw2dDmnyuvoyl1T4sjcIBu+xbDUvHzewfjA9yXAj72sIyZzFKRBVxJrmy/TxEoyFoEq6yTeZ0ww4DKpsjWtlsHIsI5KGd8Mz/AkZp4jAk2G28=  ;
Message-ID: <20060626221633.50020.qmail@web50102.mail.yahoo.com>
Date: Mon, 26 Jun 2006 15:16:33 -0700 (PDT)
From: Doug Thompson <norsk5@yahoo.com>
Subject: [PATCH 2/6]  EDAC mc numbers refactor 1-of-2
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Doug Thompson <norsk5@xmission.com>

This is part 1 of a 2-part patch set.  The code changes are split into two
parts to make the patches more readable.

Remove add_mc_to_global_list().  
In next patch, this function will be reimplemented with different semantics.

Signed-off-by: Doug Thompson <norsk5@xmission.com>
---
 edac_mc.c |   43 -------------------------------------------
 1 files changed, 43 deletions(-)


Index: linux-2.6.17-rc5/drivers/edac/edac_mc.c
===================================================================
--- linux-2.6.17-rc5.orig/drivers/edac/edac_mc.c	2006-05-25 14:06:07.000000000 -0600
+++ linux-2.6.17-rc5/drivers/edac/edac_mc.c	2006-05-25 14:06:40.000000000 -0600
@@ -1632,49 +1632,6 @@
 	return NULL;
 }
 
-static int add_mc_to_global_list(struct mem_ctl_info *mci)
-{
-	struct list_head *item, *insert_before;
-	struct mem_ctl_info *p;
-	int i;
-
-	if (list_empty(&mc_devices)) {
-		mci->mc_idx = 0;
-		insert_before = &mc_devices;
-	} else {
-		if (find_mci_by_dev(mci->dev)) {
-			edac_printk(KERN_WARNING, EDAC_MC,
-				"%s (%s) %s %s already assigned %d\n",
-				mci->dev->bus_id, dev_name(mci->dev),
-				mci->mod_name, mci->ctl_name,
-				mci->mc_idx);
-			return 1;
-		}
-
-		insert_before = NULL;
-		i = 0;
-
-		list_for_each(item, &mc_devices) {
-			p = list_entry(item, struct mem_ctl_info, link);
-
-			if (p->mc_idx != i) {
-				insert_before = item;
-				break;
-			}
-
-			i++;
-		}
-
-		mci->mc_idx = i;
-
-		if (insert_before == NULL)
-			insert_before = &mc_devices;
-	}
-
-	list_add_tail_rcu(&mci->link, insert_before);
-	return 0;
-}
-
 static void complete_mc_list_del(struct rcu_head *head)
 {
 	struct mem_ctl_info *mci;

