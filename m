Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVAIPdE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVAIPdE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 10:33:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261497AbVAIPdE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 10:33:04 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:35535 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261585AbVAIPcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 10:32:17 -0500
Date: Sun, 9 Jan 2005 16:32:16 +0100
From: Jens Axboe <axboe@suse.de>
To: Hikaru1@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ide-cd in 2.6.8-2.6.10 and 2.4.26-2.4.28 high cpu use with dma
Message-ID: <20050109153212.GA28417@suse.de>
References: <20050109105201.GB12497@roll> <20050109105418.GD12497@roll> <20050109123028.GA12753@roll>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050109123028.GA12753@roll>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 09 2005, Hikaru1@verizon.net wrote:
> A minor mistake. I forgot to state explicitly that the problem only appears
> with writing audio cds. Writing data cds does not cause problems.

The change isn't safe, it was made for a reason since some drives
timeout if the alignment/length isn't correct. It probably is a little
pessimistic right now, can you see if this just works for you?

===== drivers/ide/ide-cd.c 1.105 vs edited =====
--- 1.105/drivers/ide/ide-cd.c	2005-01-08 06:43:53 +01:00
+++ edited/drivers/ide/ide-cd.c	2005-01-09 16:31:53 +01:00
@@ -1915,7 +1915,7 @@
 		/*
 		 * check if dma is safe
 		 */
-		if ((rq->data_len & mask) || (addr & mask))
+		if ((rq->data_len & 3) || (addr & mask))
 			info->dma = 0;
 	}
 

-- 
Jens Axboe

