Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264374AbTGBSuK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 14:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264377AbTGBSuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 14:50:10 -0400
Received: from pop.gmx.net ([213.165.64.20]:13526 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264374AbTGBSuB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 14:50:01 -0400
Message-ID: <3F032991.3030201@gmx.at>
Date: Wed, 02 Jul 2003 20:50:57 +0200
From: Wilfried Weissmann <Wilfried.Weissmann@gmx.at>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020623 Debian/1.0.0-0.woody.1
MIME-Version: 1.0
To: Wil Reichert <wilreichert@yahoo.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: highpoint driver problem, 2.4.21-ac4
References: <4FHn.4MD.1@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wil Reichert wrote:
 > The on-board Highpoint controller (HPT372A) on my DFI NF2 is having
 > issue.  Loading the hptraid module results in a 'No such device'
 > message while the hpt366 module segfaults and leaves an oops in my
 > logs.  These errors occur regardless of the disk/raid configuration
 > in the hpt BIOS.   Following are the oops trace, an lsmod, the
 > .config and a lspci -vvv.

The crash occurs in the hpt366 module. Loading hptraid will not work 
because it depends on the kernel to claim the disks of the raid volume 
(that is what hpt366 would do). I will add autoloading of the 
ide-controller module in the next raid-driver release. However, I do not 
know why the kernel oopses. You might want to try to build the hpt366 
code into the kernel instead of a module. If it works it would probably 
mean that "ide_hwif_t *hwif" was not properly initalized.

bye,
wilfried

 >
 > Wil
 >
 > ksymoops 2.4.8 on i686 2.4.21-ac4.  Options used -V (default) -k
 > /proc/ksyms (default) -l /proc/modules (default) -o
 > /lib/modules/2.4.21-ac4/ (default) -m /boot/System.map-2.4.21-ac4
 > (default)
 >
 > Unable to handle kernel NULL pointer dereference at virtual address
 > 00000000 c0296a40 *pde = 00000000 Oops: 0002 CPU:    0 EIP:
 > 0010:[<c0296a40>]    Not tainted Using defaults from ksymoops -t
 > elf32-i386 -a i386 EFLAGS: 00010246 eax: 00000000   ebx: dfeff400
 > ecx: 00000005   edx: cfa63e52 esi: e0b91930   edi: e0b91930   ebp:
 > c02ed950   esp: cfa63e40 ds: 0018   es: 0018   ss: 0018 Process
 > insmod.modutils (pid: 10075, stackpage=cfa63000) Stack: c01ca08e
 > c02ed950 00000004 cfa63e52 00050028 c02ed950 e0b91930 e0b9194e
 > 0000f004 c01ca3cc dfeff400 e0b91930 c02ed950 00000000 0000000b
 > 00000000 0000000b 00000001 00000000 00000000 0027b4d0 00000000
 > e0b91a9c e0b91b60 Call Trace:    [<c01ca08e>] [<e0b91930>]
 > [<e0b9194e>] [<c01ca3cc>] [<e0b91930>] [<e0b91a9c>] [<e0b91b60>]
 > [<c01ca5b7>] [<e0b91930>] [<e0b90646>] [<e0b91930>] [<c01d1e65>]
 > [<e0b91a9c>] [<e0b91b60>] [<c01d1efb>] [<e0b91b60>] [<e0b91b60>]
 > [<c01ca664>] [<e0b91b60>] [<e0b9066f>] [<e0b91b60>] [<c011744a>]
 > [<e0b8e060>] [<e0b8e060>] [<c0107207>] Code: 00 00 00 00 88 01 05 00
 > 00 10 00 00 01 fe 00 00 00 00 00 00
 >
 >
 >
 >>> EIP; c0296a40 <ide_get_or_set_dma_base+0/170>   <=====
 >>
 >
 >>> ebx; dfeff400 <_end+1fc0d880/205c6500> edx; cfa63e52
 >>> <_end+f7722d2/205c6500> esi; e0b91930
 >>> <[hpt366]hpt366_chipsets+30/150> edi; e0b91930
 >>> <[hpt366]hpt366_chipsets+30/150> ebp; c02ed950
 >>> <ide_hwifs+1170/2b98> esp; cfa63e40 <_end+f7722c0/205c6500>
 >>
 >
 > Trace; c01ca08e <ide_hwif_setup_dma+6e/140> Trace; e0b91930
 > <[hpt366]hpt366_chipsets+30/150> Trace; e0b9194e
 > <[hpt366]hpt366_chipsets+4e/150> Trace; c01ca3cc
 > <do_ide_setup_pci_device+14c/310> Trace; e0b91930
 > <[hpt366]hpt366_chipsets+30/150> Trace; e0b91a9c
 > <[hpt366]hpt366_pci_tbl+1c/e0> Trace; e0b91b60 <[hpt366]driver+0/27>
 > Trace; c01ca5b7 <ide_setup_pci_device+27/30> Trace; e0b91930
 > <[hpt366]hpt366_chipsets+30/150> Trace; e0b90646
 > <[hpt366]hpt366_init_one+36/50> Trace; e0b91930
 > <[hpt366]hpt366_chipsets+30/150> Trace; c01d1e65
 > <pci_announce_device+35/70> Trace; e0b91a9c
 > <[hpt366]hpt366_pci_tbl+1c/e0> Trace; e0b91b60 <[hpt366]driver+0/27>
 > Trace; c01d1efb <pci_register_driver+5b/60> Trace; e0b91b60
 > <[hpt366]driver+0/27> Trace; e0b91b60 <[hpt366]driver+0/27> Trace;
 > c01ca664 <ide_pci_register_driver+44/70> Trace; e0b91b60
 > <[hpt366]driver+0/27> Trace; e0b9066f <[hpt366]hpt366_ide_init+f/20>
 > Trace; e0b91b60 <[hpt366]driver+0/27> Trace; c011744a
 > <sys_init_module+52a/6b0> Trace; e0b8e060
 > <[radeon]radeon_stub_info+7628/7648> Trace; e0b8e060
 > <[radeon]radeon_stub_info+7628/7648> Trace; c0107207
 > <system_call+33/38>
 >
 > Code;  c0296a40 <ide_get_or_set_dma_base+0/170> 00000000 <_EIP>:
 > Code;  c0296a40 <ide_get_or_set_dma_base+0/170>   <===== 0:   00 00
 > add    %al,(%eax)   <===== Code;  c0296a42
 > <ide_get_or_set_dma_base+2/170> 2:   00 00                     add
 > %al,(%eax) Code;  c0296a44 <ide_get_or_set_dma_base+4/170> 4:   88 01
 > mov    %al,(%ecx) Code;  c0296a46 <ide_get_or_set_dma_base+6/170> 6:
 > 05 00 00 10 00            add    $0x100000,%eax Code;  c0296a4b
 > <ide_get_or_set_dma_base+b/170> b:   00 01                     add
 > %al,(%ecx) Code;  c0296a4d <ide_get_or_set_dma_base+d/170> d:   fe 00
 > incb   (%eax)
 >

[snip]


