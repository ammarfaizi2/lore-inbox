Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265058AbTFCPfp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 11:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbTFCPfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 11:35:44 -0400
Received: from ns.suse.de ([213.95.15.193]:43280 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265064AbTFCPeb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 11:34:31 -0400
Date: Tue, 3 Jun 2003 17:48:06 +0200
From: Jens Axboe <axboe@suse.de>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: CFQ - 2.5.70-mm3 BUGs
Message-ID: <20030603154806.GI4853@suse.de>
References: <200306031113.49405.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306031113.49405.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 03 2003, Con Kolivas wrote:
> I thought I'd give the cfq another run since some change has made it
> into this patch and got these BUGs together (note, preempt enabled and
> UP +IDE):

The version in -mm3 is woefully out of data, my fault... This should fix
it, once the modular elv stuff is done, I'll update the version.

--- drivers/block/cfq-iosched.c~	2003-06-03 11:35:35.000000000 +0200
+++ drivers/block/cfq-iosched.c	2003-06-03 17:46:57.000000000 +0200
@@ -244,6 +244,7 @@
 		struct cfq_queue *cfqq = crq->cfq_queue;
 
 		cfq_remove_merge_hints(q, crq);
+		list_del_init(&rq->queuelist);
 
 		if (cfqq) {
 			cfq_del_crq_rb(cfqq, crq);

-- 
Jens Axboe

