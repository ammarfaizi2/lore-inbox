Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130670AbRAERRJ>; Fri, 5 Jan 2001 12:17:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131557AbRAERQy>; Fri, 5 Jan 2001 12:16:54 -0500
Received: from firebox-ext.surrey.redhat.com ([194.201.25.236]:21755 "EHLO
	meme.surrey.redhat.com") by vger.kernel.org with ESMTP
	id <S131242AbRAERQe>; Fri, 5 Jan 2001 12:16:34 -0500
Date: Fri, 5 Jan 2001 17:16:32 +0000
From: Tim Waugh <twaugh@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.4.0: lp superuser check
Message-ID: <20010105171632.N5253@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is a patch that changes the superuser check in lp to use
capabilities instead.

Does anyone see a problem with it before I send it to Linus?

Tim.
*/

2001-01-05  Tim Waugh  <twaugh@redhat.com>

	* drivers/char/lp.c: Capability check instead of superuser check.
	Patch from acme@connectiva.com.br.

--- linux-2.4.0/drivers/char/lp.c.lp	Wed Nov  1 15:06:20 2000
+++ linux-2.4.0/drivers/char/lp.c	Fri Jan  5 10:58:18 2001
@@ -485,7 +485,7 @@
 			if (copy_to_user((int *) arg, &LP_STAT(minor),
 					sizeof(struct lp_stats)))
 				return -EFAULT;
-			if (suser())
+			if (capable(CAP_SYS_ADMIN))
 				memset(&LP_STAT(minor), 0,
 						sizeof(struct lp_stats));
 			break;
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
