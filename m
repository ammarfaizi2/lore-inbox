Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319235AbSIKRLh>; Wed, 11 Sep 2002 13:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319237AbSIKRLh>; Wed, 11 Sep 2002 13:11:37 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:56846 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S319235AbSIKRLd>; Wed, 11 Sep 2002 13:11:33 -0400
Message-ID: <3D7F7A60.6040504@namesys.com>
Date: Wed, 11 Sep 2002 21:16:16 +0400
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Davide Libenzi <davidel@xmailserver.org>
CC: Xuan Baldauf <xuan--lkml@baldauf.org>, linux-kernel@vger.kernel.org,
       Reiserfs List <reiserfs-list@namesys.com>
Subject: Re: Heuristic readahead for filesystems
References: <Pine.LNX.4.44.0209110929390.1576-100000@blue1.dev.mcafeelabs.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Davide Libenzi wrote:

>On Wed, 11 Sep 2002, Xuan Baldauf wrote:
>
>  
>
>>Hello,
>>
>>I wonder wether Linux implements a kind of heuristic
>>readahead for filesystems:
>>
>>If an application reads a directory with getdents() and if
>>in the past, it stat()ed a significant part of the directory
>>entries, it is likely that it will stat() every entry of
>>every directory it reads with getdents() in the future. Thus
>>readahead for the stat data could improve the perfomance,
>>especially if the stat data is located closely to each other
>>on disk.
>>
Nikita should comment on this.

>>
>>If an application did a stat()..open()..read() sequence on a
>>file, it is likely that, after the next stat(), it will open
>>and read the mentioned file. Thus, one could readahead the
>>start of a file on stat() of that file.
>>
>>Combined: If an application walks a directory tree and
>>visits each file, it is likely that it will continue up to
>>the end of that tree.
>>    
>>
>
>M$ Win XP does exactly something like this and keep applications
>( windows\prefetch ) and boot profiles that it uses to prefetch disk data
>and avoid long page fault latencies. It does kind-of-work but care should
>be taken adopting a similar technique on Linux ( patents ).
>
>
>
>- Davide
>
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
>  
>
There was a Usenix paper on profiling based prefetching, does it predate 
the MS patents?

Rik, the more reads you put into the elevator, the more efficiently it 
can sort the reads, so even if latency reduction is not important, 
prefetching can still help (in principle).

Hans


