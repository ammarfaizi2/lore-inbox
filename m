Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129267AbQLMFtD>; Wed, 13 Dec 2000 00:49:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129387AbQLMFsw>; Wed, 13 Dec 2000 00:48:52 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:29455 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S129267AbQLMFsm>; Wed, 13 Dec 2000 00:48:42 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200012122116.eBCLG9O04877@wellhouse.underworld>
Subject: /dev/cpu/*/(cpuid, msr) unhappy as modules - OOPS!
To: linux-kernel@vger.kernel.org
Date: Wed, 13 Dec 2000 08:16:09 +1100 (EST)
Cc: hpa@zytor.com
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I have just compiled Linux 2.2.18 (UP) and Linux 2.4.0-test12 (SMP,
devfs), and in each case I compiled the msr and cpuid drivers as
modules. However, when I tried to read from the devices (using "cat"),
I got oopses from both 2.2.18 and 2.4.0-test12. Neither the msr.o nor
the cpuid.o modules were loaded beforehand, as I was testing my kmod
setup. The oopses are below:

Linux-2.4.0-test12 (2 oopses):
$ ksymoops -m /boot/System.map-2.4.0-test12 < oops1.txt 
ksymoops 2.3.4 on i686 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (specified)

Dec 13 01:17:47 twopit kernel: Unable to handle kernel paging request at virtual address d084a540
Dec 13 01:17:47 twopit kernel: c0133d8a
Dec 13 01:17:47 twopit kernel: *pde = 0146b063
Dec 13 01:17:47 twopit kernel: Oops: 0000
Dec 13 01:17:47 twopit kernel: CPU:    1
Dec 13 01:17:47 twopit kernel: EIP:    0010:[get_chrfops+78/368]
Dec 13 01:17:47 twopit kernel: EFLAGS: 00010282
Dec 13 01:17:47 twopit kernel: eax: 00000650   ebx: d084a540   ecx: c0215280   edx: c0268de4
Dec 13 01:17:47 twopit kernel: esi: 00000000   edi: 00000650   ebp: 000000ca   esp: cb505ee8
Dec 13 01:17:47 twopit kernel: ds: 0018   es: 0018   ss: 0018
Dec 13 01:17:47 twopit kernel: Process cat (pid: 1681, stackpage=cb505000)
Dec 13 01:17:47 twopit kernel: Stack: cf41e140 cccfef60 ffffffed cb998580 c0215280 c02158b8 cbcd7840 00000000 
Dec 13 01:17:47 twopit kernel:        c013ed99 c999ca60 c013403a 000000ca 00000001 cf41e140 ffffffed cf41e144 
Dec 13 01:17:47 twopit kernel:        cb998580 c015b5d1 cb998580 cccfef60 cccfef60 cb998580 ffffffe9 c14fa240 
Dec 13 01:17:47 twopit kernel: Call Trace: [path_walk+1997/2196] [chrdev_open+38/172] [devfs_open+277/500] [dentry_open+189/332] [filp_open+82/92] [sys_open+60/240] [system_call+51/56] 
Dec 13 01:17:47 twopit kernel: Code: 8b 03 85 c0 74 10 50 e8 62 8b fe ff 83 c4 04 85 c0 74 09 8d 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 03                     mov    (%ebx),%eax
Code;  00000002 Before first symbol
   2:   85 c0                     test   %eax,%eax
Code;  00000004 Before first symbol
   4:   74 10                     je     16 <_EIP+0x16> 00000016 Before first symbol
Code;  00000006 Before first symbol
   6:   50                        push   %eax
Code;  00000007 Before first symbol
   7:   e8 62 8b fe ff            call   fffe8b6e <_EIP+0xfffe8b6e> fffe8b6e <END_OF_CODE+2f726606/????>
Code;  0000000c Before first symbol
   c:   83 c4 04                  add    $0x4,%esp
Code;  0000000f Before first symbol
   f:   85 c0                     test   %eax,%eax
Code;  00000011 Before first symbol
  11:   74 09                     je     1c <_EIP+0x1c> 0000001c Before first symbol
Code;  00000013 Before first symbol
  13:   8d 00                     lea    (%eax),%eax

$ ksymoops -m /boot/System.map-2.4.0-test12 < oops2.txt 
ksymoops 2.3.4 on i686 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (specified)

Dec 13 01:20:02 twopit kernel: Unable to handle kernel paging request at virtual address d084a540
Dec 13 01:20:02 twopit kernel: c0133d8a
Dec 13 01:20:02 twopit kernel: *pde = 0146b063
Dec 13 01:20:02 twopit kernel: Oops: 0000
Dec 13 01:20:02 twopit kernel: CPU:    0
Dec 13 01:20:02 twopit kernel: EIP:    0010:[get_chrfops+78/368]
Dec 13 01:20:02 twopit kernel: EFLAGS: 00010282
Dec 13 01:20:02 twopit kernel: eax: 00000650   ebx: d084a540   ecx: c0215280   edx: c0268de4
Dec 13 01:20:02 twopit kernel: esi: 00000000   edi: 00000650   ebp: 000000ca   esp: cb52bee8
Dec 13 01:20:02 twopit kernel: ds: 0018   es: 0018   ss: 0018
Dec 13 01:20:02 twopit kernel: Process cat (pid: 1691, stackpage=cb52b000)
Dec 13 01:20:02 twopit kernel: Stack: cf41e140 cc605bc0 ffffffed cb998580 c0215280 c02158b8 cbcd7840 00000000 
Dec 13 01:20:02 twopit kernel:        c013ed99 c999ca60 c013403a 000000ca 00000001 cf41e140 ffffffed cf41e144 
Dec 13 01:20:02 twopit kernel:        cb998580 c015b5d1 cb998580 cc605bc0 cc605bc0 cb998580 ffffffe9 c14fa240 
Dec 13 01:20:02 twopit kernel: Call Trace: [path_walk+1997/2196] [chrdev_open+38/172] [devfs_open+277/500] [dentry_open+189/332] [filp_open+82/92] [sys_open+60/240] [system_call+51/56] 
Dec 13 01:20:02 twopit kernel: Code: 8b 03 85 c0 74 10 50 e8 62 8b fe ff 83 c4 04 85 c0 74 09 8d 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 03                     mov    (%ebx),%eax
Code;  00000002 Before first symbol
   2:   85 c0                     test   %eax,%eax
Code;  00000004 Before first symbol
   4:   74 10                     je     16 <_EIP+0x16> 00000016 Before first symbol
Code;  00000006 Before first symbol
   6:   50                        push   %eax
Code;  00000007 Before first symbol
   7:   e8 62 8b fe ff            call   fffe8b6e <_EIP+0xfffe8b6e> fffe8b6e <END_OF_CODE+2f726606/????>
Code;  0000000c Before first symbol
   c:   83 c4 04                  add    $0x4,%esp
Code;  0000000f Before first symbol
   f:   85 c0                     test   %eax,%eax
Code;  00000011 Before first symbol
  11:   74 09                     je     1c <_EIP+0x1c> 0000001c Before first symbol
Code;  00000013 Before first symbol
  13:   8d 00                     lea    (%eax),%eax


Linux-2.2.18 (1 oops):
$ ksymoops -m /boot/System.map-2.2.18 < oops.txt 
ksymoops 2.3.4 on i586 2.2.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /boot/System.map-2.2.18 (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Dec 13 01:31:18 wellhouse kernel: Unable to handle kernel paging request at virtual address c887027c
Dec 13 01:31:18 wellhouse kernel: current->tss.cr3 = 007ad000, %%cr3 = 007ad000
Dec 13 01:31:18 wellhouse kernel: *pde = 01472063
Dec 13 01:31:18 wellhouse kernel: Oops: 0000
Dec 13 01:31:18 wellhouse kernel: CPU:    0
Dec 13 01:31:18 wellhouse kernel: EIP:    0010:[chrdev_open+56/88]
Dec 13 01:31:18 wellhouse kernel: EFLAGS: 00010286
Dec 13 01:31:18 wellhouse kernel: eax: c8870260   ebx: ffffffed   ecx: 00000000   edx: 000000cb
Dec 13 01:31:18 wellhouse kernel: esi: c34d4380   edi: c0565e60   ebp: c3c35900   esp: c3b47f4c
Dec 13 01:31:18 wellhouse kernel: ds: 0018   es: 0018   ss: 0018
Dec 13 01:31:18 wellhouse kernel: Process cat (pid: 1645, process nr: 53, stackpage=c3b47000)
Dec 13 01:31:18 wellhouse kernel: Stack: c0565e60 00008000 00000003 400e88b3 bffffa4c c012497c c0565e60 c34d4380 
Dec 13 01:31:18 wellhouse kernel:        00000000 c01248d5 00000003 c05a3000 400e88b3 bffffa4c 00000000 c398549c 
Dec 13 01:31:18 wellhouse kernel:        00000400 c0124b6f c05a3000 00008000 00000000 c0124b56 c3b46000 40013ed0 
Dec 13 01:31:18 wellhouse kernel: Call Trace: [filp_open+184/264] [filp_open+17/264] [sys_open+63/160] [sys_open+38/160] [error_code+45/64] [
system_call+52/64] 
Dec 13 01:31:18 wellhouse kernel: Code: 8b 40 1c 31 db 85 c0 74 0c 83 c4 f8 56 57 ff d0 89 c3 83 c4 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   8b 40 1c                  mov    0x1c(%eax),%eax
Code;  00000003 Before first symbol
   3:   31 db                     xor    %ebx,%ebx
Code;  00000005 Before first symbol
   5:   85 c0                     test   %eax,%eax
Code;  00000007 Before first symbol
   7:   74 0c                     je     15 <_EIP+0x15> 00000015 Before first symbol
Code;  00000009 Before first symbol
   9:   83 c4 f8                  add    $0xfffffff8,%esp
Code;  0000000c Before first symbol
   c:   56                        push   %esi
Code;  0000000d Before first symbol
   d:   57                        push   %edi
Code;  0000000e Before first symbol
   e:   ff d0                     call   *%eax
Code;  00000010 Before first symbol
  10:   89 c3                     mov    %eax,%ebx
Code;  00000012 Before first symbol
  12:   83 c4 00                  add    $0x0,%esp


1 warning issued.  Results may not be reliable.

I know they're not exactly show-stoppers, but here they are anyway.
Cheers,
Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
