Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262330AbVAZPxU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262330AbVAZPxU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 10:53:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262337AbVAZPxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 10:53:20 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:4743 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S262330AbVAZPxJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 10:53:09 -0500
Message-ID: <41F7BCCA.7060101@comcast.net>
Date: Wed, 26 Jan 2005 10:52:42 -0500
From: Parag Warudkar <kernel-stuff@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jens Axboe <axboe@suse.de>, torvalds@osdl.org, alexn@dsv.su.se,
       kas@fi.muni.cz, linux-kernel@vger.kernel.org,
       lennert.vanalboom@ugent.be
Subject: Re: Memory leak in 2.6.11-rc1?
References: <20050123095608.GD16648@suse.de>	<20050123023248.263daca9.akpm@osdl.org>	<1106528219.867.22.camel@boxen>	<20050124204659.GB19242@suse.de>	<20050124125649.35f3dafd.akpm@osdl.org>	<Pine.LNX.4.58.0501241435010.4191@ppc970.osdl.org>	<20050126080152.GA2751@suse.de>	<20050126001113.30933eef.akpm@osdl.org>	<20050126084005.GB2751@suse.de>	<20050126004419.26aab4a5.akpm@osdl.org>	<20050126084743.GD2751@suse.de> <20050126005844.6880d195.akpm@osdl.org>
In-Reply-To: <20050126005844.6880d195.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am running 2.6.11-rc2+ fix for the pipe related leak by Linus. I am 
currently running a QT+KDE compile with distcc on two machines.  I am 
running these machines for around 11 hours now and  swap seems to be 
growing steadily on the -rc2 box - it went to ~260kb after 10hrs, after 
which I ran swapoff.  Now after couple hours it is at 40kb. The other 
machine is Knoppix 2.4.26 kernel with lesser memory and it hasn't run 
into swap at all.

On the -rc2 machine, however, I don't feel anything is sluggish yet. But 
I think if I leave it running long enough it might run out of memory.

I don't know if this is perfectly normal given the differences between 
2.4.x and 2.6.x VM. I will  keep it running and under load for a while 
and report any interesting stuff.

Here is /proc/meminfo on the rc2 box as of now -
root@localhost paragw]# cat /proc/meminfo
MemTotal:       775012 kB
MemFree:         55260 kB
Buffers:         72732 kB
Cached:         371956 kB
SwapCached:         40 kB
Active:         489508 kB
Inactive:       182360 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       775012 kB
LowFree:         55260 kB
SwapTotal:      787176 kB
SwapFree:       787136 kB
Dirty:            2936 kB
Writeback:           0 kB
Mapped:         259024 kB
Slab:            32288 kB
CommitLimit:   1174680 kB
Committed_AS:   450692 kB
PageTables:       3072 kB
VmallocTotal:   253876 kB
VmallocUsed:     25996 kB
VmallocChunk:   226736 kB
HugePages_Total:     0
HugePages_Free:      0
Hugepagesize:     4096 kB

Parag
Andrew Morton wrote:

>Jens Axboe <axboe@suse.de> wrote:
>  
>
>>This is my current situtation:
>>
>>...
>> axboe@wiggum:/home/axboe $ cat /proc/meminfo 
>> MemTotal:      1024992 kB
>> MemFree:          9768 kB
>> Buffers:         76664 kB
>> Cached:         328024 kB
>> SwapCached:          0 kB
>> Active:         534956 kB
>> Inactive:       224060 kB
>> HighTotal:           0 kB
>> HighFree:            0 kB
>> LowTotal:      1024992 kB
>> LowFree:          9768 kB
>> SwapTotal:           0 kB
>> SwapFree:            0 kB
>> Dirty:            1400 kB
>> Writeback:           0 kB
>> Mapped:         464232 kB
>> Slab:           225864 kB
>> CommitLimit:    512496 kB
>> Committed_AS:   773844 kB
>> PageTables:       8004 kB
>> VmallocTotal: 34359738367 kB
>> VmallocUsed:       644 kB
>> VmallocChunk: 34359737167 kB
>> HugePages_Total:     0
>> HugePages_Free:      0
>> Hugepagesize:     2048 kB
>>    
>>
>
>OK.  There's rather a lot of anonymous memory there - 700M on the LRU, 300M
>pageache, 400M anon, 200M of slab.  You need some swapspace ;)
>
>What are the symptoms?  Slow to load applications?  Lots of paging?  Poor
>I/O speeds?
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>  
>

