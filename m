Return-Path: <linux-kernel-owner+w=401wt.eu-S1030255AbXALUmA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbXALUmA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 15:42:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030311AbXALUmA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 15:42:00 -0500
Received: from mail.tmr.com ([64.65.253.246]:42432 "EHLO gaimboi.tmr.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030250AbXALUl7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 15:41:59 -0500
Message-ID: <45A7F27B.3080402@tmr.com>
Date: Fri, 12 Jan 2007 15:41:31 -0500
From: Bill Davidsen <davidsen@tmr.com>
Organization: TMR Associates Inc, Schenectady NY
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061105 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Justin Piszcz <jpiszcz@lucidpixels.com>
CC: Al Boldi <a1426z@gawab.com>, linux-kernel@vger.kernel.org,
       linux-raid@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: Linux Software RAID 5 Performance Optimizations: 2.6.19.1: (211MB/s
 read & 195MB/s write)
References: <Pine.LNX.4.64.0701111832080.3673@p34.internal.lan> <Pine.LNX.4.64.0701120934260.21164@p34.internal.lan> <Pine.LNX.4.64.0701121236470.3840@p34.internal.lan> <200701122235.30288.a1426z@gawab.com> <Pine.LNX.4.64.0701121455550.6844@p34.internal.lan> <Pine.LNX.4.64.0701121459240.3650@p34.internal.lan>
In-Reply-To: <Pine.LNX.4.64.0701121459240.3650@p34.internal.lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Justin Piszcz wrote:
> # echo 3 > /proc/sys/vm/drop_caches
> # dd if=/dev/md3 of=/dev/null bs=1M count=10240
> 10240+0 records in
> 10240+0 records out
> 10737418240 bytes (11 GB) copied, 399.352 seconds, 26.9 MB/s
> # for i in sde sdg sdi sdk; do   echo 192 > 
> /sys/block/"$i"/queue/max_sectors_kb;   echo "Set 
> /sys/block/"$i"/queue/max_sectors_kb to 192kb"; done
> Set /sys/block/sde/queue/max_sectors_kb to 192kb
> Set /sys/block/sdg/queue/max_sectors_kb to 192kb
> Set /sys/block/sdi/queue/max_sectors_kb to 192kb
> Set /sys/block/sdk/queue/max_sectors_kb to 192kb
> # echo 3 > /proc/sys/vm/drop_caches
> # dd if=/dev/md3 of=/dev/null bs=1M count=10240 
> 10240+0 records in
> 10240+0 records out
> 10737418240 bytes (11 GB) copied, 398.069 seconds, 27.0 MB/s
>
> Awful performance with your numbers/drop_caches settings.. !
>
> What were your tests designed to show?
>   
To start, I expect then to show change in write, not read... and IIRC (I 
didn't look it up) drop_caches just flushes the caches so you start with 
known memory contents, none.
>
> Justin.
>
> On Fri, 12 Jan 2007, Justin Piszcz wrote:
>
>   
>> On Fri, 12 Jan 2007, Al Boldi wrote:
>>
>>     
>>> Justin Piszcz wrote:
>>>       
>>>> RAID 5 TWEAKED: 1:06.41 elapsed @ 60% CPU
>>>>
>>>> This should be 1:14 not 1:06(was with a similarly sized file but not the
>>>> same) the 1:14 is the same file as used with the other benchmarks.  and to
>>>> get that I used 256mb read-ahead and 16384 stripe size ++ 128
>>>> max_sectors_kb (same size as my sw raid5 chunk size)
>>>>         
>>> max_sectors_kb is probably your key. On my system I get twice the read 
>>> performance by just reducing max_sectors_kb from default 512 to 192.
>>>
>>> Can you do a fresh reboot to shell and then:
>>> $ cat /sys/block/hda/queue/*
>>> $ cat /proc/meminfo
>>> $ echo 3 > /proc/sys/vm/drop_caches
>>> $ dd if=/dev/hda of=/dev/null bs=1M count=10240
>>> $ echo 192 > /sys/block/hda/queue/max_sectors_kb
>>> $ echo 3 > /proc/sys/vm/drop_caches
>>> $ dd if=/dev/hda of=/dev/null bs=1M count=10240
>>>
>>>       

-- 
bill davidsen <davidsen@tmr.com>
  CTO TMR Associates, Inc
  Doing interesting things with small computers since 1979

