Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSG2Nkz>; Mon, 29 Jul 2002 09:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317217AbSG2Nkz>; Mon, 29 Jul 2002 09:40:55 -0400
Received: from host194.steeleye.com ([216.33.1.194]:55826 "EHLO
	pogo.mtv1.steeleye.com") by vger.kernel.org with ESMTP
	id <S317215AbSG2Nkz>; Mon, 29 Jul 2002 09:40:55 -0400
Message-Id: <200207291344.g6TDiCR11064@localhost.localdomain>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
To: Jens Axboe <axboe@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Marcin Dalecki <dalecki@evision.ag>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.28 small REQ_SPECIAL abstraction 
In-Reply-To: Message from Jens Axboe <axboe@suse.de> 
   of "Mon, 29 Jul 2002 12:43:51 +0200." <20020729124351.C4861@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 29 Jul 2002 08:44:12 -0500
From: James Bottomley <James.Bottomley@steeleye.com>
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

axboe@suse.de said:
> Ok... I had two issues with the patch. 1) it did
> 	rq->flags &= REQ_QUEUED; 

Yes, that was inherited from SCSI.  Previously it just cleared flags and then 
set REQ_BARRIER|REQ_SPECIAL.  Now I needed to clear flags but preserve the 
state of REQ_QUEUED, which is what that code is doing, otherwise the 
blk_rq_tagged() would always fail lower down.

> I'll back down, it's not a matter of life and death after all. Here's
> the minimal patch that corrects the flag thing, and also makes
> blk_insert_request() conform to kernel style. Are we all happy? 

I'm happy (as long as it works on my SCSI card).

James


