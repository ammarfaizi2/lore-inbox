Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266572AbUBLUQs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 15:16:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266574AbUBLUQs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 15:16:48 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:57485 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266572AbUBLUQq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 15:16:46 -0500
Message-ID: <402BDF40.5040601@namesys.com>
Date: Thu, 12 Feb 2004 12:17:04 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jon Burgess <lkml@jburgess.uklinux.net>
CC: Rik van Riel <riel@redhat.com>,
       linux kernel <linux-kernel@vger.kernel.org>,
       reiserfs-dev <reiserfs-dev@namesys.com>
Subject: Re: ext2/3 performance regression in 2.6 vs 2.4 for small interleaved
 writes
References: <Pine.LNX.4.44.0402111528140.23220-100000@chimarrao.boston.redhat.com> <402B580E.3000404@jburgess.uklinux.net>
In-Reply-To: <402B580E.3000404@jburgess.uklinux.net>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Burgess wrote:

> Rik van Riel wrote:
>
>> Just for fun, could you also try measuring how long it takes
>> to read back the files in question ?
>>
>> Both individually and in parallel...
>>
> The original code did the read back as well, I stripped it out to make 
> the code smaller to post.
> It was the read back performance that I was most interested in. I 
> found that ext2/3 interleave all the blocks on the disk. With 2 stream 
> the read performance is 50%, 4 streams give 25% etc.
>
> I have one really bad case where I record a TV stream at 500kByte/s + 
> a radio one at 25kByte/s. These blocks are interleaved on the disk and 
> the read performance of the radio stream is reduced by the data ratio, 
> i.e. 1:20, so I get a miserable read performance of ~ 1MB/s.
>
> I found that ext2, ext3 and Reiserfs behave similarly.

Try Reiser4, it will probably cure it for you nicely.  I will be 
surprised if it does not, please let me know your results.  I would 
expect that tweaking the block preallocation code to preallocate more 
should cure it for ReiserFS V3 also....

> XFS and JFS appear to coalesce the data blocks during the write phase 
> and can read the data back at near maximum performance.
>
>    Jon
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

