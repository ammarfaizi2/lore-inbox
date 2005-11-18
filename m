Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbVKROz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbVKROz6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 09:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbVKROz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 09:55:58 -0500
Received: from mx1.redhat.com ([66.187.233.31]:18582 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750748AbVKROz5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 09:55:57 -0500
Date: Fri, 18 Nov 2005 14:55:47 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jblunck@suse.de
Subject: [PATCH] device-mapper snapshot: bio_list fix
Message-ID: <20051118145547.GK11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	jblunck@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bio_list_merge() should do nothing if the second list is empty - not oops.

From: jblunck@suse.de
Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm-bio-list.h
===================================================================
--- linux-2.6.14.orig/drivers/md/dm-bio-list.h	2005-10-28 01:02:08.000000000 +0100
+++ linux-2.6.14/drivers/md/dm-bio-list.h	2005-11-15 15:59:20.000000000 +0000
@@ -33,6 +33,9 @@ static inline void bio_list_add(struct b
 
 static inline void bio_list_merge(struct bio_list *bl, struct bio_list *bl2)
 {
+	if (!bl2->head)
+		return;
+
 	if (bl->tail)
 		bl->tail->bi_next = bl2->head;
 	else
