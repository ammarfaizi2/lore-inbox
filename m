Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265648AbTFXD1X (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 23:27:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265649AbTFXD1X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 23:27:23 -0400
Received: from ms-smtp-01.texas.rr.com ([24.93.36.229]:54496 "EHLO
	ms-smtp-01.texas.rr.com") by vger.kernel.org with ESMTP
	id S265648AbTFXD1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 23:27:21 -0400
Message-ID: <3EF7C867.8010103@austin.rr.com>
Date: Mon, 23 Jun 2003 22:41:27 -0500
From: Howard Shane <hshane@austin.rr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.21 oops on boot w/PDC20267
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Upon compiling and installing 2.4.21 for the first time I get an oops 
upon loading the older of the new Promise driver modules:

Jun 22 21:59:31 K7 kernel: PDC20267: IDE controller at PCI slot 00:0f.0
Jun 22 21:59:31 K7 kernel: PCI: Found IRQ 5 for device 00:0f.0
Jun 22 21:59:31 K7 kernel: PCI: Sharing IRQ 5 with 00:02.2
Jun 22 21:59:31 K7 kernel: PDC20267: chipset revision 2
Jun 22 21:59:31 K7 kernel: PDC20267: not 100%% native mode: will probe 
irqs later
Jun 22 21:59:31 K7 kernel: PDC20267: ROM enabled at 0xcffd0000
Jun 22 21:59:31 K7 kernel: Unable to handle kernel paging request at 
virtual address a928af1a
Jun 22 21:59:31 K7 kernel:  printing eip:
Jun 22 21:59:31 K7 kernel: a928af1a
Jun 22 21:59:31 K7 kernel: *pde = 00000000
Jun 22 21:59:31 K7 kernel: Oops: 0000
Jun 22 21:59:31 K7 kernel: CPU:    0
Jun 22 21:59:31 K7 kernel: EIP: 
0010:[zisofs_cleanup+-1456951734/-1072693456]    Not tainted
Jun 22 21:59:31 K7 kernel: EFLAGS: 00010246
Jun 22 21:59:31 K7 kernel: eax: e0a1a7f8   ebx: de093e6a   ecx: 00000007 
   edx: 00000000
Jun 22 21:59:31 K7 kernel: esi: c02b5a08   edi: dffe2c00   ebp: de093e6c 
   esp: de093e50
Jun 22 21:59:31 K7 kernel: ds: 0018   es: 0018   ss: 0018
Jun 22 21:59:31 K7 kernel: Process modprobe (pid: 364, stackpage=de093000)
Jun 22 21:59:31 K7 kernel: Stack: c02857a5 c01bf478 c02b5a08 c02b5a08 
e0a1a816 e0a1f002 0007f7cf e0a1a7f8
Jun 22 21:59:31 K7 kernel:        c01bf843 dffe2c00 e0a1a7f8 c02b5a08 
dffe2c00 dffe2c00 e0a1a920 00000000
Jun 22 21:59:31 K7 kernel:        00000000 00000005 00000001 00000000 
00000000 ce12452b 00000000 c01bf8b7
Jun 22 21:59:31 K7 kernel: Call Trace:    [ide_hwif_setup_dma+72/256] 
[<e0a1a816>] [<e0a1a7f8>] [do_ide_setup_pci_device+531/624] [<e0a1a7f8>]
Jun 22 21:59:31 K7 kernel:   [<e0a1a920>] [ide_setup_pci_device+23/32] 
[<e0a1a7f8>] [<e0a19aaf>] [<e0a1a7f8>] [<e0a19af7>]
Jun 22 21:59:31 K7 kernel:   [<e0a1a7f8>] [<e0a1a8cc>] 
[pci_announce_device+53/80] [<e0a1a8cc>] [<e0a1a920>] 
[pci_register_driver+68/96]
Jun 22 21:59:31 K7 kernel:   [<e0a1a920>] [<e0a1a920>] 
[ide_pci_register_driver+21/80] [<e0a1a920>] [<e0a19b1a>] [<e0a1a920>]
Jun 22 21:59:31 K7 kernel:   [sys_init_module+1393/1584] [<e0a18060>] 
[system_call+51/56]

I ran ksymoops after reinstalling 2.4.20 and got the following

ksymoops 2.4.5 on i686 2.4.20.  Options used

-----------snip--------------

Jun 22 21:59:31 K7 kernel: Unable to handle kernel paging request at 
virtual address a928af1a
Jun 22 21:59:31 K7 kernel: a928af1a
Jun 22 21:59:31 K7 kernel: *pde = 00000000
Jun 22 21:59:31 K7 kernel: Oops: 0000
Jun 22 21:59:31 K7 kernel: CPU:    0
Jun 22 21:59:31 K7 kernel: EIP: 
0010:[zisofs_cleanup+-1456951734/-1072693456]    Not tainted
Jun 22 21:59:31 K7 kernel: EFLAGS: 00010246
Jun 22 21:59:31 K7 kernel: eax: e0a1a7f8   ebx: de093e6a   ecx: 00000007 
   edx: 00000000
Jun 22 21:59:31 K7 kernel: esi: c02b5a08   edi: dffe2c00   ebp: de093e6c 
   esp: de093e50
Jun 22 21:59:31 K7 kernel: ds: 0018   es: 0018   ss: 0018
Jun 22 21:59:31 K7 kernel: Process modprobe (pid: 364, stackpage=de093000)
Jun 22 21:59:31 K7 kernel: Stack: c02857a5 c01bf478 c02b5a08 c02b5a08 
e0a1a816 e0a1f002 0007f7cf e0a1a7f8
Jun 22 21:59:31 K7 kernel:        c01bf843 dffe2c00 e0a1a7f8 c02b5a08 
dffe2c00 dffe2c00 e0a1a920 00000000
Jun 22 21:59:31 K7 kernel:        00000000 00000005 00000001 00000000 
00000000 ce12452b 00000000 c01bf8b7
Jun 22 21:59:31 K7 kernel: Call Trace:    [ide_hwif_setup_dma+72/256] 
[<e0a1a816>] [<e0a1a7f8>] [do_ide_setup_pci_device+531/624] [<e0a1a7f8>]
Jun 22 21:59:31 K7 kernel:   [<e0a1a920>] [ide_setup_pci_device+23/32] 
[<e0a1a7f8>] [<e0a19aaf>] [<e0a1a7f8>] [<e0a19af7>]
Jun 22 21:59:31 K7 kernel:   [<e0a1a7f8>] [<e0a1a8cc>] 
[pci_announce_device+53/80] [<e0a1a8cc>] [<e0a1a920>] 
[pci_register_driver+68/96]
Jun 22 21:59:31 K7 kernel:   [<e0a1a920>] [<e0a1a920>] 
[ide_pci_register_driver+21/80] [<e0a1a920>] [<e0a19b1a>] [<e0a1a920>]
Jun 22 21:59:31 K7 kernel: Code:  Bad EIP value
Using defaults from ksymoops -t elf32-i386 -a i386

