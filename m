Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316746AbSFUSma>; Fri, 21 Jun 2002 14:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316747AbSFUSm3>; Fri, 21 Jun 2002 14:42:29 -0400
Received: from fmr04.intel.com ([143.183.121.6]:36606 "EHLO
	caduceus.sc.intel.com") by vger.kernel.org with ESMTP
	id <S316746AbSFUSm2>; Fri, 21 Jun 2002 14:42:28 -0400
Message-ID: <3D13747A.3030804@unix-os.sc.intel.com>
Date: Fri, 21 Jun 2002 11:46:18 -0700
From: mgross <mgross@unix-os.sc.intel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@zip.com.au>
CC: "Griffiths, Richard A" <richard.a.griffiths@intel.com>,
       "'Jens Axboe'" <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net
Subject: Re: ext3 performance bottleneck as the number of spindles gets large
References: <01BDB7EEF8D4D3119D95009027AE99951B0E63EA@fmsmsx33.fm.intel.com> <3D12DCB4.872269F6@zip.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>"Griffiths, Richard A" wrote:
>
>>I should have mentioned the throughput we saw on 4 adapters 6 drives was
>>126KB/s.  The max theoretical bus bandwith is 640MB/s.
>>
>
>I hope that was 128MB/s?
>
Yes that was MB/s, the data was taken in KB a set of 3 zeros where missing.

>
>
>Please try the below patch (againt 2.4.19-pre10).  It halves the lock
>contention, and it does that by making the fs twice as efficient, so
>that's a bonus.
>
We'll give it a try.  I'm on travel right now so it may be a few days if 
Richard doesn't get to before I get back.

>
>
>I wouldn't be surprised if it made no difference.  I'm not seeing
>much difference between ext2 and ext3 here.
>
>If you have time, please test ext2 and/or reiserfs and/or ext3
>in writeback mode.
>
Soon after we finish beating the ext3 file system up I'll take a swing 
at some other file systems.

>
>And please tell us some more details regarding the performance bottleneck.
>I assume that you mean that the IO rate per disk slows as more
>disks are added to an adapter?  Or does the total throughput through
>the adapter fall as more disks are added?
>
No, the IO block write throughput for the system goes down as drives are 
added under this work load.  We measure the system throughput not the 
per drive throughput, but one could infer the per drive throughput by 
dividing.

Running bonnie++ on with 300MB files doing 8Kb sequential writes we get 
the following system wide throughput as a function of the number of 
drives attached and by number of addapters.  

One addapter                           
1 drive per addapter    127,702KB/Sec
2 drives per addapter  93,283 KB/Sec
6 drives per addapter   85,626 KB/Sec

2 addapters
1 drive per addapter    92,095 KB/Sec
2 drives per addapter  110,956 KB/Sec
6 drives per addapter   106,883 KB/Sec

4 addapters
1 drive per addapter    121,125 KB/Sec
2 drives per addapter   117,575 KB/Sec
6 drives per addapter   116,570 KB/Sec

Not too pritty.

--mgross

