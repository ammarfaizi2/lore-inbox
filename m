Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbSIVKXb>; Sun, 22 Sep 2002 06:23:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262783AbSIVKXb>; Sun, 22 Sep 2002 06:23:31 -0400
Received: from ep09.kernel.pl ([212.87.11.162]:22336 "EHLO ep09.kernel.pl")
	by vger.kernel.org with ESMTP id <S262728AbSIVKX3>;
	Sun, 22 Sep 2002 06:23:29 -0400
Date: Sun, 22 Sep 2002 12:28:33 +0200 (CEST)
From: Witek Krecicki <adasi@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: [2.5.38] IDE oopses on vmware
Message-ID: <Pine.LNX.4.44L.0209221225180.3713-100000@ep09.kernel.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-AntiVirus: scanned for viruses by AMaViS 0.2.1 (http://amavis.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops happens after:
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with  idebus=xx
hda: VMware Virtual IDE Hard Drive, ATA DISK drive
hdc: VMware Virtual IDE CDROM Drive, ATAPI CD/DVD-ROM drive
ide2: ports already in use, skipping probe

Decoded oops:
ksymoops 2.4.5 on i686 2.2.21.  Options used
     -V (default)
     -k /dev/null (specified)
     -l /dev/null (specified)
     -o /dev/null (specified)
     -m System.map (specified)

Error (regular_file): read_ksyms /dev/null is not a regular file, ignored
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Unable to handle kernel NULL pointer dereference at virtual address 00000040
c01c55ae
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0060:[<c01c55ae>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000046
eax: 00000000   ebx: c02f9dfc   ecx: c02f9dec   edx: 00000000
esi: c02f9dec   edi: c8fa0214   ebp: 00000000   esp: c12d5f34
ds: 0068   es: 0068   ss: 0068
Stack: c01bbe57 c02f9dec 00000001 c02f9dfc 00000100 c02f9dec c02f9d40 c01bc0de 
       c02f9dec c02f9d50 c02f9d40 c12d5fcc c12d5fa4 c8fa0214 c02f9d50 00000282 
       00000000 c01bc4d6 c02f9d40 00000000 c02f9d40 c12d5fcc c01bc781 c02f9d40 
Call Trace: [<c01bbe57>] [<c01bc0de>] [<c01bc4d6>] [<c01bc781>] [<c0105086>] 
   [<c0105058>] [<c0106f69>] 
Code: 8b 50 40 8b 40 3c 52 50 8d 41 10 50 e8 d5 f6 fe ff 83 c4 0c 


>>EIP; c01c55ae <ide_toggle_bounce+2a/4c>   <=====

>>ebx; c02f9dfc <ide_hwifs+bc/3a48>
>>ecx; c02f9dec <ide_hwifs+ac/3a48>
>>esi; c02f9dec <ide_hwifs+ac/3a48>
>>edi; c8fa0214 <END_OF_CODE+8c9fe68/????>
>>esp; c12d5f34 <END_OF_CODE+fd5b88/????>

Trace; c01bbe57 <ide_init_queue+5f/68>
Trace; c01bc0de <init_irq+27e/338>
Trace; c01bc4d6 <hwif_init+112/258>
Trace; c01bc781 <ideprobe_init+79/f0>
Trace; c0105086 <init+2e/188>
Trace; c0105058 <init+0/188>
Trace; c0106f69 <kernel_thread_helper+5/c>

Code;  c01c55ae <ide_toggle_bounce+2a/4c>
00000000 <_EIP>:
Code;  c01c55ae <ide_toggle_bounce+2a/4c>   <=====
   0:   8b 50 40                  mov    0x40(%eax),%edx   <=====
Code;  c01c55b1 <ide_toggle_bounce+2d/4c>
   3:   8b 40 3c                  mov    0x3c(%eax),%eax
Code;  c01c55b4 <ide_toggle_bounce+30/4c>
   6:   52                        push   %edx
Code;  c01c55b5 <ide_toggle_bounce+31/4c>
   7:   50                        push   %eax
Code;  c01c55b6 <ide_toggle_bounce+32/4c>
   8:   8d 41 10                  lea    0x10(%ecx),%eax
Code;  c01c55b9 <ide_toggle_bounce+35/4c>
   b:   50                        push   %eax
Code;  c01c55ba <ide_toggle_bounce+36/4c>
   c:   e8 d5 f6 fe ff            call   fffef6e6 <_EIP+0xfffef6e6> c01b4c94 <blk_queue_bounce_limit+0/e8>
Code;  c01c55bf <ide_toggle_bounce+3b/4c>
  11:   83 c4 0c                  add    $0xc,%esp

 <0>Kernel panic: Attempted to kill init!

1 error issued.  Results may not be reliable.

-- 
* Witek Krecicki   adasi@pld.org.pl adasi@kernel.pl  GG346981 +48502117580 *
* "None but ourselves can free our minds"  -  Bob Marley,  Redemption Song *
* http://www.risingsun.org  http://www.kernel.org    http://www.pld.org.pl *
* http://risingsun.eu.org    http://www.6bone.pl    http://www.amnesty.org *

