Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268101AbUHQEqY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268101AbUHQEqY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 00:46:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268102AbUHQEqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 00:46:24 -0400
Received: from out011pub.verizon.net ([206.46.170.135]:39916 "EHLO
	out011.verizon.net") by vger.kernel.org with ESMTP id S268101AbUHQEoo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 00:44:44 -0400
From: Gene Heskett <gene.heskett@verizon.net>
Reply-To: gene.heskett@verizon.net
Organization: Organization: None, detectable by casual observers
To: linux-kernel@vger.kernel.org
Subject: Re: Possible dcache BUG
Date: Tue, 17 Aug 2004 00:44:37 -0400
User-Agent: KMail/1.6.82
Cc: viro@parcelfarce.linux.theplanet.co.uk,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
References: <Pine.LNX.4.44.0408020911300.10100-100000@franklin.wrl.org> <200408161852.50310.gene.heskett@verizon.net> <20040816230154.GM12308@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20040816230154.GM12308@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408170044.37750.gene.heskett@verizon.net>
X-Authentication-Info: Submitted using SMTP AUTH at out011.verizon.net from [151.205.55.227] at Mon, 16 Aug 2004 23:44:39 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 August 2004 19:01, viro@parcelfarce.linux.theplanet.co.uk wrote:
>On Mon, Aug 16, 2004 at 06:52:50PM -0400, Gene Heskett wrote:
>> Well, I am seing some dups, but they are so volatile that no two
>> runs will report the same allocations as dups, and its never more
>> than 2 using /proc/fs/ext3 | sort | uniq -c | sort -nr |grep -v '
>> 1 '
>>
>> Consecutive runs will show anywhere from 3 to 10 or 12 dups, but
>> never is an address repeated between runs.
>>
>> How is this to be interpreted?
>
>That's OK.  Keep in mind that you have a *lot* of these guys and
> your cat(1) makes a lot of read(2) calls.  So what you see is
>
><starting to read>
><see inode #n that is about to be evicted>
><read some more>
><inode #n gets evicted, quite possibly - due to memory pressure from
> cat(1) or sort(1)>
><read more>
><somebody wants the same inode again>
><read more>
><see the inode #n we'd just had read from disk again>
>
>So few duplicates are all right.

I hope so.  I've got a real hoodoozy here, being out of memory (well,
maybe 30 megs left) when my nightly run of rsync started, everything
came to a grinding halt.  I couldn't even get to the screen the 
tail -f on the log was running in, but after walking away for 10 minutes. 
I can once again.  However, things seem to be partially functional so 
I'm going to see if I can do some cut-n-paste from the log screen to 
here, but I probably can't send it as sendmail was one of the items the 
OOM killer killed.  According to top, I'm about 250 megs into the 
swap, very suddenly.  No swap was in use at 23:55 local.
-------
Aug 17 00:02:00 coyote kernel: kjournald starting.  Commit interval 5 seconds
Aug 17 00:02:00 coyote kernel: EXT3 FS on hdb3, internal journal
Aug 17 00:02:00 coyote kernel: EXT3-fs: mounted filesystem with ordered data mode.
Aug 17 00:11:55 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:11:55 coyote kernel: DMA per-cpu:
Aug 17 00:11:55 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:11:55 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:11:55 coyote kernel: Normal per-cpu:
Aug 17 00:11:55 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:11:55 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:11:55 coyote kernel: HighMem per-cpu:
Aug 17 00:11:55 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:11:55 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:11:55 coyote kernel:
Aug 17 00:11:55 coyote kernel: Free pages:        4308kB (532kB HighMem)
Aug 17 00:11:55 coyote kernel: Active:31159 inactive:1039 dirty:0 writeback:28 unstable:0 free:1077 slab:222946 mapped:30766 pagetables:944
Aug 17 00:11:55 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:11:56 coyote kernel: protections[]: 8 476 540
Aug 17 00:11:56 coyote kernel: Normal free:1872kB min:936kB low:1872kB high:2808kB active:0kB inactive:2420kB present:901120kB
Aug 17 00:11:56 coyote kernel: protections[]: 0 468 532
Aug 17 00:11:56 coyote kernel: HighMem free:532kB min:128kB low:256kB high:384kB active:124636kB inactive:1736kB present:131008kB
Aug 17 00:11:56 coyote kernel: protections[]: 0 0 64
Aug 17 00:12:00 coyote kernel: DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:12:00 coyote kernel: Normal: 12*4kB 2*8kB 1*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB0*4096kB = 1872kB
Aug 17 00:12:00 coyote kernel: HighMem: 51*4kB 11*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 532kB
Aug 17 00:12:01 coyote kernel: Swap cache: add 94539, delete 86334, find 14429/21141, race 0+0
Aug 17 00:12:01 coyote kernel: Out of Memory: Killed process 2239 (httpd).
Aug 17 00:12:01 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:12:01 coyote kernel: DMA per-cpu:
Aug 17 00:12:01 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:12:01 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:12:01 coyote kernel: Normal per-cpu:
Aug 17 00:12:01 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:12:01 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:12:01 coyote kernel: HighMem per-cpu:
Aug 17 00:12:01 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:12:01 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:12:01 coyote kernel:
Aug 17 00:12:01 coyote kernel: Free pages:        4280kB (504kB HighMem)
Aug 17 00:12:01 coyote kernel: Active:31668 inactive:498 dirty:0 writeback:0 unstable:0 free:1070 slab:222978 mapped:31113 pagetables:935
Aug 17 00:12:01 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:12:01 coyote kernel: protections[]: 8 476 540
Aug 17 00:12:02 coyote kernel: Normal free:1872kB min:936kB low:1872kB high:2808kB active:1192kB inactive:1104kB present:901120kB
Aug 17 00:12:02 coyote kernel: protections[]: 0 468 532
Aug 17 00:12:02 coyote kernel: HighMem free:504kB min:128kB low:256kB high:384kB active:125480kB inactive:888kB present:131008kB
Aug 17 00:12:02 coyote kernel: protections[]: 0 0 64
Aug 17 00:12:02 coyote kernel: DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:12:02 coyote kernel: Normal: 6*4kB 5*8kB 1*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1872kB
Aug 17 00:12:02 coyote kernel: HighMem: 10*4kB 28*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 504kB
Aug 17 00:12:02 coyote kernel: Swap cache: add 95383, delete 87073, find 14612/21472, race 0+0
Aug 17 00:12:02 coyote kernel: Out of Memory: Killed process 2240 (httpd).
Aug 17 00:12:05 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:12:05 coyote kernel: DMA per-cpu:
Aug 17 00:12:05 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:12:05 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:12:05 coyote kernel: Normal per-cpu:
Aug 17 00:12:05 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:12:05 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:12:05 coyote kernel: HighMem per-cpu:
Aug 17 00:12:05 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:12:05 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:12:05 coyote kernel:
Aug 17 00:12:05 coyote kernel: Free pages:        4224kB (448kB HighMem)
Aug 17 00:12:05 coyote kernel: Active:31803 inactive:378 dirty:0 writeback:0 unstable:0 free:1056 slab:222988 mapped:31394 pagetables:926
Aug 17 00:13:37 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:15:12 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:28 coyote kernel: Normal free:1872kB min:936kB low:1872kB high:2808kB active:1144kB inactive:1160kB present:901120kB
Aug 17 00:16:28 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:29 coyote kernel: HighMem free:448kB min:128kB low:256kB high:384kB active:126068kB inactive:352kB present:131008kB
Aug 17 00:16:29 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:30 coyote kernel: DMA: 0*4kB 0*8kB 1*16kB 1*32kB 1*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:30 coyote kernel: Normal: 0*4kB 4*8kB 3*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1872kB
Aug 17 00:16:30 coyote kernel: HighMem: 40*4kB 6*8kB 1*16kB 1*32kB 1*64kB 1*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 448kB
Aug 17 00:16:30 coyote kernel: Swap cache: add 96127, delete 87885, find 14691/21706, race 0+0
Aug 17 00:16:30 coyote kernel: Out of Memory: Killed process 2241 (httpd).
Aug 17 00:16:30 coyote kernel:  unstable:0 free:8799 slab:223005 mapped:19246 pagetables:850
Aug 17 00:16:31 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:31 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:31 coyote kernel: Normal free:1848kB min:936kB low:1872kB high:2808kB active:1140kB inactive:1252kB present:901120kB
Aug 17 00:16:31 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:31 coyote kernel: HighMem free:31444kB min:128kB low:256kB high:384kB active:80988kB inactive:14548kBpresent:131008kB
Aug 17 00:16:31 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:32 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:32 coyote kernel: Normal: 0*4kB 1*8kB 3*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1848kB
Aug 17 00:16:32 coyote kernel: HighMem: 2411*4kB 1633*8kB 356*16kB 55*32kB 6*64kB 5*128kB 1*256kB 0*512kB 0*1024kB0*2048kB 0*4096kB = 31444kB
Aug 17 00:16:32 coyote kernel: Swap cache: add 102685, delete 93636, find 17082/24609, race 0+0
Aug 17 00:16:32 coyote kernel: Out of Memory: Killed process 1803 (httpd).
Aug 17 00:16:32 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:32 coyote kernel: DMA per-cpu:
Aug 17 00:16:32 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:32 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:32 coyote kernel: Normal per-cpu:
Aug 17 00:16:32 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:32 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:32 coyote kernel: HighMem per-cpu:
Aug 17 00:16:33 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:33 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:33 coyote kernel:
Aug 17 00:16:33 coyote kernel: Free pages:       35392kB (31640kB HighMem)
Aug 17 00:16:33 coyote kernel: Active:20556 inactive:3885 dirty:0 writeback:0 unstable:0 free:8848 slab:222999 mapped:19205 pagetables:841
Aug 17 00:16:33 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:33 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:33 coyote kernel: Normal free:1848kB min:936kB low:1872kB high:2808kB active:1400kB inactive:992kB present:901120kB
Aug 17 00:16:33 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:33 coyote kernel: HighMem free:31640kB min:128kB low:256kB high:384kB active:80824kB inactive:14548kBpresent:131008kB
Aug 17 00:16:34 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:34 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:34 coyote kernel: Normal: 0*4kB 1*8kB 3*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1848kB
Aug 17 00:16:34 coyote kernel: HighMem: 2460*4kB 1633*8kB 356*16kB 55*32kB 6*64kB 5*128kB 1*256kB 0*512kB 0*1024kB0*2048kB 0*4096kB = 31640kB
Aug 17 00:16:34 coyote kernel: Swap cache: add 102685, delete 93636, find 17082/24609, race 0+0
Aug 17 00:16:34 coyote kernel: Out of Memory: Killed process 1804 (httpd).
Aug 17 00:16:34 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:34 coyote kernel: DMA per-cpu:
Aug 17 00:16:34 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:34 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:34 coyote kernel: Normal per-cpu:
Aug 17 00:16:34 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:34 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:34 coyote kernel: HighMem per-cpu:
Aug 17 00:16:34 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:34 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:34 coyote kernel:
Aug 17 00:16:34 coyote kernel: Free pages:       35588kB (31836kB HighMem)
Aug 17 00:16:34 coyote kernel: Active:20469 inactive:3931 dirty:0 writeback:0 unstable:0 free:8897 slab:222993 mapped:19164 pagetables:832
Aug 17 00:16:35 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:35 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:35 coyote kernel: Normal free:1848kB min:936kB low:1872kB high:2808kB active:1216kB inactive:1176kB present:901120kB
Aug 17 00:16:35 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:35 coyote kernel: HighMem free:31836kB min:128kB low:256kB high:384kB active:80660kB inactive:14548kBpresent:131008kB
Aug 17 00:16:35 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:35 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:35 coyote kernel: Normal: 0*4kB 1*8kB 3*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1848kB
Aug 17 00:16:35 coyote kernel: HighMem: 2509*4kB 1633*8kB 356*16kB 55*32kB 6*64kB 5*128kB 1*256kB 0*512kB 0*1024kB0*2048kB 0*4096kB = 31836kB
Aug 17 00:16:35 coyote kernel: Swap cache: add 102685, delete 93636, find 17082/24609, race 0+0
Aug 17 00:16:35 coyote kernel: Out of Memory: Killed process 1805 (httpd).
Aug 17 00:16:35 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:35 coyote kernel: DMA per-cpu:
Aug 17 00:16:35 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:35 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:35 coyote kernel: Normal per-cpu:
Aug 17 00:16:35 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:35 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:36 coyote kernel: HighMem per-cpu:
Aug 17 00:16:36 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:36 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:36 coyote kernel:
Aug 17 00:16:36 coyote kernel: Free pages:       35784kB (32032kB HighMem)
Aug 17 00:16:36 coyote kernel: Active:20404 inactive:3954 dirty:0 writeback:0 unstable:0 free:8946 slab:222987 mapped:19038 pagetables:823
Aug 17 00:16:36 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:36 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:36 coyote kernel: Normal free:1848kB min:936kB low:1872kB high:2808kB active:1124kB inactive:1268kB present:901120kB
Aug 17 00:16:36 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:36 coyote kernel: HighMem free:32032kB min:128kB low:256kB high:384kB active:80492kB inactive:14548kBpresent:131008kB
Aug 17 00:16:36 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:36 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:36 coyote kernel: Normal: 0*4kB 1*8kB 3*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1848kB
Aug 17 00:16:36 coyote kernel: HighMem: 2558*4kB 1633*8kB 356*16kB 55*32kB 6*64kB 5*128kB 1*256kB 0*512kB 0*1024kB0*2048kB 0*4096kB = 32032kB
Aug 17 00:16:36 coyote kernel: Swap cache: add 102685, delete 93636, find 17082/24609, race 0+0
Aug 17 00:16:36 coyote kernel: Out of Memory: Killed process 2153 (sendmail).
Aug 17 00:16:36 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:36 coyote kernel: DMA per-cpu:
Aug 17 00:16:36 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:36 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:36 coyote kernel: Normal per-cpu:
Aug 17 00:16:36 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:36 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:36 coyote kernel: HighMem per-cpu:
Aug 17 00:16:36 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:36 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:36 coyote kernel:
Aug 17 00:16:36 coyote kernel: Free pages:       35812kB (32060kB HighMem)
Aug 17 00:16:36 coyote kernel: Active:20381 inactive:3976 dirty:0 writeback:0 unstable:0 free:8953 slab:222986 mapped:19037 pagetables:818
Aug 17 00:16:36 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:36 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:36 coyote kernel: Normal free:1848kB min:936kB low:1872kB high:2808kB active:1036kB inactive:1356kB present:901120kB
Aug 17 00:16:36 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:36 coyote kernel: HighMem free:32060kB min:128kB low:256kB high:384kB active:80488kB inactive:14548kBpresent:131008kB
Aug 17 00:16:36 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:36 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:36 coyote kernel: Normal: 0*4kB 1*8kB 3*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1848kB
Aug 17 00:16:36 coyote kernel: HighMem: 2565*4kB 1633*8kB 356*16kB 55*32kB 6*64kB 5*128kB 1*256kB 0*512kB 0*1024kB0*2048kB 0*4096kB = 32060kB
Aug 17 00:16:36 coyote kernel: Swap cache: add 102685, delete 93636, find 17082/24609, race 0+0
Aug 17 00:16:36 coyote kernel: Out of Memory: Killed process 21567 (kdeinit).
Aug 17 00:16:36 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:36 coyote kernel: DMA per-cpu:
Aug 17 00:16:36 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:36 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:36 coyote kernel: Normal per-cpu:
Aug 17 00:16:36 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:36 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:36 coyote kernel: HighMem per-cpu:
Aug 17 00:16:36 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:37 coyote kernel:
Aug 17 00:16:37 coyote kernel: Free pages:       36120kB (32368kB HighMem)
Aug 17 00:16:37 coyote kernel: Active:20284 inactive:4018 dirty:0 writeback:0 unstable:0 free:9030 slab:222984 mapped:18935 pagetables:800
Aug 17 00:16:37 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:37 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:37 coyote kernel: Normal free:1848kB min:936kB low:1872kB high:2808kB active:952kB inactive:1444kB present:901120kB
Aug 17 00:16:37 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:37 coyote kernel: HighMem free:32368kB min:128kB low:256kB high:384kB active:80184kB inactive:14628kBpresent:131008kB
Aug 17 00:16:37 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:37 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:37 coyote kernel: Normal: 0*4kB 1*8kB 3*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1848kB
Aug 17 00:16:37 coyote kernel: HighMem: 2580*4kB 1642*8kB 365*16kB 56*32kB 6*64kB 5*128kB 1*256kB 0*512kB 0*1024kB0*2048kB 0*4096kB = 32368kB
Aug 17 00:16:37 coyote kernel: Swap cache: add 102702, delete 93647, find 17218/24748, race 0+0
Aug 17 00:16:37 coyote kernel: Out of Memory: Killed process 1809 (httpd).
Aug 17 00:16:37 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:37 coyote kernel: DMA per-cpu:
Aug 17 00:16:37 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:37 coyote kernel: Normal per-cpu:
Aug 17 00:16:37 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:37 coyote kernel: HighMem per-cpu:
Aug 17 00:16:37 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:37 coyote kernel:
Aug 17 00:16:37 coyote kernel: Free pages:       36120kB (32368kB HighMem)
Aug 17 00:16:37 coyote kernel: Active:20263 inactive:4039 dirty:0 writeback:0 unstable:0 free:9030 slab:222984 mapped:18935 pagetables:800
Aug 17 00:16:37 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:37 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:37 coyote kernel: Normal free:1848kB min:936kB low:1872kB high:2808kB active:868kB inactive:1528kB present:901120kB
Aug 17 00:16:37 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:37 coyote kernel: HighMem free:32368kB min:128kB low:256kB high:384kB active:80184kB inactive:14628kBpresent:131008kB
Aug 17 00:16:37 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:37 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:37 coyote kernel: Normal: 0*4kB 1*8kB 3*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1848kB
Aug 17 00:16:37 coyote kernel: HighMem: 2580*4kB 1642*8kB 365*16kB 56*32kB 6*64kB 5*128kB 1*256kB 0*512kB 0*1024kB0*2048kB 0*4096kB = 32368kB
Aug 17 00:16:37 coyote kernel: Swap cache: add 102702, delete 93647, find 17218/24748, race 0+0
Aug 17 00:16:37 coyote kernel: Out of Memory: Killed process 1968 (arpwatch).
Aug 17 00:16:37 coyote kernel: device eth0 left promiscuous mode
Aug 17 00:16:37 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:37 coyote kernel: DMA per-cpu:
Aug 17 00:16:37 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:37 coyote kernel: Normal per-cpu:
Aug 17 00:16:37 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:37 coyote kernel: HighMem per-cpu:
Aug 17 00:16:37 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:37 coyote kernel:
Aug 17 00:16:37 coyote kernel: Free pages:       36232kB (32480kB HighMem)
Aug 17 00:16:37 coyote kernel: Active:20222 inactive:4053 dirty:0 writeback:0 unstable:0 free:9058 slab:222983 mapped:18921 pagetables:795
Aug 17 00:16:37 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:37 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:37 coyote kernel: Normal free:1848kB min:936kB low:1872kB high:2808kB active:792kB inactive:1604kB present:901120kB
Aug 17 00:16:37 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:37 coyote kernel: HighMem free:32480kB min:128kB low:256kB high:384kB active:80096kB inactive:14608kBpresent:131008kB
Aug 17 00:16:37 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:37 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:37 coyote kernel: Normal: 0*4kB 1*8kB 3*16kB 0*32kB 0*64kB 0*128kB 1*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1848kB
Aug 17 00:16:37 coyote kernel: HighMem: 2598*4kB 1645*8kB 366*16kB 56*32kB 6*64kB 5*128kB 1*256kB 0*512kB 0*1024kB0*2048kB 0*4096kB = 32480kB
Aug 17 00:16:37 coyote kernel: Swap cache: add 102702, delete 93673, find 17218/24748, race 0+0
Aug 17 00:16:37 coyote kernel: Out of Memory: Killed process 10755 (kdeinit).
Aug 17 00:16:37 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:37 coyote kernel: DMA per-cpu:
Aug 17 00:16:37 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:37 coyote kernel: Normal per-cpu:
Aug 17 00:16:37 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:37 coyote kernel: HighMem per-cpu:
Aug 17 00:16:37 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:37 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:37 coyote kernel:
Aug 17 00:16:37 coyote kernel: Free pages:       25392kB (21616kB HighMem)
Aug 17 00:16:37 coyote kernel: Active:21664 inactive:5363 dirty:0 writeback:0 unstable:0 free:6348 slab:223017 mapped:19400 pagetables:798
Aug 17 00:16:37 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:37 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:37 coyote kernel: Normal free:1872kB min:936kB low:1872kB high:2808kB active:1132kB inactive:1268kB present:901120kB
Aug 17 00:16:37 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:37 coyote kernel: HighMem free:21616kB min:128kB low:256kB high:384kB active:85524kB inactive:20184kBpresent:131008kB
Aug 17 00:16:37 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:37 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:37 coyote kernel: Normal: 16*4kB 6*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB0*4096kB = 1872kB
Aug 17 00:16:38 coyote kernel: HighMem: 0*4kB 1536*8kB 373*16kB 57*32kB 8*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 21616kB
Aug 17 00:16:39 coyote kernel: Swap cache: add 103622, delete 93673, find 17556/25253, race 0+0
Aug 17 00:16:39 coyote kernel: Out of Memory: Killed process 1812 (httpd).
Aug 17 00:16:40 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:40 coyote kernel: DMA per-cpu:
Aug 17 00:16:40 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:40 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:40 coyote kernel: Normal per-cpu:
Aug 17 00:16:40 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:40 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:40 coyote kernel: HighMem per-cpu:
Aug 17 00:16:40 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:40 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:40 coyote kernel:
Aug 17 00:16:40 coyote kernel: Free pages:       26540kB (22764kB HighMem)
Aug 17 00:16:40 coyote kernel: Active:21447 inactive:5282 dirty:0 writeback:0 unstable:0 free:6635 slab:223012 mapped:19102 pagetables:789
Aug 17 00:16:40 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:40 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:40 coyote kernel: Normal free:1872kB min:936kB low:1872kB high:2808kB active:1456kB inactive:944kB present:901120kB
Aug 17 00:16:40 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:40 coyote kernel: HighMem free:22764kB min:128kB low:256kB high:384kB active:84332kB inactive:20184kBpresent:131008kB
Aug 17 00:16:40 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:40 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:40 coyote kernel: Normal: 16*4kB 6*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB0*4096kB = 1872kB
Aug 17 00:16:40 coyote kernel: HighMem: 221*4kB 1569*8kB 373*16kB 57*32kB 8*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 22764kB
Aug 17 00:16:40 coyote kernel: Swap cache: add 103622, delete 93673, find 17556/25253, race 0+0
Aug 17 00:16:40 coyote kernel: Out of Memory: Killed process 1813 (httpd).
Aug 17 00:16:40 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:40 coyote kernel: DMA per-cpu:
Aug 17 00:16:40 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:40 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:40 coyote kernel: Normal per-cpu:
Aug 17 00:16:40 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:40 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:40 coyote kernel: HighMem per-cpu:
Aug 17 00:16:40 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:40 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:40 coyote kernel:
Aug 17 00:16:40 coyote kernel: Free pages:       25784kB (22008kB HighMem)
Aug 17 00:16:40 coyote kernel: Active:21640 inactive:5304 dirty:0 writeback:0 unstable:0 free:6446 slab:223008 mapped:19233 pagetables:780
Aug 17 00:16:40 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:40 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:40 coyote kernel: Normal free:1872kB min:936kB low:1872kB high:2808kB active:1368kB inactive:1032kB present:901120kB
Aug 17 00:16:40 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:40 coyote kernel: HighMem free:22008kB min:128kB low:256kB high:384kB active:85192kB inactive:20184kBpresent:131008kB
Aug 17 00:16:40 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:40 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:40 coyote kernel: Normal: 16*4kB 6*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB0*4096kB = 1872kB
Aug 17 00:16:40 coyote kernel: HighMem: 28*4kB 1571*8kB 373*16kB 57*32kB 8*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 22008kB
Aug 17 00:16:40 coyote kernel: Swap cache: add 103622, delete 93673, find 17556/25253, race 0+0
Aug 17 00:16:40 coyote kernel: Out of Memory: Killed process 1810 (httpd).
Aug 17 00:16:40 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:40 coyote kernel: DMA per-cpu:
Aug 17 00:16:40 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:40 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:40 coyote kernel: Normal per-cpu:
Aug 17 00:16:40 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:40 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:40 coyote kernel: HighMem per-cpu:
Aug 17 00:16:40 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:40 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:40 coyote kernel:
Aug 17 00:16:40 coyote kernel: Free pages:       25952kB (22176kB HighMem)
Aug 17 00:16:40 coyote kernel: Active:21621 inactive:5296 dirty:0 writeback:0 unstable:0 free:6488 slab:223006 mapped:19162 pagetables:771
Aug 17 00:16:40 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:40 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:40 coyote kernel: Normal free:1872kB min:936kB low:1872kB high:2808kB active:1400kB inactive:1000kB present:901120kB
Aug 17 00:16:41 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:41 coyote kernel: HighMem free:22176kB min:128kB low:256kB high:384kB active:85084kB inactive:20184kBpresent:131008kB
Aug 17 00:16:41 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:41 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:41 coyote kernel: Normal: 16*4kB 6*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB0*4096kB = 1872kB
Aug 17 00:16:41 coyote kernel: HighMem: 70*4kB 1571*8kB 373*16kB 57*32kB 8*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 22176kB
Aug 17 00:16:41 coyote kernel: Swap cache: add 103622, delete 93673, find 17740/25437, race 0+0
Aug 17 00:16:41 coyote kernel: Out of Memory: Killed process 3119 (kdeinit).
Aug 17 00:16:41 coyote kernel: oom-killer: gfp_mask=0xd0
Aug 17 00:16:41 coyote kernel: DMA per-cpu:
Aug 17 00:16:41 coyote kernel: cpu 0 hot: low 2, high 6, batch 1
Aug 17 00:16:41 coyote kernel: cpu 0 cold: low 0, high 2, batch 1
Aug 17 00:16:41 coyote kernel: Normal per-cpu:
Aug 17 00:16:41 coyote kernel: cpu 0 hot: low 32, high 96, batch 16
Aug 17 00:16:41 coyote kernel: cpu 0 cold: low 0, high 32, batch 16
Aug 17 00:16:41 coyote kernel: HighMem per-cpu:
Aug 17 00:16:41 coyote kernel: cpu 0 hot: low 14, high 42, batch 7
Aug 17 00:16:41 coyote kernel: cpu 0 cold: low 0, high 14, batch 7
Aug 17 00:16:41 coyote kernel:
Aug 17 00:16:41 coyote kernel: Free pages:       26820kB (23044kB HighMem)
Aug 17 00:16:41 coyote kernel: Active:21387 inactive:5311 dirty:0 writeback:0 unstable:0 free:6705 slab:223005 mapped:18948 pagetables:754
Aug 17 00:16:41 coyote kernel: DMA free:1904kB min:16kB low:32kB high:48kB active:0kB inactive:0kB present:16384kB
Aug 17 00:16:41 coyote kernel: protections[]: 8 476 540
Aug 17 00:16:41 coyote kernel: Normal free:1872kB min:936kB low:1872kB high:2808kB active:1340kB inactive:1060kB present:901120kB
Aug 17 00:16:41 coyote kernel: protections[]: 0 468 532
Aug 17 00:16:41 coyote kernel: HighMem free:23044kB min:128kB low:256kB high:384kB active:84208kB inactive:20184kBpresent:131008kB
Aug 17 00:16:41 coyote kernel: protections[]: 0 0 64
Aug 17 00:16:41 coyote kernel: DMA: 10*4kB 5*8kB 4*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB 0*4096kB = 1904kB
Aug 17 00:16:41 coyote kernel: Normal: 16*4kB 6*8kB 0*16kB 1*32kB 1*64kB 1*128kB 0*256kB 1*512kB 1*1024kB 0*2048kB0*4096kB = 1872kB
Aug 17 00:16:41 coyote kernel: HighMem: 273*4kB 1576*8kB 374*16kB 57*32kB 8*64kB 6*128kB 1*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 23044kB
Aug 17 00:16:41 coyote kernel: Swap cache: add 103622, delete 93761, find 17740/25437, race 0+0
Aug 17 00:16:41 coyote kernel: Out of Memory: Killed process 3133 (kdeinit).

[root@coyote xsane-0.90]# cat /proc/meminfo
MemTotal:      1035956 kB
MemFree:          5524 kB
Buffers:         15816 kB
Cached:          80116 kB
SwapCached:      57788 kB
Active:         134848 kB
Inactive:        51592 kB
HighTotal:      131008 kB
HighFree:          532 kB
LowTotal:       904948 kB
LowFree:          4992 kB
SwapTotal:     3857104 kB
SwapFree:      3752500 kB
Dirty:             164 kB
Writeback:           0 kB
Mapped:         115268 kB
Slab:           833184 kB
Committed_AS:   295784 kB
PageTables:       3424 kB
VmallocTotal:   114680 kB
VmallocUsed:     19876 kB
VmallocChunk:    94640 kB

[root@coyote xsane-0.90]# cat /proc/slabinfo
slabinfo - version: 2.0
# name            <active_objs> <num_objs> <objsize> <objperslab> <pagesperslab> : tunables <batchcount> <limit> <sharedfactor> : slabdata <active_slabs> <num_slabs> <sharedavail>
unix_sock            200    200    384   10    1 : tunables   54   27    0 : slabdata     20     20      0
tcp_tw_bucket          4     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_bind_bucket       27    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
tcp_open_request       0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
inet_peer_cache        0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
ip_fib_hash           10    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
ip_dst_cache          16     30    256   15    1 : tunables  120   60    0 : slabdata      2      2      0
arp_cache              4     31    128   31    1 : tunables  120   60    0 : slabdata      1      1      0
raw4_sock              0      0    480    8    1 : tunables   54   27    0 : slabdata      0      0      0
udp_sock               2      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
tcp_sock              32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
flow_cache             0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
mqueue_inode_cache      1      8    480    8    1 : tunables   54   27    0 : slabdata      1      1      0
udf_inode_cache        0      0    352   11    1 : tunables   54   27    0 : slabdata      0      0      0
smb_request            0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
smb_inode_cache        1     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
isofs_inode_cache      0      0    320   12    1 : tunables   54   27    0 : slabdata      0      0      0
fat_inode_cache        4     22    352   11    1 : tunables   54   27    0 : slabdata      2      2      0
ext2_inode_cache       0      0    416    9    1 : tunables   54   27    0 : slabdata      0      0      0
journal_handle        25    135     28  135    1 : tunables  120   60    0 : slabdata      1      1      0
journal_head         607   2835     48   81    1 : tunables  120   60    0 : slabdata     35     35      0
revoke_table          14    290     12  290    1 : tunables  120   60    0 : slabdata      1      1      0
revoke_record          0      0     16  226    1 : tunables  120   60    0 : slabdata      0      0      0
ext3_inode_cache  1488612 1488618    448    9    1 : tunables   54   27    0 : slabdata 165402 165402      0
eventpoll_pwq          0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
eventpoll_epi          0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
kioctx                 0      0    160   25    1 : tunables  120   60    0 : slabdata      0      0      0
kiocb                  0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
dnotify_cache        222    370     20  185    1 : tunables  120   60    0 : slabdata      2      2      0
file_lock_cache       19     43     92   43    1 : tunables  120   60    0 : slabdata      1      1      0
fasync_cache           2    226     16  226    1 : tunables  120   60    0 : slabdata      1      1      0
shmem_inode_cache      5     10    384   10    1 : tunables   54   27    0 : slabdata      1      1      0
posix_timers_cache      0      0     96   41    1 : tunables  120   60    0 : slabdata      0      0      0
uid_cache              5    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
sgpool-128            32     32   2048    2    1 : tunables   24   12    0 : slabdata     16     16      0
sgpool-64             32     32   1024    4    1 : tunables   54   27    0 : slabdata      8      8      0
sgpool-32             32     32    512    8    1 : tunables   54   27    0 : slabdata      4      4      0
sgpool-16             32     45    256   15    1 : tunables  120   60    0 : slabdata      3      3      0
sgpool-8              32     62    128   31    1 : tunables  120   60    0 : slabdata      2      2      0
cfq_pool              64    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
crq_pool               0      0     36  107    1 : tunables  120   60    0 : slabdata      0      0      0
deadline_drq           0      0     48   81    1 : tunables  120   60    0 : slabdata      0      0      0
as_arq               101    130     60   65    1 : tunables  120   60    0 : slabdata      2      2      0
blkdev_ioc            80    185     20  185    1 : tunables  120   60    0 : slabdata      1      1      0
blkdev_queue          12     18    448    9    1 : tunables   54   27    0 : slabdata      2      2      0
blkdev_requests       80    104    152   26    1 : tunables  120   60    0 : slabdata      4      4      0
biovec-(256)         256    256   3072    2    2 : tunables   24   12    0 : slabdata    128    128      0
biovec-128           256    260   1536    5    2 : tunables   24   12    0 : slabdata     52     52      0
biovec-64            256    260    768    5    1 : tunables   54   27    0 : slabdata     52     52      0
biovec-16            256    260    192   20    1 : tunables  120   60    0 : slabdata     13     13      0
biovec-4             256    305     64   61    1 : tunables  120   60    0 : slabdata      5      5      0
biovec-1             368    452     16  226    1 : tunables  120   60    0 : slabdata      2      2      0
bio                  366    366     64   61    1 : tunables  120   60    0 : slabdata      6      6      0
sock_inode_cache     234    242    352   11    1 : tunables   54   27    0 : slabdata     22     22      0
skbuff_head_cache    251    475    160   25    1 : tunables  120   60    0 : slabdata     19     19      0
sock                   2     12    320   12    1 : tunables   54   27    0 : slabdata      1      1      0
proc_inode_cache     610    612    320   12    1 : tunables   54   27    0 : slabdata     51     51      0
sigqueue              66     81    148   27    1 : tunables  120   60    0 : slabdata      3      3      0
radix_tree_node     2565   3276    276   14    1 : tunables   54   27    0 : slabdata    234    234      0
bdev_cache            12     18    416    9    1 : tunables   54   27    0 : slabdata      2      2      0
mnt_cache             25     41     96   41    1 : tunables  120   60    0 : slabdata      1      1      0
inode_cache         2354   2380    288   14    1 : tunables   54   27    0 : slabdata    170    170      0
dentry_cache      1115280 1116752    140   28    1 : tunables  120   60    0 : slabdata  39884  39884      0
filp                2060   2300    160   25    1 : tunables  120   60    0 : slabdata     92     92      0
names_cache           17     17   4096    1    1 : tunables   24   12    0 : slabdata     17     17      0
idr_layer_cache       81     87    136   29    1 : tunables  120   60    0 : slabdata      3      3      0
buffer_head         4151   8424     48   81    1 : tunables  120   60    0 : slabdata    104    104      0
mm_struct             98     98    512    7    1 : tunables   54   27    0 : slabdata     14     14      0
vm_area_struct      8554   8554     84   47    1 : tunables  120   60    0 : slabdata    182    182      0
fs_cache              94    119     32  119    1 : tunables  120   60    0 : slabdata      1      1      0
files_cache           93     99    416    9    1 : tunables   54   27    0 : slabdata     11     11      0
signal_cache         116    123     96   41    1 : tunables  120   60    0 : slabdata      3      3      0
sighand_cache        111    111   1312    3    1 : tunables   24   12    0 : slabdata     37     37      0
task_struct          121    130   1424    5    2 : tunables   24   12    0 : slabdata     26     26      0
anon_vma            1770   2035      8  407    1 : tunables  120   60    0 : slabdata      5      5      0
pgd                   94     94   4096    1    1 : tunables   24   12    0 : slabdata     94     94      0
size-131072(DMA)       0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-131072            0      0 131072    1   32 : tunables    8    4    0 : slabdata      0      0      0
size-65536(DMA)        0      0  65536    1   16 : tunables    8    4    0 : slabdata      0      0      0
size-65536             1      1  65536    1   16 : tunables    8    4    0 : slabdata      1      1      0
size-32768(DMA)        0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-32768             0      0  32768    1    8 : tunables    8    4    0 : slabdata      0      0      0
size-16384(DMA)        0      0  16384    1    4 : tunables    8    4    0 : slabdata      0      0      0
size-16384             5      9  16384    1    4 : tunables    8    4    0 : slabdata      5      9      0
size-8192(DMA)         0      0   8192    1    2 : tunables    8    4    0 : slabdata      0      0      0
size-8192             11     11   8192    1    2 : tunables    8    4    0 : slabdata     11     11      0
size-4096(DMA)         0      0   4096    1    1 : tunables   24   12    0 : slabdata      0      0      0
size-4096            184    184   4096    1    1 : tunables   24   12    0 : slabdata    184    184      0
size-2048(DMA)         0      0   2048    2    1 : tunables   24   12    0 : slabdata      0      0      0
size-2048            174    194   2048    2    1 : tunables   24   12    0 : slabdata     97     97      0
size-1024(DMA)         0      0   1024    4    1 : tunables   54   27    0 : slabdata      0      0      0
size-1024            157    180   1024    4    1 : tunables   54   27    0 : slabdata     45     45      0
size-512(DMA)          0      0    512    8    1 : tunables   54   27    0 : slabdata      0      0      0
size-512             197    448    512    8    1 : tunables   54   27    0 : slabdata     56     56      0
size-256(DMA)          0      0    256   15    1 : tunables  120   60    0 : slabdata      0      0      0
size-256             213    420    256   15    1 : tunables  120   60    0 : slabdata     28     28      0
size-192(DMA)          0      0    192   20    1 : tunables  120   60    0 : slabdata      0      0      0
size-192             120    120    192   20    1 : tunables  120   60    0 : slabdata      6      6      0
size-128(DMA)          0      0    128   31    1 : tunables  120   60    0 : slabdata      0      0      0
size-128            1243   1302    128   31    1 : tunables  120   60    0 : slabdata     42     42      0
size-64(DMA)           0      0     64   61    1 : tunables  120   60    0 : slabdata      0      0      0
size-64            47735  48251     64   61    1 : tunables  120   60    0 : slabdata    791    791      0
size-32(DMA)           0      0     32  119    1 : tunables  120   60    0 : slabdata      0      0      0
size-32             1368   1428     32  119    1 : tunables  120   60    0 : slabdata     12     12      0
kmem_cache           124    124    128   31    1 : tunables  120   60    0 : slabdata      4      4      0

I cannot start any new shells, as before.  Is there any usable dna in this sample?                                                                                       

Reboot time I guess :(((

-- 
Cheers, Gene
"There are four boxes to be used in defense of liberty:
 soap, ballot, jury, and ammo. Please use in that order."
-Ed Howdershelt (Author)
99.24% setiathome rank, not too shabby for a WV hillbilly
Yahoo.com attorneys please note, additions to this message
by Gene Heskett are:
Copyright 2004 by Maurice Eugene Heskett, all rights reserved.
