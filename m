Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbTDUIVB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 04:21:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTDUIVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 04:21:01 -0400
Received: from [210.22.78.238] ([210.22.78.238]:28616 "HELO trust-mart.com")
	by vger.kernel.org with SMTP id S263787AbTDUIU7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 04:20:59 -0400
From: hv <hv@trust-mart.com.cn>
To: linux-kernel@vger.kernel.org
Subject: state D in 2.5.67-ac2 and 2.5.68-mm1
Message-Id: <20030421163220.663690e9.hv@trust-mart.com.cn>
Organization: it-TM
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Mon, 21 Apr 2003 04:20:59 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,all:
       My 2.5.67-ac2 and 2.5.68-mm1 kernel have much processes with state D when I run postgresql.
      I used devfsd and ext3 filesystem.My linux is redhat9.0.
     The other question is pdflush would be a zombie if there have much "D" process.
    oops is:
Apr 21 13:48:09 hv kernel:  <1>Unable to handle kernel paging request at virtual address 297c9b10
Apr 21 13:48:09 hv kernel:  printing eip:
Apr 21 13:48:09 hv kernel: c03f2668
Apr 21 13:48:09 hv kernel: *pde = 00000000
Apr 21 13:48:09 hv kernel: Oops: 0002 [#2]
Apr 21 13:48:09 hv kernel: CPU:    0
Apr 21 13:48:10 hv kernel: EIP:    0060:[<c03f2668>]    Not tainted VLI
Apr 21 13:48:10 hv kernel: EFLAGS: 00010286
Apr 21 13:48:10 hv kernel: eax: 00000000   ebx: c0138ad0   ecx: 00000000   edx:
00000000
Apr 21 13:48:10 hv kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp:
e34abff8
Apr 21 13:48:10 hv kernel: ds: 007b   es: 007b   ss: 0068
Apr 21 13:48:10 hv kernel: Process pdflush (pid: 5612, threadinfo=e34aa000 task=f44f2180)
Apr 21 13:48:10 hv kernel: Stack: 00000000 00000000
Apr 21 13:48:11 hv kernel: Call Trace:
Apr 21 13:48:11 hv kernel: Code: 69 69 0d 00 00 00 00 9b 8e 04 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <d2> b4 03 40 10 69 69 0d 00 00 00 00 6d b4 03 40 c8 b4 03 40 11

ksymoops result is:
ksymoops 2.4.9 on i686 2.5.68-mm1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.68-mm1/ (default)
     -m /boot/System.map (specified)

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Apr 21 13:48:09 hv kernel:  <1>Unable to handle kernel paging request at virtual address 297c9b10
Apr 21 13:48:09 hv kernel: c03f2668
Apr 21 13:48:09 hv kernel: *pde = 00000000
Apr 21 13:48:09 hv kernel: Oops: 0002 [#2]
Apr 21 13:48:09 hv kernel: CPU:    0
Apr 21 13:48:10 hv kernel: EIP:    0060:[<c03f2668>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
Apr 21 13:48:10 hv kernel: EFLAGS: 00010286
Apr 21 13:48:10 hv kernel: eax: 00000000   ebx: c0138ad0   ecx: 00000000   edx:
Warning (Oops_set_regs): garbage 'edx:' at end of register line ignored
00000000
Apr 21 13:48:10 hv kernel: esi: 00000000   edi: 00000000   ebp: 00000000   esp:
Warning (Oops_set_regs): garbage 'esp:' at end of register line ignored
e34abff8
Apr 21 13:48:10 hv kernel: ds: 007b   es: 007b   ss: 0068
Apr 21 13:48:10 hv kernel: Stack: 00000000 00000000
Apr 21 13:48:11 hv kernel: Call Trace:
Apr 21 13:48:11 hv kernel: Code: 69 69 0d 00 00 00 00 9b 8e 04 08 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 <d2> b4 03 40 10 69 69 0d 00 00 00 00 6d b4 03 40 c8 b4 03 40 11


>>EIP; c03f2668 <pci_vendor_list+23e8/4e18>   <=====

>>ebx; c0138ad0 <pdflush+0/13>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c03f263d <pci_vendor_list+23bd/4e18>
00000000 <_EIP>:
Code;  c03f263d <pci_vendor_list+23bd/4e18>
   0:   69 69 0d 00 00 00 00      imul   $0x0,0xd(%ecx),%ebp
Code;  c03f2644 <pci_vendor_list+23c4/4e18>
   7:   9b                        fwait
Code;  c03f2645 <pci_vendor_list+23c5/4e18>
   8:   8e 04 08                  movl   (%eax,%ecx,1),%es

This decode from eip onwards should be reliable

Code;  c03f2668 <pci_vendor_list+23e8/4e18>
00000000 <_EIP>:
Code;  c03f2668 <pci_vendor_list+23e8/4e18>   <=====
   0:   d2                        (bad)     <=====
Code;  c03f2669 <pci_vendor_list+23e9/4e18>
   1:   b4 03                     mov    $0x3,%ah
Code;  c03f266b <pci_vendor_list+23eb/4e18>
   3:   40                        inc    %eax
Code;  c03f266c <pci_vendor_list+23ec/4e18>
   4:   10 69 69                  adc    %ch,0x69(%ecx)
Code;  c03f266f <pci_vendor_list+23ef/4e18>
   7:   0d 00 00 00 00            or     $0x0,%eax
Code;  c03f2674 <pci_vendor_list+23f4/4e18>
   c:   6d                        insl   (%dx),%es:(%edi)
Code;  c03f2675 <pci_vendor_list+23f5/4e18>
   d:   b4 03                     mov    $0x3,%ah
Code;  c03f2677 <pci_vendor_list+23f7/4e18>
   f:   40                        inc    %eax
Code;  c03f2678 <pci_vendor_list+23f8/4e18>
  10:   c8 b4 03 40               enter  $0x3b4,$0x40
Code;  c03f267c <pci_vendor_list+23fc/4e18>
  14:   11                        .byte 0x11


2 warnings and 1 error issued.  Results may not be reliable.
