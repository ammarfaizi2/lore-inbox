Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUHCLUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUHCLUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 07:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265792AbUHCLUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 07:20:21 -0400
Received: from ecbull20.frec.bull.fr ([129.183.4.3]:48281 "EHLO
	ecbull20.frec.bull.fr") by vger.kernel.org with ESMTP
	id S265772AbUHCLUQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 07:20:16 -0400
Message-ID: <410F74E1.9020400@bull.net>
Date: Tue, 03 Aug 2004 13:20:01 +0200
From: Guillaume Thouvenin <guillaume.thouvenin@bull.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040413 Debian/1.6-5
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: linux-kernel@vger.kernel.org, riel@redhat.com
Subject: Re: [Patch for review] BSD accounting IO stats
References: <2oJkL-4sl-41@gated-at.bofh.it> <m3r7qpsoa4.fsf@averell.firstfloor.org>
In-Reply-To: <m3r7qpsoa4.fsf@averell.firstfloor.org>
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/08/2004 13:24:51,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 03/08/2004 13:24:54,
	Serialize complete at 03/08/2004 13:24:54
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

>>diff -uprN -X dontdiff linux-2.6.8-rc2/drivers/block/ll_rw_blk.c linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c
>>--- linux-2.6.8-rc2/drivers/block/ll_rw_blk.c	2004-07-18 06:57:42.000000000 +0200
>>+++ linux-2.6.8-rc2+BSDacct_IO/drivers/block/ll_rw_blk.c	2004-07-27 09:17:33.149321480 +0200
>>@@ -1949,10 +1949,12 @@ void drive_stat_acct(struct request *rq,
>> 
>> 	if (rw == READ) {
>> 		disk_stat_add(rq->rq_disk, read_sectors, nr_sectors);
>>+		current->rblk += nr_sectors;
>>    
>>
>
>This doesn't look very useful, because most writes which
>are flushed delayed would get accounted to pdflushd.
>Using such inaccurate data for accounting sounds quite dangerous
>to me.
>  
>
I agree with that. Like you and Andrew said, this metric (write block) 
is just an estimate (quite wrong indeed) of what really occurred in the 
system because some writings are accounted elsewhere (pdflush or 
journaling file system).

I also agree that a rough estimation is not very interesting, therefore 
I'm working on another patch to provide accurate values.

Best,
Guillaume
