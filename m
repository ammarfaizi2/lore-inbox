Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132385AbRDJQEf>; Tue, 10 Apr 2001 12:04:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132392AbRDJQEZ>; Tue, 10 Apr 2001 12:04:25 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:23302 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132385AbRDJQES>; Tue, 10 Apr 2001 12:04:18 -0400
Subject: Re: [PATCH] Fix scsi_unblock_requests()
To: gibbs@scsiguy.com (Justin T. Gibbs)
Date: Tue, 10 Apr 2001 17:06:26 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200104101502.f3AF2hs31410@aslan.scsiguy.com> from "Justin T. Gibbs" at Apr 10, 2001 09:02:43 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14n0ey-0004W9-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> In its current implementation, scsi_unblock_requests() simply
> clears host_self_blocked in the SCSI host struct.  This means
> that either a transaction must complete or a new transaction

Suppose the queue is unblocked from inside the functions called to process
the request. In that situation the old code is correct and your code might
introduce other problems

> unblocks.  scsi_queue_next_request() verifies all other state
> to ensure queuing new transactions is safe prior to proceeding.

Including recursion ?

The patch seems right apart from checking these details out further. 

