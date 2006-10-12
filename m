Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161114AbWJLFaG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161114AbWJLFaG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 01:30:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965285AbWJLFaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 01:30:05 -0400
Received: from py-out-1112.google.com ([64.233.166.176]:5342 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S965284AbWJLFaC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 01:30:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mail-followup-to:mime-version:content-type:content-disposition:user-agent;
        b=F6+32uC0wUNBgqhMvGhJKnJpFdukerDu6jJNPgObx665p32aiqndNQu7FBJpl60qu7fAlsfGJ7MrC+To6OeOnkITGtMf3HCMetGkijG7vf37vqLsK5cPvzssXmLYFYwt51MbusKMpQCPuarKSGFPdK4fEcm7NRta5ZpAaybpbsQ=
Date: Thu, 12 Oct 2006 14:30:24 +0900
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Subject: [PATCH] sch_htb: use rb_first() cleanup
Message-ID: <20061012053024.GC29465@localhost>
Mail-Followup-To: Akinobu Mita <akinobu.mita@gmail.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use rb_first() to get first entry in rb tree.

Cc: "David S. Miller" <davem@davemloft.net>
Signed-off-by: Akinbou Mita <akinobu.mita@gmail.com>

 net/sched/sch_htb.c |    5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

Index: work-fault-inject/net/sched/sch_htb.c
===================================================================
--- work-fault-inject.orig/net/sched/sch_htb.c
+++ work-fault-inject/net/sched/sch_htb.c
@@ -786,11 +786,10 @@ static long htb_do_events(struct htb_sch
 	for (i = 0; i < 500; i++) {
 		struct htb_class *cl;
 		long diff;
-		struct rb_node *p = q->wait_pq[level].rb_node;
+		struct rb_node *p = rb_first(&q->wait_pq[level]);
+
 		if (!p)
 			return 0;
-		while (p->rb_left)
-			p = p->rb_left;
 
 		cl = rb_entry(p, struct htb_class, pq_node);
 		if (time_after(cl->pq_key, q->jiffies)) {
