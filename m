Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291020AbSAaLZZ>; Thu, 31 Jan 2002 06:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291021AbSAaLZF>; Thu, 31 Jan 2002 06:25:05 -0500
Received: from [195.63.194.11] ([195.63.194.11]:49930 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S291020AbSAaLZD>; Thu, 31 Jan 2002 06:25:03 -0500
Message-ID: <3C59297C.20607@evision-ventures.com>
Date: Thu, 31 Jan 2002 12:24:44 +0100
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Christoph Hellwig <hch@ns.caldera.de>, linux-kernel@vger.kernel.org,
        torvalds@transmeta.com, axboe@suse.de
Subject: Re: A modest proposal -- We need a patch penguin
In-Reply-To: <E16VYXy-0003xa-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>>I still don't think maintainig this array is worth just for hfs
>>readahead, so the below patch disables it and gets rid of read_ahead.
>>
>>Jens, could you check the patch and include it in your next batch of
>>block-layer changes for Linus?
>>
>
>What would be significantly more useful would be to make it actually work.
>Lots of drivers benefit from control over readahead sizes - both the
>stunningly slow low end stuff and the high end raid cards that often want
>to get hit by very large I/O requests (eg 128K for the ami megaraid)
>
No you are wrong. This array is supposed to provide a readahead setting 
on the driver level, which is bogous, since
it's something that *should* not be exposed to the upper layers at all. 
Please note as well that
 we have already max_readahead in struut block_device as well. Please 
note that this array only has
a granularity of major block device numbers which is compleatly bogous 
for example for a disk and
cd-rom hanging on a IDE interface. And so on and so on... It's really 
better to let it go.


