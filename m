Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129409AbRCABVa>; Wed, 28 Feb 2001 20:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129413AbRCABVV>; Wed, 28 Feb 2001 20:21:21 -0500
Received: from mail5.svr.pol.co.uk ([195.92.193.20]:5703 "EHLO
	mail5.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S129409AbRCABVG>; Wed, 28 Feb 2001 20:21:06 -0500
Date: Thu, 1 Mar 2001 01:23:22 +0000
From: Adam Huffman <bloch@verdurin.com>
To: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Oops with 2.4.2
Message-ID: <20010301012322.A912@bloch.verdurin.priv>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This seems to be a return of the problem I was having a while ago
relating to the USB drivers.  The Oops happens when I move the mouse
with the usb-uhci driver.  The alternate driver (uhci) does not load
properly (message in syslog - uhci: host controller halted. very bad)

System:
K7 800
KA7-100 m/b (Via KX133 chipset)

Here is the decoded oops:

ksymoops 2.4.0 on i686 2.4.2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2/ (default)
     -m /boot/System.map-2.4.2 (specified)

Unable to handle kernel NULL pointer dereference at virtual address 0000000c
d083932d
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d083932d>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00e08269     ecx: 00888105       edx: 0000000c
esi: cfbb0c40   edi: 00000004     ebp: cfa3eb00       esp: c0271eec
ds: 0018        es: 0018       ss: 0018
Process swapper (pid: 0, stackpage=c0271000)
Stack:  00000000 cfa3eb24 cfa67180 cff06dc0 cfbb0c40 cff06ddc 00000000 d0839619
        cff06dc0 cfbb0c40 00000001 00000000 00000000 cff06ddc cff06dc0 cff06ddc
        00000000 d0839828 cff06dc0 cfbb0c48 00000000 c0110001 00000001 c010d2b2
Call Trace: [<d0839619>] [<d0839828>] [<c0110001>] [<c010d2b2>] [<c010a2f9>] [<c010a468>] [<c0107240>]
        [<c0109120>] [<c0107240>] [<c0107263>] [<c01072e2>] [<c0105000>] [<c0100191>]
Code: 8b 04 82 c1 e9 08 83 e1 0f d3 e8 83 e0 01 c1 e0 13 09 45 08

>>EIP; d083932d <[usb-uhci]process_interrupt+fd/1e0>   <=====
Trace; d0839619 <[usb-uhci]process_urb+79/1f0>
Trace; d0839828 <[usb-uhci]uhci_interrupt+98/100>
Trace; c0110001 <init_table+1/80>
Trace; c010d2b2 <timer_interrupt+62/110>
Trace; c010a2f9 <handle_IRQ_event+39/60>
Trace; c010a468 <do_IRQ+68/b0>
Trace; c0107240 <default_idle+0/30>
Trace; c0109120 <ret_from_intr+0/20>
Trace; c0107240 <default_idle+0/30>
Trace; c0107263 <default_idle+23/30>
Trace; c01072e2 <cpu_idle+52/70>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  d083932d <[usb-uhci]process_interrupt+fd/1e0>
00000000 <_EIP>:
Code;  d083932d <[usb-uhci]process_interrupt+fd/1e0>   <=====
   0:   8b 04 82                  mov    (%edx,%eax,4),%eax   <=====
Code;  d0839330 <[usb-uhci]process_interrupt+100/1e0>
   3:   c1 e9 08                  shr    $0x8,%ecx
Code;  d0839333 <[usb-uhci]process_interrupt+103/1e0>
   6:   83 e1 0f                  and    $0xf,%ecx
Code;  d0839336 <[usb-uhci]process_interrupt+106/1e0>
   9:   d3 e8                     shr    %cl,%eax
Code;  d0839338 <[usb-uhci]process_interrupt+108/1e0>
   b:   83 e0 01                  and    $0x1,%eax
Code;  d083933b <[usb-uhci]process_interrupt+10b/1e0>
   e:   c1 e0 13                  shl    $0x13,%eax
Code;  d083933e <[usb-uhci]process_interrupt+10e/1e0>
  11:   09 45 08                  or     %eax,0x8(%ebp)

Kernel panic: Aiee, killing interrupt handler!

Here are the boot messages from a working boot:


Feb 28 12:06:56 bloch kernel: PCI: PCI BIOS revision 2.10 entry at 0xfb4d0, last bus=1
Feb 28 12:06:56 bloch kernel: PCI: Using configuration type 1
Feb 28 12:06:56 bloch kernel: PCI: Probing PCI hardware
Feb 28 12:06:56 bloch kernel: Unknown bridge resource 0: assuming transparent
Feb 28 12:06:56 bloch kernel: PCI: Using IRQ router VIA [1106/0686] at 00:07.0
Feb 28 12:06:57 bloch kernel: ACPI: Core Subsystem version [20010208]
Feb 28 12:06:57 bloch kernel: ACPI: Subsystem enabled
Feb 28 12:06:57 bloch kernel: ACPI: System firmware supports: C2 C3
Feb 28 12:06:57 bloch kernel: ACPI: plvl2lat=90 plvl3lat=900
Feb 28 12:06:57 bloch kernel: ACPI: C2 enter=1288 C2 exit=322
Feb 28 12:06:57 bloch kernel: ACPI: C3 enter=38653 C3 exit=3221
Feb 28 12:06:57 bloch kernel: ACPI: Not using ACPI idle
Feb 28 12:06:57 bloch kernel: ACPI: System firmware supports: S0 S1 S3 S4 S5
Feb 28 12:06:57 bloch kernel: usb.c: registered new driver usbdevfs
Feb 28 12:06:57 bloch kernel: usb.c: registered new driver hub
Feb 28 12:06:57 bloch kernel: usb-uhci.c: $Revision: 1.251 $ time 02:58:59 Feb 22 2001
Feb 28 12:06:57 bloch kernel: usb-uhci.c: High bandwidth mode enabled
Feb 28 12:06:57 bloch kernel: PCI: Found IRQ 5 for device 00:07.2
Feb 28 12:06:57 bloch kernel: PCI: The same IRQ used for device 00:07.3
Feb 28 12:06:57 bloch kernel: PCI: The same IRQ used for device 00:08.0
Feb 28 12:06:57 bloch kernel: usb-uhci.c: USB UHCI at I/O 0xc400, IRQ 5
Feb 28 12:06:57 bloch kernel: usb-uhci.c: Detected 2 ports
Feb 28 12:06:57 bloch kernel: usb.c: new USB bus registered, assigned bus number 1
Feb 28 12:06:57 bloch kernel: Product: USB UHCI Root Hub
Feb 28 12:06:57 bloch kernel: SerialNumber: c400
Feb 28 12:06:57 bloch kernel: hub.c: USB hub found
Feb 28 12:06:57 bloch kernel: hub.c: 2 ports detected
Feb 28 12:06:57 bloch kernel: PCI: Found IRQ 5 for device 00:07.3
Feb 28 12:06:57 bloch kernel: PCI: The same IRQ used for device 00:07.2
Feb 28 12:06:57 bloch kernel: PCI: The same IRQ used for device 00:08.0
Feb 28 12:06:57 bloch kernel: usb-uhci.c: USB UHCI at I/O 0xc800, IRQ 5
Feb 28 12:06:57 bloch kernel: usb-uhci.c: Detected 2 ports
Feb 28 12:06:57 bloch kernel: hub.c: USB new device connect on bus1/1, assigned device number 2
Feb 28 12:06:57 bloch kernel: usb.c: new USB bus registered, assigned bus number 2
Feb 28 12:06:57 bloch kernel: Product: USB UHCI Root Hub
Feb 28 12:06:57 bloch kernel: SerialNumber: c800
Feb 28 12:06:57 bloch kernel: hub.c: USB hub found
Feb 28 12:06:57 bloch kernel: hub.c: 2 ports detected
Feb 28 12:06:57 bloch kernel: Manufacturer: Logitech
Feb 28 12:06:57 bloch kernel: Product: USB-PS/2 Mouse M-BA47
Feb 28 12:06:57 bloch kernel: usb.c: USB device 2 (vend/prod 0x46d/0xc002) is not claimed by any active driver.
Feb 28 12:06:57 bloch kernel:   Length              = 18
Feb 28 12:06:57 bloch kernel:   DescriptorType      = 01
Feb 28 12:06:57 bloch kernel:   USB version         = 1.00
Feb 28 12:06:57 bloch kernel:   Vendor:Product      = 046d:c002
Feb 28 12:06:57 bloch kernel:   MaxPacketSize0      = 8
Feb 28 12:06:57 bloch kernel:   NumConfigurations   = 1
Feb 28 12:06:57 bloch kernel:   Device version      = 1.20
Feb 28 12:06:57 bloch kernel:   Device Class:SubClass:Protocol = 00:00:00
Feb 28 12:06:57 bloch kernel:     Per-interface classes
Feb 28 12:06:57 bloch kernel: Configuration:
Feb 28 12:06:57 bloch kernel:   bLength             =    9
Feb 28 12:06:57 bloch kernel:   bDescriptorType     =   02
Feb 28 12:06:57 bloch kernel:   wTotalLength        = 0022
Feb 28 12:06:57 bloch kernel:   bNumInterfaces      =   01
Feb 28 12:06:57 bloch kernel:   bConfigurationValue =   01
Feb 28 12:06:57 bloch kernel:   iConfiguration      =   00
Feb 28 12:06:57 bloch kernel:   bmAttributes        =   a0
Feb 28 12:06:57 bloch kernel:   MaxPower            =   50mA
Feb 28 12:06:57 bloch kernel: 
Feb 28 12:06:57 bloch kernel:   Interface: 0
Feb 28 12:06:57 bloch kernel:   Alternate Setting:  0
Feb 28 12:06:57 bloch kernel:     bLength             =    9
Feb 28 12:06:57 bloch kernel:     bDescriptorType     =   04
Feb 28 12:06:57 bloch kernel:     bInterfaceNumber    =   00
Feb 28 12:06:57 bloch kernel:     bAlternateSetting   =   00
Feb 28 12:06:57 bloch kernel:     bNumEndpoints       =   01
Feb 28 12:06:57 bloch kernel:     bInterface Class:SubClass:Protocol =   03:01:02
Feb 28 12:06:57 bloch kernel:     iInterface          =   00
Feb 28 12:06:57 bloch kernel:     Endpoint:
Feb 28 12:06:57 bloch kernel:       bLength             =    7
Feb 28 12:06:57 bloch kernel:       bDescriptorType     =   05
Feb 28 12:06:57 bloch kernel:       bEndpointAddress    =   81 (in)
Feb 28 12:06:57 bloch kernel:       bmAttributes        =   03 (Interrupt)
Feb 28 12:06:57 bloch kernel:       wMaxPacketSize      = 0008
Feb 28 12:06:57 bloch kernel:       bInterval           =   0a
Feb 28 12:06:57 bloch kernel: usb.c: registered new driver hid
Feb 28 12:06:57 bloch kernel: input0: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse M-BA47] on usb1:2.0
Feb 28 12:06:57 bloch kernel: mouse0: PS/2 mouse device for input0
Feb 28 12:06:57 bloch kernel: mice: PS/2 mouse device common for all mice
Feb 28 12:06:41 bloch rc.sysinit: Initializing USB controller (usb-uhci):  succeeded 
Feb 28 12:06:41 bloch rc.sysinit: Mounting USB filesystem:  succeeded 
Feb 28 12:06:41 bloch modprobe: Note: /etc/modules.conf is more recent than /lib/modules/2.4.2/modules.dep 
Feb 28 12:06:41 bloch rc.sysinit: Initializing USB HID interface:  succeeded 
Feb 28 12:06:41 bloch modprobe: Note: /etc/modules.conf is more recent than /lib/modules/2.4.2/modules.dep 
Feb 28 12:06:41 bloch rc.sysinit: Initializing USB mouse:  succeeded 
