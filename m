Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313628AbSGDUSM>; Thu, 4 Jul 2002 16:18:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSGDUSL>; Thu, 4 Jul 2002 16:18:11 -0400
Received: from postfix3-2.free.fr ([213.228.0.169]:63953 "EHLO
	postfix3-2.free.fr") by vger.kernel.org with ESMTP
	id <S313628AbSGDUSF>; Thu, 4 Jul 2002 16:18:05 -0400
Date: Thu, 4 Jul 2002 23:22:40 +0200
To: linux-kernel@vger.kernel.org, Robert Love <rml@tech9.net>
Subject: oops with 2.4.18 and preempt patch, on SMP + ext3 machine
Message-ID: <20020704212240.GB659@bylbo.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Yann Dirson <ydirson@altern.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coming back home tonight, I found my machine in a bad state, as shown by the
attached kern.log extract (including last usual message and all lines until
reboot).  I had left the machine under "vlock -a", and the console was
filled with all sort of oops messages onscreen, all of which appear to be
listed in the log.

I first attempted to switch to another console (which (afterthought)
presumably lockvc still disallowed, although I interpreted the non-switching
as being caused by the kernel being hosed), and IIRC I got one more message
on-screen.
Looking at the times in the log, it looks like the failed assertion and
subsequent errors occured when I "woke up" the machine (just hitting a
modifier key to get my screen out of DPMS sleep).

I could sync with SYSRQ (as seen in the log), but the RO-remounting did not
complete for the 3rd device.  At this point I re-tried to sync and only got
messages telling my request had been seen, but nothing appeared to be really
done.  Then rebooted with SYSRQ-B.

The kernel is a kernel.org 2.4.18, with the addition of the "premptible
kernel" patch (preempt-kernel-rml-2.4.18-5.patch.gz, from Debian package
versionned 20020530-1).  I attach the config file (with comments stripped).

The included "<whatever> exited with preempt_count 1" also occur under
normal use (mainly at boot-time and halt-time), which may not be normal as
well.

The machine did not have anything special scheduled, just usual cron jobs,
which had let a 2.4.17 (with other patches, but not the preempt one) run
smoothly with a 3-months uptime.

Decoded version of oopses attached as well (I suppose the warning can be
ignored, I'm still running the same kernel).

The machine is a bi-pIII:

vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Pentium III (Coppermine)
stepping        : 10


Is there enough info here to start a bug hunt ?  Or has this been
investigated and fixed already ?

-- 
Yann Dirson    <ydirson@altern.org> |    Why make M$-Bill richer & richer ?
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
Pro:    <yann.dirson@fr.alcove.com> |  Freedom, Power, Stability, Gratuity
     http://ydirson.free.fr/        | Check <http://www.debian.org/>


====kern.log

Jul  4 09:22:16 localhost kernel: PPP Deflate Compression module registered
Jul  4 14:27:52 localhost kernel: APIC error on CPU1: 00(02)
Jul  4 18:29:33 localhost kernel: APIC error on CPU1: 02(08)
Jul  4 18:29:37 localhost kernel: APIC error on CPU1: 08(08)
Jul  4 18:32:52 localhost kernel: APIC error on CPU1: 08(08)
Jul  4 18:34:31 localhost kernel: APIC error on CPU1: 08(02)
Jul  4 20:53:12 localhost kernel: Assertion failure in journal_commit_transaction() at commit.c:79: "commit_transaction->t_state == T_RUNNING"
Jul  4 20:53:12 localhost kernel: invalid operand: 0000
Jul  4 20:53:12 localhost kernel: CPU:    0
Jul  4 20:53:12 localhost kernel: EIP:    0010:[journal_commit_transaction+234/3970]    Tainted: P 
Jul  4 20:53:12 localhost kernel: EFLAGS: 00210282
Jul  4 20:53:12 localhost kernel: eax: 00000070   ebx: f7bbf694   ecx: ffffff90   edx: f75ee000
Jul  4 20:53:12 localhost kernel: esi: f7bbf600   edi: f7bbf600   ebp: c3e0be60   esp: f75efe74
Jul  4 20:53:12 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:12 localhost kernel: Process kjournald (pid: 93, stackpage=f75ef000)
Jul  4 20:53:12 localhost kernel: Stack: c01ff3c0 c01ff390 c01ff387 0000004f c01ff440 f7bbf650 f7bbf600 f7bbf600 
Jul  4 20:53:12 localhost kernel:        00000000 00000000 c02b2800 f67e6ba0 f7bbf694 f7bbf650 f75ee000 00000000 
Jul  4 20:53:12 localhost kernel:        00000000 00000000 00000000 cdbe8ca0 f104c5e0 0001d214 f2ceea80 f67e6ba0 
Jul  4 20:53:12 localhost kernel: Call Trace: [update_process_times+32/152] [call_reschedule_interrupt+5/12] [kjournald+342/492] [commit_timeout+0/12] [kernel_thread+40/56] 
Jul  4 20:53:12 localhost kernel: 
Jul  4 20:53:12 localhost kernel: Code: 0f 0b 83 c4 14 c7 45 08 01 00 00 00 8b bc 24 48 01 00 00 8b 
Jul  4 20:53:12 localhost kernel:  <6>note: kjournald[93] exited with preempt_count 1
Jul  4 20:53:14 localhost kernel: Unable to handle kernel paging request at virtual address 000400d4
Jul  4 20:53:14 localhost kernel:  printing eip:
Jul  4 20:53:14 localhost kernel: c0166df7
Jul  4 20:53:14 localhost kernel: *pde = 00000000
Jul  4 20:53:14 localhost kernel: Oops: 0002
Jul  4 20:53:14 localhost kernel: CPU:    0
Jul  4 20:53:14 localhost kernel: EIP:    0010:[journal_get_write_access+35/92]    Tainted: P 
Jul  4 20:53:14 localhost kernel: EFLAGS: 00010282
Jul  4 20:53:14 localhost kernel: eax: cbc48b50   ebx: 00040040   ecx: 000400d4   edx: 00000000
Jul  4 20:53:14 localhost kernel: esi: e5fa9640   edi: cbc48b50   ebp: 000400d4   esp: f6b55ea4
Jul  4 20:53:14 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:14 localhost kernel: Process kdeinit (pid: 745, stackpage=f6b55000)
Jul  4 20:53:14 localhost kernel: Stack: 00000000 e5fa9640 f6b55efc f5a2e9a0 c0161546 e5fa9640 f6d2ff80 f6b55efc 
Jul  4 20:53:14 localhost kernel:        f5a2e9a0 e5fa9640 f6b55fa4 c01662b8 f75da800 e5fa9640 f75da800 c01615da 
Jul  4 20:53:14 localhost kernel:        e5fa9640 f5a2e9a0 f6b55efc 00000000 e5fa9640 f5a2e9a0 f6d2ff80 f33b9380 
Jul  4 20:53:14 localhost kernel: Call Trace: [ext3_reserve_inode_write+50/172] [start_this_handle+284/352] [ext3_mark_inode_dirty+26/52] [ext3_dirty_inode+163/276] [__mark_inode_dirty+50/188] 
Jul  4 20:53:14 localhost kernel:    [update_atime+75/80] [link_path_walk+2038/2328] [path_walk+26/28] [__user_walk+53/80] [sys_stat64+25/112] [system_call+51/56] 
Jul  4 20:53:14 localhost kernel: 
Jul  4 20:53:14 localhost kernel: Code: f0 ff 8b 94 00 00 00 0f 88 17 15 00 00 6a 00 57 56 e8 f7 f9 
Jul  4 20:53:14 localhost kernel:  <6>note: kdeinit[745] exited with preempt_count 1
Jul  4 20:53:15 localhost kernel: Unable to handle kernel paging request at virtual address 000400d4
Jul  4 20:53:15 localhost kernel:  printing eip:
Jul  4 20:53:15 localhost kernel: c0166df7
Jul  4 20:53:15 localhost kernel: *pde = 00000000
Jul  4 20:53:15 localhost kernel: Oops: 0002
Jul  4 20:53:15 localhost kernel: CPU:    0
Jul  4 20:53:15 localhost kernel: EIP:    0010:[journal_get_write_access+35/92]    Tainted: P 
Jul  4 20:53:15 localhost kernel: EFLAGS: 00210286
Jul  4 20:53:15 localhost kernel: eax: cccc1fd0   ebx: 00040040   ecx: 000400d4   edx: 00000000
Jul  4 20:53:15 localhost kernel: esi: e655f7c0   edi: cccc1fd0   ebp: 000400d4   esp: d5e01e9c
Jul  4 20:53:15 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:15 localhost kernel: Process wander (pid: 3518, stackpage=d5e01000)
Jul  4 20:53:15 localhost kernel: Stack: 00000000 e655f7c0 d5e01ef4 f3212480 c0161546 e655f7c0 f73d8c60 d5e01ef4 
Jul  4 20:53:15 localhost kernel:        f3212480 e655f7c0 00000008 c01662b8 f75da800 e655f7c0 f75da800 c01615da 
Jul  4 20:53:15 localhost kernel:        e655f7c0 f3212480 d5e01ef4 00000000 e655f7c0 f3212480 f73d8c60 f5806880 
Jul  4 20:53:15 localhost kernel: Call Trace: [ext3_reserve_inode_write+50/172] [start_this_handle+284/352] [ext3_mark_inode_dirty+26/52] [ext3_dirty_inode+163/276] [__mark_inode_dirty+50/188] 
Jul  4 20:53:15 localhost kernel:    [update_atime+75/80] [do_generic_file_read+1159/1172] [generic_file_read+126/300] [file_read_actor+0/224] [sys_read+143/312] [system_call+51/56] 
Jul  4 20:53:15 localhost kernel: 
Jul  4 20:53:15 localhost kernel: Code: f0 ff 8b 94 00 00 00 0f 88 17 15 00 00 6a 00 57 56 e8 f7 f9 
Jul  4 20:53:15 localhost kernel:  <6>note: wander[3518] exited with preempt_count 1
Jul  4 20:53:16 localhost kernel: Unable to handle kernel paging request at virtual address 000400d4
Jul  4 20:53:16 localhost kernel:  printing eip:
Jul  4 20:53:16 localhost kernel: c0166df7
Jul  4 20:53:16 localhost kernel: *pde = 00000000
Jul  4 20:53:16 localhost kernel: Oops: 0002
Jul  4 20:53:16 localhost kernel: CPU:    1
Jul  4 20:53:16 localhost kernel: EIP:    0010:[journal_get_write_access+35/92]    Tainted: P 
Jul  4 20:53:16 localhost kernel: EFLAGS: 00010296
Jul  4 20:53:16 localhost kernel: eax: cde83910   ebx: 00040040   ecx: 000400d4   edx: 00000000
Jul  4 20:53:16 localhost kernel: esi: e655f7e0   edi: cde83910   ebp: 000400d4   esp: f72b9e60
Jul  4 20:53:16 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:16 localhost kernel: Process XFree86 (pid: 700, stackpage=f72b9000)
Jul  4 20:53:16 localhost kernel: Stack: 00000000 e655f7e0 f72b9eb8 f3f04680 c0161546 e655f7e0 f6fef260 f72b9eb8 
Jul  4 20:53:16 localhost kernel:        f3f04680 e655f7e0 f72b9f88 c01662b8 f75da800 e655f7e0 f75da800 c01615da 
Jul  4 20:53:16 localhost kernel:        e655f7e0 f3f04680 f72b9eb8 00000000 e655f7e0 f3f04680 f6fef260 f3efb980 
Jul  4 20:53:16 localhost kernel: Call Trace: [ext3_reserve_inode_write+50/172] [start_this_handle+284/352] [ext3_mark_inode_dirty+26/52] [ext3_dirty_inode+163/276] [__mark_inode_dirty+50/188] 
Jul  4 20:53:16 localhost kernel:    [update_atime+75/80] [link_path_walk+1029/2328] [sock_recvmsg+61/184] [path_walk+26/28] [open_namei+131/1396] [filp_open+59/92] 
Jul  4 20:53:16 localhost kernel:    [sys_open+59/248] [system_call+51/56] 
Jul  4 20:53:16 localhost kernel: 
Jul  4 20:53:16 localhost kernel: Code: f0 ff 8b 94 00 00 00 0f 88 17 15 00 00 6a 00 57 56 e8 f7 f9 
Jul  4 20:53:16 localhost kernel:  <6>note: XFree86[700] exited with preempt_count 1
Jul  4 20:53:17 localhost kernel: Assertion failure in journal_commit_transaction() at commit.c:79: "commit_transaction->t_state == T_RUNNING"
Jul  4 20:53:17 localhost kernel: invalid operand: 0000
Jul  4 20:53:17 localhost kernel: CPU:    0
Jul  4 20:53:17 localhost kernel: EIP:    0010:[journal_commit_transaction+234/3970]    Tainted: P 
Jul  4 20:53:17 localhost kernel: EFLAGS: 00210282
Jul  4 20:53:17 localhost kernel: eax: 00000070   ebx: f75da894   ecx: ffffff90   edx: f7528000
Jul  4 20:53:17 localhost kernel: esi: f75da800   edi: f75da800   ebp: c3e0b3e0   esp: f7529e74
Jul  4 20:53:17 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:17 localhost kernel: Process kjournald (pid: 94, stackpage=f7529000)
Jul  4 20:53:17 localhost kernel: Stack: c01ff3c0 c01ff390 c01ff387 0000004f c01ff440 f75da850 f75da800 f75da800 
Jul  4 20:53:17 localhost kernel:        00000000 00000000 f7529eac f68127e0 f75da894 f75da850 f7528000 00000000 
Jul  4 20:53:17 localhost kernel:        00000000 00000000 00000000 00000000 f104cd00 00038df6 f2f8da40 f67f15c0 
Jul  4 20:53:17 localhost kernel: Call Trace: [schedule+1237/1492] [kjournald+342/492] [commit_timeout+0/12] [kernel_thread+40/56] 
Jul  4 20:53:17 localhost kernel: 
Jul  4 20:53:17 localhost kernel: Code: 0f 0b 83 c4 14 c7 45 08 01 00 00 00 8b bc 24 48 01 00 00 8b 
Jul  4 20:53:17 localhost kernel:  <6>note: kjournald[94] exited with preempt_count 1
Jul  4 21:04:58 localhost kernel: SysRq : Emergency Sync
Jul  4 21:04:58 localhost kernel: Syncing device 03:02 ... OK
Jul  4 21:04:58 localhost kernel: Syncing device 03:03 ... OK
Jul  4 21:04:58 localhost kernel: Syncing device 03:05 ... OK
Jul  4 21:04:58 localhost kernel: Syncing device 03:06 ... OK
Jul  4 21:04:58 localhost kernel: Syncing device 03:07 ... OK
Jul  4 21:04:58 localhost kernel: Done.

==== decoded:

ksymoops 2.4.5 on i686 2.4.18+preempt.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.18+preempt/ (default)
     -m /boot/System.map-2.4.18+preempt (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Jul  4 20:53:12 localhost kernel: invalid operand: 0000
Jul  4 20:53:12 localhost kernel: CPU:    0
Jul  4 20:53:12 localhost kernel: EIP:    0010:[journal_commit_transaction+234/3970]    Tainted: P 
Jul  4 20:53:12 localhost kernel: EFLAGS: 00210282
Jul  4 20:53:12 localhost kernel: eax: 00000070   ebx: f7bbf694   ecx: ffffff90   edx: f75ee000
Jul  4 20:53:12 localhost kernel: esi: f7bbf600   edi: f7bbf600   ebp: c3e0be60   esp: f75efe74
Jul  4 20:53:12 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:12 localhost kernel: Process kjournald (pid: 93, stackpage=f75ef000)
Jul  4 20:53:12 localhost kernel: Stack: c01ff3c0 c01ff390 c01ff387 0000004f c01ff440 f7bbf650 f7bbf600 f7bbf600 
Jul  4 20:53:12 localhost kernel:        00000000 00000000 c02b2800 f67e6ba0 f7bbf694 f7bbf650 f75ee000 00000000 
Jul  4 20:53:12 localhost kernel:        00000000 00000000 00000000 cdbe8ca0 f104c5e0 0001d214 f2ceea80 f67e6ba0 
Jul  4 20:53:12 localhost kernel: Call Trace: [update_process_times+32/152] [call_reschedule_interrupt+5/12] [kjournald+342/492] [commit_timeout+0/12] [kernel_thread+40/56] 
Jul  4 20:53:12 localhost kernel: Code: 0f 0b 83 c4 14 c7 45 08 01 00 00 00 8b bc 24 48 01 00 00 8b 
Using defaults from ksymoops -t elf32-i386 -a i386


>>ebx; f7bbf694 <_end+378f9f64/3853a8d0>
>>ecx; ffffff90 <END_OF_CODE+77e630d/????>
>>edx; f75ee000 <_end+373288d0/3853a8d0>
>>esi; f7bbf600 <_end+378f9ed0/3853a8d0>
>>edi; f7bbf600 <_end+378f9ed0/3853a8d0>
>>ebp; c3e0be60 <_end+3b46730/3853a8d0>
>>esp; f75efe74 <_end+3732a744/3853a8d0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 14                  add    $0x14,%esp
Code;  00000005 Before first symbol
   5:   c7 45 08 01 00 00 00      movl   $0x1,0x8(%ebp)
Code;  0000000c Before first symbol
   c:   8b bc 24 48 01 00 00      mov    0x148(%esp,1),%edi
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax

Jul  4 20:53:14 localhost kernel: Unable to handle kernel paging request at virtual address 000400d4
Jul  4 20:53:14 localhost kernel: c0166df7
Jul  4 20:53:14 localhost kernel: *pde = 00000000
Jul  4 20:53:14 localhost kernel: Oops: 0002
Jul  4 20:53:14 localhost kernel: CPU:    0
Jul  4 20:53:14 localhost kernel: EIP:    0010:[journal_get_write_access+35/92]    Tainted: P 
Jul  4 20:53:14 localhost kernel: EFLAGS: 00010282
Jul  4 20:53:14 localhost kernel: eax: cbc48b50   ebx: 00040040   ecx: 000400d4   edx: 00000000
Jul  4 20:53:14 localhost kernel: esi: e5fa9640   edi: cbc48b50   ebp: 000400d4   esp: f6b55ea4
Jul  4 20:53:14 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:14 localhost kernel: Process kdeinit (pid: 745, stackpage=f6b55000)
Jul  4 20:53:14 localhost kernel: Stack: 00000000 e5fa9640 f6b55efc f5a2e9a0 c0161546 e5fa9640 f6d2ff80 f6b55efc 
Jul  4 20:53:14 localhost kernel:        f5a2e9a0 e5fa9640 f6b55fa4 c01662b8 f75da800 e5fa9640 f75da800 c01615da 
Jul  4 20:53:14 localhost kernel:        e5fa9640 f5a2e9a0 f6b55efc 00000000 e5fa9640 f5a2e9a0 f6d2ff80 f33b9380 
Jul  4 20:53:14 localhost kernel: Call Trace: [ext3_reserve_inode_write+50/172] [start_this_handle+284/352] [ext3_mark_inode_dirty+26/52] [ext3_dirty_inode+163/276] [__mark_inode_dirty+50/188] 
Jul  4 20:53:14 localhost kernel: Code: f0 ff 8b 94 00 00 00 0f 88 17 15 00 00 6a 00 57 56 e8 f7 f9 


>>eax; cbc48b50 <_end+b983420/3853a8d0>
>>ebx; 00040040 Before first symbol
>>ecx; 000400d4 Before first symbol
>>esi; e5fa9640 <_end+25ce3f10/3853a8d0>
>>edi; cbc48b50 <_end+b983420/3853a8d0>
>>ebp; 000400d4 Before first symbol
>>esp; f6b55ea4 <_end+36890774/3853a8d0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f0 ff 8b 94 00 00 00      lock decl 0x94(%ebx)
Code;  00000007 Before first symbol
   7:   0f 88 17 15 00 00         js     1524 <_EIP+0x1524> 00001524 Before first symbol
Code;  0000000d Before first symbol
   d:   6a 00                     push   $0x0
Code;  0000000f Before first symbol
   f:   57                        push   %edi
Code;  00000010 Before first symbol
  10:   56                        push   %esi
Code;  00000011 Before first symbol
  11:   e8 f7 f9 00 00            call   fa0d <_EIP+0xfa0d> 0000fa0d Before first symbol

Jul  4 20:53:15 localhost kernel: Unable to handle kernel paging request at virtual address 000400d4
Jul  4 20:53:15 localhost kernel: c0166df7
Jul  4 20:53:15 localhost kernel: *pde = 00000000
Jul  4 20:53:15 localhost kernel: Oops: 0002
Jul  4 20:53:15 localhost kernel: CPU:    0
Jul  4 20:53:15 localhost kernel: EIP:    0010:[journal_get_write_access+35/92]    Tainted: P 
Jul  4 20:53:15 localhost kernel: EFLAGS: 00210286
Jul  4 20:53:15 localhost kernel: eax: cccc1fd0   ebx: 00040040   ecx: 000400d4   edx: 00000000
Jul  4 20:53:15 localhost kernel: esi: e655f7c0   edi: cccc1fd0   ebp: 000400d4   esp: d5e01e9c
Jul  4 20:53:15 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:15 localhost kernel: Process wander (pid: 3518, stackpage=d5e01000)
Jul  4 20:53:15 localhost kernel: Stack: 00000000 e655f7c0 d5e01ef4 f3212480 c0161546 e655f7c0 f73d8c60 d5e01ef4 
Jul  4 20:53:15 localhost kernel:        f3212480 e655f7c0 00000008 c01662b8 f75da800 e655f7c0 f75da800 c01615da 
Jul  4 20:53:15 localhost kernel:        e655f7c0 f3212480 d5e01ef4 00000000 e655f7c0 f3212480 f73d8c60 f5806880 
Jul  4 20:53:15 localhost kernel: Call Trace: [ext3_reserve_inode_write+50/172] [start_this_handle+284/352] [ext3_mark_inode_dirty+26/52] [ext3_dirty_inode+163/276] [__mark_inode_dirty+50/188] 
Jul  4 20:53:15 localhost kernel: Code: f0 ff 8b 94 00 00 00 0f 88 17 15 00 00 6a 00 57 56 e8 f7 f9 


>>eax; cccc1fd0 <_end+c9fc8a0/3853a8d0>
>>ebx; 00040040 Before first symbol
>>ecx; 000400d4 Before first symbol
>>esi; e655f7c0 <_end+2629a090/3853a8d0>
>>edi; cccc1fd0 <_end+c9fc8a0/3853a8d0>
>>ebp; 000400d4 Before first symbol
>>esp; d5e01e9c <_end+15b3c76c/3853a8d0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f0 ff 8b 94 00 00 00      lock decl 0x94(%ebx)
Code;  00000007 Before first symbol
   7:   0f 88 17 15 00 00         js     1524 <_EIP+0x1524> 00001524 Before first symbol
Code;  0000000d Before first symbol
   d:   6a 00                     push   $0x0
Code;  0000000f Before first symbol
   f:   57                        push   %edi
Code;  00000010 Before first symbol
  10:   56                        push   %esi
Code;  00000011 Before first symbol
  11:   e8 f7 f9 00 00            call   fa0d <_EIP+0xfa0d> 0000fa0d Before first symbol

Jul  4 20:53:16 localhost kernel: Unable to handle kernel paging request at virtual address 000400d4
Jul  4 20:53:16 localhost kernel: c0166df7
Jul  4 20:53:16 localhost kernel: *pde = 00000000
Jul  4 20:53:16 localhost kernel: Oops: 0002
Jul  4 20:53:16 localhost kernel: CPU:    1
Jul  4 20:53:16 localhost kernel: EIP:    0010:[journal_get_write_access+35/92]    Tainted: P 
Jul  4 20:53:16 localhost kernel: EFLAGS: 00010296
Jul  4 20:53:16 localhost kernel: eax: cde83910   ebx: 00040040   ecx: 000400d4   edx: 00000000
Jul  4 20:53:16 localhost kernel: esi: e655f7e0   edi: cde83910   ebp: 000400d4   esp: f72b9e60
Jul  4 20:53:16 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:16 localhost kernel: Process XFree86 (pid: 700, stackpage=f72b9000)
Jul  4 20:53:16 localhost kernel: Stack: 00000000 e655f7e0 f72b9eb8 f3f04680 c0161546 e655f7e0 f6fef260 f72b9eb8 
Jul  4 20:53:16 localhost kernel:        f3f04680 e655f7e0 f72b9f88 c01662b8 f75da800 e655f7e0 f75da800 c01615da 
Jul  4 20:53:16 localhost kernel:        e655f7e0 f3f04680 f72b9eb8 00000000 e655f7e0 f3f04680 f6fef260 f3efb980 
Jul  4 20:53:16 localhost kernel: Call Trace: [ext3_reserve_inode_write+50/172] [start_this_handle+284/352] [ext3_mark_inode_dirty+26/52] [ext3_dirty_inode+163/276] [__mark_inode_dirty+50/188] 
Jul  4 20:53:16 localhost kernel: Code: f0 ff 8b 94 00 00 00 0f 88 17 15 00 00 6a 00 57 56 e8 f7 f9 


>>eax; cde83910 <_end+dbbe1e0/3853a8d0>
>>ebx; 00040040 Before first symbol
>>ecx; 000400d4 Before first symbol
>>esi; e655f7e0 <_end+2629a0b0/3853a8d0>
>>edi; cde83910 <_end+dbbe1e0/3853a8d0>
>>ebp; 000400d4 Before first symbol
>>esp; f72b9e60 <_end+36ff4730/3853a8d0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   f0 ff 8b 94 00 00 00      lock decl 0x94(%ebx)
Code;  00000007 Before first symbol
   7:   0f 88 17 15 00 00         js     1524 <_EIP+0x1524> 00001524 Before first symbol
Code;  0000000d Before first symbol
   d:   6a 00                     push   $0x0
Code;  0000000f Before first symbol
   f:   57                        push   %edi
Code;  00000010 Before first symbol
  10:   56                        push   %esi
Code;  00000011 Before first symbol
  11:   e8 f7 f9 00 00            call   fa0d <_EIP+0xfa0d> 0000fa0d Before first symbol

Jul  4 20:53:17 localhost kernel: invalid operand: 0000
Jul  4 20:53:17 localhost kernel: CPU:    0
Jul  4 20:53:17 localhost kernel: EIP:    0010:[journal_commit_transaction+234/3970]    Tainted: P 
Jul  4 20:53:17 localhost kernel: EFLAGS: 00210282
Jul  4 20:53:17 localhost kernel: eax: 00000070   ebx: f75da894   ecx: ffffff90   edx: f7528000
Jul  4 20:53:17 localhost kernel: esi: f75da800   edi: f75da800   ebp: c3e0b3e0   esp: f7529e74
Jul  4 20:53:17 localhost kernel: ds: 0018   es: 0018   ss: 0018
Jul  4 20:53:17 localhost kernel: Process kjournald (pid: 94, stackpage=f7529000)
Jul  4 20:53:17 localhost kernel: Stack: c01ff3c0 c01ff390 c01ff387 0000004f c01ff440 f75da850 f75da800 f75da800 
Jul  4 20:53:17 localhost kernel:        00000000 00000000 f7529eac f68127e0 f75da894 f75da850 f7528000 00000000 
Jul  4 20:53:17 localhost kernel:        00000000 00000000 00000000 00000000 f104cd00 00038df6 f2f8da40 f67f15c0 
Jul  4 20:53:17 localhost kernel: Call Trace: [schedule+1237/1492] [kjournald+342/492] [commit_timeout+0/12] [kernel_thread+40/56] 
Jul  4 20:53:17 localhost kernel: Code: 0f 0b 83 c4 14 c7 45 08 01 00 00 00 8b bc 24 48 01 00 00 8b 


>>ebx; f75da894 <_end+37315164/3853a8d0>
>>ecx; ffffff90 <END_OF_CODE+77e630d/????>
>>edx; f7528000 <_end+372628d0/3853a8d0>
>>esi; f75da800 <_end+373150d0/3853a8d0>
>>edi; f75da800 <_end+373150d0/3853a8d0>
>>ebp; c3e0b3e0 <_end+3b45cb0/3853a8d0>
>>esp; f7529e74 <_end+37264744/3853a8d0>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 14                  add    $0x14,%esp
Code;  00000005 Before first symbol
   5:   c7 45 08 01 00 00 00      movl   $0x1,0x8(%ebp)
Code;  0000000c Before first symbol
   c:   8b bc 24 48 01 00 00      mov    0x148(%esp,1),%edi
Code;  00000013 Before first symbol
  13:   8b 00                     mov    (%eax),%eax


1 warning issued.  Results may not be reliable.


==== config

CONFIG_X86=y
CONFIG_ISA=y
CONFIG_UID16=y

CONFIG_EXPERIMENTAL=y

CONFIG_MODULES=y
CONFIG_MODVERSIONS=y
CONFIG_KMOD=y

CONFIG_MPENTIUMIII=y
CONFIG_X86_WP_WORKS_OK=y
CONFIG_X86_INVLPG=y
CONFIG_X86_CMPXCHG=y
CONFIG_X86_XADD=y
CONFIG_X86_BSWAP=y
CONFIG_X86_POPAD_OK=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_X86_L1_CACHE_SHIFT=5
CONFIG_X86_TSC=y
CONFIG_X86_GOOD_APIC=y
CONFIG_X86_PGE=y
CONFIG_X86_USE_PPRO_CHECKSUM=y
CONFIG_MICROCODE=m
CONFIG_X86_MSR=m
CONFIG_X86_CPUID=m
CONFIG_HIGHMEM4G=y
CONFIG_HIGHMEM=y
CONFIG_MTRR=y
CONFIG_SMP=y
CONFIG_PREEMPT=y
CONFIG_HAVE_DEC_LOCK=y

CONFIG_NET=y
CONFIG_X86_IO_APIC=y
CONFIG_X86_LOCAL_APIC=y
CONFIG_PCI=y
CONFIG_PCI_GOANY=y
CONFIG_PCI_BIOS=y
CONFIG_PCI_DIRECT=y
CONFIG_PCI_NAMES=y
CONFIG_SYSVIPC=y
CONFIG_SYSCTL=y
CONFIG_KCORE_ELF=y
CONFIG_BINFMT_ELF=y
CONFIG_BINFMT_MISC=m
CONFIG_PM=y
CONFIG_APM=m
CONFIG_APM_RTC_IS_GMT=y


CONFIG_PARPORT=m
CONFIG_PARPORT_PC=m
CONFIG_PARPORT_PC_CML1=m
CONFIG_PARPORT_SERIAL=m
CONFIG_PARPORT_PC_FIFO=y
CONFIG_PARPORT_1284=y


CONFIG_BLK_DEV_FD=m
CONFIG_BLK_DEV_LOOP=m
CONFIG_BLK_DEV_NBD=m
CONFIG_BLK_DEV_RAM=m
CONFIG_BLK_DEV_RAM_SIZE=4096


CONFIG_PACKET=m
CONFIG_PACKET_MMAP=y
CONFIG_NETFILTER=y
CONFIG_UNIX=y
CONFIG_INET=y
CONFIG_SYN_COOKIES=y

CONFIG_IP_NF_CONNTRACK=m
CONFIG_IP_NF_FTP=m
CONFIG_IP_NF_IRC=m
CONFIG_IP_NF_IPTABLES=m
CONFIG_IP_NF_MATCH_MARK=m
CONFIG_IP_NF_MATCH_MULTIPORT=m
CONFIG_IP_NF_MATCH_STATE=m
CONFIG_IP_NF_MATCH_OWNER=m
CONFIG_IP_NF_FILTER=m
CONFIG_IP_NF_TARGET_REJECT=m
CONFIG_IP_NF_TARGET_LOG=m


CONFIG_NET_SCHED=y
CONFIG_NET_SCH_CBQ=m
CONFIG_NET_SCH_PRIO=m
CONFIG_NET_SCH_RED=m
CONFIG_NET_SCH_SFQ=m
CONFIG_NET_SCH_TBF=m
CONFIG_NET_SCH_GRED=m
CONFIG_NET_SCH_DSMARK=m
CONFIG_NET_SCH_INGRESS=m
CONFIG_NET_QOS=y
CONFIG_NET_ESTIMATOR=y


CONFIG_IDE=y

CONFIG_BLK_DEV_IDE=y

CONFIG_BLK_DEV_IDEDISK=y
CONFIG_BLK_DEV_IDECD=m

CONFIG_BLK_DEV_IDEPCI=y
CONFIG_BLK_DEV_IDEDMA_PCI=y
CONFIG_BLK_DEV_ADMA=y
CONFIG_IDEDMA_PCI_AUTO=y
CONFIG_BLK_DEV_IDEDMA=y
CONFIG_BLK_DEV_VIA82CXXX=y
CONFIG_IDEDMA_AUTO=y
CONFIG_BLK_DEV_IDE_MODES=y

CONFIG_SCSI=m

CONFIG_BLK_DEV_SD=m
CONFIG_SD_EXTRA_DEVS=2

CONFIG_SCSI_DEBUG_QUEUES=y

CONFIG_SCSI_PPA=m


CONFIG_NETDEVICES=y

CONFIG_DUMMY=m

CONFIG_NET_ETHERNET=y
CONFIG_NET_PCI=y
CONFIG_NE2K_PCI=m
CONFIG_8139TOO=m

CONFIG_PPP=m
CONFIG_PPP_ASYNC=m
CONFIG_PPP_DEFLATE=m
CONFIG_PPP_BSDCOMP=m
CONFIG_SLIP=m
CONFIG_SLIP_COMPRESSED=y
CONFIG_SLIP_SMART=y


CONFIG_INPUT=m
CONFIG_INPUT_JOYDEV=m

CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_SERIAL=m
CONFIG_UNIX98_PTYS=y
CONFIG_UNIX98_PTY_COUNT=256
CONFIG_PRINTER=m
CONFIG_PPDEV=m


CONFIG_MOUSE=y
CONFIG_PSMOUSE=y

CONFIG_INPUT_GAMEPORT=m

CONFIG_INPUT_ANALOG=m

CONFIG_WATCHDOG=y
CONFIG_SOFT_WATCHDOG=y
CONFIG_NVRAM=m
CONFIG_RTC=y

CONFIG_AGP=m
CONFIG_AGP_VIA=y
CONFIG_DRM=y

CONFIG_DRM_NEW=y
CONFIG_DRM_MGA=m


CONFIG_AFFS_FS=m
CONFIG_HFS_FS=m
CONFIG_EXT3_FS=y
CONFIG_JBD=y
CONFIG_FAT_FS=m
CONFIG_VFAT_FS=m
CONFIG_TMPFS=y
CONFIG_ISO9660_FS=m
CONFIG_JOLIET=y
CONFIG_ZISOFS=y
CONFIG_MINIX_FS=m
CONFIG_PROC_FS=y
CONFIG_DEVPTS_FS=y
CONFIG_EXT2_FS=y
CONFIG_UDF_FS=m

CONFIG_NFS_FS=m
CONFIG_NFS_V3=y
CONFIG_NFSD=m
CONFIG_NFSD_V3=y
CONFIG_SUNRPC=m
CONFIG_LOCKD=m
CONFIG_LOCKD_V4=y
CONFIG_ZISOFS_FS=m
CONFIG_ZLIB_FS_INFLATE=m

CONFIG_PARTITION_ADVANCED=y
CONFIG_MSDOS_PARTITION=y
CONFIG_NLS=y

CONFIG_NLS_DEFAULT="iso8859-15"
CONFIG_NLS_CODEPAGE_437=m
CONFIG_NLS_CODEPAGE_850=m
CONFIG_NLS_ISO8859_1=m
CONFIG_NLS_ISO8859_2=m
CONFIG_NLS_ISO8859_5=m
CONFIG_NLS_ISO8859_15=m
CONFIG_NLS_UTF8=m

CONFIG_VGA_CONSOLE=y
CONFIG_VIDEO_SELECT=y

CONFIG_FB=y
CONFIG_DUMMY_CONSOLE=y
CONFIG_VIDEO_SELECT=y
CONFIG_FB_MATROX=m
CONFIG_FB_MATROX_G100=y
CONFIG_FBCON_CFB8=m
CONFIG_FBCON_CFB16=m
CONFIG_FBCON_CFB24=m
CONFIG_FBCON_CFB32=m
CONFIG_FBCON_FONTS=y
CONFIG_FONT_8x8=y
CONFIG_FONT_8x16=y
CONFIG_FONT_SUN12x22=y

CONFIG_SOUND=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_GUS=m
CONFIG_SOUND_GUSMAX=y

CONFIG_USB=m

CONFIG_USB_DEVICEFS=y

CONFIG_USB_UHCI=m


CONFIG_DEBUG_KERNEL=y
CONFIG_MAGIC_SYSRQ=y
