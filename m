Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262848AbUKXVAo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbUKXVAo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 16:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262849AbUKXVAo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 16:00:44 -0500
Received: from ns.theshore.net ([67.18.92.50]:664 "EHLO www.theshore.net")
	by vger.kernel.org with ESMTP id S262848AbUKXVAN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 16:00:13 -0500
Message-ID: <000f01c4d25b$e8d497c0$0201a8c0@hawk>
From: "Christopher S. Aker" <caker@theshore.net>
To: "Jens Axboe" <axboe@suse.de>
Cc: <linux-kernel@vger.kernel.org>
References: <001301c4d1f6$941d1370$0201a8c0@hawk> <20041124130139.GC13847@suse.de> <20041124132449.GD13847@suse.de> <002e01c4d22a$f426f630$0201a8c0@hawk> <20041124134038.GF13847@suse.de>
Subject: Re: 2.6.10-rc2-bk7 - Badness in cfq_put_request at drivers/block/cfq-iosched.c:1402
Date: Wed, 24 Nov 2004 13:29:24 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1437
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1441
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Can you try this simple check to see if it triggers anything?
>
> ===== cfq-iosched.c 1.13 vs edited =====
> --- 1.13/drivers/block/cfq-iosched.c 2004-10-30 01:35:21 +02:00
> +++ edited/cfq-iosched.c 2004-11-24 14:40:13 +01:00
> @@ -1389,6 +1389,8 @@
>   struct cfq_data *cfqd = q->elevator->elevator_data;
>   struct cfq_rq *crq = RQ_DATA(rq);
>
> + WARN_ON(!spin_is_locked(q->queue_lock));
> +
>   if (crq) {
>   struct cfq_queue *cfqq = crq->cfq_queue;

I'd be happy to, but I won't have a free machine for a couple of days.  I'll can
probably give it a shot during the weekend...

-Chris

