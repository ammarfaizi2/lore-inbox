Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSEARFU>; Wed, 1 May 2002 13:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313639AbSEARFT>; Wed, 1 May 2002 13:05:19 -0400
Received: from [195.63.194.11] ([195.63.194.11]:21011 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S313571AbSEARFS>; Wed, 1 May 2002 13:05:18 -0400
Message-ID: <3CD0119D.1080905@evision-ventures.com>
Date: Wed, 01 May 2002 18:02:37 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] reworked IDE/general tagged command queueing
In-Reply-To: <Pine.LNX.4.44.0205010900050.4589-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Linus Torvalds napisa?:
> 
> On Wed, 1 May 2002, Jens Axboe wrote:
> 
>>I've rewritten parts of the IDE TCQ stuff to be, well, a lot better in
>>my oppinion. I had to accept that the ata_request and rq->special usage
>>sucked, it was just one big mess.
> 
> 
> Looks good.

Well after a short cross over look at it I agree.
The generic interface looks sane for me as well. However
I will have to look a bit deeper, becouse at the first sight
the double pointer to tag_index looks a bit "overelaborate"
to me. But I may change my opinnion after looking at the
actual usage - so please take this small bit of critique
with a good grain of salt...

+#define BLK_TAGS_PER_LONG	(sizeof(unsigned long) * 8)
+#define BLK_TAGS_MASK		(BLK_TAGS_PER_LONG - 1)
+
+struct blk_queue_tag {
+ 
struct request **tag_index;	/* map of busy tags */
+ 
unsigned long *tag_map;		/* bit map of free/busy tags */
+ 
struct list_head busy_list;	/* fifo list of busy tags */
+ 
int busy;			/* current depth */
+ 
int max_depth;
+};
+

