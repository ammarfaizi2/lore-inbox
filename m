Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265700AbUBPRME (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 12:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUBPRME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 12:12:04 -0500
Received: from kinesis.swishmail.com ([209.10.110.86]:1798 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S265900AbUBPRKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 12:10:51 -0500
Message-ID: <4030FB66.6060803@techsource.com>
Date: Mon, 16 Feb 2004 12:18:30 -0500
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Daniel Blueman <daniel.blueman@gmx.net>
CC: aradford@3WARE.com, linux-kernel@vger.kernel.org
Subject: Re: File system performance, hardware performance, ext3, 3ware RA
 ID1, etc.
References: <402D6354.3010801@techsource.com> <30156.1076775952@www12.gmx.net>
In-Reply-To: <30156.1076775952@www12.gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Daniel Blueman wrote:
> Tim,
> 
> Do you get the same numbers (but slightly higher, as this is will measure
> from a smaller portion of outer zones) with:
> 
> # hdparm -t /dev/sda
> 
> ?

I ran this test.  This is a read test.  What I did below was a write test.

Additionally, I ran this test:
     time dd if=/dev/sda of=/dev/null bs=1024k count=1024

 From that, I got 47 megs/sec.  From 'hdparm -t /dev/sda', I got a 
slightly lower number.

So, for reads, I'm getting good performance.  47 megs/sec at the 
outer-most tracks is a bit lower than the 50+ that reviewers report, but 
it's not bad.

However, I don't get anywhere near the 40+ megs/sec the reviewers say 
the drive gets for writes.  That model as a single drive in my wife's 
computer gets about 39 megs/sec, which is great.  But behind the 3ware, 
the drive gets only 13 megs/sec.  (iozone reports about 15 megs/sec, but 
that's influenced by caching in RAM, and iozone is writing to a file on 
tracks further out, I think.)

> 
> 
>>Adam Radford wrote:
>>
>>>Perhaps you are issuing non purely sequential IO.  The card firmware
>>
>>does
>>
>>>some 
>>>reodering, but at some point it will cause performance degradation.  Can
>>
>>you
>>
>>>try 
>>>kernel 2.6 w/xfs? 
>>
>>Not any time soon, but as I mentioned earlier, I measured 13.9 megs/sec 
>>when I ran this command:
>>
>>     time dd if=/dev/zero of=/dev/sda2 bs=1024k count=1024
>>
>>No file system was involved; I was simply writing zeros to the block 
>>device (swap partition with swap off).  It took 73.522 seconds to do the 
>>above operation.  Also, I was running in single-user mode while doing 
>>the test.
>>
>>
>>>Also, in my experience, the 'raw io' interface doesn't issue any
>>>asynchronous IO.  The
>>>card _definately_ needs asynchronous IO posted to it or you will not get
>>>good results
>>>because you won't get all the drives busy.
>>
>>With RAID1, both drives will be written with the same data.  There is no 
>>need to be asynchronous, since it's all completely linear and sequential 
>>with large data blocks.
> 
> 

