Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311709AbSCTPxO>; Wed, 20 Mar 2002 10:53:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311725AbSCTPxE>; Wed, 20 Mar 2002 10:53:04 -0500
Received: from [195.63.194.11] ([195.63.194.11]:32781 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311723AbSCTPwq>; Wed, 20 Mar 2002 10:52:46 -0500
Message-ID: <3C98AFFE.3000908@evision-ventures.com>
Date: Wed, 20 Mar 2002 16:51:26 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020311
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Luigi Genoni <kernel@Expansa.sns.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: oops at boot with 2.5.7 and i810
In-Reply-To: <Pine.LNX.4.44.0203192243290.28639-100000@Expansa.sns.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Luigi Genoni wrote:
> 
> On Tue, 19 Mar 2002, Martin Dalecki wrote:
> 
> 
>>Luigi Genoni wrote:
>>
>>>that is: __get_hash_table

OK I have been looking that the correspodning function
and found it only to be related to filesystem super-block
operations as well as buffer_head manipulation... Quite
out of order if you ask me. So the chances are that there
are just particular problems with your compiler/build

In esp. fs/buffer is the only place where it get's used!

/fs/buffer.c:struct buffer_head * __get_hash_table(struct block_device *bdev, 
sector_t block, int size)
./fs/buffer.c:          bh = __get_hash_table(bdev, block, size);
./fs/buffer.c:  old_bh = __get_hash_table(bh->b_bdev, bh->b_blocknr, bh->b_size);

Let me guess: You root partition is on a ReiserFS?

