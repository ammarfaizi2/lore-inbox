Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285548AbRLGVLx>; Fri, 7 Dec 2001 16:11:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285551AbRLGVLr>; Fri, 7 Dec 2001 16:11:47 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:42250 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S285548AbRLGVLb>; Fri, 7 Dec 2001 16:11:31 -0500
Message-ID: <3C11303B.5070404@namesys.com>
Date: Sat, 08 Dec 2001 00:10:19 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Ragnar =?ISO-8859-1?Q?Kj=F8rstad?= <reiserfs@ragnark.vestdata.no>,
        linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <E16CP0X-0000uE-00@starship.berlin> <20011207190301.C6640@vestdata.no> <E16CPaA-0000uj-00@starship.berlin>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>On December 7, 2001 07:03 pm, Ragnar Kjørstad wrote:
>
>>>With ReiserFS we see slowdown due to random access even with small 
>>>directories.  I don't think this is a cache effect.
>>>
>>I can't see why the benefit from read-ahead on the file-data should be
>>affected by the directory-size?
>>
>>I forgot to mention another important effect of hash-ordering:
>>If you mostly add new files to the directory it is far less work if you
>>almost always can add the new entry at the end rather than insert it in
>>the middle. Well, it depends on your implementation of course, but this
>>effect is quite noticable on reiserfs. When untaring a big directory of
>>maildir the performance difference between the tea hash and a special
>>maildir hash was approxemately 20%. The choice of hash should not affect
>>the performance on writing the data itself, so it has to be related to
>>the cost of the insert operation.
>>
>
>Yes, I think you're on the right track.  HTree on the other hand is optimized 
>for inserting in arbitrary places, it takes no advantage at all of sequential 
>insertion.  (And doesn't suffer from this, because it all happens in cache 
>anyway - a million-file indexed directory is around 30 meg.)
>
>--
>Daniel
>
>
And how large is the dcache and all the inodes?  I believe large 
directory plus small file performance is heavily affected by the 
enormous size of struct inode and all the other per file data.  


Hans


