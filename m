Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVBHSia@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVBHSia (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 13:38:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261625AbVBHSia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 13:38:30 -0500
Received: from balu1.urz.unibas.ch ([131.152.1.51]:45246 "EHLO
	balu1.urz.unibas.ch") by vger.kernel.org with ESMTP id S261624AbVBHSiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 13:38:21 -0500
Date: Tue, 8 Feb 2005 19:38:11 +0100
From: Peter Englmaier <ppe@astro.unibas.ch>
To: linux-kernel@vger.kernel.org
Subject: Kernel Crash with Oops and possible file corruption
Message-ID: <20050208183811.GA20512@astro.unibas.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-SMTP-Vilter-Version: 1.1.8
X-SMTP-Vilter-Virus-Backend: savse
X-SMTP-Vilter-Status: clean
X-SMTP-Vilter-savse-Virus-Status: clean
X-SMTP-Vilter-Unwanted-Backend: attachment
X-SMTP-Vilter-attachment-Unwanted-Status: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Kernel Developers,

I've got a machine where nfsd dies with an oops from time to time.
When this happens I need to reboot it to get nfsd working again.
Sometimes it also crashes (stops responding to network, keyboard).

The ksymoops output is attached below.

This happens quite often (every day or few days).

Distribution: 
  Fedora Core 2 with all updates with kernel-2.6.10-1.12_FC2
System: Hyperthreading Pentium 4 with 3 GHz.

Hyperthreading turned off. 
Boot arguments: ro root=LABEL=/ ide=nodma apm=off acpi=off

I submitted another oops report recently on this list:
(http://marc.theaimsgroup.com/?l=linux-kernel&m=110665923109025&w=2)
I was adviced to try the newest kernel and turn of SMP, but this 
did not help. The crash now happens simply in a different place.
Memtest86+ did not show any errors and the system is not overclocked
as far as I can tell, but I suspect that something with interrupt
processing is wrong.

Best, 
Peter.

ksymoops 2.4.9 on i686 2.6.10-1.12_FC2.  Options used
     -V (default)
     -K (specified)
     -l /proc/modules (default)
     -o /lib/modules/2.6.10-1.12_FC2/ (default)
     -m /boot/System.map-2.6.10-1.12_FC2 (specified)

No modules in ksyms, skipping objects
No ksyms, skipping lsmod
CPU 0 irqstacks, hard=c03e0000 soft=c03df000
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth0: e100_probe: addr 0xffdfe000, irq 5, MAC addr 00:0C:76:24:5F:0A
e100: Intel(R) PRO/100 Network Driver, 3.2.3-k2-NAPI
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth0: e100_probe: addr 0xffdfe000, irq 5, MAC addr 00:0C:76:24:5F:0A
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
Unable to handle kernel paging request at virtual address ff890000
c0173bb3
*pde = 00003067
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<c0173bb3>]    Not tainted VLI
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010286   (2.6.10-1.12_FC2) 
eax: 00000000   ebx: ff88f000   ecx: ffffefff   edx: 00001000
esi: ff88f000   edi: ff890000   ebp: cf3f2000   esp: f5c6ceac
ds: 007b   es: 007b   ss: 0068
Stack: 00000000 daf85234 f5c6cec8 00001000 c0173c20 ff88f000 cf3f2000 d543963c 
       00000000 daf9378c f882562d 00000001 4205500a 30f7ea30 00000000 ff88f000 
       00000002 f704fc00 daf9378c 4205500a 30f7ea30 daf937c8 c017f1f9 4205500a 
Call Trace:
 [<c0173c20>] generic_readlink+0x45/0x68
 [<f882562d>] ext3_dirty_inode+0x5f/0x63 [ext3]
 [<c017f1f9>] update_atime+0x76/0x9e
 [<f8a7c922>] nfsd_readlink+0x65/0x81 [nfsd]
 [<f8a81ae6>] nfsd3_proc_readlink+0x8a/0x95 [nfsd]
 [<f8a841b1>] nfs3svc_decode_readlinkargs+0x0/0xc5 [nfsd]
 [<f8a78671>] nfsd_dispatch+0xbf/0x17e [nfsd]
 [<f89ef88e>] svc_process+0x336/0x574 [sunrpc]
 [<f8a78382>] nfsd+0x1e4/0x414 [nfsd]
 [<f8a7819e>] nfsd+0x0/0x414 [nfsd]
 [<c01011dd>] kernel_thread_helper+0x5/0xb
Code: b0 00 00 00 5b 5e 5f 5d c3 55 31 c0 89 d5 57 89 ca 56 53 8b 74 24 14 81 fe 18 fc ff ff 0f 97 c0 89 f3 85 c0 75 26 83 c9 ff 89 f7 <f2> ae f7 d1 49 39 d1 89 cb 89 e8 0f 47 da 89 d9 89 f2 e8 c2 7a 


>>EIP; c0173bb3 <vfs_readlink+22/4a>   <=====

Trace; c0173c20 <generic_readlink+45/68>
Trace; f882562d <END_OF_CODE+383e662d/????>
Trace; c017f1f9 <update_atime+76/9e>
Trace; f8a7c922 <END_OF_CODE+3863d922/????>
Trace; f8a81ae6 <END_OF_CODE+38642ae6/????>
Trace; f8a841b1 <END_OF_CODE+386451b1/????>
Trace; f8a78671 <END_OF_CODE+38639671/????>
Trace; f89ef88e <END_OF_CODE+385b088e/????>
Trace; f8a78382 <END_OF_CODE+38639382/????>
Trace; f8a7819e <END_OF_CODE+3863919e/????>
Trace; c01011dd <kernel_thread_helper+5/b>

This architecture has variable length instructions, decoding before eip
is unreliable, take these instructions with a pinch of salt.

Code;  c0173b88 <sys_rename+1dd/1e6>
00000000 <_EIP>:
Code;  c0173b88 <sys_rename+1dd/1e6>
   0:   b0 00                     mov    $0x0,%al
Code;  c0173b8a <sys_rename+1df/1e6>
   2:   00 00                     add    %al,(%eax)
Code;  c0173b8c <sys_rename+1e1/1e6>
   4:   5b                        pop    %ebx
Code;  c0173b8d <sys_rename+1e2/1e6>
   5:   5e                        pop    %esi
Code;  c0173b8e <sys_rename+1e3/1e6>
   6:   5f                        pop    %edi
Code;  c0173b8f <sys_rename+1e4/1e6>
   7:   5d                        pop    %ebp
Code;  c0173b90 <sys_rename+1e5/1e6>
   8:   c3                        ret    
Code;  c0173b91 <vfs_readlink+0/4a>
   9:   55                        push   %ebp
Code;  c0173b92 <vfs_readlink+1/4a>
   a:   31 c0                     xor    %eax,%eax
Code;  c0173b94 <vfs_readlink+3/4a>
   c:   89 d5                     mov    %edx,%ebp
Code;  c0173b96 <vfs_readlink+5/4a>
   e:   57                        push   %edi
Code;  c0173b97 <vfs_readlink+6/4a>
   f:   89 ca                     mov    %ecx,%edx
Code;  c0173b99 <vfs_readlink+8/4a>
  11:   56                        push   %esi
Code;  c0173b9a <vfs_readlink+9/4a>
  12:   53                        push   %ebx
Code;  c0173b9b <vfs_readlink+a/4a>
  13:   8b 74 24 14               mov    0x14(%esp),%esi
Code;  c0173b9f <vfs_readlink+e/4a>
  17:   81 fe 18 fc ff ff         cmp    $0xfffffc18,%esi
Code;  c0173ba5 <vfs_readlink+14/4a>
  1d:   0f 97 c0                  seta   %al
Code;  c0173ba8 <vfs_readlink+17/4a>
  20:   89 f3                     mov    %esi,%ebx
Code;  c0173baa <vfs_readlink+19/4a>
  22:   85 c0                     test   %eax,%eax
Code;  c0173bac <vfs_readlink+1b/4a>
  24:   75 26                     jne    4c <_EIP+0x4c>
Code;  c0173bae <vfs_readlink+1d/4a>
  26:   83 c9 ff                  or     $0xffffffff,%ecx
Code;  c0173bb1 <vfs_readlink+20/4a>
  29:   89 f7                     mov    %esi,%edi

This decode from eip onwards should be reliable

Code;  c0173bb3 <vfs_readlink+22/4a>
00000000 <_EIP>:
Code;  c0173bb3 <vfs_readlink+22/4a>   <=====
   0:   f2 ae                     repnz scas %es:(%edi),%al   <=====
Code;  c0173bb5 <vfs_readlink+24/4a>
   2:   f7 d1                     not    %ecx
Code;  c0173bb7 <vfs_readlink+26/4a>
   4:   49                        dec    %ecx
Code;  c0173bb8 <vfs_readlink+27/4a>
   5:   39 d1                     cmp    %edx,%ecx
Code;  c0173bba <vfs_readlink+29/4a>
   7:   89 cb                     mov    %ecx,%ebx
Code;  c0173bbc <vfs_readlink+2b/4a>
   9:   89 e8                     mov    %ebp,%eax
Code;  c0173bbe <vfs_readlink+2d/4a>
   b:   0f 47 da                  cmova  %edx,%ebx
Code;  c0173bc1 <vfs_readlink+30/4a>
   e:   89 d9                     mov    %ebx,%ecx
Code;  c0173bc3 <vfs_readlink+32/4a>
  10:   89 f2                     mov    %esi,%edx
Code;  c0173bc5 <vfs_readlink+34/4a>
  12:   e8                        .byte 0xe8
Code;  c0173bc6 <vfs_readlink+35/4a>
  13:   c2                        .byte 0xc2
Code;  c0173bc7 <vfs_readlink+36/4a>
  14:   7a                        .byte 0x7a

