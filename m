Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVF2TDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVF2TDy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 15:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262433AbVF2TDx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 15:03:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22933 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262442AbVF2TCr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 15:02:47 -0400
Date: Wed, 29 Jun 2005 12:02:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Toufeeq Hussain <toufeeqh@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: 2.6.13-rc1 problems
Message-Id: <20050629120210.489db9fd.akpm@osdl.org>
In-Reply-To: <42C2EAE4.90007@gmail.com>
References: <42C2EAE4.90007@gmail.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Toufeeq Hussain <toufeeqh@gmail.com> wrote:
>
> After upgrading to 2.6.13-rc1 my system crashes after running for around
>  10 minutes.

Try this:

--- 25/drivers/block/ll_rw_blk.c~get_request-nastiness	2005-06-29 09:36:27.000000000 -0700
+++ 25-akpm/drivers/block/ll_rw_blk.c	2005-06-29 09:36:27.000000000 -0700
@@ -1918,10 +1918,9 @@ get_rq:
 	 * limit of requests, otherwise we could have thousands of requests
 	 * allocated with any setting of ->nr_requests
 	 */
-	if (rl->count[rw] >= (3 * q->nr_requests / 2)) {
-		spin_unlock_irq(q->queue_lock);
+	if (rl->count[rw] >= (3 * q->nr_requests / 2))
 		goto out;
-	}
+
 	rl->count[rw]++;
 	rl->starved[rw] = 0;
 	if (rl->count[rw] >= queue_congestion_on_threshold(q))
_

