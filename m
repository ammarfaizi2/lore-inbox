Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269186AbTCBL2N>; Sun, 2 Mar 2003 06:28:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269187AbTCBL2N>; Sun, 2 Mar 2003 06:28:13 -0500
Received: from 217-127-135-237.uc.nombres.ttd.es ([217.127.135.237]:35313 "EHLO
	pulp.ibd.es") by vger.kernel.org with ESMTP id <S269186AbTCBL2J>;
	Sun, 2 Mar 2003 06:28:09 -0500
Subject: [2.5.63] Oops bttv related
From: Alfredo Sanjuan <alfre@ibdinternet.com>
To: kraxel@bytesex.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: IBD Internet
Message-Id: <1046605022.1185.6.camel@den>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 02 Mar 2003 12:37:02 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is with vanilla 2.5.63, with no module support. Just launching
zapping (a tv app like xawtv) under a fresh XFree86 4.3.0. The tv card
is an Avermedia TV Capture 98 and the video card is a NVIDIA Geforce4 Ti
4200. This setup works fine with 2.4.20 + alsa + acpi-20021212 patches.

After the oops, X just crash and reboot. Launching zapping again just
show a pink screen.

I'm not subscribed to linux-kernel, CC any replies to me.


# ksymoops < oops-bttv.txt
ksymoops 2.4.5 on i686 2.5.63.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.63/ (default)
     -m /boot/System.map-2.5.63 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
kernel BUG at drivers/media/video/bttv-risc.c:846!
invalid operand: 0000
CPU:    0
EIP:    0060:[<c02673b1>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00013293
eax: 00000000   ebx: decc94e0   ecx: 00000000   edx: 00000020
esi: dfd4e760   edi: c03509a4   ebp: c0425780   esp: de3bdd90
ds: 007b   es: 007b   ss: 0068
Stack: c0425780 dfd4e7d8 00000140 000000f0 00000000 00000000 decc940c
dfd4e760
       de3bdeec c0425780 c025f24f c0425780 decc94e0 c03509a4 dfd4e760
000003bf
       000003e2 decc9400 decc940c 00000001 00000001 de3bc000 de3b0004
bfffc4b3
Call Trace: [<c025f24f>]  [<c026ece1>]  [<c033ccfc>]  [<c0132921>] 
[<c0131491>]  [<c01499ec>]  [<c0259be4>]  [<c0116a3c>]  [<c013e902>] 
[<c026063e>]  [<c025eea0>]  [<c015b0db>]  [<c01095cf>]
Code: 0f 0b 4e 03 80 cc 37 c0 8b 47 0c 89 46 70 8b 47 10 89 46 74


>>EIP; c02673b1 <bttv_overlay_risc+71/160>   <=====

>>ebx; decc94e0 <END_OF_CODE+1e895308/????>
>>esi; dfd4e760 <END_OF_CODE+1f91a588/????>
>>edi; c03509a4 <bttv_formats+144/2ac>
>>ebp; c0425780 <bttvs+0/1620>
>>esp; de3bdd90 <END_OF_CODE+1df89bb8/????>

Trace; c025f24f <bttv_do_ioctl+3af/1760>
Trace; c026ece1 <tuner_command+121/240>
Trace; c033ccfc <unix_stream_recvmsg+10c/360>
Trace; c0132921 <buffered_rmqueue+b1/150>
Trace; c0131491 <generic_file_aio_write+71/90>
Trace; c01499ec <do_sync_write+8c/c0>
Trace; c0259be4 <video_usercopy+c4/1a0>
Trace; c0116a3c <do_page_fault+23c/45e>
Trace; c013e902 <do_brk+142/220>
Trace; c026063e <bttv_ioctl+3e/70>
Trace; c025eea0 <bttv_do_ioctl+0/1760>
Trace; c015b0db <sys_ioctl+bb/240>
Trace; c01095cf <syscall_call+7/b>

Code;  c02673b1 <bttv_overlay_risc+71/160>
00000000 <_EIP>:
Code;  c02673b1 <bttv_overlay_risc+71/160>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c02673b3 <bttv_overlay_risc+73/160>
   2:   4e                        dec    %esi
Code;  c02673b4 <bttv_overlay_risc+74/160>
   3:   03 80 cc 37 c0 8b         add    0x8bc037cc(%eax),%eax
Code;  c02673ba <bttv_overlay_risc+7a/160>
   9:   47                        inc    %edi
Code;  c02673bb <bttv_overlay_risc+7b/160>
   a:   0c 89                     or     $0x89,%al
Code;  c02673bd <bttv_overlay_risc+7d/160>
   c:   46                        inc    %esi
Code;  c02673be <bttv_overlay_risc+7e/160>
   d:   70 8b                     jo     ffffff9a <_EIP+0xffffff9a>
Code;  c02673c0 <bttv_overlay_risc+80/160>
   f:   47                        inc    %edi
Code;  c02673c1 <bttv_overlay_risc+81/160>
  10:   10 89 46 74 00 00         adc    %cl,0x7446(%ecx)


1 warning and 1 error issued.  Results may not be reliable.

-- 
Alfredo Sanjuan <alfre@ibdinternet.com>
IBD Internet

