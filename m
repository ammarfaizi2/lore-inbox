Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269135AbRGaBQY>; Mon, 30 Jul 2001 21:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269137AbRGaBQO>; Mon, 30 Jul 2001 21:16:14 -0400
Received: from rj.SGI.COM ([204.94.215.100]:9449 "EHLO rj.corp.sgi.com")
	by vger.kernel.org with ESMTP id <S269135AbRGaBQJ>;
	Mon, 30 Jul 2001 21:16:09 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Linus Torvalds <torvalds@transmeta.com>
cc: mason@suse.com, linux-kernel@vger.kernel.org,
        "Justin T. Gibbs" <gibbs@scsiguy.com>
Subject: Re: BUG at smp.c:481, 2.4.8-pre2 
In-Reply-To: Your message of "Mon, 30 Jul 2001 10:33:08 MST."
             <200107301733.f6UHX8H01494@penguin.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 31 Jul 2001 11:16:06 +1000
Message-ID: <31650.996542166@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Mon, 30 Jul 2001 10:33:08 -0700, 
Linus Torvalds <torvalds@transmeta.com> wrote:
>In article <296370000.996508500@tiny> you write:
>>
>>Ok, During boot on 2.4.8-pre2 I'm getting this oops just as it starts to
>>probe my aic7890 card.  Andrea is cc'd because I'm guessing it is due to
>>one of his patches ;-)
>
>It's a sanity check, which I removed (because it's worse to panic in a
>2.4.x kernel than it is to have the sanity problem). But the sanity
>check does show that there is some problem in ahc_pci_map_registers():
>it calls "ioremap()" with interrupts disabled, which is rather broken.

FYI, same problem with aic7xxx on 2.4.8-pre2.  Sorry, Linus, it is using a
kernel debugger ;)

SCSI subsystem driver Revision: 1.00
scsi0 : AdvanSys SCSI 3.3G: PCI Ultra: IO 0x2000-0x200F, IRQ 0x13
  Vendor: ARCHIVE   Model: Python 25601-XXX  Rev: 2.75
  Type:   Sequential-Access                  ANSI SCSI revision: 02
kernel BUG at smp.c:501!

Entering kdb (current=0xc1232000, pid 1) on processor 1 Oops: invalid operand
due to oops @ 0xc010eaba
eax = 0x00000019 ebx = 0x00000020 ecx = 0x00000001 edx = 0x00000001 
esi = 0xc037fc28 edi = 0xc1233d5c esp = 0xc1233d44 eip = 0xc010eaba 
ebp = 0xc1233d70 xss = 0x00000018 xcs = 0x00000010 eflags = 0x00010082 
xds = 0x00000018 xes = 0x00000018 origeax = 0xffffffff &regs = 0xc1233d10
[1]kdb> bt
    EBP       EIP         Function(args)
0xc1233d70 0xc010eaba smp_call_function+0xc6 (0xc010e8e8, 0x0, 0x1, 0x1)
                               kernel .text 0xc0100000 0xc010e9f4 0xc010eaec
0xc1233d8c 0xc010e94c flush_tlb_all+0x14
                               kernel .text 0xc0100000 0xc010e938 0xc010e998
0xc1233dcc 0xc0110b73 remap_area_pages+0x1e3 (0xc8c00000, 0xf4100000, 0x1000, 0x10)
                               kernel .text 0xc0100000 0xc0110990 0xc0110b80
0xc1233df8 0xc0110c4d __ioremap+0xcd (0xf4100000, 0x100, 0x10)
                               kernel .text 0xc0100000 0xc0110b80 0xc0110c74
0xc1233e28 0xc01cd9f4 ahc_pci_map_registers+0xbc (0xc7f71a00)
                               kernel .text 0xc0100000 0xc01cd938 0xc01cdb64
0xc1233e70 0xc01d9752 ahc_pci_config+0x42 (0xc7f71a00, 0xc032a2fc, 0xc7f9b000)
                               kernel .text 0xc0100000 0xc01d9710 0xc01d9bec
0xc1233ef4 0xc01cd8c8 ahc_linux_pci_dev_probe+0xe8 (0xc7f9b000, 0xc032879c)
                               kernel .text 0xc0100000 0xc01cd7e0 0xc01cd908
0xc1233f14 0xc01e85ae pci_announce_device+0x3e (0xc03287e0, 0xc7f9b000, 0x202)
                               kernel .text 0xc0100000 0xc01e8570 0xc01e85d4
0xc1233f30 0xc01e8617 pci_register_driver+0x43 (0xc03287e0)
                               kernel .text 0xc0100000 0xc01e85d4 0xc01e8634
0xc1233f40 0xc01cd916 ahc_linux_pci_probe+0xe (0xc0328700)
                               kernel .text 0xc0100000 0xc01cd908 0xc01cd938
0xc1233f58 0xc01ca64c ahc_linux_detect+0x1c (0xc0328700)
                               kernel .text 0xc0100000 0xc01ca630 0xc01ca694
0xc1233fa0 0xc01b833f scsi_register_host+0x5b (0xc0328700)
                               kernel .text 0xc0100000 0xc01b82e4 0xc01b85d8
0xc1233fb0 0xc01b8d4d scsi_register_module+0x29
                               kernel .text 0xc0100000 0xc01b8d24 0xc01b8d7c
0xc1233fc0 0xc0347079 AdvWaitEEPCmd+0x69
                               kernel .text.init 0xc0332000 0xc0347010 0xc03470a0
0xc1233fcc 0xc03329e9 do_initcalls+0xd
                               kernel .text.init 0xc0332000 0xc03329dc 0xc0332a00
0xc1233fd4 0xc0332a2e do_basic_setup+0x2e (0x10f00)
                               kernel .text.init 0xc0332000 0xc0332a00 0xc0332a40
0xc1233fec 0xc01050ae init+0x32
                               kernel .text 0xc0100000 0xc010507c 0xc0105230
           0xc01055c7 kernel_thread+0x23
                               kernel .text 0xc0100000 0xc01055a4 0xc01055dc
[1]kdb> 

