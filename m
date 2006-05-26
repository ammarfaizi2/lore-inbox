Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWEZNjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWEZNjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 09:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWEZNjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 09:39:04 -0400
Received: from mail.artecdesign.ee ([62.65.32.9]:62863 "EHLO
	postikukk.artecdesign.ee") by vger.kernel.org with ESMTP
	id S1750738AbWEZNjD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 09:39:03 -0400
Message-ID: <447704F1.1060104@artecdesign.ee>
Date: Fri, 26 May 2006 16:38:57 +0300
From: Indrek Kruusa <indrek.kruusa@artecdesign.ee>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: long/heavy USB fs operations panics 2.6.16.18
References: <447495CC.7040205@artecdesign.ee> <20060524192503.GJ17964@cosmic.amd.com>
In-Reply-To: <20060524192503.GJ17964@cosmic.amd.com>
Content-Type: multipart/mixed;
 boundary="------------070308040004090707080002"
X-ADG-Spam-Score: 0.0 (/)
X-ADG-Spam-ScoreInt: 0
X-ADG-Spam-Report: Content analysis details:   (0.0 points, 5.5 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.8 SARE_BAYES_5x8         BODY: Bayes poison 5x8
	0.8 SARE_BAYES_6x8         BODY: Bayes poison 6x8
	1.0 SARE_BAYES_7x8         BODY: Bayes poison 7x8
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
X-ADG-ExiScan-Signature: 060195174cb5b2811e8526c0a83bc312
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070308040004090707080002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I have tried playing a big *.wav: WinCE is OK but Linux  is not (output 
attached). It can't be hardware problem. Of course the bios is still  
under development here...

It happens somewhere at the end. Sound will disappear, long time silence 
(1 min?) and then oopsing.

Indrek


--------------070308040004090707080002
Content-Type: text/plain;
 name="wav_crash.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="wav_crash.txt"

xxx:/mnt/usbflash# ls -l Guns_n_roses_Paradise\ City.wav 
-rwxr-xr-x  1 root root 71672876 2006-05-23 10:47 Guns_n_roses_Paradise City.wav

dbe61:/mnt/usbflash# aplay Guns_n_roses_Paradise\ City.wav 
Playing WAVE 'Guns_n_roses_Paradise City.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
Unable to handle kernel paging request at virtual address f7060965

 printing eip:

c0150325

*pde = 00000000

Oops: 0000 [#1]

Modules linked in: snd_cs5535audio snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_ac97_bus snd_page_alloc generic amd74xx 8139too hw_random

CPU:    0

EIP:    0060:[<c0150325>]    Not tainted VLI

EFLAGS: 00010002   (2.6.16.18 #10) 

EIP is at free_block+0x65/0xe0

eax: 00000000   ebx: f7060965   ecx: c1237750   edx: c1000000

esi: 00000004   edi: c121f980   ebp: 00000000   esp: cebd9eec

ds: 007b   es: 007b   ss: 0068

Process events/0 (pid: 3, threadinfo=cebd8000 task=c1210030)

Stack: <0>00000004 c122ac10 c122ac10 00000004 c122ac00 c121f980 c01503f5 00000000 

       c038e300 c03d9fd8 c121f9c8 c121f980 c121e920 00000001 c01504d5 00000000 

       c121e970 c0412524 c121e6a0 00000286 00000000 c01250cf 00000000 c038e300 

Call Trace:

 [<c01503f5>] drain_array_locked+0x55/0xd0

 [<c01504d5>] cache_reap+0x65/0x130

 [<c01250cf>] run_workqueue+0x5f/0xd0

 [<c0150470>] cache_reap+0x0/0x130

 [<c0125301>] worker_thread+0x111/0x150

 [<c0112b20>] default_wake_function+0x0/0x20

 [<c012840a>] kthread+0xea/0xf0

 [<c01251f0>] worker_thread+0x0/0x150

 [<c0128320>] kthread+0x0/0xf0

 [<c0101005>] kernel_thread_helper+0x5/0x10

Code: 45 39 2c 24 0f 84 7c 00 00 00 8b 44 24 04 8b 15 80 1b 41 c0 8b 0c a8 8d 81 00 00 00 40 c1 e8 0c c1 e0 05 8b 5c 10 1c 8b 44 24 1c <8b> 13 8b 74 87 14 8b 43 04 89 42 04 89 10 31 d2 8b 43 0c c7 03 

 <1>Unable to handle kernel paging request at virtual address 10e50a33

 printing eip:

c01506cf

*pde = 00000000

Oops: 0000 [#2]

Modules linked in: snd_cs5535audio snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_ac97_bus snd_page_alloc generic amd74xx 8139too hw_random

CPU:    0

EIP:    0060:[<c01506cf>]    Not tainted VLI

EFLAGS: 00010006   (2.6.16.18 #10) 

EIP is at kfree+0x2f/0x60

eax: 00027d00   ebx: cdfadee0   ecx: 10e50a33   edx: c1000000

esi: c13e83c0   edi: 00000286   ebp: ce0faa00   esp: cd535d4c

ds: 007b   es: 007b   ss: 0068

Process syslogd (pid: 1824, threadinfo=cd534000 task=c13e95d0)

Stack: <0>cdfadee0 cdfadee0 cd535d84 c02ca9f0 c13e83c0 cd535d84 cd535d84 c031fa4c 

       cdfadee0 cdfadee0 cd535f44 00000000 08054299 cd535e3c 00000723 00000000 

       00000000 00000000 00000000 0000002a 00000000 000003fe cd535f28 cd535dc4 

Call Trace:

 [<c02ca9f0>] kfree_skbmem+0x10/0xa0

 [<c031fa4c>] unix_dgram_recvmsg+0x19c/0x290

 [<c02c4065>] sock_recvmsg+0xf5/0x150

 [<c01285e0>] autoremove_wake_function+0x0/0x60

 [<c013bae3>] __alloc_pages+0x53/0x300

 [<c013c00e>] __get_free_pages+0x1e/0x50

 [<c0166f9c>] __pollwait+0x8c/0xd0

 [<c02c5134>] sys_recvfrom+0xd4/0x170

 [<c0167419>] do_select+0x439/0x4c0

 [<c0166f10>] __pollwait+0x0/0xd0

 [<c02c5203>] sys_recv+0x33/0x40

 [<c02c5d13>] sys_socketcall+0x1a3/0x2b0

 [<c0102e65>] syscall_call+0x7/0xb

Code: 74 24 04 8b 74 24 10 89 1c 24 89 7c 24 08 85 f6 74 2b 9c 5f fa 8b 15 80 1b 41 c0 8d 86 00 00 00 40 c1 e8 0c c1 e0 05 8b 4c 10 18 <8b> 19 8b 03 3b 43 04 73 18 89 74 83 10 40 89 03 57 9d 8b 1c 24 

 <0>Eeek! page_mapcount(page) went negative! (-377691118)

  page->flags = e935f5bb

Unable to handle kernel paging request at virtual address ed17e9da

 printing eip:

c0148368

*pde = 00000000

Oops: 0000 [#3]

Modules linked in: snd_cs5535audio snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_ac97_bus snd_page_alloc generic amd74xx 8139too hw_random

CPU:    0

EIP:    0060:[<c0148368>]    Not tainted VLI

EFLAGS: 00010202   (2.6.16.18 #10) 

EIP is at page_remove_rmap+0x68/0xb0

eax: e935f5bb   ebx: c10080c0   ecx: ffffffff   edx: ed17e9d6

esi: b7e02000   edi: c10080c0   ebp: b7e02000   esp: cd535b98

ds: 007b   es: 007b   ss: 0068

Process syslogd (pid: 1824, threadinfo=cd534000 task=c13e95d0)

Stack: <0>c034e019 e935f5bb cd95b808 c01425d5 c10080c0 b7e01000 00406025 003b6f5f 

       00000001 00000000 00000001 ce377b7c ce377b7c ce377b7c 00000000 ffffffff 

       c0409e58 ce223700 00406025 b7e01fff b7e02000 00000000 cd535c20 ce3aa22c 

Call Trace:

 [<c01425d5>] unmap_vmas+0x255/0x530

 [<c0145487>] exit_mmap+0x67/0xe0

 [<c0113e84>] mmput+0x24/0x70

 [<c011724a>] exit_mm+0x6a/0xf0

 [<c0117ec5>] do_exit+0xe5/0x790

 [<c0262aa4>] do_unblank_screen+0x14/0x140

 [<c0116a3b>] printk+0x1b/0x20

 [<c0103d4d>] die+0x21d/0x220

 [<c0110fa3>] do_page_fault+0x383/0x650

 [<c01a0cf8>] journal_stop+0x148/0x260

 [<c0110c20>] do_page_fault+0x0/0x650

 [<c010308f>] error_code+0x4f/0x54

 [<c01506cf>] kfree+0x2f/0x60

 [<c02ca9f0>] kfree_skbmem+0x10/0xa0

 [<c031fa4c>] unix_dgram_recvmsg+0x19c/0x290

 [<c02c4065>] sock_recvmsg+0xf5/0x150

 [<c01285e0>] autoremove_wake_function+0x0/0x60

 [<c013bae3>] __alloc_pages+0x53/0x300

 [<c013c00e>] __get_free_pages+0x1e/0x50

 [<c0166f9c>] __pollwait+0x8c/0xd0

 [<c02c5134>] sys_recvfrom+0xd4/0x170

 [<c0167419>] do_select+0x439/0x4c0

 [<c0166f10>] __pollwait+0x0/0xd0

 [<c02c5203>] sys_recv+0x33/0x40

 [<c02c5d13>] sys_socketcall+0x1a3/0x2b0

 [<c0102e65>] syscall_call+0x7/0xb

Code: 04 24 f8 d4 34 c0 40 89 44 24 04 e8 d3 e6 fc ff 8b 03 c7 04 24 19 e0 34 c0 89 44 24 04 e8 c1 e6 fc ff 8b 03 89 da f6 c4 40 75 29 <8b> 42 04 c7 04 24 31 e0 34 c0 40 89 44 24 04 e8 a4 e6 fc ff 8b 

 <1>Fixing recursive fault but reboot is needed!

underrun!!! (at least 6.266 ms long)
Unable to handle kernel paging request at virtual address e18fecce

 printing eip:

c01774f7

*pde = 00000000

Oops: 0000 [#4]

Modules linked in: snd_cs5535audio snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_ac97_bus snd_page_alloc generic amd74xx 8139too hw_random

CPU:    0

EIP:    0060:[<c01774f7>]    Not tainted VLI

EFLAGS: 00010292   (2.6.16.18 #10) 

EIP is at do_mpage_readpage+0x27/0x520

eax: e18fecce   ebx: c1122000   ecx: 00000001   edx: 00000001

esi: c1122000   edi: 00001000   ebp: 00003d39   esp: c13e3cf4

ds: 007b   es: 007b   ss: 0068

Process aplay (pid: 2008, threadinfo=c13e2000 task=ceab0a50)

Stack: <0>cccef118 00000020 c013d14d cccef118 c13e3d60 00000001 c1122000 00000000 

       ccce5f40 0000445a 00000020 00000020 c13800c0 cf8c1180 00000c00 cda93400 

       00000020 00000000 0000ac44 cf913962 cda93400 00000020 0000002c cda93400 

Call Trace:

 [<c013d14d>] __do_page_cache_readahead+0x9d/0x230

 [<cf8c1180>] snd_cs5535audio_ac97_codec_read+0x30/0x80 [snd_cs5535audio]

 [<cf913962>] snd_ac97_read+0x32/0x50 [snd_ac97_codec]

 [<cf918434>] snd_ac97_set_rate+0x144/0x1d0 [snd_ac97_codec]

 [<c013d5d2>] blockable_page_cache_readahead+0x72/0x100

 [<c011a7b1>] current_fs_time+0x51/0x80

 [<c0177a1e>] mpage_readpage+0x2e/0x50

 [<c01b63e0>] fat_get_block+0x0/0x40

 [<c0137b73>] do_generic_mapping_read+0x133/0x4c0

 [<c01b63e0>] fat_get_block+0x0/0x40

 [<c01386f9>] __generic_file_aio_read+0xb9/0x280

 [<c0136530>] file_read_actor+0x0/0x110

 [<c0138acb>] generic_file_aio_read+0x5b/0x80

 [<c0153d49>] do_sync_read+0xc9/0x130

 [<cf8d8cc9>] snd_pcm_playback_ioctl1+0x169/0x470 [snd_pcm]

 [<c01285e0>] autoremove_wake_function+0x0/0x60

 [<c016657a>] do_ioctl+0x2a/0x80

 [<c01541b5>] vfs_read+0xb5/0x190

 [<c0154dfb>] sys_read+0x4b/0x80

 [<c0102e65>] syscall_call+0x7/0xb

Code: 00 00 00 00 55 57 bf 00 10 00 00 56 53 81 ec bc 00 00 00 89 54 24 18 89 4c 24 14 8b 5c 24 18 89 44 24 1c 8b 42 10 ba 01 00 00 00 <8b> 00 89 44 24 24 8b 40 5c 89 7c 24 28 88 c1 d3 6c 24 28 d3 e2 

 <1>Unable to handle kernel NULL pointer dereference at virtual address 0000010c

 printing eip:

c0135be7

*pde = 00000000

Oops: 0000 [#5]

Modules linked in: snd_cs5535audio snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_ac97_bus snd_page_alloc generic amd74xx 8139too hw_random

CPU:    0

EIP:    0060:[<c0135be7>]    Not tainted VLI

EFLAGS: 00010207   (2.6.16.18 #10) 

EIP is at page_waitqueue+0x17/0x30

eax: 94024500   ebx: c1024500   ecx: 00000020   edx: 00000000

esi: c1024500   edi: cd203b7c   ebp: ce74e4ec   esp: cd24fedc

ds: 007b   es: 007b   ss: 0068

Process bash (pid: 1911, threadinfo=cd24e000 task=ceaae030)

Stack: <0>c01370bc 00000000 c0143475 c1024500 b7f565d0 01228065 b7f565d0 ce223be0 

       00000012 00000082 00000082 ceab0a50 01228065 ce18fd58 cd203b7c b7f565d0 

       c01436b3 ce18fd58 cd203b7c ce223c20 01228065 ceab0b04 c0118ad9 ceab0a50 

Call Trace:

 [<c01370bc>] unlock_page+0x1c/0x30

 [<c0143475>] do_wp_page+0x215/0x2f0

 [<c01436b3>] __handle_mm_fault+0x163/0x810

 [<c0118ad9>] do_wait+0x4a9/0xa40

 [<c01665c7>] do_ioctl+0x77/0x80

 [<c0110d5a>] do_page_fault+0x13a/0x650

 [<c0110c20>] do_page_fault+0x0/0x650

 [<c010308f>] error_code+0x4f/0x54

Code: 00 00 e8 0d ff ff ff 83 c4 0c c3 89 f6 8d bc 27 00 00 00 00 8b 10 b9 20 00 00 00 69 c0 01 00 37 9e c1 ea 1e 8b 14 95 ac 7d 3d c0 <2b> 8a 0c 01 00 00 8b 92 04 01 00 00 d3 e8 8d 04 c2 c3 8d b4 26 

 <1>Unable to handle kernel paging request at virtual address ea94ecc7

 printing eip:

c013b33e

*pde = 00000000

Oops: 0002 [#6]

Modules linked in: snd_cs5535audio snd_ac97_codec snd_pcm_oss snd_mixer_oss snd_pcm snd_timer snd soundcore snd_ac97_bus snd_page_alloc generic amd74xx 8139too hw_random

CPU:    0

EIP:    0060:[<c013b33e>]    Not tainted VLI

EFLAGS: 00010087   (2.6.16.18 #10) 

EIP is at free_pages_bulk+0xbe/0x280

eax: eeaef0bc   ebx: 00000000   ecx: c1122658  
--------------070308040004090707080002--
