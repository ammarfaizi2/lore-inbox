Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264124AbUEHFuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264124AbUEHFuM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 01:50:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264138AbUEHFuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 01:50:12 -0400
Received: from arnor.apana.org.au ([203.14.152.115]:53511 "EHLO
	arnor.apana.org.au") by vger.kernel.org with ESMTP id S264124AbUEHFuH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 01:50:07 -0400
Date: Sat, 8 May 2004 15:50:00 +1000
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Call might_sleep in tasklet_kill
Message-ID: <20040508055000.GA31358@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi:

The following patch calls might_sleep in tasklet_kill.  This would've
helped in tracking down http://bugs.debian.org/234365 where someone
called tasklet_kill with IRQs disabled.

Cheers,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel/softirq.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/kernel/softirq.c,v
retrieving revision 1.1.1.12
diff -u -r1.1.1.12 softirq.c
--- a/kernel/softirq.c	5 Apr 2004 09:49:43 -0000	1.1.1.12
+++ b/kernel/softirq.c	8 May 2004 05:48:50 -0000
@@ -286,8 +286,7 @@
 
 void tasklet_kill(struct tasklet_struct *t)
 {
-	if (in_interrupt())
-		printk("Attempt to kill tasklet from interrupt\n");
+	might_sleep();
 
 	while (test_and_set_bit(TASKLET_STATE_SCHED, &t->state)) {
 		do

--/04w6evG8XlLl3ft--
