Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286198AbSAEBfV>; Fri, 4 Jan 2002 20:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286262AbSAEBfM>; Fri, 4 Jan 2002 20:35:12 -0500
Received: from urtica.linuxnews.pl ([217.67.192.54]:41735 "EHLO
	urtica.linuxnews.pl") by vger.kernel.org with ESMTP
	id <S286198AbSAEBex>; Fri, 4 Jan 2002 20:34:53 -0500
Date: Sat, 5 Jan 2002 02:34:43 +0100 (CET)
From: Pawel Kot <pkot@linuxnews.pl>
To: Ingo Molnar <mingo@elte.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: [oops] sched-O1-2.4.17-A2
Message-ID: <Pine.LNX.4.33.0201050233270.32070-100000@urtica.linuxnews.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ingo,

I tried to test sched-O1-2.4.17-A2.patch on my machine: UP, PII 400, 256MB
RAM, Slackware 8.0 with misc updates. The patch applied to the 2.4.17-vanilla.
First depmod generated the errors:
depmod: *** Unresolved symbols in
/lib/modules/2.4.17sched/kernel/fs/jbd/jbd.o
depmod:         sys_sched_yield
depmod: *** Unresolved symbols in
/lib/modules/2.4.17sched/kernel/fs/nfs/nfs.o
depmod:         sys_sched_yield
depmod: *** Unresolved symbols in
/lib/modules/2.4.17sched/kernel/fs/reiserfs/reiserfs.o
depmod:         sys_sched_yield
depmod:         nr_context_switches
depmod: *** Unresolved symbols in
/lib/modules/2.4.17sched/kernel/net/sunrpc/sunrpc.o
depmod:         sys_sched_yield
Then, after rebooting:
 - I logged in,
 - I run X (XFree86 4.1.0)
 - I run gimp
 - I run netscape
 - I run mozilla
The machine hang. I tried SAK. It worked. I found the oops below in the
logs. Then I tried to get it through ksymoops. I run 'locate ksymoops'.
It showed me 5 lines of the output. And hang. The keyboard was active (num
lock), but magic keys didn't work. Just hard reset. No oops found.
Hope it helps.

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
Jan  5 02:13:20 blurp kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000000
Jan  5 02:13:20 blurp kernel: c011317c
Jan  5 02:13:20 blurp kernel: *pde = 00000000
Jan  5 02:13:20 blurp kernel: Oops: 0002
Jan  5 02:13:20 blurp kernel: CPU:    0
Jan  5 02:13:20 blurp kernel: EIP:    0010:[<c011317c>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Jan  5 02:13:20 blurp kernel: EFLAGS: 00010006
Jan  5 02:13:20 blurp kernel: eax: c02b6854   ebx: 00000000   ecx: c02b6520 edx: c9be602c
Jan  5 02:13:20 blurp kernel: esi: c9be6000   edi: 00000246   ebp: c9d55e84 esp: c9d55e5c
Jan  5 02:13:20 blurp kernel: ds: 0018   es: 0018   ss: 0018
Jan  5 02:13:20 blurp kernel: Process mozilla-bin (pid: 150, stackpage=c9d55000)
Jan  5 02:13:20 blurp kernel: Stack: c9be6000 c9d54000 00000246 c9be8564 c1517788 c0115e39 00000000 00000100
Jan  5 02:13:20 blurp kernel:        00000078 c02b6520 c1517788 c011603c c9d54000 c9d55f04 c9d55f58 c9d55ec8
Jan  5 02:13:20 blurp kernel:        00000000 00000097 cd6fc5b4 00000000 c9cd252c 00000107 c01057c6 00000100
Jan  5 02:13:20 blurp kernel: Call Trace: [<c0115e39>] [<c011603c>] [<c01057c6>] [<c0106ae3>] [<c0121158>]
Jan  5 02:13:20 blurp kernel:    [<c0105423>] [<c0121271>] [<c0121158>] [<c01d860d>] [<c01d8695>] [<c01d933c>]
Jan  5 02:13:20 blurp kernel:    [<c0106bd4>] [<c0106ae3>]
Jan  5 02:13:20 blurp kernel: Code: 89 13 8b 46 24 0f b3 41 0c ff 01 89 4e 34 ff 05 08 65 2b c0

>>EIP; c011317c <wake_up_forked_process+1c0/1dc>   <=====
Trace; c0115e39 <do_fork+461/730>
Trace; c011603c <do_fork+664/730>
Trace; c01057c6 <sys_clone+1e/28>
Trace; c0106ae3 <system_call+33/38>
Trace; c0121158 <exec_modprobe+0/74>
Trace; c0105423 <kernel_thread+1f/38>
Trace; c0121271 <request_module+a5/1a0>
Trace; c0121158 <exec_modprobe+0/74>
Trace; c01d860d <sock_create+95/100>
Trace; c01d8695 <sys_socket+1d/50>
Trace; c01d933c <sys_socketcall+64/200>
Trace; c0106bd4 <error_code+34/3c>
Trace; c0106ae3 <system_call+33/38>
Code;  c011317c <wake_up_forked_process+1c0/1dc>
0000000000000000 <_EIP>:
Code;  c011317c <wake_up_forked_process+1c0/1dc>   <=====
   0:   89 13                     mov    %edx,(%ebx)   <=====
Code;  c011317e <wake_up_forked_process+1c2/1dc>
   2:   8b 46 24                  mov    0x24(%esi),%eax
Code;  c0113181 <wake_up_forked_process+1c5/1dc>
   5:   0f b3 41 0c               btr    %eax,0xc(%ecx)
Code;  c0113185 <wake_up_forked_process+1c9/1dc>
   9:   ff 01                     incl   (%ecx)
Code;  c0113187 <wake_up_forked_process+1cb/1dc>
   b:   89 4e 34                  mov    %ecx,0x34(%esi)
Code;  c011318a <wake_up_forked_process+1ce/1dc>
   e:   ff 05 08 65 2b c0         incl   0xc02b6508


10 warnings issued.  Results may not be reliable.

regards
pkot
-- 
mailto:pkot@linuxnews.pl :: mailto:pkot@slackware.pl
http://kt.linuxnews.pl/ :: Kernel Traffic po polsku

