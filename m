Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316884AbSGTFM0>; Sat, 20 Jul 2002 01:12:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317367AbSGTFM0>; Sat, 20 Jul 2002 01:12:26 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:37029 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S316884AbSGTFMZ>; Sat, 20 Jul 2002 01:12:25 -0400
Message-ID: <3D38EF31.9000007@namesys.com>
Date: Sat, 20 Jul 2002 09:03:45 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: Rik van Riel <riel@conectiva.com.br>,
       Andreas Dilger <adilger@clusterfs.com>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
       Guillaume Boissiere <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org,
       Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST]
References: <Pine.LNX.4.44.0207192153150.1120-100000@waste.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:

>  
>
>
>  
>
>>So, I am assuming a new system call must go in before feature freeze.
>> One can reasonably argue that because it only affects one experimental
>>filesystem named reiser4 (until other FS authors see how nice it is and
>>start to use it;-) ) and does not complicate VFS,  it is not core code,
>>and should not be subject to the freeze.  I'll make that argument if we
>>don't have it ready in time....;-)
>>    
>>
>
>It only doesn't complicate VFS because we haven't discussed generalizing
>it yet. The desire to do transactional processing is not unique to Reiser
>any more than journalling is. See recent thread about fsync and MTAs.
>
>
>If you hide all your nifty features under a carpet (aka ioctl) where no
>one but Viro notices them, then maybe you'll be able to push this stuff
>late September and get them in. But FS-specific syscalls are a non-starter
>- what happens to the second FS that decides it wants transactions or
>multi-file I/O but doesn't quite fit your model?
>
>  
>
The way the Linux community works is first you show that it works, then 
you ask others to follow you.  In 2.6 we will show that it works.  In 
2.7 we will ask others to consider adopting it.  In 5-15 years, some of 
them will.  Trust me that there is no queue of other FS authors seeking 
to take advantage of our code, and complaining that we are locking them 
out from our transactions API.  Shoot, some of them are still using 
linear search directories and not packing small files together into one 
block.;-)

So, we are not hiding it under a carpet in ioctl, we are doing something 
clean and powerful and general enough to be usable by any other storage 
layer that chooses to implement the required functions.

We need to compete with Microsoft's OFS.  We have a tight and busy 
schedule if we are to ship a filesystem offering superior semantics for 
semi-structured data queries with a clean and powerful code architecture 
behind it, and ship it before OFS ships.  Reiser4 gets the storage layer 
foundation in place, and reduces the amount of code required for the 
later stages several fold.  It also provides a framework for several 
serious approaches to security problems (like giving apps a transactions 
API), and has some features that are just plain nifty (e.g. inheritance).

All of this squabbling over filesystem (distro) competition within Linux 
is just a distraction from the important job of getting something ready 
for when OFS comes over that hill over yonder there.....  unless you 
want to hear from your friends in 2004+ about the superior namespace 
integration Longhorn offers in Windows compared to Linux, and how it 
makes everything simpler....

-- 
Hans



