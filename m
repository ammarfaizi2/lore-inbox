Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267166AbSK2Wp7>; Fri, 29 Nov 2002 17:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267167AbSK2Wp7>; Fri, 29 Nov 2002 17:45:59 -0500
Received: from mta01-svc.ntlworld.com ([62.253.162.41]:10677 "EHLO
	mta01-svc.ntlworld.com") by vger.kernel.org with ESMTP
	id <S267166AbSK2Wp4>; Fri, 29 Nov 2002 17:45:56 -0500
From: Chris Rankin <cj.rankin@ntlworld.com>
Message-Id: <200211292253.gATMrJdN000759@twopit.underworld>
Subject: [OOPS] Linux-2.4.20 SMP deadlock. devfs-related?
To: linux-kernel@vger.kernel.org
Date: Fri, 29 Nov 2002 22:53:19 +0000 (GMT)
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've just rebuilt my 2.4.20 from scratch, since I remembered that I've
upgraded my compiler to 3.2.1 and I didn't do a "make mrproper" when I
built my previous 2.4.20 kerenel. It has not solved my problem, but
the deadlock is no longer happening in the mga.o module. Maybe the
true culprit is higher up the module stack?

Cheers,
Chris

Linux-2.4.20 SMP, 1 GB RAM, devfs, gcc-3.2.1, dual PIII-933 Coppermine.

ksymoops 2.4.8 on i686 2.4.20.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.20/ (default)
     -m /boot/System.map-2.4.20 (specified)

activating NMI Watchdog ... done.
testing NMI watchdog ... OK.
cpu: 0, clocks: 1332635, slice: 444211
cpu: 1, clocks: 1332635, slice: 444211
NMI Watchdog detected LOCKUP on CPU1, eip c01062eb, registers:
CPU:    1
EIP:    0010:[<c01062eb>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000087
eax: f6056f4c   ebx: f7e4aae0   ecx: 00000286   edx: f7e4aaf8
esi: f6056e00   edi: f5fe8960   ebp: f5fe8960   esp: f5d27ee8
ds: 0018   es: 0018   ss: 0018
Process alsactl (pid: 1333, stackpage=f5d27000)
Stack: fb2ceff0 00000038 000001f0 fb2d1c40 fb2cd350 f613b680 fb2ca22f f5d4dda0 
       f5fe8960 00000000 f60415e0 f5fe8960 f5d4dda0 f60415e8 c018c805 f5d4dda0 
       f5fe8960 c014d942 00000064 ffffffeb f5fe8960 ffffffe9 c027aa00 f5fe8960 
Call Trace:    [<fb2ceff0>] [<fb2d1c40>] [<fb2cd350>] [<fb2ca22f>] [<c018c805>]
  [<c014d942>] [<c0140e53>] [<c0140d78>] [<c0141153>] [<c010774f>]
Code: f3 90 81 38 00 00 00 01 75 f6 f0 81 28 00 00 00 01 0f 85 e2 


>>EIP; c01062eb <__write_lock_failed+7/20>   <=====

>>eax; f6056f4c <_end+35d22adc/38511bf0>
>>ebx; f7e4aae0 <_end+37b16670/38511bf0>
>>edx; f7e4aaf8 <_end+37b16688/38511bf0>
>>esi; f6056e00 <_end+35d22990/38511bf0>
>>edi; f5fe8960 <_end+35cb44f0/38511bf0>
>>ebp; f5fe8960 <_end+35cb44f0/38511bf0>
>>esp; f5d27ee8 <_end+359f3a78/38511bf0>

Trace; fb2ceff0 <[snd].text.lock.control+5/135>
Trace; fb2d1c40 <[snd]snd_fops+0/48>
Trace; fb2cd350 <[snd]snd_ctl_open+0/130>
Trace; fb2ca22f <[snd]snd_open+df/160>
Trace; c018c805 <devfs_open+195/210>
Trace; c014d942 <vfs_permission+82/140>
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

 NMI Watchdog detected LOCKUP on CPU1, eip c01062eb, registers:
CPU:    1
EIP:    0010:[<c01062eb>]    Not tainted
EFLAGS: 00000087
eax: f6056f4c   ebx: f71db5e0   ecx: 00000286   edx: f71db5f8
esi: f6056e00   edi: f6015520   ebp: f6015520   esp: f5d53ee8
ds: 0018   es: 0018   ss: 0018
Process aplay (pid: 1324, stackpage=f5d53000)
Stack: fb2ceff0 00000038 000001f0 fb2d1c40 fb2cd350 f613b680 fb2ca22f f5d4dda0 
       f6015520 00000000 f60415e0 f6015520 f5d4dda0 f60415e8 c018c805 f5d4dda0 
       f6015520 c014d942 00000064 ffffffeb f6015520 ffffffe9 c027aa00 f6015520 
Call Trace:    [<fb2ceff0>] [<fb2d1c40>] [<fb2cd350>] [<fb2ca22f>] [<c018c805>]
  [<c014d942>] [<c0140e53>] [<c0140d78>] [<c0141153>] [<c010774f>]
Code: f3 90 81 38 00 00 00 01 75 f6 f0 81 28 00 00 00 01 0f 85 e2 


>>EIP; c01062eb <__write_lock_failed+7/20>   <=====

>>eax; f6056f4c <_end+35d22adc/38511bf0>
>>ebx; f71db5e0 <_end+36ea7170/38511bf0>
>>edx; f71db5f8 <_end+36ea7188/38511bf0>
>>esi; f6056e00 <_end+35d22990/38511bf0>
>>edi; f6015520 <_end+35ce10b0/38511bf0>
>>ebp; f6015520 <_end+35ce10b0/38511bf0>
>>esp; f5d53ee8 <_end+35a1fa78/38511bf0>

Trace; fb2ceff0 <[snd].text.lock.control+5/135>
Trace; fb2d1c40 <[snd]snd_fops+0/48>
Trace; fb2cd350 <[snd]snd_ctl_open+0/130>
Trace; fb2ca22f <[snd]snd_open+df/160>
Trace; c018c805 <devfs_open+195/210>
Trace; c014d942 <vfs_permission+82/140>
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

