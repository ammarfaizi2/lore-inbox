Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267157AbSK2UuQ>; Fri, 29 Nov 2002 15:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267158AbSK2UuQ>; Fri, 29 Nov 2002 15:50:16 -0500
Received: from mta03-svc.ntlworld.com ([62.253.162.43]:27545 "EHLO
	mta03-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267157AbSK2UuN>; Fri, 29 Nov 2002 15:50:13 -0500
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200211292057.gATKvZsI001040@twopit.underworld>
Subject: [OOPS] 2.4.20-SMP with mga.o (rescued by NMI)
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Nov 2002 20:57:35 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have just booted into 2.4.20-SMP (1 GB RAM, devfs, with latest ALSA)
and the kernel deadlocked. The NMI bailed me out, but I think someone
must have scheduled while holding a spinlock in the mga module (or
something).

I'm back running on 2.4.19 for now, but did remember to pass the oops
through ksymoops while still in 2.4.20. Can anyone see the problem,
please?

Cheers,
Chris

ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (specified)

activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
cpu: 0, clocks: 1332736, slice: 444245
cpu: 1, clocks: 1332736, slice: 444245
NMI Watchdog detected LOCKUP on CPU0, eip c01062eb, registers:
CPU:    0
EIP:    0010:[<c01062eb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000087
eax: f7694d4c   ebx: f7e4a720   ecx: 00000286   edx: f7e4a738
esi: f7694c00   edi: f6fc5f60   ebp: f76fb440   esp: f6f9beec
ds: 0018   es: 0018   ss: 0018
Process alsactl (pid: 564, stackpage=f6f9b000)
Stack: f8932ae0 00000038 000001f0 f8935620 00000000 f892e22f f6fd0840 f76fb440 
       00000000 f6fcacc0 f76fb440 f6fd0840 f6fcacc8 c018c805 f6fd0840 f76fb440 
       f6f9bf84 c014e7d9 ffffffeb f76fb440 ffffffe9 c027aa00 f76fb440 f6fd0840 
Call Trace:    [<f8932ae0>] [<f8935620>] [<f892e22f>] [<c018c805>] [<c014e7d9>]
  [<c0140e53>] [<c0140d78>] [<c0141153>] [<c010774f>]
Code: f3 90 81 38 00 00 00 01 75 f6 f0 81 28 00 00 00 01 0f 85 e2 


>>EIP; c01062eb <__write_lock_failed+7/20>   <=====

>>eax; f7694d4c <_end+373608dc/38511bf0>
>>ebx; f7e4a720 <_end+37b162b0/38511bf0>
>>edx; f7e4a738 <_end+37b162c8/38511bf0>
>>esi; f7694c00 <_end+37360790/38511bf0>
>>edi; f6fc5f60 <_end+36c91af0/38511bf0>
>>ebp; f76fb440 <_end+373c6fd0/38511bf0>
>>esp; f6f9beec <_end+36c67a7c/38511bf0>

Trace; f8932ae0 <[mga]mga_unlock+b0/e0>
Trace; f8935620 <[mga]mga__clients_info+0/100>
Trace; f892e22f <[mga]mga_agp_enable+4f/a0>
Trace; c018c805 <devfs_open+195/210>
Trace; c014e7d9 <path_lookup+39/40>
Trace; c0140e53 <dentry_open+d3/1e0>
Trace; c0140d78 <filp_open+68/70>
Trace; c0141153 <sys_open+53/c0>
Trace; c010774f <system_call+33/38>

Code;  c01062eb <__write_lock_failed+7/20>
00000000 <_EIP>:
Code;  c01062eb <__write_lock_failed+7/20>   <=====
   0:   f3 90                     repz nop    <=====
Code;  c01062ed <__write_lock_failed+9/20>
   2:   81 38 00 00 00 01         cmpl   $0x1000000,(%eax)
Code;  c01062f3 <__write_lock_failed+f/20>
   8:   75 f6                     jne    0 <_EIP>
Code;  c01062f5 <__write_lock_failed+11/20>
   a:   f0 81 28 00 00 00 01      lock subl $0x1000000,(%eax)
Code;  c01062fc <__write_lock_failed+18/20>
  11:   0f 85 e2 00 00 00         jne    f9 <_EIP+0xf9> c01063e4 <copy_siginfo_to_user+74/c0>

 NMI Watchdog detected LOCKUP on CPU0, eip c01062eb, registers:
CPU:    0
EIP:    0010:[<c01062eb>]    Not tainted
EFLAGS: 00000087
eax: f7694d4c   ebx: f7e4a6e0   ecx: 00000286   edx: f7e4a6f8
esi: f7694c00   edi: f6fc5f60   ebp: f76fb1c0   esp: f716deec
ds: 0018   es: 0018   ss: 0018
Process alsactl (pid: 555, stackpage=f716d000)
Stack: f8932ae0 00000038 000001f0 f8935620 00000000 f892e22f f6fd0840 f76fb1c0 
       00000000 f6fcacc0 f76fb1c0 f6fd0840 f6fcacc8 c018c805 f6fd0840 f76fb1c0 
       f716df84 c014e7d9 ffffffeb f76fb1c0 ffffffe9 c027aa00 f76fb1c0 f6fd0840 
Call Trace:    [<f8932ae0>] [<f8935620>] [<f892e22f>] [<c018c805>] [<c014e7d9>]
  [<c0140e53>] [<c0140d78>] [<c0141153>] [<c010774f>]
Code: f3 90 81 38 00 00 00 01 75 f6 f0 81 28 00 00 00 01 0f 85 e2 


>>EIP; c01062eb <__write_lock_failed+7/20>   <=====

>>eax; f7694d4c <_end+373608dc/38511bf0>
>>ebx; f7e4a6e0 <_end+37b16270/38511bf0>
>>edx; f7e4a6f8 <_end+37b16288/38511bf0>
>>esi; f7694c00 <_end+37360790/38511bf0>
>>edi; f6fc5f60 <_end+36c91af0/38511bf0>
>>ebp; f76fb1c0 <_end+373c6d50/38511bf0>
>>esp; f716deec <_end+36e39a7c/38511bf0>

Trace; f8932ae0 <[mga]mga_unlock+b0/e0>
Trace; f8935620 <[mga]mga__clients_info+0/100>
Trace; f892e22f <[mga]mga_agp_enable+4f/a0>
Trace; c018c805 <devfs_open+195/210>
Trace; c014e7d9 <path_lookup+39/40>
Trace; c0140e53 <dentry_open+d3/1e0>
Trace; c0140d78 <filp_open+68/70>
Trace; c0141153 <sys_open+53/c0>
Trace; c010774f <system_call+33/38>

Code;  c01062eb <__write_lock_failed+7/20>
00000000 <_EIP>:
Code;  c01062eb <__write_lock_failed+7/20>   <=====
   0:   f3 90                     repz nop    <=====
Code;  c01062ed <__write_lock_failed+9/20>
   2:   81 38 00 00 00 01         cmpl   $0x1000000,(%eax)
Code;  c01062f3 <__write_lock_failed+f/20>
   8:   75 f6                     jne    0 <_EIP>
Code;  c01062f5 <__write_lock_failed+11/20>
   a:   f0 81 28 00 00 00 01      lock subl $0x1000000,(%eax)
Code;  c01062fc <__write_lock_failed+18/20>
  11:   0f 85 e2 00 00 00         jne    f9 <_EIP+0xf9> c01063e4 <copy_siginfo_to_user+74/c0>

