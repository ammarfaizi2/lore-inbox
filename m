Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262660AbTCZXjw>; Wed, 26 Mar 2003 18:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262663AbTCZXjw>; Wed, 26 Mar 2003 18:39:52 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:64451 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S262660AbTCZXjp>; Wed, 26 Mar 2003 18:39:45 -0500
Message-Id: <200303262350.h2QNoqjf015366@post.webmailer.de>
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Subject: Re: [PATCH] s390 update (4/9): common i/o layer update.
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       schwidefsky@de.ibm.com
Date: Thu, 27 Mar 2003 00:47:38 +0100
References: <20030326153033$579e@gated-at.bofh.it> <20030326161014$2d93@gated-at.bofh.it>
User-Agent: KNode/0.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:

> On Wed, Mar 26, 2003 at 04:10:16PM +0100, Martin Schwidefsky wrote:
>> +    typeof (chsc_area_ssd.response_block)
>> +            *ssd_res = &chsc_area_ssd.response_block;
> 
> Yikes!  Please use the actual type here instead of typeof()

That code still has a bigger problem and has to be changed anyway.
If there is a good reason against typeof, I will do it differently
for the final version. This change only kept the hack working
with gcc-3.3, I just forgot to do it right before Martin submitted
it.

>> +    if (sch->lpm == 0)
>> +            return -ENODEV;
>> +    else
>> +            return -EACCES;
> 
> I'd write this as return (sch->lpm ? -EACCES : -ENODEV), but maybe I'm
> just too picky..

No, you are right. I'll change it.

>> -    sch = kmalloc (sizeof (*sch), GFP_DMA);
>> +    sch = kmalloc (sizeof (*sch), GFP_KERNEL | GFP_DMA);
> 
> What about using GFP_KERNEL | __GFP_DMA instead?  This makes it
> more clear that it's just a qualifier.

Erm, no:

$ find -name \*.c | xargs grep '\<__GFP_DMA' | wc -l
      9
$ find -name \*.c | xargs grep '\<GFP_DMA'  | wc -l
    183

How about changing the few users of __GFP_DMA to GFP_DMA instead?

        Arnd <><
