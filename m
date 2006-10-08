Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751219AbWJHPYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751219AbWJHPYH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 11:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWJHPYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 11:24:07 -0400
Received: from bellona.wg.saar.de ([192.109.53.23]:34172 "EHLO
	bellona.wg.saar.de") by vger.kernel.org with ESMTP id S1751219AbWJHPYF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 11:24:05 -0400
Message-ID: <45291832.4010705@hal.saar.de>
Date: Sun, 08 Oct 2006 17:24:34 +0200
From: Michael Kress <kress@hal.saar.de>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: irq issues ("nobody cared")
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm having trouble with irqs ...

Oct  8 10:38:51 matrix kernel: irq 16: nobody cared (try booting with
the "irqpoll" option)
Oct  8 10:38:51 matrix kernel:
Oct  8 10:38:51 matrix kernel: Call Trace: <IRQ>
<ffffffff801519b0>{__report_bad_irq+48}
Oct  8 10:38:51 matrix kernel:       
<ffffffff80151c0f>{note_interrupt+511} <ffffffff80151324>{__do_IRQ+212}
Oct  8 10:38:51 matrix kernel:        <ffffffff8010dae4>{do_IRQ+68}
<ffffffff80250fad>{evtchn_do_upcall+205}
Oct  8 10:38:51 matrix kernel:       
<ffffffff8010ba0a>{do_hypervisor_callback+30}
<ffffffff8011da36>{ia32_syscall+30                                        }
Oct  8 10:38:51 matrix kernel:       
<ffffffff8010722a>{hypercall_page+554}
<ffffffff8010722a>{hypercall_page+554}
Oct  8 10:38:51 matrix kernel:       
<ffffffff80250eda>{force_evtchn_callback+10}
<ffffffff80134587>{__do_softirq+103                                        }
Oct  8 10:38:51 matrix kernel:       
<ffffffff8010beda>{call_softirq+30} <ffffffff8010dc97>{do_softirq+71}
Oct  8 10:38:51 matrix kernel:        <ffffffff8010dae9>{do_IRQ+73}
<ffffffff80250fad>{evtchn_do_upcall+205}
Oct  8 10:38:51 matrix kernel:       
<ffffffff8010ba0a>{do_hypervisor_callback+30} <EOI>
Oct  8 10:38:51 matrix kernel:        <ffffffff8011da36>{ia32_syscall+30}
Oct  8 10:38:51 matrix kernel: handlers:
Oct  8 10:38:52 matrix kernel: [<ffffffff802aa310>] (usb_hcd_irq+0x0/0x60)
Oct  8 10:38:52 matrix kernel: [<ffffffff802aa310>] (usb_hcd_irq+0x0/0x60)
Oct  8 10:38:52 matrix kernel: Disabling IRQ #16

Sometimes it's also irq 17. Of course I tried irqpoll, but that's no use
here.
Currently I'm using 'noirqbalance noirqdebug' as kernel parameters as
these two reduce a little bit the above messages, but they still occur.
Data written on hard disks seems to be alright, and I think, this
doesn't concern my controller, but it's strange anyways. I'm mentioning
this, because this sometimes happens during high I/O activities.
This issue doesn't arise with my distribution's stock kernel
(centos-4.4, i.e. 2.6.9-42), just with xen.

However, this seems to be usb related, as the irqs 16 and 17 handle usb.

My setup: Supermicro X6DH8-G2+, 3ware 9550SXU-4LP, 4GB RAM,
xen-3.0.2-2(i.e.linux-2.6.16)

[root@matrix ~]# cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3
  1:          8          0          0          0        Phys-irq  i8042
  8:          0          0          0          0        Phys-irq  rtc
  9:          0          0          0          0        Phys-irq  acpi
 12:         96          0          0          0        Phys-irq  i8042
 14:        355          0          0          0        Phys-irq  ide0
 16:     100000          0          0          0        Phys-irq 
uhci_hcd:usb2, uhci_hcd:usb5
 17:     100000          0          0          0        Phys-irq 
uhci_hcd:usb4
 18:         15          0          0          0        Phys-irq  aic79xx
 19:         15          0          0          0        Phys-irq  aic79xx
 20:     314835          0          0          0        Phys-irq  3w-9xxx
 21:     181910          0          0          0        Phys-irq  peth0
 23:          2          0          0          0        Phys-irq 
ehci_hcd:usb1
 24:          0          0          0          0        Phys-irq 
uhci_hcd:usb3
256:     771659          0          0          0     Dynamic-irq  timer0
257:      54358          0          0          0     Dynamic-irq  resched0
258:         60          0          0          0     Dynamic-irq  callfunc0
259:          0      34150          0          0     Dynamic-irq  resched1
260:          0        195          0          0     Dynamic-irq  callfunc1
261:          0     180536          0          0     Dynamic-irq  timer1
262:          0          0      39679          0     Dynamic-irq  resched2
263:          0          0        200          0     Dynamic-irq  callfunc2
264:          0          0     415147          0     Dynamic-irq  timer2
265:          0          0          0      32499     Dynamic-irq  resched3
266:          0          0          0        220     Dynamic-irq  callfunc3
267:          0          0          0      78138     Dynamic-irq  timer3
268:       2608          0          0          0     Dynamic-irq  xenbus
269:          0          0          0          0     Dynamic-irq  console
NMI:          0          0          0          0
LOC:          0          0          0          0
ERR:          0
MIS:          0

[root@matrix ~]# cat /proc/bus/usb/devices
T:  Bus=05 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.16-xen uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.3
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=04 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.16-xen uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.2
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=03 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc=  0/900 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.16-xen uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.1
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=12  MxCh= 2
B:  Alloc= 17/900 us ( 2%), #Int=  1, #Iso=  0
D:  Ver= 1.10 Cls=09(hub  ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.16-xen uhci_hcd
S:  Product=UHCI Host Controller
S:  SerialNumber=0000:00:1d.0
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=255ms

T:  Bus=02 Lev=01 Prnt=01 Port=00 Cnt=01 Dev#=  2 Spd=12  MxCh= 0
D:  Ver= 1.10 Cls=00(>ifc ) Sub=00 Prot=00 MxPS=64 #Cfgs=  1
P:  Vendor=14dd ProdID=1002 Rev= 0.01
S:  Manufacturer=Peppercon AG
S:  Product=MultiDevice
S:  SerialNumber=123456789012
C:* #Ifs= 2 Cfg#= 1 Atr=80 MxPwr=100mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=01 Prot=01 Driver=usbhid
E:  Ad=84(I) Atr=03(Int.) MxPS=   8 Ivl=10ms
I:  If#= 1 Alt= 0 #EPs= 1 Cls=03(HID  ) Sub=00 Prot=02 Driver=usbhid
E:  Ad=83(I) Atr=03(Int.) MxPS=   8 Ivl=10ms

T:  Bus=01 Lev=00 Prnt=00 Port=00 Cnt=00 Dev#=  1 Spd=480 MxCh= 8
B:  Alloc=  0/800 us ( 0%), #Int=  0, #Iso=  0
D:  Ver= 2.00 Cls=09(hub  ) Sub=00 Prot=01 MxPS=64 #Cfgs=  1
P:  Vendor=0000 ProdID=0000 Rev= 2.06
S:  Manufacturer=Linux 2.6.16-xen ehci_hcd
S:  Product=EHCI Host Controller
S:  SerialNumber=0000:00:1d.7
C:* #Ifs= 1 Cfg#= 1 Atr=c0 MxPwr=  0mA
I:  If#= 0 Alt= 0 #EPs= 1 Cls=09(hub  ) Sub=00 Prot=00 Driver=hub
E:  Ad=81(I) Atr=03(Int.) MxPS=   2 Ivl=256ms
[root@matrix ~]# lsusb
Bus 005 Device 001: ID 0000:0000
Bus 004 Device 001: ID 0000:0000
Bus 003 Device 001: ID 0000:0000
Bus 002 Device 002: ID 14dd:1002
Bus 002 Device 001: ID 0000:0000
Bus 001 Device 001: ID 0000:0000

[root@matrix ~]# lspci
00:00.0 Host bridge: Intel Corporation E7520 Memory Controller Hub (rev 0c)
00:00.1 Class ff00: Intel Corporation E7525/E7520 Error Reporting
Registers (rev 0c)
00:01.0 System peripheral: Intel Corporation E7520 DMA Controller (rev 0c)
00:02.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port
A (rev 0c)
00:03.0 PCI bridge: Intel Corporation E7525/E7520/E7320 PCI Express Port
A1 (rev 0c)
00:04.0 PCI bridge: Intel Corporation E7525/E7520 PCI Express Port B
(rev 0c)
00:06.0 PCI bridge: Intel Corporation E7520 PCI Express Port C (rev 0c)
00:1d.0 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #1 (rev 02)
00:1d.1 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #2 (rev 02)
00:1d.2 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #3 (rev 02)
00:1d.3 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB
UHCI Controller #4 (rev 02)
00:1d.7 USB Controller: Intel Corporation 82801EB/ER (ICH5/ICH5R) USB2
EHCI Controller (rev 02)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev c2)
00:1f.0 ISA bridge: Intel Corporation 82801EB/ER (ICH5/ICH5R) LPC
Interface Bridge (rev 02)
00:1f.1 IDE interface: Intel Corporation 82801EB/ER (ICH5/ICH5R) IDE
Controller (rev 02)
00:1f.3 SMBus: Intel Corporation 82801EB/ER (ICH5/ICH5R) SMBus
Controller (rev 02)
02:00.0 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge
A (rev 09)
02:00.1 PIC: Intel Corporation 6700/6702PXH I/OxAPIC Interrupt
Controller A (rev 09)
02:00.2 PCI bridge: Intel Corporation 6700PXH PCI Express-to-PCI Bridge
B (rev 09)
02:00.3 PIC: Intel Corporation 6700PXH I/OxAPIC Interrupt Controller B
(rev 09)
03:02.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
03:02.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
04:01.0 RAID bus controller: 3ware Inc 9550SX SATA-RAID
04:02.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet
Controller (rev 03)
04:02.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet
Controller (rev 03)
07:01.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)


Any ideas?
TIA - Michael

-- 
Michael Kress, kress@hal.saar.de
http://www.michael-kress.de / http://kress.net
P E N G U I N S   A R E   C O O L

