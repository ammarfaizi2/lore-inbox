Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265471AbSKAAiX>; Thu, 31 Oct 2002 19:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265459AbSKAAiX>; Thu, 31 Oct 2002 19:38:23 -0500
Received: from ulima.unil.ch ([130.223.144.143]:6022 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S265471AbSKAAiR>;
	Thu, 31 Oct 2002 19:38:17 -0500
Date: Fri, 1 Nov 2002 01:44:43 +0100
From: Gregoire Favre <greg@ulima.unil.ch>
To: Kai Germaschewski <kai-germaschewski@uiowa.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.45 : kernel BUG at kernel/workqueue.c:69! (ISDN?)
Message-ID: <20021101004443.GA27854@ulima.unil.ch>
References: <20021031215441.GD24890@ulima.unil.ch> <Pine.LNX.4.44.0210311620470.27728-100000@chaos.physics.uiowa.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0210311620470.27728-100000@chaos.physics.uiowa.edu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello again,

I can't compil AVM Fritz!Card PCI/PCIv2/PnP support in the kernel:

  Generating include/linux/compile.h (updated)
  gcc -Wp,-MD,init/.version.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2 -march=pentium4 -Iarch/i386/mach-generic -nostdinc -iwithprefix include    -DKBUILD_BASENAME=version   -c -o init/version.o init/version.c
   ld -m elf_i386  -r -o init/built-in.o init/main.o init/version.o init/do_mounts.o
  	ld -m elf_i386 -e stext -T arch/i386/vmlinux.lds.s arch/i386/kernel/head.o arch/i386/kernel/init_task.o  init/built-in.o --start-group  arch/i386/kernel/built-in.o  arch/i386/mm/built-in.o  arch/i386/mach-generic/built-in.o  kernel/built-in.o  mm/built-in.o  fs/built-in.o  ipc/built-in.o  security/built-in.o  crypto/built-in.o  lib/lib.a  arch/i386/lib/lib.a  drivers/built-in.o  sound/built-in.o  arch/i386/pci/built-in.o  net/built-in.o --end-group  -o vmlinux
drivers/built-in.o(.data+0x18ff4): undefined reference to `local symbols in discarded section .exit.text'
make: *** [vmlinux] Error 1

As a module, it compils just perfectly!!!
But modprobe hisax_fcpcipnp result in an oops, this time I compil with
CONFIG_KALLSYMS=y and see if that would say more...

I got (modprobe hisax_fcpcipnp):

hisax_isac: ISAC-S/ISAC-SX ISDN driver v0.1.0
hisax_fcpcipnp: Fritz!Card PCI/PCIv2/PnP ISDN driver v0.0.1
Debug: sleeping function called from illegal context at mm/slab.c:1304
Call Trace:
 [<c013663a>] kmem_flagcheck+0x5e/0x60
 [<c01366dc>] cache_grow+0xa0/0x224
 [<c01369aa>] cache_alloc_refill+0x14a/0x1b4
 [<c0136abc>] kmem_cache_alloc+0x40/0x42
 [<c0185070>] devfsd_notify_de+0x58/0xfc
 [<c018516d>] devfsd_notify+0x59/0x86
 [<c0185398>] devfs_register+0x1fe/0x350
 [<c0210000>] xfs_read+0x1c4/0x222
 [<c02cfd77>] isdn_register_devfs+0x71/0x86
 [<c02cf96d>] isdn_add_channels+0x97/0xb4
 [<c02ce123>] register_isdn+0x11f/0x1c6
 [<c02d8a41>] hisax_register+0x8d/0x158
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<e37aaff0>] new_adapter+0xd2/0xdc [hisax_fcpcipnp]
 [<e37ab59e>] .rodata.str1.1+0x47/0x5d [hisax_fcpcipnp]
 [<e37ab040>] fcpci_probe+0x20/0xa0 [hisax_fcpcipnp]
 [<e37abfe0>] fcpci_driver+0x0/0x7c [hisax_fcpcipnp]
 [<c022142e>] pci_device_probe+0x5e/0x6c
 [<e37abf60>] fcpci_ids+0x0/0x54 [hisax_fcpcipnp]
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<c0229bd8>] bus_match+0x42/0x6e
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<c0229cde>] driver_attach+0x5c/0x74
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<c0229f8f>] bus_add_driver+0x69/0x94
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<c022a490>] driver_register+0x46/0x52
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<c022153d>] pci_register_driver+0x3b/0x4c
 [<e37ac008>] fcpci_driver+0x28/0x7c [hisax_fcpcipnp]
 [<e37ab1fb>] init_module+0x1f/0x48 [hisax_fcpcipnp]
 [<e37abfe0>] fcpci_driver+0x0/0x7c [hisax_fcpcipnp]
 [<c011c8a1>] sys_init_module+0x4eb/0x62e
 [<e37aa060>] fcpci_read_isac+0x0/0x64 [hisax_fcpcipnp]
 [<e37ab7e8>] .kmodtab+0x0/0xc [hisax_fcpcipnp]
 [<e37aa060>] fcpci_read_isac+0x0/0x64 [hisax_fcpcipnp]
 [<c0107457>] syscall_call+0x7/0xb

get_drv 0: 0 -> 1
fcpcipnp0: State ST_DRV_NULL Event EV_DRV_REGISTER
fcpcipnp0: ChangeState ST_DRV_LOADED
HiSax: Card 1 Protocol EDSS1 Id=fcpcipnp0 (0)
HiSax: DSS1 Rev. 2.30.6.2
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
get_drv 0: 1 -> 2
fcpcipnp0: State ST_DRV_LOADED Event EV_STAT_RUN
fcpcipnp0: ChangeState ST_DRV_RUNNING
put_drv 0: 2 -> 1
hisax_fcpcipnp: found adapter Fritz!Card PCI at 03:00.0

And compiling the kernel with the "old one":
ISDN subsystem initialized
PPP BSD Compression module registered
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
HiSax: Linux Driver for passive ISDN cards
HiSax: Version 3.5 (kernel)
HiSax: Layer1 Revision 2.41.6.5
HiSax: Layer2 Revision 2.25.6.4
HiSax: TeiMgr Revision 2.17.6.3
HiSax: Layer3 Revision 2.17.6.5
HiSax: LinkLayer Revision 2.51.6.6
HiSax: Approval certification failed because of
HiSax: unauthorized source code changes
HiSax: Total 1 card defined
get_drv 0: 0 -> 1
HiSax: State ST_DRV_NULL Event EV_DRV_REGISTER
HiSax: ChangeState ST_DRV_LOADED
HiSax: Card 1 Protocol EDSS1 Id=HiSax (0)
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
HiSax: AVM PCI driver Rev. 1.22.6.6
FritzPnP: no ISA PnP present
AVM PCI: stat 0x2020a
AVM PCI: Class A Rev 2
HiSax: AVM Fritz!PCI config irq:16 base:0xB800
AVM PCI: ISAC version (0): 2086/2186 V1.1
psmouse.c: Received PS2++ packet #0, but don't know how to handle.
AVM Fritz PnP/PCI: IRQ 16 count 0
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_STAVAIL
put_drv 0: 2 -> 1
AVM Fritz PnP/PCI: IRQ 16 count 3
HiSax: DSS1 Rev. 2.30.6.2
HiSax: 2 channels added
HiSax: MAX_WAITING_CALLS added
get_drv 0: 1 -> 2
HiSax: State ST_DRV_LOADED Event EV_STAT_RUN
HiSax: ChangeState ST_DRV_RUNNING
put_drv 0: 2 -> 1

And if I manage connecting to internet using this last one, you'll
receive it ;-)

Well all that was working under 2.4 perfectly didn't work anymore here:
I don't know how to connect under 2.5: I use my ISDN Router and LAN
again...
Oups my script to enable LAN:
#!/bin/sh
isdn stop
isdnctrl delif ippp0 force
modprobe eepro100
ifconfig eth0 up
/etc/rc.d/init.d/network restart
ifup eth0

gives this:
/usr/local/bin/ROUTEUR: line 3:  3631 Segmentation fault      isdnctrl delif ippp0 force

And from dmesg:
ISDN_CMD_LOCK 0/0
ippp0: local hangup
Unable to handle kernel NULL pointer dereference at virtual address 0000004c
 printing eip:
c02c5b2f
*pde = 00000000
Oops: 0000
binfmt_misc dvb-ttpci alps_bsrv2 floppy eepro100 mii ext2 ehci-hcd usbcore  
CPU:    0
EIP:    0060:[<c02c5b2f>]    Not tainted
EFLAGS: 00010282
EIP is at fsm_event+0x1b/0xe6
eax: 0000004c   ebx: d4382000   ecx: d438220c   edx: dffef1e0
esi: 0000004c   edi: 0000001c   ebp: bffffb04   esp: ca4e9cd0
ds: 0068   es: 0068   ss: 0068
Process isdnctrl (pid: 3631, threadinfo=ca4e8000 task=d1a21380)
Stack: 0000568c 00000286 0000001d 00000001 d4382008 d4382000 d111de80 d4382004 
       bffffb04 c02cf8ac 0000004c 0000001c 00000000 c02c2d44 00000000 ffffffff 
       fffffff2 bffffb04 ca4e9d2c c02c37de d111de80 bffffb04 00000009 70707069 
Call Trace:
 [<c02cf8ac>] isdn_slot_free+0x22/0x26
 [<c02c2d44>] isdn_net_dev_delete+0x50/0xbe
 [<c02c37de>] isdn_net_ioctl+0xfc/0x320
 [<c01accf6>] check_journal_end+0x172/0x286
 [<c01ad28a>] do_journal_end+0xcc/0xbc8
 [<c0139d72>] buffered_rmqueue+0xce/0x168
 [<c014202e>] do_page_cache_readahead+0x74/0x152
 [<c0139ea8>] __alloc_pages+0x9c/0x2b0
 [<c0139d72>] buffered_rmqueue+0xce/0x168
 [<c0139ea8>] __alloc_pages+0x9c/0x2b0
 [<c0123c4c>] update_process_times+0x46/0x52
 [<c0123ac5>] update_wall_time+0xd/0x36
 [<c0123d8d>] do_timer+0xe9/0xee
 [<c010ce3f>] do_timer_interrupt+0x4f/0x100
 [<c0126acf>] collect_signal+0xab/0xea
 [<c012eae4>] do_wp_page+0x302/0x37e
 [<c02cefb8>] isdn_ctrl_ioctl+0x68/0x65c
 [<c012f543>] handle_mm_fault+0x7d/0xae
 [<c0115af7>] do_page_fault+0x25b/0x488
 [<c0126746>] sys_rt_sigaction+0x82/0xba
 [<c021f100>] copy_from_user+0x4c/0x50
 [<c0156dcb>] sys_ioctl+0xed/0x28a
 [<c011589c>] do_page_fault+0x0/0x488
 [<c0107457>] syscall_call+0x7/0xb

Code: 8b 0e 8b 5e 04 8b 41 04 39 c3 7d 05 3b 79 08 7c 3b c7 04 24

I think it will be quiete hard to use ISDN under 2.5...

Thank you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
