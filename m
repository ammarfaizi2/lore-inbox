Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129793AbQKULgi>; Tue, 21 Nov 2000 06:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129819AbQKULg2>; Tue, 21 Nov 2000 06:36:28 -0500
Received: from smtp.dave.sonera.fi ([131.177.130.21]:38841 "EHLO
	smtp.dave.sonera.fi") by vger.kernel.org with ESMTP
	id <S129793AbQKULgK>; Tue, 21 Nov 2000 06:36:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Problem with SYSV IPC
From: Janne Himanka <janne.himanka@sonera.com>
Date: 21 Nov 2000 13:05:48 +0200
Message-ID: <m3bsv937qr.fsf@kyklos.poh.tele.fi>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Notus)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have compiled 2.4.0-test10 and 2.4.0-test11 kernels, mounted
/dev/shm and tried to install the Perl IPC::Shareable module. "make
test" produces a lot of errors (sample below), and a message from the
kernel appears in /var/log/messages. I am using a Compaq PIII 866MHz,
Redhat 7.0. I compiled test10 with gcc 2.96 anf kgcc, test11 with
kgcc, all produced more or less the same results. SYSV IPC is
configured in the kernel. No modules were loaded at the time of
failure. After the failure the machine functions normally.
X apparently uses shared memory without problems. I attach also the
ksymoops output.

%%%%%%% Output of Perl IPC::Shareable "make test" %%%%%%%%%%%%%%%
PERL_DL_NONLAZY=1 /usr/bin/perl -Iblib/arch -Iblib/lib -I/usr/lib/perl5/5.6.0/i386-linux -I/usr/lib/perl5/5.6.0 -e 'use Test::Harness qw(&runtests $verbose); $verbose=0; runtests @ARGV;' t/*.t
t/00base............ok                                                       
t/05sv..............ok                                                       
t/10av..............ok 1/11Munged shared memory segment (size exceeded?) at t/10av.t line 21
t/10av..............dubious                                                  
	Test returned status 255 (wstat 65280, 0xff00)
DIED. FAILED tests 2-11
	Failed 10/11 tests, 9.09% okay
t/15hv..............ok 9/10Munged shared memory segment (size exceeded?) at t/15hv.t line 86
t/15hv..............dubious                                                  
	Test returned status 255 (wstat 65280, 0xff00)
DIED. FAILED test 10
	Failed 1/10 tests, 90.00% okay
t/20ref.............ok 1/8Munged shared memory segment (size exceeded?) at t/20ref.t line 26
t/20ref.............dubious                                                  
	Test returned status 255 (wstat 65280, 0xff00)
DIED. FAILED tests 2-8

[More of the same omitted]

%%%%%%%%%%%%%%% Kernel messages from /var/log/messages %%%%%%%%%%%%%%%%%

Nov 21 12:38:02 kyklos kernel: kernel BUG at sem.c:926!
Nov 21 12:38:02 kyklos kernel: invalid operand: 0000
Nov 21 12:38:02 kyklos kernel: CPU:    0
Nov 21 12:38:02 kyklos kernel: EIP:    0010:[sys_semop+999/1184]
Nov 21 12:38:02 kyklos kernel: EFLAGS: 00210286
Nov 21 12:38:02 kyklos kernel: eax: 00000019   ebx: cc196000   ecx: 00000000   edx: 00000003
Nov 21 12:38:02 kyklos kernel: esi: 00000001   edi: ce00d440   ebp: 00050000   esp: cc197da0
Nov 21 12:38:02 kyklos kernel: ds: 0018   es: 0018   ss: 0018
Nov 21 12:38:02 kyklos kernel: Process perl (pid: 852, stackpage=cc197000)
Nov 21 12:38:02 kyklos kernel: Stack: c02129c5 c0212a51 0000039e 00000002 08105798 00050000 00000000 cc197e1e 
Nov 21 12:38:02 kyklos kernel:        cc197e10 00057fff 00000002 cc197e1c 00000001 00000000 00000002 cc197e10 
Nov 21 12:38:02 kyklos kernel:        cccf6720 00000000 00000000 cc196000 cccf6720 00000354 00000000 ce00d440 
Nov 21 12:38:02 kyklos kernel: Call Trace: [tvecs+41085/49688] [tvecs+41225/49688] [ret_from_intr+0/32] [__insert_vm_struct+228/404] [avl_remove+205/220] [shm_nopage+146/164] [do_no_page+89/196] 
Nov 21 12:38:02 kyklos kernel:        [handle_mm_fault+232/356] [unmap_fixup+99/308] [do_munmap+634/648] [sys_shmdt+92/124] [sys_ipc+64/500] [error_code+52/60] [system_call+51/56] 
Nov 21 12:38:02 kyklos kernel: Code: 0f 0b 83 c4 0c c7 83 54 02 00 00 00 00 00 00 be d5 ff ff ff 

%%%%%%%%%%%%%% ksymoops output %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[shem@kyklos /tmp]$ ksymoops -k /tmp/ksyms oops.txt 
ksymoops 2.3.4 on i686 2.4.0-test11.  Options used
     -V (default)
     -k /tmp/ksyms (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test11/ (default)
     -m /usr/src/linux/System.map (default)

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Nov 21 12:38:02 kyklos kernel: invalid operand: 0000
Nov 21 12:38:02 kyklos kernel: CPU:    0
Nov 21 12:38:02 kyklos kernel: EIP:    0010:[sys_semop+999/1184]
Nov 21 12:38:02 kyklos kernel: EFLAGS: 00210286
Nov 21 12:38:02 kyklos kernel: eax: 00000019   ebx: cc196000   ecx: 00000000   edx: 00000003
Nov 21 12:38:02 kyklos kernel: esi: 00000001   edi: ce00d440   ebp: 00050000   esp: cc197da0
Nov 21 12:38:02 kyklos kernel: ds: 0018   es: 0018   ss: 0018
Nov 21 12:38:02 kyklos kernel: Process perl (pid: 852, stackpage=cc197000)
Nov 21 12:38:02 kyklos kernel: Stack: c02129c5 c0212a51 0000039e 00000002 08105798 00050000 00000000 cc197e1e 
Nov 21 12:38:02 kyklos kernel:        cc197e10 00057fff 00000002 cc197e1c 00000001 00000000 00000002 cc197e10 
Nov 21 12:38:02 kyklos kernel:        cccf6720 00000000 00000000 cc196000 cccf6720 00000354 00000000 ce00d440 
Nov 21 12:38:02 kyklos kernel: Call Trace: [tvecs+41085/49688] [tvecs+41225/49688] [ret_from_intr+0/32] [__insert_vm_struct+228/404] [avl_remove+205/220] [shm_nopage+146/164] [do_no_page+89/196] 
Nov 21 12:38:02 kyklos kernel: Code: 0f 0b 83 c4 0c c7 83 54 02 00 00 00 00 00 00 be d5 ff ff ff 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   0f 0b                     ud2a   
Code;  00000002 Before first symbol
   2:   83 c4 0c                  add    $0xc,%esp
Code;  00000005 Before first symbol
   5:   c7 83 54 02 00 00 00      movl   $0x0,0x254(%ebx)
Code;  0000000c Before first symbol
   c:   00 00 00 
Code;  0000000f Before first symbol
   f:   be d5 ff ff ff            mov    $0xffffffd5,%esi


1 warning issued.  Results may not be reliable.


Janne Himanka
janne.himanka@sonera.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
