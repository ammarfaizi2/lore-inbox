Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264463AbTK2WSo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 17:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264485AbTK2WSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 17:18:44 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:1042 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S264463AbTK2WSj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 17:18:39 -0500
Date: Sat, 29 Nov 2003 23:18:37 +0100
To: linux-kernel@vger.kernel.org
Subject: Bug in usb visor with 2.4.23
Message-ID: <20031129221837.GB9465@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just got a kernel Ooops when trying to sync my Tungsten, here is the
output of ksymoops, but please do not kill me because the kernel is
tainted, it is the nvidia kernel module and the pwcx kernel module.

ksymoops 2.4.9 on i686 2.4.23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.23/ (default)
     -m /boot/System.map-2.4.23 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_Version): Version mismatch.  3c59x says 2.4.23, pwcx says 2.4.20.  Expect lots of address mismatches.
Unable to handle kernel NULL pointer dereference at virtual address 00000018
f1f5f773
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<f1f5f773>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010046
eax: 00000000   ebx: 00000000   ecx: 00000000   edx: 00000300
esi: 00000246   edi: db7f4400   ebp: ffffffea   esp: c7b33e9c
ds: 0018   es: 0018   ss: 0018
Process jpilot (pid: 9039, stackpage=c7b33000)
Stack: db7f4488 db7f44e0 db7f4400 f1f59c2b db7f4488 db7f44e0 f1f597de db7f4488 
       f1f5b9ac d7558000 00000002 7fffffff d7558000 c7b32000 d7558970 c01acd83 
       d7558000 00000cbd 00000000 c7b32000 00000000 00000000 00000000 c7b32000 
Call Trace:    [<f1f59c2b>] [<f1f597de>] [<f1f5b9ac>] [<c01acd83>] [<c01ad159>]
  [<c01a9a36>] [<c01a9760>] [<c01499bd>] [<c0108e0f>]
Code: 83 78 18 8d 0f 44 da 41 83 f9 17 7e e6 56 9d 8b 15 08 1d f6 


>>EIP; f1f5f773 <[visor]visor_chars_in_buffer+23/90>   <=====

>>edi; db7f4400 <_end+1b4a9340/30837fc0>
>>esp; c7b33e9c <_end+77e8ddc/30837fc0>

Trace; f1f59c2b <[usbserial]serial_set_termios+9b/100>
Trace; f1f597de <[usbserial]serial_chars_in_buffer+7e/110>
Trace; f1f5b9ac <[usbserial].text.end+104/bd0>
Trace; c01acd83 <tty_wait_until_sent+83/d0>
Trace; c01ad159 <set_termios+d9/140>
Trace; c01a9a36 <tty_ioctl+2d6/520>
Trace; c01a9760 <tty_ioctl+0/520>
Trace; c01499bd <sys_ioctl+bd/240>
Trace; c0108e0f <system_call+33/38>

Code;  f1f5f773 <[visor]visor_chars_in_buffer+23/90>
00000000 <_EIP>:
Code;  f1f5f773 <[visor]visor_chars_in_buffer+23/90>   <=====
   0:   83 78 18 8d               cmpl   $0xffffff8d,0x18(%eax)   <=====
Code;  f1f5f777 <[visor]visor_chars_in_buffer+27/90>
   4:   0f 44 da                  cmove  %edx,%ebx
Code;  f1f5f77a <[visor]visor_chars_in_buffer+2a/90>
   7:   41                        inc    %ecx
Code;  f1f5f77b <[visor]visor_chars_in_buffer+2b/90>
   8:   83 f9 17                  cmp    $0x17,%ecx
Code;  f1f5f77e <[visor]visor_chars_in_buffer+2e/90>
   b:   7e e6                     jle    fffffff3 <_EIP+0xfffffff3>
Code;  f1f5f780 <[visor]visor_chars_in_buffer+30/90>
   d:   56                        push   %esi
Code;  f1f5f781 <[visor]visor_chars_in_buffer+31/90>
   e:   9d                        popf   
Code;  f1f5f782 <[visor]visor_chars_in_buffer+32/90>
   f:   8b 15 08 1d f6 00         mov    0xf61d08,%edx


2 warnings issued.  Results may not be reliable.


More information:
* 2.4.23 self compiled
* debian sid
* modules loaded:
Module                  Size  Used by    Tainted: PF 
visor                  11656   1
usbserial              18044   0 [visor]
isofs                  26580   0 (autoclean)
zlib_inflate           18244   0 (autoclean) [isofs]
loop                    9432   0 (autoclean)
nvidia               1630112  11 (autoclean)
usb-storage            25808   0
joydev                  5984   0 (unused)
keybdev                 2084   0 (unused)
mousedev                4180   1
hid                    21540   0 (unused)
parport_pc             23272   1 (autoclean)
lp                      6720   0 (autoclean)
parport                24616   1 (autoclean) [parport_pc lp]
pwcx                   86752   0 (unused)
audio                  42520   0
pwc                    44336   0 [pwcx]
videodev                6336   1 [pwc]
uhci                   25436   0 (unused)
usbcore                62156   1 [visor usbserial usb-storage hid audio pwc uhci
]
via686a                 8052   0 (unused)
adm1021                 5912   0 (unused)
i2c-proc                6804   0 [via686a adm1021]
i2c-isa                  716   0 (unused)
i2c-viapro              3564   0 (unused)
i2c-core               14980   0 [via686a adm1021 i2c-proc i2c-isa i2c-viapro]
emu10k1                60812   2
sound                  57448   0 [emu10k1]
ac97_codec             13300   0 [emu10k1]
soundcore               3652   9 [audio emu10k1 sound]
3c59x                  26000   1
ide-scsi               10096   0

* lmsensors and i2c compiled from debian sid -source packages

I will try to reproduce this without one of these tsts evil modules ;-)
But maybe the above ksymoops output already gives a hint.

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
POLPERRO (n.)
A polperro is the ball, or muff, of soggy hair found clinging to bath
overflow-holes.
			--- Douglas Adams, The Meaning of Liff
