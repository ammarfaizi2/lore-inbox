Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266555AbTGRQxt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 12:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267517AbTGRQxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 12:53:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:19384 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266555AbTGRQx3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 12:53:29 -0400
Message-ID: <3F1828AA.40506@gmx.at>
Date: Fri, 18 Jul 2003 19:04:42 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Oops when modprobing piix (2.4.21)
References: <awi2.Vz.5@gated-at.bofh.it>
Content-Type: multipart/mixed;
 boundary="------------060802090208080709020808"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060802090208080709020808
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Tuukka Toivonen wrote:
 > [1.] Summary:
 > Oops when modprobing piix (2.4.21, 2.4.20 not tested)

the attached patch fixes the problem. i just recognized that the fix is 
already merged into 2.4.21-pre6-ac1.

greetings,
wilfried

 >
 > [2.] Full description:
 > When piix support is compiled as module, and I type
 > 	modprobe piix
 > I get immediately kernel oops message. modprobe crashes with 
segmentation fault.
 >
 > [3.] Keywords:
 > piix, ide, dma
 >
 > [4.] Kernel version:
 > Linux version 2.4.21
 >
 > [5.] Output of Oops:
 > ksymoops 2.4.5 on i586 2.4.21.  Options used
 >      -V (default)
 >      -k /proc/ksyms (default)
 >      -l /proc/modules (default)
 >      -o /lib/modules/2.4.21/ (default)
 >      -m /boot/vmlinuz-2.4.21.map (specified)
 >
 > Jul  5 01:21:01 datazone kernel: Unable to handle kernel paging 
request at virtual address 83a52264
 > Jul  5 01:21:01 datazone kernel: c01f1e52
 > Jul  5 01:21:01 datazone kernel: *pde = 00000000
 > Jul  5 01:21:01 datazone kernel: Oops: 0002
 > Jul  5 01:21:01 datazone kernel: CPU:    0
 > Jul  5 01:21:01 datazone kernel: EIP:    0010:[<c01f1e52>]    Not tainted
 > Using defaults from ksymoops -t elf32-i386 -a i386
 > Jul  5 01:21:01 datazone kernel: EFLAGS: 00010282
 > Jul  5 01:21:01 datazone kernel: eax: c3812884   ebx: c1397e46   ecx: 
00000cf8   edx: 00000000
 > Jul  5 01:21:01 datazone kernel: esi: c023f9e0   edi: c10fc800   ebp: 
c1397e48   esp: c1397e30
 > Jul  5 01:21:01 datazone kernel: ds: 0018   es: 0018   ss: 0018
 > Jul  5 01:21:01 datazone kernel: Process modprobe (pid: 2467, 
stackpage=c1397000)
 > Jul  5 01:21:01 datazone kernel: Stack: c01788a8 c023f9e0 c023f9e0 
c38128a2 c381f000 00058bdf c1397e84 c0178c5a
 > Jul  5 01:21:01 datazone kernel:        c10fc800 c3812884 c023f9e0 
c10fc800 c10fc800 c3812e00 00000000 00000000
 > Jul  5 01:21:01 datazone kernel:        00000001 00000000 00000000 
e11db874 00000000 c1397ea0 c0178ccd c1397e9c
 > Jul  5 01:21:01 datazone kernel: Call Trace:    [<c01788a8>] 
[<c38128a2>] [<c0178c5a>] [<c3812884>] [<c3812e00>]
 > Jul  5 01:21:01 datazone kernel:   [<c0178ccd>] [<c3812884>] 
[<c011e4be>] [<c3811f18>] [<c3812884>] [<c3811f54>]
 > Jul  5 01:21:01 datazone kernel:   [<c3812884>] [<c3812c10>] 
[<c017c17e>] [<c3812c10>] [<c3812e00>] [<c017c1e7>]
 > Jul  5 01:21:01 datazone kernel:   [<c3812e00>] [<c3812e00>] 
[<c0178d1f>] [<c3812e00>] [<c3812012>] [<c3812e00>]
 > Jul  5 01:21:01 datazone kernel:   [<c01127f5>] [<c0127fa2>] 
[<c3811060>] [<c0106c93>]
 > Jul  5 01:21:01 datazone kernel: Code: 30 34 30 30 30 0a 23 64 65 66 
69 6e 65 20 4d 41 53 4b 5f 31
 >
 >
 >
 >>>EIP; c01f1e52 <ide_get_or_set_dma_base+2/148>   <=====
 >>
 >
 >>>eax; c3812884 <[piix]piix_pci_info+90/3c0>
 >>>ebx; c1397e46 <_end+11541ba/35bc374>
 >>>ecx; 00000cf8 Before first symbol
 >>>esi; c023f9e0 <ide_hwifs+0/2c88>
 >>>edi; c10fc800 <_end+eb8b74/35bc374>
 >>>ebp; c1397e48 <_end+11541bc/35bc374>
 >>>esp; c1397e30 <_end+11541a4/35bc374>
 >>
 >
 > Trace; c01788a8 <ide_hwif_setup_dma+48/f0>
 > Trace; c38128a2 <[piix]piix_pci_info+ae/3c0>
 > Trace; c0178c5a <do_ide_setup_pci_device+222/27c>
 > Trace; c3812884 <[piix]piix_pci_info+90/3c0>
 > Trace; c3812e00 <[piix]driver+0/3f>
 > Trace; c0178ccd <ide_setup_pci_device+19/20>
 > Trace; c3812884 <[piix]piix_pci_info+90/3c0>
 > Trace; c011e4be <do_anonymous_page+e2/100>
 > Trace; c3811f18 <[piix]init_setup_piix+10/14>
 > Trace; c3812884 <[piix]piix_pci_info+90/3c0>
 > Trace; c3811f54 <[piix]piix_init_one+38/50>
 > Trace; c3812884 <[piix]piix_pci_info+90/3c0>
 > Trace; c3812c10 <[piix]piix_pci_tbl+54/244>
 > Trace; c017c17e <pci_announce_device+42/68>
 > Trace; c3812c10 <[piix]piix_pci_tbl+54/244>
 > Trace; c3812e00 <[piix]driver+0/3f>
 > Trace; c017c1e7 <pci_register_driver+43/60>
 > Trace; c3812e00 <[piix]driver+0/3f>
 > Trace; c3812e00 <[piix]driver+0/3f>
 > Trace; c0178d1f <ide_pci_register_driver+17/5c>
 > Trace; c3812e00 <[piix]driver+0/3f>
 > Trace; c3812012 <[piix]piix_ide_init+12/18>
 > Trace; c3812e00 <[piix]driver+0/3f>
 > Trace; c01127f5 <sys_init_module+5a9/664>
 > Trace; c0127fa2 <__alloc_pages+3e/14c>
 > Trace; c3811060 <[piix]__module_description+0/0>
 > Trace; c0106c93 <system_call+33/40>
 >
 > Code;  c01f1e52 <ide_get_or_set_dma_base+2/148>
 > 00000000 <_EIP>:
 > Code;  c01f1e52 <ide_get_or_set_dma_base+2/148>   <=====
 >    0:   30 34 30                  xor    %dh,(%eax,%esi,1)   <=====
 > Code;  c01f1e55 <ide_get_or_set_dma_base+5/148>
 >    3:   30 30                     xor    %dh,(%eax)
 > Code;  c01f1e57 <ide_get_or_set_dma_base+7/148>
 >    5:   0a 23                     or     (%ebx),%ah
 > Code;  c01f1e59 <ide_get_or_set_dma_base+9/148>
 >    7:   64 65 66 69 6e 65 20      imul   $0x4d20,%fs:%gs:0x65(%esi),%bp
 > Code;  c01f1e60 <ide_get_or_set_dma_base+10/148>
 >    e:   4d
 > Code;  c01f1e61 <ide_get_or_set_dma_base+11/148>
 >    f:   41                        inc    %ecx
 > Code;  c01f1e62 <ide_get_or_set_dma_base+12/148>
 >   10:   53                        push   %ebx
 > Code;  c01f1e63 <ide_get_or_set_dma_base+13/148>
 >   11:   4b                        dec    %ebx
 > Code;  c01f1e64 <ide_get_or_set_dma_base+14/148>
 >   12:   5f                        pop    %edi
 > Code;  c01f1e65 <ide_get_or_set_dma_base+15/148>
 >   13:   31 00                     xor    %eax,(%eax)


--------------060802090208080709020808
Content-Type: text/plain;
 name="linux-2.4.21-ac4-idedmafix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.4.21-ac4-idedmafix.patch"

--- linux/drivers/ide/setup-pci.c.orig	2003-07-06 00:04:06.000000000 +0200
+++ linux/drivers/ide/setup-pci.c	2003-07-06 00:04:12.000000000 +0200
@@ -172,7 +172,7 @@ static int ide_setup_pci_baseregs (struc
  *	is already in DMA mode we check and enforce IDE simplex rules.
  */
 
-static unsigned long __init ide_get_or_set_dma_base (ide_hwif_t *hwif)
+static unsigned long ide_get_or_set_dma_base (ide_hwif_t *hwif)
 {
 	unsigned long	dma_base = 0;
 	struct pci_dev	*dev = hwif->pci_dev;


--------------060802090208080709020808--


