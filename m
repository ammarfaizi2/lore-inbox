Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286411AbSAEXfc>; Sat, 5 Jan 2002 18:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286428AbSAEXfX>; Sat, 5 Jan 2002 18:35:23 -0500
Received: from urtica.linuxnews.pl ([217.67.192.54]:27913 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S286411AbSAEXfP>; Sat, 5 Jan 2002 18:35:15 -0500
Date: Sun, 6 Jan 2002 00:35:00 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [patch] O(1) scheduler, 2.4.17-B0, 2.5.2-pre8-B0.
In-Reply-To: <Pine.LNX.4.33.0201060128250.1250-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0201060031580.32070-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 6 Jan 2002, Ingo Molnar wrote:

Hi Ingo,

> this is the next, bugfix release of the O(1) scheduler:
>
> 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-B0.patch
>
> This release could fix the lockups and crashes reported by some people.
[...]
> Comments, bug reports, suggestions are welcome,

The same machine as before. The same scenario:
1. login
2. startx
3. gimp &
4. netscape &
5. mozilla &
6. freeze & oops
7. SAK
8. pasting oops
9. freeze

Result of ksymoops below. Hope it helps.

ksymoops 2.4.1 on i686 2.4.17sched.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.17sched (specified)
     -m /usr/src/linux-2.4.17-scheduler/System.map (specified)

Warning (compare_maps): mismatch on symbol sb_be_quiet  , sb_lib says d2845804, /lib/modules/2.4.17sched/kernel/drivers/sound/sb_lib.o says d2843ea4.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sb_lib.o entry
Warning (compare_maps): mismatch on symbol smw_free  , sb_lib says d2845810, /lib/modules/2.4.17sched/kernel/drivers/sound/sb_lib.o says d2843eb0.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sb_lib.o entry
Warning (compare_maps): mismatch on symbol audio_devs  , sound says d2828e00, /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o says d28287a0.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol midi_devs  , sound says d2828e70, /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o says d2828810.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol mixer_devs  , sound says d2828e18, /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o says d28287b8.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_audiodevs  , sound says d2828e14, /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o says d28287b4.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_midis  , sound says d2828e88, /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o says d2828828.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_mixers  , sound says d2828e2c, /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o says d28287cc.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol num_synths  , sound says d2828e6c, /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o says d282880c.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o entry
Warning (compare_maps): mismatch on symbol synth_devs  , sound says d2828e40, /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o says d28287e0.  Ignoring /lib/modules/2.4.17sched/kernel/drivers/sound/sound.o entry
Jan  6 00:25:55 blurp kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan  6 00:25:55 blurp kernel: c011311c
Jan  6 00:25:55 blurp kernel: *pde = 00000000
Jan  6 00:25:55 blurp kernel: Oops: 0002
Jan  6 00:25:55 blurp kernel: CPU:    0
Jan  6 00:25:55 blurp kernel: EIP:    0010:[<c011311c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  6 00:25:55 blurp kernel: EFLAGS: 00010006
Jan  6 00:25:55 blurp kernel: eax: c02b6854   ebx: c9c62000   ecx: c9c6202c   edx: 00000000
Jan  6 00:25:55 blurp kernel: esi: c9e08000   edi: c9c62000   ebp: c9e09e74   esp: c9e09e2c
Jan  6 00:25:55 blurp kernel: ds: 0018   es: 0018   ss: 0018
Jan  6 00:25:55 blurp kernel: Process mozilla-bin (pid: 145, stackpage=c9e09000)
Jan  6 00:25:55 blurp kernel: Stack: c9c62000 c9e08000 00000246 c9c6202c c1517788 00000100 00000520 c9c64aa0
Jan  6 00:25:55 blurp kernel:        c1405e80 c02b6520 00000001 c9c64000 c9c62000 c9c62000 cc959a64 c9c64564
Jan  6 00:25:55 blurp kernel:        c02b6500 00000246 c9e09e84 c0114ebf c9c62000 00000000 c1517788 c0115efc
Jan  6 00:25:55 blurp kernel: Call Trace: [<c0114ebf>] [<c0115efc>] [<c01057c6>] [<c0106ae3>] [<c0121008>]
Jan  6 00:25:55 blurp kernel:    [<c0105423>] [<c0121121>] [<c0121008>] [<c01d84bd>] [<c01d8545>] [<c01d91ec>]
Jan  6 00:25:55 blurp kernel:    [<c0106bd4>] [<c0106ae3>]
Jan  6 00:25:55 blurp kernel: Code: 89 0a 8b 47 24 8b 55 dc 0f b3 42 0c ff 02 89 57 34 8b 4d f8

>>EIP; c011311c <try_to_wake_up+41c/460>   <=====
Trace; c0114ebf <wake_up_process+b/1c>
Trace; c0115efc <do_fork+664/720>
Trace; c01057c6 <sys_clone+1e/28>
Trace; c0106ae3 <system_call+33/38>
Trace; c0121008 <exec_modprobe+0/74>
Trace; c0105423 <kernel_thread+1f/38>
Trace; c0121121 <request_module+a5/1a0>
Trace; c0121008 <exec_modprobe+0/74>
Trace; c01d84bd <sock_create+95/100>
Trace; c01d8545 <sys_socket+1d/50>
Trace; c01d91ec <sys_socketcall+64/200>
Trace; c0106bd4 <error_code+34/3c>
Trace; c0106ae3 <system_call+33/38>
Code;  c011311c <try_to_wake_up+41c/460>
0000000000000000 <_EIP>:
Code;  c011311c <try_to_wake_up+41c/460>   <=====
   0:   89 0a                     mov    %ecx,(%edx)   <=====
Code;  c011311e <try_to_wake_up+41e/460>
   2:   8b 47 24                  mov    0x24(%edi),%eax
Code;  c0113121 <try_to_wake_up+421/460>
   5:   8b 55 dc                  mov    0xffffffdc(%ebp),%edx
Code;  c0113124 <try_to_wake_up+424/460>
   8:   0f b3 42 0c               btr    %eax,0xc(%edx)
Code;  c0113128 <try_to_wake_up+428/460>
   c:   ff 02                     incl   (%edx)
Code;  c011312a <try_to_wake_up+42a/460>
   e:   89 57 34                  mov    %edx,0x34(%edi)
Code;  c011312d <try_to_wake_up+42d/460>
  11:   8b 4d f8                  mov    0xfffffff8(%ebp),%ecx


10 warnings issued.  Results may not be reliable.

pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

