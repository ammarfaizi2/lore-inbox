Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261939AbSI3Gwo>; Mon, 30 Sep 2002 02:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261940AbSI3Gwo>; Mon, 30 Sep 2002 02:52:44 -0400
Received: from [212.27.202.177] ([212.27.202.177]:42246 "EHLO
	chudak.century.cz") by vger.kernel.org with ESMTP
	id <S261939AbSI3Gwl>; Mon, 30 Sep 2002 02:52:41 -0400
Message-ID: <3D97F5F3.8060903@century.cz>
Date: Mon, 30 Sep 2002 08:57:55 +0200
From: =?ISO-8859-2?Q?Petr_Tit=ECra?= <P.Titera@century.cz>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.2a) Gecko/20020915
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.5.39 - sleeping function called from illegal context
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
    I have some more instances of above bug.

I get this during startup just aftrer xfs initializes, but it may not be 
related.

Sep 29 22:36:29 localhost modprobe: modprobe: Can't locate module 
char-major-10-134
Sep 29 22:36:29 localhost kernel: Sleeping function called from illegal 
context at slab.c:1374
Sep 29 22:36:29 localhost kernel: d6247f5c c0117022 c0240300 c0242162 
0000055e c150f300 c0131965 c0242162
Sep 29 22:36:29 localhost kernel:        0000055e c012be28 d76241c0 
d6490e40 d63b2b40 00000000 00000400 00000001
Sep 29 22:36:29 localhost kernel:        d63ce360 c010b7c3 00000080 
000001d0 00000000 d6246000 08080410 00000018
Sep 29 22:36:29 localhost kernel: Call Trace:
Sep 29 22:36:29 localhost kernel:  [<c0117022>]__might_sleep+0x52/0x60
Sep 29 22:36:29 localhost kernel:  [<c0131965>]kmalloc+0x55/0x140
Sep 29 22:36:29 localhost kernel:  [<c012be28>]do_munmap+0x108/0x120
Sep 29 22:36:29 localhost kernel:  [<c010b7c3>]sys_ioperm+0x83/0x120
Sep 29 22:36:29 localhost kernel:  [<c010719f>]syscall_call+0x7/0xb
Sep 29 22:36:29 localhost kernel:
Sep 29 22:36:29 localhost kernel: MTRR: setting reg 2


These two I get when I try to run KDE. It initializes and then hangs 
entire machine

Sep 29 22:33:04 localhost kernel: Sleeping function called from illegal 
context at /usr/src/linux/include/asm/semaphore.h:119
Sep 29 22:33:04 localhost kernel: d3b87c54 c0117022 c0240300 e0927020 
00000077 c157c800 e091f008 e0927020
Sep 29 22:33:04 localhost kernel:        00000077 00000001 d6c69800 
d3b86000 00000000 00001000 0807d3d8 e0920cd1
Sep 29 22:33:04 localhost kernel:        c157c800 d3b86000 00000000 
e09210bf c157c800 00004140 00000000 00000000
Sep 29 22:33:04 localhost kernel: Call Trace:
Sep 29 22:33:04 localhost kernel:  [<c0117022>]__might_sleep+0x52/0x60
Sep 29 22:33:04 localhost kernel:  
[<e0927020>].rodata.str1.32+0x200/0xa80 [snd-pcm]
Sep 29 22:33:04 localhost kernel:  
[<e091f008>]snd_pcm_prepare+0x28/0x200 [snd-pcm]
Sep 29 22:33:04 localhost kernel:  
[<e0927020>].rodata.str1.32+0x200/0xa80 [snd-pcm]
Sep 29 22:33:04 localhost kernel:  
[<e0920cd1>]snd_pcm_common_ioctl1+0x1b1/0x260 [snd-pcm]
Sep 29 22:33:04 localhost kernel:  
[<e09210bf>]snd_pcm_playback_ioctl1+0x33f/0x350 [snd-pcm]
Sep 29 22:33:04 localhost kernel:  
[<c013aeea>]do_page_cache_readahead+0x8a/0x160
Sep 29 22:33:04 localhost kernel:  [<c012d3fe>]find_get_page+0x1e/0x40
Sep 29 22:33:04 localhost kernel:  [<c012e071>]filemap_nopage+0xf1/0x240
Sep 29 22:33:04 localhost kernel:  [<c012aa4c>]do_no_page+0x20c/0x280
Sep 29 22:33:04 localhost kernel:  [<c012ab2d>]handle_mm_fault+0x6d/0x110
Sep 29 22:33:04 localhost kernel:  
[<e0921477>]snd_pcm_kernel_playback_ioctl+0x27/0x30 [snd-pcm]
Sep 29 22:33:04 localhost kernel:  
[<e0936b15>]snd_pcm_oss_prepare+0x15/0x40 [snd-pcm-oss]
Sep 29 22:33:05 localhost kernel:  
[<e0936b78>]snd_pcm_oss_make_ready+0x38/0x50 [snd-pcm-oss]
Sep 29 22:33:05 localhost kernel:  
[<e0936f3a>]snd_pcm_oss_write1+0x3a/0x160 [snd-pcm-oss]
Sep 29 22:33:05 localhost kernel:  
[<e0938dc5>]snd_pcm_oss_write+0x35/0x70 [snd-pcm-oss]
Sep 29 22:33:05 localhost kernel:  [<c013e5e4>]vfs_write+0xb4/0x140
Sep 29 22:33:05 localhost kernel:  [<c014d676>]sys_ioctl+0x246/0x290
Sep 29 22:33:05 localhost kernel:  [<c013e6d8>]sys_write+0x28/0x40
Sep 29 22:33:05 localhost kernel:  [<c010719f>]syscall_call+0x7/0xb
Sep 29 22:33:05 localhost kernel:
Sep 29 22:33:06 localhost kernel: Sleeping function called from illegal 
context at /usr/src/linux/include/asm/semaphore.h:119
Sep 29 22:33:06 localhost kernel: d3b87c54 c0117022 c0240300 e0927020 
00000077 c157c800 e091f008 e0927020
Sep 29 22:33:06 localhost kernel:        00000077 00000001 d6c69800 
d3b86000 00000000 00001000 080a5f18 e0920cd1
Sep 29 22:33:06 localhost kernel:        c157c800 d3b86000 00000000 
e09210bf c157c800 00004140 00000000 00000000
Sep 29 22:33:06 localhost kernel: Call Trace:
Sep 29 22:33:06 localhost kernel:  [<c0117022>]__might_sleep+0x52/0x60
Sep 29 22:33:06 localhost kernel:  
[<e0927020>].rodata.str1.32+0x200/0xa80 [snd-pcm]
Sep 29 22:33:06 localhost kernel:  
[<e091f008>]snd_pcm_prepare+0x28/0x200 [snd-pcm]
Sep 29 22:33:06 localhost kernel:  
[<e0927020>].rodata.str1.32+0x200/0xa80 [snd-pcm]
Sep 29 22:33:06 localhost kernel:  
[<e0920cd1>]snd_pcm_common_ioctl1+0x1b1/0x260 [snd-pcm]
Sep 29 22:33:06 localhost kernel:  
[<e09210bf>]snd_pcm_playback_ioctl1+0x33f/0x350 [snd-pcm]
Sep 29 22:33:06 localhost kernel:  [<c01343d6>]__alloc_pages+0x66/0x210
Sep 29 22:33:06 localhost kernel:  [<c012a801>]do_anonymous_page+0x171/0x1b0
Sep 29 22:33:06 localhost kernel:  [<c012a875>]do_no_page+0x35/0x280
Sep 29 22:33:06 localhost kernel:  [<c012ab2d>]handle_mm_fault+0x6d/0x110
Sep 29 22:33:06 localhost kernel:  
[<e0921477>]snd_pcm_kernel_playback_ioctl+0x27/0x30 [snd-pcm]
Sep 29 22:33:06 localhost kernel:  
[<e0936b15>]snd_pcm_oss_prepare+0x15/0x40 [snd-pcm-oss]
Sep 29 22:33:06 localhost kernel:  
[<e0936b78>]snd_pcm_oss_make_ready+0x38/0x50 [snd-pcm-oss]
Sep 29 22:33:07 localhost kernel:  
[<e0936f3a>]snd_pcm_oss_write1+0x3a/0x160 [snd-pcm-oss]
Sep 29 22:33:07 localhost kernel:  
[<e0938dc5>]snd_pcm_oss_write+0x35/0x70 [snd-pcm-oss]
Sep 29 22:33:07 localhost kernel:  [<c013e5e4>]vfs_write+0xb4/0x140
Sep 29 22:33:07 localhost kernel:  [<c013e6d8>]sys_write+0x28/0x40
Sep 29 22:33:07 localhost kernel:  [<c010719f>]syscall_call+0x7/0xb
Sep 29 22:33:07 localhost kernel:


Petr Titera

