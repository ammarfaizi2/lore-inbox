Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131424AbQLNO7W>; Thu, 14 Dec 2000 09:59:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131406AbQLNO7N>; Thu, 14 Dec 2000 09:59:13 -0500
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:2156 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S131265AbQLNO7D>; Thu, 14 Dec 2000 09:59:03 -0500
Date: Thu, 14 Dec 2000 14:29:40 +0000
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org
Subject: USB-related Oops in test12
Message-ID: <20001214142940.A1018@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This Oops happened with mutt as the only active user process.

I'd been using uhci for a while with test kernels, as usb-uhci had
been oopsing on first mouse use.  However, with test12 I found a
problem with uhci:

Dec 13 12:13:24 bloch kernel: PCI: Found IRQ 5 for device 00:07.2
Dec 13 12:13:24 bloch kernel: PCI: The same IRQ used for device
00:07.3
Dec 13 12:13:24 bloch kernel: PCI: The same IRQ used for device
00:08.0
Dec 13 12:13:24 bloch kernel: uhci.c: USB UHCI at I/O 0xc400, IRQ 5
Dec 13 12:13:24 bloch kernel: uhci.c: detected 2 ports
Dec 13 12:13:24 bloch kernel: usb.c: new USB bus registered, assigned
bus number 1
Dec 13 12:13:24 bloch kernel: uhci: host controller process
error. something bad happened
Dec 13 12:13:24 bloch kernel: uhci: host controller halted. very bad
Dec 13 12:13:24 bloch kernel: Product: USB UHCI-alt Root Hub
Dec 13 12:13:24 bloch kernel: SerialNumber: c400
Dec 13 12:13:24 bloch kernel: hub.c: USB hub found
Dec 13 12:13:24 bloch kernel: hub.c: 2 ports detected
Dec 13 12:13:24 bloch kernel: PCI: Found IRQ 5 for device 00:07.3
Dec 13 12:13:24 bloch kernel: PCI: The same IRQ used for device
00:07.2
Dec 13 12:13:24 bloch kernel: PCI: The same IRQ used for device
00:08.0
Dec 13 12:13:24 bloch kernel: uhci.c: USB UHCI at I/O 0xc800, IRQ 5
Dec 13 12:13:24 bloch kernel: uhci.c: detected 2 ports
Dec 13 12:13:24 bloch kernel: usb.c: new USB bus registered, assigned
bus number 2
Dec 13 12:13:24 bloch kernel: uhci: host controller halted. very bad
Dec 13 12:13:24 bloch kernel: uhci: host controller process
error. something bad happened
Dec 13 12:13:24 bloch kernel: uhci: host controller halted. very bad
Dec 13 12:13:24 bloch kernel: Product: USB UHCI-alt Root Hub
Dec 13 12:13:24 bloch kernel: SerialNumber: c800
Dec 13 12:13:24 bloch kernel: hub.c: USB hub found
Dec 13 12:13:24 bloch kernel: hub.c: 2 ports detected
Dec 13 12:13:24 bloch kernel: hub.c: USB new device connect on bus1/1,
assigned
device number 3
Dec 13 12:13:24 bloch kernel: usb_control/bulk_msg: timeout
Dec 13 12:13:24 bloch kernel: usb.c: USB device not accepting new
address=3 (error=-110)
Dec 13 12:13:24 bloch kernel: hub.c: USB new device connect on bus1/1,
assigned
device number 4
Dec 13 12:13:24 bloch kernel: PCI: Found IRQ 5 for device 00:08.0
Dec 13 12:13:24 bloch kernel: PCI: The same IRQ used for device
00:07.2
Dec 13 12:13:24 bloch kernel: PCI: The same IRQ used for device
00:07.3
Dec 13 12:13:24 bloch kernel: usb_control/bulk_msg: timeout
Dec 13 12:13:24 bloch kernel: usb.c: USB device not accepting new
address=4 (error=-110)

so I switched back to usb-uhci

Those PCI messages are new with test 12 - the USB controller shares an
IRQ with an SB Live card.  That hadn't caused a problem previously.

Here is the ksymoops output:

ksymoops 2.3.4 on i686 2.4.0-test12.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test12/ (default)
     -m /boot/System.map-2.4.0-test12 (specified)

Warning (compare_maps): snd symbol pm_register not found in /lib/modules/2.4.0-test12/misc/snd.o.  Ignoring /lib/modules/2.4.0-test12/misc/snd.o entry
Warning (compare_maps): snd symbol pm_send not found in /lib/modules/2.4.0-test12/misc/snd.o.  Ignoring /lib/modules/2.4.0-test12/misc/snd.o entry
Warning (compare_maps): snd symbol pm_unregister not found in /lib/modules/2.4.0-test12/misc/snd.o.  Ignoring /lib/modules/2.4.0-test12/misc/snd.o entry
Unable to handle kernel NULL pointer dereference at virtual address 0000000c
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d086734b>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00e08269     ecx: 00888105       edx: 0000000c
esi: 00000004   edi: cfa84c40     ebp: cfabeb00       esp: c0259ec8
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage=c0259000)
Stack: 00000000 cfabeb24 cfabc180 cff28cc0 cfa84c40 cff28cdc 00000000 d0867639
       cff28cc0 cfa84c40 00000020 00000002 00000000 cff28cdc cff28cc0 cff28cdc
       00000000 d0867848 cff28cc0 cfa84c48 00000000 cfef0001 00000000 c02a7480
Call Trace: [<d0867639>] [<d0867848>] [<c010c1bf>] [<c010c342>] [<c010afb0>] [<c01c3e62>] [<c01c3b80>]
       [<c0109150>] [<c01c3b80>] [<c011fc01>] [<c01091d8>] [<c0105000>] [<c0100191>]
Code: 8b 04 82 c1 e9 08 83 e1 0f d3 e8 83 e0 01 c1 e0 13 09 45 08

>>EIP; d086734b <[usb-uhci]process_interrupt+10b/1f0>   <=====
Trace; d0867639 <[usb-uhci]process_urb+79/1f0>
Trace; d0867848 <[usb-uhci]uhci_interrupt+98/100>
Trace; c010c1bf <handle_IRQ_event+2f/60>
Trace; c010c342 <do_IRQ+72/c0>
Trace; c010afb0 <ret_from_intr+0/20>
Trace; c01c3e62 <acpi_idle+2e2/330>
Trace; c01c3b80 <acpi_idle+0/330>
Trace; c0109150 <default_idle+0/30>
Trace; c01c3b80 <acpi_idle+0/330>
Trace; c011fc01 <check_pgt_cache+11/20>
Trace; c01091d8 <cpu_idle+38/50>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  d086734b <[usb-uhci]process_interrupt+10b/1f0>
00000000 <_EIP>:
Code;  d086734b <[usb-uhci]process_interrupt+10b/1f0>   <=====
   0:   8b 04 82                  mov    (%edx,%eax,4),%eax   <=====
Code;  d086734e <[usb-uhci]process_interrupt+10e/1f0>
   3:   c1 e9 08                  shr    $0x8,%ecx
Code;  d0867351 <[usb-uhci]process_interrupt+111/1f0>
   6:   83 e1 0f                  and    $0xf,%ecx
Code;  d0867354 <[usb-uhci]process_interrupt+114/1f0>
   9:   d3 e8                     shr    %cl,%eax
Code;  d0867356 <[usb-uhci]process_interrupt+116/1f0>
   b:   83 e0 01                  and    $0x1,%eax
Code;  d0867359 <[usb-uhci]process_interrupt+119/1f0>
   e:   c1 e0 13                  shl    $0x13,%eax
Code;  d086735c <[usb-uhci]process_interrupt+11c/1f0>
  11:   09 45 08                  or     %eax,0x8(%ebp)

Aiee, killing interrupt handler
Kernel panic: Attempted to kill the idle task!

3 warnings issued.  Results may not be reliable.

Here is the USB and ACPI output from dmesg:

ACPI: support found
ACPI: PBLK 1 @ 0x4010:0
        -0196: *** Error: Sleep State package elements are not both of type Number
ACPI: S1 supported
ACPI: S5 supported
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 192k freed
Adding Swap: 248968k swap-space (priority -1)
usb.c: registered new driver usbdevfs
usb.c: registered new driver hub
usb-uhci.c: $Revision: 1.251 $ time 02:09:53 Dec 13 2000
usb-uhci.c: High bandwidth mode enabled
PCI: Found IRQ 5 for device 00:07.2
PCI: The same IRQ used for device 00:07.3
PCI: The same IRQ used for device 00:08.0
usb-uhci.c: USB UHCI at I/O 0xc400, IRQ 5
usb-uhci.c: Detected 2 ports
usb.c: new USB bus registered, assigned bus number 1
usb.c: kmalloc IF c14c4dc0, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 1 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: c400
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c14c4dc0
usb.c: kusbd: /sbin/hotplug add 1
usb.c: kusbd policy returned 0xfffffffe
PCI: Found IRQ 5 for device 00:07.3
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 00:08.0
usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 5
usb-uhci.c: Detected 2 ports
hub.c: port 1 connection change
hub.c: port 1, portstatus 301, change 3, 1.5 Mb/s
hub.c: port 1, portstatus 303, change 0, 1.5 Mb/s
hub.c: USB new device connect on bus1/1, assigned device number 2
usb.c: new USB bus registered, assigned bus number 2
usb.c: kmalloc IF c14c4a40, numif 1
usb.c: new device strings: Mfr=0, Product=2, SerialNumber=1
usb.c: USB device number 3 default language ID 0x0
Product: USB UHCI Root Hub
SerialNumber: c800
hub.c: USB hub found
hub.c: 2 ports detected
hub.c: standalone hub
hub.c: ganged power switching
hub.c: global over-current protection
hub.c: power on to power good time: 2ms
hub.c: hub controller current requirement: 0mA
hub.c: port removable status: RR
hub.c: local power source is good
hub.c: no over-current condition exists
hub.c: enabling power on all ports
usb.c: hub driver claimed interface c14c4a40
usb.c: kusbd: /sbin/hotplug add 3
usb.c: kusbd policy returned 0xfffffffe
usb.c: kmalloc IF c14c0f40, numif 1
usb.c: skipped 1 class/vendor specific interface descriptors
usb.c: new device strings: Mfr=1, Product=2, SerialNumber=0
usb.c: USB device number 2 default language ID 0x409
Manufacturer: Logitech
Product: USB-PS/2 Mouse M-BA47
usb.c: unhandled interfaces on device
usb.c: USB device 2 (vend/prod 0x46d/0xc002) is not claimed by any active driver.
  Length              = 18
  DescriptorType      = 01
  USB version         = 1.00
  Vendor:Product      = 046d:c002
  MaxPacketSize0      = 8
  NumConfigurations   = 1
  Device version      = 1.20
  Device Class:SubClass:Protocol = 00:00:00
    Per-interface classes
Configuration:
  bLength             =    9
  bDescriptorType     =   02
  wTotalLength        = 0022
  bNumInterfaces      =   01
  bConfigurationValue =   01
  iConfiguration      =   00
  bmAttributes        =   a0
  MaxPower            =   50mA

  Interface: 0
  Alternate Setting:  0
    bLength             =    9
    bDescriptorType     =   04
    bInterfaceNumber    =   00
    bAlternateSetting   =   00
    bNumEndpoints       =   01
    bInterface Class:SubClass:Protocol =   03:01:02
    iInterface          =   00
    Endpoint:
      bLength             =    7
      bDescriptorType     =   05
      bEndpointAddress    =   81 (in)
      bmAttributes        =   03 (Interrupt)
      wMaxPacketSize      = 0008
      bInterval           =   0a
usb.c: kusbd: /sbin/hotplug add 2
usb.c: kusbd policy returned 0xfffffffe
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 enable change, status 300
hub.c: port 1 connection change
hub.c: port 1, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 2 connection change
hub.c: port 2, portstatus 300, change 3, 1.5 Mb/s
hub.c: port 1 enable change, status 300
hub.c: port 2 enable change, status 300
usb.c: registered new driver hid
input0: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse M-BA47] on usb1:2.0
usb.c: hid driver claimed interface c14c0f40
mouse0: PS/2 mouse device for input0
mice: PS/2 mouse device common for all mice
PCI: Found IRQ 5 for device 00:08.0
PCI: The same IRQ used for device 00:07.2
PCI: The same IRQ used for device 00:07.3
eth0: Setting full-duplex based on MII #32 link partner ability of 45e1.

Athlon 800 on Abit KA7-100 m/b, 256Mb.

Clean test12 tree.

Adam
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
