Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUGKIjb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUGKIjb (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 04:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266520AbUGKIja
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 04:39:30 -0400
Received: from herkules.viasys.com ([194.100.28.129]:23001 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S266519AbUGKIjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 04:39:16 -0400
Date: Sun, 11 Jul 2004 11:39:12 +0300
From: Ville Herva <vherva@viasys.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Christopher Swingley <cswingle@iarc.uaf.edu>, linux-kernel@vger.kernel.org
Subject: Re: IRQ issues, (nobody cared, disabled), not USB
Message-ID: <20040711083912.GG16073@viasys.com>
Reply-To: vherva@viasys.com
References: <20040708155356.GG22065@iarc.uaf.edu> <20040708220522.73839ea3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040708220522.73839ea3.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2+mremap-unmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 08, 2004 at 10:05:22PM -0700, you [Andrew Morton] wrote:
> Christopher Swingley <cswingle@iarc.uaf.edu> wrote:
> >
> > Greetings!
> > 
> > For the past few iterations of 2.6 (including the vanilla 2.6.7 I'm 
> > running now) I've had this problem:
> > 
> >  03:27:26 kernel: irq 7: nobody cared!
> > ...
> > I've tried booting without ACPI, and I've tried an eepro100 card instead 
> > of the 8139too that's causing the error above.  I believe I've tried 
> > different PCI slots for the second ethernet card too, but I may be 
> > mistaken about that.  No matter what I've tried, under 2.6, the second 
> > ethernet card gets disabled at some point between a few hours and a few 
> > days after the system boots.
> 
> hmm, so the eepro100 failed in the same way as the rtl8139?
> 
> That would tend to point at the PIC losing its brains.
> 
> It would be useful if you could go back to 2.6.5 for a while, so we can
> mostly-eliminate a hardware glitch.

I've had this sort of stuff with two different machines. I'm not sure if it
is related.

First machine: 2.6.6-mm4, ACPI no compiled in at all, preemt, Celeron
1.4GHz, i815 and HPT370A ide. When I attached Mitsumi DW-7802TE dvd-rw on
the HPT interface, and tried to enable DMA for it, I got:

--8<-----------------------------------------------------------------------
hdg: MITSUMI DW-7802TE, ATAPI CD/DVD-ROM drive                                  
irq 11: nobody cared!                                                           
 [<c0105724>] __report_bad_irq+0x24/0x90                                        
 [<c0105811>] note_interrupt+0x61/0x90                                          
 [<c01056d0>] handle_IRQ_event+0x30/0x60                                        
 [<c0105a9b>] do_IRQ+0x11b/0x130                                                
 [<c0104008>] common_interrupt+0x18/0x20                                        
 [<c011914d>] __do_softirq+0x2d/0x80                                            
 [<c01191c7>] do_softirq+0x27/0x30                                              
 [<c0105a78>] do_IRQ+0xf8/0x130                                                 
 [<c0104008>] common_interrupt+0x18/0x20                                        
 [<c022007b>] hpt372_tune_chipset+0xeb/0x100                                    
 [<c01058fb>] enable_irq+0x3b/0xc0                                              
 [<c0228b88>] probe_hwif+0x248/0x410                                            
 [<c0224a83>] idedefault_attach+0x13/0x50                                       
 [<c022980f>] hwif_init+0x12f/0x240                                             
 [<c0228d59>] probe_hwif_init+0x9/0x60                                          
 [<c022c685>] ide_setup_pci_device+0x65/0x80                                    
 [<c038d68b>] init_setup_hpt366+0x18b/0x190                                     
 [<c0176537>] create_proc_entry+0x77/0xc0                                       
 [<c0220b1f>] hpt366_init_one+0x2f/0x40                                         
 [<c038e234>] ide_scan_pcidev+0x54/0x70                                         
 [<c038e27e>] ide_scan_pcibus+0x2e/0xb0                                         
 [<c038e1c8>] ide_init+0x48/0x60                                                
 [<c037e62b>] do_initcalls+0x2b/0xc0                                            
 [<c0100420>] init+0x0/0x140                                                    
 [<c0100455>] init+0x35/0x140                                                   
 [<c0102198>] kernel_thread_helper+0x0/0x18                                     
 [<c010219d>] kernel_thread_helper+0x5/0x18                                     
                                                                                
handlers:                                                                       
[<c0225f20>] (ide_intr+0x0/0x180)                                               
Disabling IRQ #11                                                               
--8<-----------------------------------------------------------------------
                                                                                
In /proc/interrupts, there is:                                                  
  11:    1123881          XT-PIC  ide2, ide3,uhci_hcd, Ensoniq AudioPCI, Intel  82801BA-ICH2, nvidia".                                                         

It didn't happen with a Mitsumi TE-4804 CD-RW on the same interface.

So the DW-7802TE unit refused to work on HPT.



Second Box: Toshiba Satellite Laptop, 650MHz PIII Fedora Core 2 2.6.5-1.358
and kernel-2.6.6-1.435.2.3 kernels.

Rather many devices stuffed to irq11:
 11:     108761          XT-PIC  uhci_hcd, yenta, yenta, YMFPCI, eth0

Booting 2.6.5-1.358 without noacpi nor acpi=off gives:

--8<-----------------------------------------------------------------------
Linux version 2.6.5-1.358 (bhcompile@bugs.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Sat May 8 09:04:50 EDT 2004
ACPI: RSDP (v000 TOSHIB                                    ) @ 0x000f0170
ACPI: RSDT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0fff0000
ACPI: FADT (v001 TOSHIB 750      0x00970814 TASM 0x04010000) @ 0x0fff0054
ACPI: DSDT (v001 TOSHIB 2800     0x20001204 MSFT 0x0100000a) @ 0x00000000
ACPI: PM-Timer IO Port: 0xee08
PCI: PCI BIOS revision 2.10 entry at 0xfd515, last bus=4
PCI: Using configuration type 1
mtrr: v2.0 (20020519)
ACPI: Subsystem revision 20040326
ACPI: IRQ9 SCI: Level Trigger.
    ACPI-0165: *** Error: No object was returned from [\_SB_.LNKA._STA] (Node 11f3a7fc), AE_NOT_EXIST
    ACPI-0165: *** Error: No object was returned from [\_SB_.LNKB._STA] (Node 11f3a6fc), AE_NOT_EXIST
    ACPI-0165: *** Error: No object was returned from [\_SB_.LNKC._STA] (Node 11f3a5fc), AE_NOT_EXIST
    ACPI-0165: *** Error: No object was returned from [\_SB_.LNKD._STA] (Node 11f3a4fc), AE_NOT_EXIST
    ACPI-0165: *** Error: No object was returned from [\_SB_.LNKE._STA] (Node 11f3a3fc), AE_NOT_EXIST
    ACPI-0165: *** Error: No object was returned from [\_SB_.LNKG._STA] (Node 11f3a2fc), AE_NOT_EXIST
    ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.FDD_._STA] (Node 11f3457c), AE_NOT_EXIST
    ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT_._STA] (Node 11f3443c), AE_NOT_EXIST
    ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PRT1._STA] (Node 11f3435c), AE_NOT_EXIST
    ACPI-0165: *** Error: No object was returned from [\_SB_.PCI0.FNC0.PCC0._STA] (Node 11f3425c), AE_NOT_EXIST
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (00:00)
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
ACPI: Power Resource [PIHD] (on)
ACPI: Power Resource [PMHD] (on)
ACPI: Power Resource [PFAN] (off)
Linux Plug and Play Support v0.97 (c) Adam Belay
usbcore: registered new driver usbfs
usbcore: registered new driver hub
ACPI: No IRQ known for interrupt pin D of device 0000:00:1f.2
ACPI: No IRQ known for interrupt pin B of device 0000:00:1f.6
ACPI: No IRQ known for interrupt pin A of device 0000:01:00.0
ACPI: No IRQ known for interrupt pin A of device 0000:02:03.0
ACPI: No IRQ known for interrupt pin A of device 0000:02:07.0
ACPI: No IRQ known for interrupt pin A of device 0000:02:08.0
ACPI: No IRQ known for interrupt pin B of device 0000:02:09.0
ACPI: No IRQ known for interrupt pin A of device 0000:02:0d.0 - using IRQ 255
ACPI: No IRQ known for interrupt pin B of device 0000:02:0d.1 - using IRQ 255
PCI: Using ACPI for IRQ routing
PCI: if you experience problems, try using option 'pci=noacpi' or even 'acpi=off'
ACPI: Fan [FAN] (off)
ACPI: Processor [CPU0] (supports C1 C2)
ACPI: Thermal Zone [THRM] (67 C)
ACPI: No IRQ known for interrupt pin B of device 0000:00:1f.6
ACPI: AC Adapter [ADP1] (on-line)
ACPI: Battery Slot [BAT1] (battery present)
ACPI: Power Button (FF) [PWRF]
ACPI: Lid Switch [LID]
toshiba_acpi: Toshiba Laptop ACPI Extras version 0.18
toshiba_acpi:     HCI method: \_SB_.VALD.GHCI
USB Universal Host Controller Interface driver v2.2
ACPI: No IRQ known for interrupt pin D of device 0000:00:1f.2
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: irq 11, io base 0000cf80
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: No IRQ known for interrupt pin A of device 0000:02:08.0
e100: eth0: e100_probe: addr 0xfcee7000, irq 11, MAC addr 00:00:39:34:C1:3B
e100: Intel(R) PRO/100 Network Driver, 3.0.17
e100: Copyright(c) 1999-2004 Intel Corporation
ACPI: No IRQ known for interrupt pin A of device 0000:02:08.0
e100: eth0: e100_probe: addr 0xfcee7000, irq 11, MAC addr 00:00:39:34:C1:3B
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
PCI: Enabling device 0000:02:0d.0 (0000 -> 0002)
ACPI: No IRQ known for interrupt pin A of device 0000:02:0d.0 - using IRQ 255
Yenta: CardBus bridge found at 0000:02:0d.0 [1179:0001]
irq 11: nobody cared! (screaming interrupt?)
Call Trace:
 [<021070c9>] __report_bad_irq+0x2b/0x67
 [<02107161>] note_interrupt+0x43/0x66
 [<02107327>] do_IRQ+0x109/0x169
 [<0223007b>] sock_ioctl+0x13e/0x280
 [<0211af64>] __do_softirq+0x2c/0x73
 [<021078f5>] do_softirq+0x46/0x4d
 =======================
 [<0210737b>] do_IRQ+0x15d/0x169
 [<0210fe92>] delay_pmtmr+0xb/0x13
 [<02191439>] __delay+0x9/0xa
 [<129247fe>] yenta_probe_irq+0xa7/0x100 [yenta_socket]
 [<129249a6>] yenta_get_socket_capabilities+0x28/0x49 [yenta_socket]
 [<12924c51>] yenta_probe+0x18c/0x1d1 [yenta_socket]
 [<0219653a>] pci_device_probe_static+0x2a/0x3d
 [<02196568>] __pci_device_probe+0x1b/0x2c
 [<02196594>] pci_device_probe+0x1b/0x2d
 [<021d94ed>] bus_match+0x27/0x45
 [<021d95b9>] driver_attach+0x37/0x6a
 [<021d97cb>] bus_add_driver+0x6a/0x81
 [<021d9ab3>] driver_register+0x28/0x2c
 [<021966b9>] pci_register_driver+0x4b/0x66
 [<02127eac>] sys_init_module+0xe7/0x1bd

handlers:
[<0221522d>] (usb_hcd_irq+0x0/0x4b)
[<1292dc6e>] (e100_intr+0x0/0xe0 [e100])
Disabling IRQ #11
Yenta: ISA IRQ mask 0x0498, PCI irq 0
Socket status: 30000007
PCI: Enabling device 0000:02:0d.1 (0000 -> 0002)
ACPI: No IRQ known for interrupt pin B of device 0000:02:0d.1 - using IRQ 255
Yenta: CardBus bridge found at 0000:02:0d.1 [1179:0001]
Yenta: ISA IRQ mask 0x0498, PCI irq 0
Socket status: 30000007
--8<-----------------------------------------------------------------------

And although e100 loads and accects ifconfig without hitch, no packets ever
move. No networking. eepro100 doesn't work either.

Booting with noacpi didn't alter the situation. With "noacpi acpi=off" and
disabling pcmcia, sound and usb modules I get:

--8<-----------------------------------------------------------------------
Linux version 2.6.5-1.358 (bhcompile@bugs.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Sat May 8 09:04:50 EDT 2004
Kernel command line: 3 ro root=LABEL=/ rhgb noacpi nousb acpi=off
PCI: PCI BIOS revision 2.10 entry at 0xfd515, last bus=4
PCI: Using configuration type 1
ACPI: ACPI tables contain no PCI IRQ routing entries
PCI: Invalid ACPI-PCI IRQ routing table
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/244c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:02:0d.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:02:0d.0
PCI: Sharing IRQ 11 with 0000:02:03.0
PCI: IRQ 0 for device 0000:02:0d.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:02:0d.1
PCI: Sharing IRQ 11 with 0000:00:1f.6    
PCI: Sharing IRQ 11 with 0000:02:07.0
PCI: Sharing IRQ 11 with 0000:02:09.0
PCI: Found IRQ 11 for device 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:02:07.0    
PCI: Sharing IRQ 11 with 0000:02:09.0
PCI: Sharing IRQ 11 with 0000:02:0d.1
e100: Intel(R) PRO/100 Network Driver, 3.0.17 
e100: Copyright(c) 1999-2004 Intel Corporation
e100: eth0: e100_probe: addr 0xfcee7000, irq 11, MAC addr 00:00:39:34:C1:3B
e100: Intel(R) PRO/100 Network Driver, 3.0.17 
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Found IRQ 11 for device 0000:02:08.0
e100: eth0: e100_probe: addr 0xfcee7000, irq 11, MAC addr 00:00:39:34:C1:3B
irq 11: nobody cared! (screaming interrupt?)
Call Trace:
 [<021070c9>] __report_bad_irq+0x2b/0x67
 [<02107161>] note_interrupt+0x43/0x66
 [<02107327>] do_IRQ+0x109/0x169
 [<0211af64>] __do_softirq+0x2c/0x73
 [<021078f5>] do_softirq+0x46/0x4d
 =======================
 [<0210737b>] do_IRQ+0x15d/0x169 
 [<02107707>] setup_irq+0x86/0x95
 [<128d7c6e>] e100_intr+0x0/0xe0 [e100]
 [<0210743f>] request_irq+0x88/0x9d
 [<128d8517>] e100_up+0xdc/0x11f [e100] 
 [<128d91ab>] e100_open+0x20/0x45 [e100]
 [<02235a97>] dev_open+0x5f/0xcc
 [<022369cc>] dev_change_flags+0x48/0xee
 [<02267a19>] devinet_ioctl+0x255/0x4a1
 [<022694a8>] inet_ioctl+0x47/0x73  
 [<022301a5>] sock_ioctl+0x268/0x280
 [<0214ea0e>] sys_ioctl+0x1f2/0x224
 [<0210737b>] do_IRQ+0x15d/0x169

handlers:
[<128d7c6e>] (e100_intr+0x0/0xe0 [e100])
Disabling IRQ #11
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
eepro100.c:v1.09j-t 9/29/99 Donald Becker http://www.scyld.com/network/eepro100.html
eepro100.c: $Revision: 1.36 $ 2000/11/17 Modified by Andrey V. Savochkin <saw@saw.sw.com.sg> and others
PCI: Found IRQ 11 for device 0000:02:08.0
eth0: OEM i82557/i82558 10/100 Ethernet, 00:00:39:34:C1:3B, IRQ 11.
  Board assembly 000000-000, Physical connectors present: RJ45
  Primary interface chip i82555 PHY #1.
  General self-test: passed.
  Serial sub-system self-test: passed. 
  Internal registers self-test: passed.
  ROM checksum self-test: passed (0x04f4518b).
irq 11: nobody cared! (screaming interrupt?)
Call Trace:
 [<021070c9>] __report_bad_irq+0x2b/0x67
 [<02107161>] note_interrupt+0x43/0x66
 [<02107327>] do_IRQ+0x109/0x169
 [<0211af64>] __do_softirq+0x2c/0x73
 [<021078f5>] do_softirq+0x46/0x4d
 =======================
 [<0210737b>] do_IRQ+0x15d/0x169 
 [<02107707>] setup_irq+0x86/0x95
 [<128d77de>] speedo_interrupt+0x0/0x19a [eepro100]
 [<0210743f>] request_irq+0x88/0x9d
 [<128d6ae6>] speedo_open+0x79/0x175 [eepro100]
 [<02235a97>] dev_open+0x5f/0xcc
 [<022369cc>] dev_change_flags+0x48/0xee
 [<02267a19>] devinet_ioctl+0x255/0x4a1
 [<022694a8>] inet_ioctl+0x47/0x73  
 [<022301a5>] sock_ioctl+0x268/0x280
 [<0214ea0e>] sys_ioctl+0x1f2/0x224

handlers:
[<128d77de>] (speedo_interrupt+0x0/0x19a [eepro100])
Disabling IRQ #11
--8<-----------------------------------------------------------------------

Somehow ACPI still rears it head in the kernel messages despite acpi=off.

After upgrading to kernel-2.6.6-1.435.2.3, I still get the oopses when
loading just about any module that touches irq11, e100 and eppro100 in
particular (no networking), but sound doesn't work either. I've no usb nor
pcmcia gear, so I can't tell about that.

Giving "noacpi acpi=off" seems to do its deeds though - I can load and use
e100 just fine. Sound works too, but (at least once) shortly afterwards
networking seized.

--8<-----------------------------------------------------------------------
Linux version 2.6.6-1.435.2.3 (bhcompile@tweety.build.redhat.com) (gcc version 3.3.3 20040412 (Red Hat Linux 3.3.3-7)) #1 Thu Jul 1 08:25:29 EDT 2004
Kernel command line: ro root=LABEL=/ rhgb noacpi acpi=off
PCI: PCI BIOS revision 2.10 entry at 0xfd515, last bus=4
PCI: Using configuration type 1
ACPI: Subsystem revision 20040326
ACPI: Interpreter disabled.
PCI: Probing PCI hardware
PCI: Probing PCI hardware (bus 00)
PCI: Transparent bridge - 0000:00:1e.0
PCI: Using IRQ router PIIX/ICH [8086/244c] at 0000:00:1f.0
PCI: IRQ 0 for device 0000:02:0d.0 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:02:0d.0
PCI: Sharing IRQ 11 with 0000:02:03.0
PCI: IRQ 0 for device 0000:02:0d.1 doesn't match PIRQ mask - try pci=usepirqmask
PCI: Found IRQ 11 for device 0000:02:0d.1
PCI: Sharing IRQ 11 with 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:02:07.0
PCI: Sharing IRQ 11 with 0000:02:09.0
PCI: Found IRQ 11 for device 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:02:07.0
PCI: Sharing IRQ 11 with 0000:02:09.0
PCI: Sharing IRQ 11 with 0000:02:0d.1
uhci_hcd 0000:00:1f.2: UHCI Host Controller
uhci_hcd 0000:00:1f.2: irq 11, io base 0000cf80
uhci_hcd 0000:00:1f.2: new USB bus registered, assigned bus number 1
PCI: Found IRQ 11 for device 0000:02:03.0
PCI: Sharing IRQ 11 with 0000:02:0d.0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[11]  MMIO=[fceff800-fcefffff]  Max Packet=[2048]
e100: Intel(R) PRO/100 Network Driver, 3.0.18
e100: Copyright(c) 1999-2004 Intel Corporation
PCI: Found IRQ 11 for device 0000:02:08.0
e100: eth0: e100_probe: addr 0xfcee7000, irq 11, MAC addr 00:00:39:34:C1:3B
PCI: Found IRQ 11 for device 0000:02:0d.0
PCI: Sharing IRQ 11 with 0000:02:03.0
Yenta: CardBus bridge found at 0000:02:0d.0 [1179:0001]
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000007
PCI: Found IRQ 11 for device 0000:02:0d.1
PCI: Sharing IRQ 11 with 0000:00:1f.6
PCI: Sharing IRQ 11 with 0000:02:07.0
PCI: Sharing IRQ 11 with 0000:02:09.0
Yenta: CardBus bridge found at 0000:02:0d.1 [1179:0001]
Yenta: ISA IRQ mask 0x0498, PCI irq 11
Socket status: 30000007
--8<-----------------------------------------------------------------------

With 2.4.x this machine has no problems.

-- v -- 

v@iki.fi



