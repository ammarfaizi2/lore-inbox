Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130270AbQLNLkj>; Thu, 14 Dec 2000 06:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130883AbQLNLk3>; Thu, 14 Dec 2000 06:40:29 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:46095 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S130270AbQLNLkY>; Thu, 14 Dec 2000 06:40:24 -0500
From: Chris Rankin <rankinc@zip.com.au>
Message-Id: <200012141109.eBEB9oO07065@wellhouse.underworld>
Subject: Re: /dev/cpu/*/(cpuid, msr) unhappy as modules - OOPS!
To: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 14 Dec 2000 22:09:49 +1100 (EST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1193.195.67.189.85.976703444.squirrel@www.zytor.com> from "H. Peter Anvin" at Dec 13, 2000 02:30:44 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK, I've just tried repeating this experiment on 2.2.18 (no devfs) and
it oopsed this time, so there's obviously something else going on
here.

$ ksymoops -m /boot/System.map-2.2.18 < oops2.txt 
ksymoops 2.3.4 on i586 2.2.18.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.2.18/ (default)
     -m /boot/System.map-2.2.18 (specified)

Warning (compare_maps): ksyms_base symbol module_list_R__ver_module_list not found in System.map.  Ignoring ksyms_base entry
Dec 14 22:03:53 wellhouse kernel: Unable to handle kernel paging request at virtual address c888a27c
Dec 14 22:03:53 wellhouse kernel: current->tss.cr3 = 03003000, %%cr3 = 03003000
Dec 14 22:03:53 wellhouse kernel: *pde = 013f2063
Dec 14 22:03:53 wellhouse kernel: Oops: 0000
Dec 14 22:03:53 wellhouse kernel: CPU:    0
Dec 14 22:03:53 wellhouse kernel: EIP:    0010:[chrdev_open+56/88]
Dec 14 22:03:53 wellhouse kernel: EFLAGS: 00010286
Dec 14 22:03:53 wellhouse kernel: eax: c888a260   ebx: ffffffed   ecx: 00000000   edx: 000000cb
Dec 14 22:03:53 wellhouse kernel: esi: c25ba8c0   edi: c18c2288   ebp: c3c50ca0   esp: c0ef9f4c
Dec 14 22:03:53 wellhouse kernel: ds: 0018   es: 0018   ss: 0018
Dec 14 22:03:53 wellhouse kernel: Process cat (pid: 7021, process nr: 61, stackpage=c0ef9000)
Dec 14 22:03:53 wellhouse kernel: Stack: c18c2288 00008000 00000003 400e88b3 bffffa6c c012497c c18c2288 c25ba8c0 
Dec 14 22:03:53 wellhouse kernel:        00000000 c01248d5 00000003 c398a000 400e88b3 bffffa6c 00000000 c16b427c 
Dec 14 22:03:53 wellhouse kernel:        00000400 c0124b6f c398a000 00008000 00000000 c0124b56 c0ef8000 40013ed0 
Dec 14 22:03:53 wellhouse kernel: Call Trace: [filp_open+184/264] [filp_open+17/264] [sys_open+63/160] [sys_open+38/160] [error_code+45/64] [system_call+52/64] 
Dec 14 22:03:53 wellhouse kernel: Code: 8b 40 1c 31 db 85 c0 74 0c 83 c4 f8 56 57 ff d0 89 c3 83 c4 
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

Chris
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
