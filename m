Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261360AbSIWU1a>; Mon, 23 Sep 2002 16:27:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261361AbSIWU1a>; Mon, 23 Sep 2002 16:27:30 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:56291 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S261360AbSIWU13>;
	Mon, 23 Sep 2002 16:27:29 -0400
Date: Mon, 23 Sep 2002 22:32:40 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: kernel BUG at filemap.c:81!
Message-ID: <Pine.GSO.4.30.0209232224580.10036-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I'm running Yellow Dog Linx 2.3 on a PowerBook G4, with the ydl stock
2.4.19-4a kernel.
I just compiled and loaded the alsa 0.9rc3 driver. Shortly after testing
with mplayer :), I get this oops:

-------------------------->
ksymoops 2.4.1 on ppc 2.4.19-4a.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.19-4a/ (default)
     -m /boot/System.map-2.4.19-4a (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): mismatch on symbol xchg_u32  , ksyms_base says c000e014, System.map says c0008904.  Ignoring ksyms_base entry
Warning (compare_maps): mismatch on symbol snd_cards_count  , snd says e3397644, /lib/modules/2.4.19-4a/kernel/sound/acore/snd.o says e3397e38.  Ignoring /lib/modules/2.4.19-4a/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol snd_seq_root  , snd says e3397674, /lib/modules/2.4.19-4a/kernel/sound/acore/snd.o says e3397e68.  Ignoring /lib/modules/2.4.19-4a/kernel/sound/acore/snd.o entry
Warning (compare_maps): mismatch on symbol md_size  , md says e3365ae0, /lib/modules/2.4.19-4a/kernel/drivers/md/md.o says e3365380.  Ignoring /lib/modules/2.4.19-4a/kernel/drivers/md/md.o entry
Warning (compare_maps): mismatch on symbol mddev_map  , md says e33652e0, /lib/modules/2.4.19-4a/kernel/drivers/md/md.o says e3364b80.  Ignoring /lib/modules/2.4.19-4a/kernel/drivers/md/md.o entry
0514) Richard Gooch (rgooch@atnf.csiro.au)
kernel BUG at filemap.c:81!
Oops: Exception in kernel mode, sig: 4
NIP: C002CAF0 XER: 00000000 LR: C002CAF0 SP: D3F9DE50 REGS: d3f9dda0 TRAP: 0700    Not tainted
Using defaults from ksymoops -t elf32-powerpc -a powerpc:common
MSR: 00089032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK = d3f9c000[4754] 'mplayer' Last syscall: 3
last math d3f9c000 last altivec 00000000
GPR00: C002CAF0 D3F9DE50 D3F9C000 0000001C 00001032 00000001 00000020 C03A0000
GPR08: 00000000 00000000 0000001F D3F9DD70 00000050 102022F8 10200000 10200000
GPR16: 7FFFF88C 00000000 102E7A90 C002EBAC DA8733C0 00000001 D3F9DEF8 D7294A00
GPR24: 00001000 00000000 0000001F DA8733A0 DFEAEDBC D7294AAC 00000001 C09FE6A0
Call backtrace:
C002CAF0 C002D980 C002DA68 C002E3F0 C002E6B0 C002ED84 C003EA38
C00061DC 0FF8B598 100D6C74 100CBF5C 100D47DC 100CC570 100CD2F4
100D21D8 100D2458 100D4AE4 100CAFAC 10008D58 0F9BFF70 00000000
Warning (Oops_read): Code line not seen, dumping what data is available

>>NIP; c002caf0 <add_page_to_hash_queue+50/7c>   <=====
Trace; c002caf0 <add_page_to_hash_queue+50/7c>
Trace; c002d980 <add_to_page_cache_unique+a4/d0>
Trace; c002da68 <page_cache_read+bc/118>
Trace; c002e3f0 <generic_file_readahead+168/1c8>
Trace; c002e6b0 <do_generic_file_read+1ec/4a8>
Trace; c002ed84 <generic_file_read+90/180>
Trace; c003ea38 <sys_read+c8/14c>
Trace; c00061dc <ret_from_syscall_1+0/b4>
Trace; 0ff8b598 Before first symbol
Trace; 100d6c74 Before first symbol
Trace; 100cbf5c Before first symbol
Trace; 100d47dc Before first symbol
Trace; 100cc570 Before first symbol
Trace; 100cd2f4 Before first symbol
Trace; 100d21d8 Before first symbol
Trace; 100d2458 Before first symbol
Trace; 100d4ae4 Before first symbol
Trace; 100cafac Before first symbol
Trace; 10008d58 Before first symbol
Trace; 0f9bff70 Before first symbol
Trace; 00000000 Before first symbol


7 warnings issued.  Results may not be reliable.
<----------------------------

I am not sure if the above ksymoops report is correct, tell me what can I
do for you.

The same problem exists with the newest alsa driver from cvs.

Is this a general kernel bug, or an alsa-bug?

thanks.

-- 
pozsy

