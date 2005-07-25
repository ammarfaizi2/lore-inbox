Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261421AbVGYTul@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVGYTul (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 15:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261484AbVGYTui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 15:50:38 -0400
Received: from mail.gmx.de ([213.165.64.20]:32943 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261421AbVGYTtl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 15:49:41 -0400
X-Authenticated: #28678167
Message-ID: <42E542D5.3080905@gmx.net>
Date: Mon, 25 Jul 2005 21:51:49 +0200
From: Andreas Baer <lnx1@gmx.net>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050725)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: linux-kernel@vger.kernel.org, pmarques@grupopie.com
Subject: Re: Problem with Asus P4C800-DX and P4 -Northwood-
References: <42E4373D.1070607@gmx.net> <20050725051236.GS8907@alpha.home.local> <42E4E4B0.6050904@gmx.net> <20050725152425.GA24568@alpha.home.local>
In-Reply-To: <20050725152425.GA24568@alpha.home.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Willy Tarreau wrote:
> On Mon, Jul 25, 2005 at 03:10:08PM +0200, Andreas Baer wrote:
> (...)
> 
>>I have (S-ATA-150 Disk 80GB)
>>
>>         /dev/sda:  50.59 MB/sec
>>         /dev/sda1: 50.62 MB/sec    (Windows FAT32)
>>         /dev/sda6: 41.63 MB/sec    (Linux ReiserFS)
>>
>>On the Notebook I have at most an ATA-100 Disk with 80GB and it shows the 
>>same declension.
>>
>>Here I have
>>
>>         /dev/hda:  26.91 MB/sec
>>         /dev/hda1: 26.90 MB/sec    (Windows FAT32)
>>         /dev/hda7: 17.89 MB/sec    (Linux EXT3)
>>
>>Could you give me a reason how this is possible?
> 
> 
> a reason for what ? the fact that the notebook performs faster than the
> desktop while slower on I/O ?

No, a reason why the partition with Linux (ReiserFS or Ext3) is always slower
than the Windows partition?

> 
>>Vmstat for Notebook P4 3.0 GHz 512 MB RAM:
> 
> 
> Your Notebook's P4 has HT enabled (50% apparent idle remain permanently during
> operation). But you'll note that your load is 60% system + 40% user there, and
> that you do absolutely no I/O (I presume it's the second run and it's cached).
> 
> 
>>procs -----------memory---------- ---swap-- -----io---- --system-- 
>>----cpu----
>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
>> id wa
>> 1  0      0 179620  14812 228832    0    0    33    21  557   184  3  1 
>> 95  1
>> 2  0      0 178828  14812 228832    0    0     0     0 1295   819  6  2 
>> 92  0
>> 1  0      0 175948  14812 228832    0    0     0     0 1090   111 37 17 
>> 46  0
>> 1  0      0 175948  14812 228832    0    0     0     0 1064   101 23 28 
>> 50  0
>> 1  0      0 175948  14812 228832    0    0     0     0 1066   100 20 31 
>> 49  0
>> 1  0      0 175980  14820 228824    0    0     0    48 1066   119 20 30 
>> 50  0
>> 1  0      0 175980  14820 228824    0    0     0     0 1067    86 19 31 
>> 50  0
>> 1  0      0 175988  14820 228824    0    0     0     0 1064   115 20 30 
>> 50  0
> 
> 
> (...)

Yeah the HT is enabled but as I said that changes nothing on the result, if I
enable or diable it on the desktop machine.
Sorry about the I/O, I explained something wrong. Look below, I answered Paulo
Marques to explain everything.

>  
> 
>>Vmstat for Desktop P4 2.4 GHz 1024 MB RAM:
> 
> 
> This one's hyperthreaded too (apparent consumption never goes above 50%).
> However, while not doing any I/O either, you're always spending only 4% in
> user and 96% in system. This means that it might take 10x more time to
> complete the same operations, had it been user-cpu bound. And this is about
> what you observe.
> 
> There clearly is a problem on the system installed on this machine. You should
> use strace to see what this machine does all the time, it is absolutely not
> expected that the user/system ratios change so much between two nearly
> identical systems. So there are system calls which eat all CPU. You may want
> to try strace -Tttt on the running process during a few tens of seconds. I
> guess you'll immediately find the culprit amongst the syscalls, and it might
> give you a clue.

I hope you are talking about a hardware/kernel problem and not a software
problem, because I tried it also with LiveCD's and they showed the same results
on this machine.
I'm not a linux expert, that means I've never done anything like that before,
so it would be nice if you give me a hint what you see in this results. :)

strace output for desktop:
<--snip-->
[pid 15146] 1122317366.469624 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.469692 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.469760 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.469828 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.469896 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.469963 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.470031 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.470098 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.470168 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.470236 _llseek(3, 7471104, [7471104], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.470298 read(3,
"\1\200\1\0\0\0\0\0\1\0G\247\35a\7\204\f\rP@\317\313\27"..., 131072) = 131072
<0.000138>
[pid 15146] 1122317366.470528 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.470599 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.470667 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.470734 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.470802 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.470870 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.470939 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.471008 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.471079 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000016>
[pid 15146] 1122317366.471158 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.471227 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.471295 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.471363 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000020>
[pid 15146] 1122317366.471436 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.471505 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.471573 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.471641 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.471708 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.471776 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000015>
[pid 15146] 1122317366.471844 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000017>
[pid 15146] 1122317366.471915 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000016>
[pid 15146] 1122317366.471991 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000014>
[pid 15146] 1122317366.472058 _llseek(3, 7602176, [7602176], SEEK_SET) = 0
<0.000015>
<--snip-->

strace output for notebook:
<--snip-->
[pid  1431] 1122318636.262024 _llseek(3, 1757184, [1757184], SEEK_SET) = 0
<0.000017>
[pid  1431] 1122318636.262098 _llseek(3, 1757184, [1757184], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.262173 _llseek(3, 1757184, [1757184], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.262247 _llseek(3, 1757184, [1757184], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.262321 _llseek(3, 1757184, [1757184], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.262396 _llseek(3, 1757184, [1757184], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.262465 read(3,
"\0\0\0\0\0\0\0\0\0\0\0\0RZ\0\0\0\0\0\0\1\0G\247\252\333"..., 4096) = 4096
<0.000024>
[pid  1431] 1122318636.262578 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000017>
[pid  1431] 1122318636.262654 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000017>
[pid  1431] 1122318636.262732 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000017>
[pid  1431] 1122318636.262809 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.262881 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.262952 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.263023 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.263094 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.263165 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.263237 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.263310 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.263381 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.263452 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.263523 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.263594 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.263666 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000017>
[pid  1431] 1122318636.263740 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000024>
[pid  1431] 1122318636.263841 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.263913 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.263984 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000014>
[pid  1431] 1122318636.264055 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.264127 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.264199 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.264271 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.264342 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.264414 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.264487 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.264558 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.264630 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.264710 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.264788 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.264861 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.264934 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.265006 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.265077 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.265149 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000014>
[pid  1431] 1122318636.265220 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.265292 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.265363 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.265436 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.265509 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.265580 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.265652 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.265726 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000017>
[pid  1431] 1122318636.265818 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.265891 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.265963 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.266034 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.266106 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.266177 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.266250 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.266322 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.266394 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.266466 _llseek(3, 1761280, [1761280], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.266534 read(3,
"\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\0\210Z\0\0\0\0\0"..., 4096) = 4096
<0.000022>
[pid  1431] 1122318636.266641 _llseek(3, 1765376, [1765376], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.266715 _llseek(3, 1765376, [1765376], SEEK_SET) = 0
<0.000015>
[pid  1431] 1122318636.266800 _llseek(3, 1765376, [1765376], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.266875 _llseek(3, 1765376, [1765376], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.266949 _llseek(3, 1765376, [1765376], SEEK_SET) = 0
<0.000016>
[pid  1431] 1122318636.267023 _llseek(3, 1765376, [1765376], SEEK_SET) = 0
<0.000016>
<--snip-->

These are just snips of billions of lines...
The crazy things is, that the read operation takes only 0.000022 on the
notebook and 0.000138 on the desktop, also there are a LOT more _llseek
operations between each read operation (to much to list them) on the desktop
but one possible reason is that I didn't catch the same area of processing
lines... (it scrolls much too fast)

> 
>>procs -----------memory---------- ---swap-- -----io---- --system-- 
>>----cpu----
>> r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us sy 
>> id wa
>> 1  0      0 594688  39340 292228    0    0    52    29  581   484  5  2 
>> 92  2
>> 1  0      0 591208  39340 292228    0    0     0    68 1116   545 15 14 
>> 71  0
>> 1  0      0 591208  39340 292228    0    0     0     0 1090   112  3 48 
>> 50  0
>> 1  0      0 591208  39340 292228    0    0     0     0 1089   124  2 48 
>> 50  0
>> 1  0      0 591208  39340 292228    0    0     0     0 1089   114  3 48 
>> 50  0
>> 1  0      0 591208  39340 292228    0    0     0     0 1090   120  1 49 
>> 50  0
>> 1  0      0 591208  39340 292228    0    0     0    24 1094   138  2 49 
>> 50  0
>> 1  0      0 591256  39340 292228    0    0     0     0 1090   118  2 48 
>> 50  0
> 
> 
> (...)
> 
> Regards,
> Willy


> Paulo Marques wrote:
>> Andreas Baer wrote:
>> 
>>> [...]
>>> Vmstat for Notebook P4 3.0 GHz 512 MB RAM:
>>>
>>> procs -----------memory---------- ---swap-- -----io---- --system-- 
>>> ----cpu----
>>>  r  b   swpd   free   buff  cache   si   so    bi    bo   in    cs us 
>>> sy id wa
>>>  1  0      0 179620  14812 228832    0    0    33    21  557   184  3  
>>> 1 95  1
>>>  2  0      0 178828  14812 228832    0    0     0     0 1295   819  6  
>>> 2 92  0
>>>  1  0      0 175948  14812 228832    0    0     0     0 1090   111 37 17 
>> 
>> 
>> This vmstat output doesn't show any input / output happening. Are you 
>> sure this was taken *while* your test is running? If it is, then all 
>> files are already in pagecache. The fact that you have free memory at 
>> all times, and that the run on the notebook takes less than 20 seconds 
>> confirms this.

I haven't said that there is any data loaded from files DURING the operation
(sorry for this). Random access files are used, but not for this process. What
I do is building up a r-tree index structure to get faster access to the stored
data, but everything is currently done completely in memory.

>> The second takes a lot more time to execute. The 1Gb memory does make me 
>> suspicious, though.
>> 
>> There is a known problem with BIOS that don't set up the mtrr's 
>> correctly for the whole memory and leave a small amount of memory on the 
>> top with the wrong settings. Accessing this memory becomes painfully slow.
>> 
>> Can you send the output of /proc/mtrr and try to boot with something 
>> like "mem=768M" to see if that improves performance on the Desktop P4?

w/o "mem=768M":
---------------

$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0xc0000000 (3072MB), size= 256MB: write-combining, count=1
reg02: base=0xe0000000 (3584MB), size= 256MB: write-combining, count=1

$ cat /proc/meminfo | grep MemTotal
MemTotal:      1033620 kB

with "mem=768M":
----------------

$ cat /proc/mtrr
reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
reg01: base=0xc0000000 (3072MB), size= 256MB: write-combining, count=1
reg02: base=0xe0000000 (3584MB), size= 256MB: write-combining, count=1

$ cat /proc/meminfo | grep MemTotal
MemTotal:       775116 kB

The speed didn't get any better through this change.

Just for information, here my kernel options for memory size...
     High Memory Support (off)
     [*] 1Gb Low Memory Support


============================================================================

Another thing is that the ACPI does not seem to work properly on this board.

$ acpi -V
No support for device type: battery
No support for device type: thermal
No support for device type: ac_adapter

$ dmesg | grep ACPI
  BIOS-e820: 000000003ff30000 - 000000003ff40000 (ACPI data)
  BIOS-e820: 000000003ff40000 - 000000003fff0000 (ACPI NVS)
ACPI: RSDP (v002 ACPIAM                                ) @ 0x000f9e30
ACPI: XSDT (v001 A M I  OEMXSDT  0x10000412 MSFT 0x00000097) @ 0x3ff30100
ACPI: FADT (v003 A M I  OEMFACP  0x10000412 MSFT 0x00000097) @ 0x3ff30290
ACPI: MADT (v001 A M I  OEMAPIC  0x10000412 MSFT 0x00000097) @ 0x3ff30390
ACPI: OEMB (v001 A M I  OEMBIOS  0x10000412 MSFT 0x00000097) @ 0x3ff40040
ACPI: DSDT (v001  P4C81 P4C81106 0x00000106 INTL 0x02002026) @ 0x00000000
ACPI: Local APIC address 0xfee00000
ACPI: LAPIC (acpi_id[0x01] lapic_id[0x00] enabled)
ACPI: LAPIC (acpi_id[0x02] lapic_id[0x01] enabled)
ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
ACPI: IRQ0 used by override.
ACPI: IRQ2 used by override.
ACPI: IRQ9 used by override.
Using ACPI (MADT) for SMP configuration information
ACPI: Subsystem revision 20050309
ACPI: Interpreter enabled
ACPI: Using IOAPIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P4._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 *5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs *3 4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKE] (IRQs 3 *4 5 6 7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 *7 10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 7 *10 11 12 14 15)
PCI: Using ACPI for IRQ routing
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:02:05.0[A] -> GSI 22 (level, low) -> IRQ 22
ACPI: PCI Interrupt 0000:00:1f.1[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1f.2[A] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 23
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 19
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 18
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:01:00.0[A] -> GSI 16 (level, low) -> IRQ 16
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20

but I'm not the only one...

http://forums.gentoo.org/viewtopic-t-215898-highlight-p4c800.html

