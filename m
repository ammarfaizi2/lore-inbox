Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316540AbSFPUTH>; Sun, 16 Jun 2002 16:19:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSFPUTG>; Sun, 16 Jun 2002 16:19:06 -0400
Received: from omniver.ne.client2.attbi.com ([66.30.197.22]:61178 "HELO
	carboy.peaveynet.com") by vger.kernel.org with SMTP
	id <S316540AbSFPUTE>; Sun, 16 Jun 2002 16:19:04 -0400
Date: Sun, 16 Jun 2002 16:16:56 -0400
From: "Justin S. Peavey" <jpeavey+kernel@peaveynet.com>
To: linux-kernel@vger.kernel.org
Subject: Oops from EMU10K1 (2.4.18 and CVS version)
Message-ID: <20020616201656.GE15266@colltech.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.18-6mdk on an i686
X-PGP-Key: http://www.peaveynet.com/~jpeavey/gpg.key
X-PGP-Fingerprint: 9D65 5346 78FA 5186 896D  B35A D97A 370B 1F8C 2F6F
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Noticed using maseq (MainActor) application, all attempts to use audio
caused the application to crash when opening the /dev/dsp device and
generated an oops (see oops1).  Based on the oops error generated
(kernel BUG at audio.c:1474!) and a posting from Rui ("Re: Oops in
emu10k1 driver", 01 Apr 2002), I upgraded to the latest CVS version of
emu10k1.

After CVS upgrade, the application now plays about a half-second of
audio then crashes again with a different Oops message (see oops2).
Strace shows the application now crashing while writing to the sound
device.  Just to be experimental, I applied the 2.4 patch sitting in
the docs area of the CVS tree, recompiled, installed and re-tested -
same problem (see oops3).

Any suggestions on where to go next with this?

-Justin

----------- Oops1: 2.4.18 kernel

ksymoops 2.4.3 on i686 2.4.18-12mdk.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-12mdk/ (default)
     -m /boot/System.map-2.4.18-12mdk (default)

Jun 16 12:24:09 stout kernel: kernel BUG at audio.c:1474!
Jun 16 12:24:09 stout kernel: invalid operand: 0000
Jun 16 12:24:09 stout kernel: CPU:    0
Jun 16 12:24:09 stout kernel: EIP:    0010:[scanner:__insmod_scanner_S.data_L2240+36132890/746806]    Tainted: PF
Jun 16 12:24:09 stout kernel: EIP:    0010:[<e4e1527a>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 16 12:24:09 stout kernel: EFLAGS: 00010006
Jun 16 12:24:09 stout kernel: eax: 0000000e   ebx: dc0c68c8   ecx: 0000000e   edx: 00003556
Jun 16 12:24:09 stout kernel: esi: 00000002   edi: 00000007   ebp: 0000ffff   esp: da215ea0
Jun 16 12:24:09 stout kernel: ds: 0018   es: 0018   ss: 0018
Jun 16 12:24:09 stout kernel: Process maseq (pid: 11607, stackpage=da215000)
Jun 16 12:24:09 stout kernel: Stack: 00018000 0001c000 00010000 00014000 bfffec00 d4987000 dc0c6880 00000202
Jun 16 12:24:09 stout kernel:        e4e141a1 dc0c6880 d4987618 c5300003 df4e8000 e4e16fbd c5303400 d4987618
Jun 16 12:24:09 stout kernel:        c5303400 c5303400 d4987000 dc0c68c8 00001000 dc0c6880 d4987000 c5303400
Jun 16 12:24:09 stout kernel: Call Trace: [scanner:__insmod_scanner_S.data_L2240+36128577/751119] [scanner:__insmod_scanner_S.data_L2240+36140381/739315] [sys_ioctl+129/592] [system_call+51/64]
Jun 16 12:24:09 stout kernel: Call Trace: [<e4e141a1>] [<e4e16fbd>] [<c0145941>] [<c0108b73>]
Jun 16 12:24:09 stout kernel: Code: 0f 0b c2 05 18 df e1 e4 e9 1e ff ff ff c7 43 18 00 00 00 00

>>EIP; e4e1527a <[emu10k1]calculate_ifrag+ea/1f0>   <=====
Trace; e4e141a0 <[emu10k1]emu10k1_audio_ioctl+cf0/1430>
Trace; e4e16fbc <[emu10k1]emu10k1_waveout_setformat+2c/130>
Trace; c0145940 <sys_ioctl+80/250>
Trace; c0108b72 <system_call+32/40>
Code;  e4e1527a <[emu10k1]calculate_ifrag+ea/1f0>
00000000 <_EIP>:
Code;  e4e1527a <[emu10k1]calculate_ifrag+ea/1f0>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  e4e1527c <[emu10k1]calculate_ifrag+ec/1f0>
   2:   c2 05 18                  ret    $0x1805
Code;  e4e1527e <[emu10k1]calculate_ifrag+ee/1f0>
   5:   df e1                     (bad)
Code;  e4e15280 <[emu10k1]calculate_ifrag+f0/1f0>
   7:   e4 e9                     in     $0xe9,%al
Code;  e4e15282 <[emu10k1]calculate_ifrag+f2/1f0>
   9:   1e                        push   %ds
Code;  e4e15284 <[emu10k1]calculate_ifrag+f4/1f0>
   a:   ff                        (bad)
Code;  e4e15284 <[emu10k1]calculate_ifrag+f4/1f0>
   b:   ff                        (bad)
Code;  e4e15286 <[emu10k1]calculate_ifrag+f6/1f0>
   c:   ff c7                     inc    %edi
Code;  e4e15288 <[emu10k1]calculate_ifrag+f8/1f0>
   e:   43                        inc    %ebx
Code;  e4e15288 <[emu10k1]calculate_ifrag+f8/1f0>
   f:   18 00                     sbb    %al,(%eax)

----------------Oops 2: CVS from 15 June 02

ksymoops 2.4.3 on i686 2.4.18-12mdk.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-12mdk/ (default)
     -m /boot/System.map-2.4.18-12mdk (default)

Jun 16 14:46:07 stout kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jun 16 14:46:07 stout kernel:  printing eip:
Jun 16 14:46:07 stout kernel: c0117ee6
Jun 16 14:46:07 stout kernel: *pde = 00000000
Jun 16 14:46:07 stout kernel: Oops: 0002
Jun 16 14:46:07 stout kernel: CPU:    0
Jun 16 14:46:07 stout kernel: EIP:    0010:[interruptible_sleep_on+38/80]    Tainted: PF
Jun 16 14:46:07 stout kernel: EIP:    0010:[<c0117ee6>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 16 14:46:07 stout kernel: EFLAGS: 00010082
Jun 16 14:46:07 stout kernel: eax: de7df628   ebx: 00000282   ecx: d51cff34   edx: 00000000
Jun 16 14:46:07 stout kernel: esi: de7df000   edi: 00000520   ebp: d51cff40   esp: d51cff2c
Jun 16 14:46:07 stout kernel: ds: 0018   es: 0018   ss: 0018
Jun 16 14:46:07 stout kernel: Process maseq (pid: 3398, stackpage=d51cf000)
Jun 16 14:46:07 stout kernel: Stack: 00000000 d51ce000 d51cff58 e2c1b3dd 00000296 d51cff58 e2c1b46b 00000009
Jun 16 14:46:07 stout kernel:        d51ce000 000012a0 d6edbbc0 000012a0 00000000 d3e8be20 ffffffea 000017c0
Jun 16 14:46:07 stout kernel:        c0138701 d3e8be20 40f652a8 000017c0 d3e8be40 c010a06a ddd2b9e0 800c5012
Jun 16 14:46:07 stout kernel: Call Trace: [scanner:__insmod_scanner_S.data_L2240+506237/36373459] [scanner:__insmod_scanner_S.data_L2240+506379/36373317] [sys_write+209/240] [handle_IRQ_event+58/128] [sys_ioctl+141/592]
Jun 16 14:46:07 stout kernel: Call Trace: [<e2c1b3dd>] [<e2c1b46b>] [<c0138701>] [<c010a06a>] [<c014594d>]
Jun 16 14:46:07 stout kernel:    [<c0108b73>]
Jun 16 14:46:07 stout kernel: Code: 89 4a 04 89 45 f8 89 55 f4 89 08 e8 ba f9 ff ff fa 8b 55 f8

>>EIP; c0117ee6 <interruptible_sleep_on+26/50>   <=====
Trace; e2c1b3dc <[emu10k1]emu10k1_audio_write+1ac/270>
Trace; e2c1b46a <[emu10k1]emu10k1_audio_write+23a/270>
Trace; c0138700 <sys_write+d0/f0>
Trace; c010a06a <handle_IRQ_event+3a/80>
Trace; c014594c <sys_ioctl+8c/250>
Trace; c0108b72 <system_call+32/40>
Code;  c0117ee6 <interruptible_sleep_on+26/50>
00000000 <_EIP>:
Code;  c0117ee6 <interruptible_sleep_on+26/50>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c0117ee8 <interruptible_sleep_on+28/50>
   3:   89 45 f8                  mov    %eax,0xfffffff8(%ebp)
Code;  c0117eec <interruptible_sleep_on+2c/50>
   6:   89 55 f4                  mov    %edx,0xfffffff4(%ebp)
Code;  c0117eee <interruptible_sleep_on+2e/50>
   9:   89 08                     mov    %ecx,(%eax)
Code;  c0117ef0 <interruptible_sleep_on+30/50>
   b:   e8 ba f9 ff ff            call   fffff9ca <_EIP+0xfffff9ca> c01178b0 <schedule+0/380>
Code;  c0117ef6 <interruptible_sleep_on+36/50>
  10:   fa                        cli    
Code;  c0117ef6 <interruptible_sleep_on+36/50>
  11:   8b 55 f8                  mov    0xfffffff8(%ebp),%edx


------------------- Oops 3: CVS from 15 June 02 and 2.4 patch in docs
                    directory

ksymoops 2.4.3 on i686 2.4.18-12mdk.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18-12mdk/ (default)
     -m /boot/System.map-2.4.18-12mdk (default)

Jun 16 15:44:18 stout kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000004
Jun 16 15:44:18 stout kernel:  printing eip:
Jun 16 15:44:18 stout kernel: c0117ee6
Jun 16 15:44:18 stout kernel: *pde = 00000000
Jun 16 15:44:18 stout kernel: Oops: 0002
Jun 16 15:44:18 stout kernel: CPU:    0
Jun 16 15:44:18 stout kernel: EIP:    0010:[interruptible_sleep_on+38/80]    Tainted: PF
Jun 16 15:44:18 stout kernel: EIP:    0010:[<c0117ee6>]    Tainted: PF
Using defaults from ksymoops -t elf32-i386 -a i386
Jun 16 15:44:18 stout kernel: EFLAGS: 00010082
Jun 16 15:44:18 stout kernel: eax: de249628   ebx: 00000282   ecx: c6fcbf34   edx: 00000000
Jun 16 15:44:18 stout kernel: esi: de249000   edi: 00000524   ebp: c6fcbf40   esp: c6fcbf2c
Jun 16 15:44:18 stout kernel: ds: 0018   es: 0018   ss: 0018
Jun 16 15:44:18 stout kernel: Process maseq (pid: 3539, stackpage=c6fcb000)
Jun 16 15:44:18 stout kernel: Stack: 00000000 c6fca000 c6fcbf58 e2c1b3dd 00000296 c6fcbf58 e2c1b46b 00000009
Jun 16 15:44:18 stout kernel:        c6fca000 0000129c d57adc00 0000129c 00000000 d9b40860 ffffffea 000017c0
Jun 16 15:44:18 stout kernel:        c0138701 d9b40860 40f652a4 000017c0 d9b40880 c010a06a d8b75680 800c5012
Jun 16 15:44:18 stout kernel: Call Trace: [scanner:__insmod_scanner_S.data_L2240+506237/36373459] [scanner:__insmod_scanner_S.data_L2240+506379/36373317] [sys_write+209/240] [handle_IRQ_event+58/128] [sys_ioctl+141/592]
Jun 16 15:44:18 stout kernel: Call Trace: [<e2c1b3dd>] [<e2c1b46b>] [<c0138701>] [<c010a06a>] [<c014594d>]
Jun 16 15:44:18 stout kernel:    [<c0108b73>]
Jun 16 15:44:18 stout kernel: Code: 89 4a 04 89 45 f8 89 55 f4 89 08 e8 ba f9 ff ff fa 8b 55 f8

>>EIP; c0117ee6 <interruptible_sleep_on+26/50>   <=====
Trace; e2c1b3dc <[emu10k1]emu10k1_audio_write+1ac/270>
Trace; e2c1b46a <[emu10k1]emu10k1_audio_write+23a/270>
Trace; c0138700 <sys_write+d0/f0>
Trace; c010a06a <handle_IRQ_event+3a/80>
Trace; c014594c <sys_ioctl+8c/250>
Trace; c0108b72 <system_call+32/40>
Code;  c0117ee6 <interruptible_sleep_on+26/50>
00000000 <_EIP>:
Code;  c0117ee6 <interruptible_sleep_on+26/50>   <=====
   0:   89 4a 04                  mov    %ecx,0x4(%edx)   <=====
Code;  c0117ee8 <interruptible_sleep_on+28/50>
   3:   89 45 f8                  mov    %eax,0xfffffff8(%ebp)
Code;  c0117eec <interruptible_sleep_on+2c/50>
   6:   89 55 f4                  mov    %edx,0xfffffff4(%ebp)
Code;  c0117eee <interruptible_sleep_on+2e/50>
   9:   89 08                     mov    %ecx,(%eax)
Code;  c0117ef0 <interruptible_sleep_on+30/50>
   b:   e8 ba f9 ff ff            call   fffff9ca <_EIP+0xfffff9ca> c01178b0 <schedule+0/380>
Code;  c0117ef6 <interruptible_sleep_on+36/50>
  10:   fa                        cli    
Code;  c0117ef6 <interruptible_sleep_on+36/50>
  11:   8b 55 f8                  mov    0xfffffff8(%ebp),%edx





