Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263893AbRFDVhM>; Mon, 4 Jun 2001 17:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263900AbRFDVhB>; Mon, 4 Jun 2001 17:37:01 -0400
Received: from esteel10.client.dti.net ([209.73.14.10]:52405 "EHLO
	shookay.e-steel.com") by vger.kernel.org with ESMTP
	id <S263893AbRFDVgw>; Mon, 4 Jun 2001 17:36:52 -0400
Date: Mon, 4 Jun 2001 17:36:46 -0400
From: Mathieu Chouquet-Stringer <mchouque@e-steel.com>
To: linux-kernel@vger.kernel.org
Subject: Oops while unmounting a reiserfs partition
Message-ID: <20010604173646.A2530@shookay.e-steel.com>
Mail-Followup-To: Mathieu Chouquet-Stringer <mchouque@e-steel.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hello!

I just mkreiserfsed a new partition (a 50g hardware raid0 array, I know
this is just a testing machine), mounted it, and then unmounted it, and
OOPS! My kernel version is plain 2.4.5...
If you need more information, let me know.

Jun  4 17:25:03 nynetops03 kernel: reiserfs: checking transaction log (device 08:11) ...
Jun  4 17:25:07 nynetops03 kernel: Using r5 hash to sort names
Jun  4 17:25:07 nynetops03 kernel: ReiserFS version 3.6.25
Jun  4 17:26:11 nynetops03 kernel: journal_begin called without kernel lock held
Jun  4 17:26:11 nynetops03 kernel: kernel BUG at journal.c:423!
Jun  4 17:26:11 nynetops03 kernel: invalid operand: 0000
Jun  4 17:26:11 nynetops03 kernel: CPU:    1
Jun  4 17:26:11 nynetops03 kernel: EIP:    0010:[reiserfs_check_lock_depth+56/64]
Jun  4 17:26:11 nynetops03 kernel: EIP:    0010:[<c018bb98>]
Jun  4 17:26:11 nynetops03 kernel: EFLAGS: 00010282
Jun  4 17:26:11 nynetops03 kernel: eax: 0000001d   ebx: d8e15f24   ecx: 00000001   edx: 00000001
Jun  4 17:26:11 nynetops03 kernel: esi: df9c5400   edi: 00000000   ebp: 3b1bfcf3   esp: d8e15eac
Jun  4 17:26:11 nynetops03 kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 17:26:11 nynetops03 kernel: Process umount (pid: 4577, stackpage=d8e15000)
Jun  4 17:26:11 nynetops03 kernel: Stack: c02678b3 c0267a44 000001a7 c018e2cf c0268a61 00000000 d7e75250 000000e8 
Jun  4 17:26:11 nynetops03 kernel:        df731000 40173000 d8e15f60 00000000 00000018 d8e15f24 df9c5400 c02a8620 
Jun  4 17:26:11 nynetops03 kernel:        c02a8698 c018e516 d8e15f24 df9c5400 0000000a 00000000 c017ffdc d8e15f24 
Jun  4 17:26:11 nynetops03 kernel: Call Trace: [do_journal_begin_r+31/560] [journal_begin+22/32] [reiserfs_put_super+28/224] [iput+63/368] [fsync_super+180/192] [kill_super+162/288] [path_release+41/48] 
Jun  4 17:26:11 nynetops03 kernel: Call Trace: [<c018e2cf>] [<c018e516>] [<c017ffdc>] [<c014bf3f>] [<c0137494>] [<c013bd72>] [<c0140e79>] 
Jun  4 17:26:11 nynetops03 kernel:        [sys_umount+301/352] [sys_munmap+51/80] [sys_oldumount+12/16] [system_call+51/56] 
Jun  4 17:26:11 nynetops03 kernel:        [<c013c22d>] [<c0126ec3>] [<c013c26c>] [<c0106e0b>] 
Jun  4 17:26:11 nynetops03 kernel: 
Jun  4 17:26:11 nynetops03 kernel: Code: 0f 0b 83 c4 0c c3 89 f6 31 c0 c3 8d b6 00 00 00 00 8d bc 27 

And the decoded output:
ksymoops 2.4.0 on i686 2.4.5.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.5/ (default)
     -m /boot/System.map-2.4.5 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Warning (compare_maps): ksyms_base symbol __VERSIONED_SYMBOL(shmem_file_setup) not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol machine_real_restart_R__ver_machine_real_restart not found in System.map.  Ignoring ksyms_base entry
Jun  4 17:26:11 nynetops03 kernel: kernel BUG at journal.c:423!
Jun  4 17:26:11 nynetops03 kernel: invalid operand: 0000
Jun  4 17:26:11 nynetops03 kernel: CPU:    1
Jun  4 17:26:11 nynetops03 kernel: EIP:    0010:[reiserfs_check_lock_depth+56/64]
Jun  4 17:26:11 nynetops03 kernel: EIP:    0010:[<c018bb98>]
Using defaults from ksymoops -t elf32-i386 -a i386
Jun  4 17:26:11 nynetops03 kernel: EFLAGS: 00010282
Jun  4 17:26:11 nynetops03 kernel: eax: 0000001d   ebx: d8e15f24   ecx: 00000001   edx: 00000001
Jun  4 17:26:11 nynetops03 kernel: esi: df9c5400   edi: 00000000   ebp: 3b1bfcf3   esp: d8e15eac
Jun  4 17:26:11 nynetops03 kernel: ds: 0018   es: 0018   ss: 0018
Jun  4 17:26:11 nynetops03 kernel: Process umount (pid: 4577, stackpage=d8e15000)
Jun  4 17:26:11 nynetops03 kernel: Stack: c02678b3 c0267a44 000001a7 c018e2cf c0268a61 00000000 d7e75250 000000e8 
Jun  4 17:26:11 nynetops03 kernel:        df731000 40173000 d8e15f60 00000000 00000018 d8e15f24 df9c5400 c02a8620 
Jun  4 17:26:11 nynetops03 kernel:        c02a8698 c018e516 d8e15f24 df9c5400 0000000a 00000000 c017ffdc d8e15f24 
Jun  4 17:26:11 nynetops03 kernel: Call Trace: [do_journal_begin_r+31/560] [journal_begin+22/32] [reiserfs_put_super+28/224] [iput+63/368] [fsync_super+180/192] [kill_super+162/288] [path_release+41/48] 
Jun  4 17:26:11 nynetops03 kernel: Call Trace: [<c018e2cf>] [<c018e516>] [<c017ffdc>] [<c014bf3f>] [<c0137494>] [<c013bd72>] [<c0140e79>] 
Jun  4 17:26:11 nynetops03 kernel:        [<c013c22d>] [<c0126ec3>] [<c013c26c>] [<c0106e0b>] 
Jun  4 17:26:11 nynetops03 kernel: Code: 0f 0b 83 c4 0c c3 89 f6 31 c0 c3 8d b6 00 00 00 00 8d bc 27 

>>EIP; c018bb98 <reiserfs_check_lock_depth+38/40>   <=====
Trace; c018e2cf <do_journal_begin_r+1f/230>
Trace; c018e516 <journal_begin+16/20>
Trace; c017ffdc <reiserfs_put_super+1c/e0>
Trace; c014bf3f <iput+3f/170>
Trace; c0137494 <fsync_super+b4/c0>
Trace; c013bd72 <kill_super+a2/120>
Trace; c0140e79 <path_release+29/30>
Trace; c013c22d <sys_umount+12d/160>
Trace; c0126ec3 <sys_munmap+33/50>
Trace; c013c26c <sys_oldumount+c/10>
Trace; c0106e0b <system_call+33/38>
Code;  c018bb98 <reiserfs_check_lock_depth+38/40>
00000000 <_EIP>:
Code;  c018bb98 <reiserfs_check_lock_depth+38/40>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c018bb9a <reiserfs_check_lock_depth+3a/40>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c018bb9d <reiserfs_check_lock_depth+3d/40>
   5:   c3                        ret    
Code;  c018bb9e <reiserfs_check_lock_depth+3e/40>
   6:   89 f6                     mov    %esi,%esi
Code;  c018bba0 <push_journal_writer+0/10>
   8:   31 c0                     xor    %eax,%eax
Code;  c018bba2 <push_journal_writer+2/10>
   a:   c3                        ret    
Code;  c018bba3 <push_journal_writer+3/10>
   b:   8d b6 00 00 00 00         lea    0x0(%esi),%esi
Code;  c018bba9 <push_journal_writer+9/10>
  11:   8d bc 27 00 00 00 00      lea    0x0(%edi,1),%edi


3 warnings issued.  Results may not be reliable.


-- 
Mathieu CHOUQUET-STRINGER              E-Mail : mchouque@e-steel.com
     Learning French is trivial: the word for horse is cheval, and
               everything else follows in the same way.
                        -- Alan J. Perlis
