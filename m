Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271160AbTGPWLI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:11:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271152AbTGPWLA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:11:00 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:18886 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S271164AbTGPWIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:08:36 -0400
Message-ID: <3F15D050.6090207@blue-labs.org>
Date: Wed, 16 Jul 2003 18:23:12 -0400
From: david <david+hb@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030716
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test1 issues, ACPI, USB, ALSA
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are the problems I've found thusfar:

1. must boot with either acpi=off or pci=noacpi.  If this isn't done, 
half of things don't work right (eth0, USB mouse, etc) and when trying 
to use such devices, I get a message to the effect of IRQ NN disabled

2. randomly some IRQs stop being delivered or something.  I notice it 
first in X when my USB mouse stops working.  The PS/2 glidepoint mouse 
keeps working fine.  Most everything else on this IRQ (ohci-hcd, eth0) 
all stop working -- sym53c8xx keeps working.

3. only 1/2 of my USB ports work.  I have 6 ports, ports 1, 2, and 5 
don't work.

4. if I try to use my i8x0 onboard sound (ALSA), I immediately lose 
mouse/eth0/etc as above and I get a flurry of messages as will be described.


Now for the texts.

# cat usb-port1-mouse-in
ehci_hcd 0000:00:02.2: GetStatus port 1 status 001403 POWER sig=k  CSC 
CONNECT
hub 1-0:0: port 1, status 501, change 1, 480 Mb/s
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:02.2: port 1 low speed --> companion
ehci_hcd 0000:00:02.2: GetStatus port 1 status 003402 POWER OWNER sig=k  CSC

# cat usb-port1-mouse-out
ehci_hcd 0000:00:02.2: GetStatus port 1 status 001002 POWER sig=se0  CSC
hub 1-0:0: port 1, status 100, change 1, 12 Mb/s

# cat usb-port2-mouse-in
ehci_hcd 0000:00:02.2: GetStatus port 2 status 001403 POWER sig=k  CSC 
CONNECT
hub 1-0:0: port 2, status 501, change 1, 480 Mb/s
hub 1-0:0: debounce: port 2: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:02.2: port 2 low speed --> companion
ehci_hcd 0000:00:02.2: GetStatus port 2 status 003402 POWER OWNER sig=k  CSC

# cat usb-port2-mouse-out
ehci_hcd 0000:00:02.2: GetStatus port 2 status 001002 POWER sig=se0  CSC
hub 1-0:0: port 2, status 100, change 1, 12 Mb/s

# cat usb-port3-mouse-in
ehci_hcd 0000:00:02.2: GetStatus port 3 status 001403 POWER sig=k  CSC 
CONNECT
hub 1-0:0: port 3, status 501, change 1, 480 Mb/s
hub 1-0:0: debounce: port 3: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:02.2: port 3 low speed --> companion
ehci_hcd 0000:00:02.2: GetStatus port 3 status 003402 POWER OWNER sig=k  CSC
ohci-hcd 0000:00:02.1: GetStatus roothub.portstatus [1] = 0x00010301 CSC 
LSDA PPS CCS
hub 2-0:0: port 1, status 301, change 1, 1.5 Mb/s
hub 2-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
ohci-hcd 0000:00:02.1: GetStatus roothub.portstatus [1] = 0x00100303 
PRSC LSDA PPS PES CCS
hub 2-0:0: new USB device on port 1, assigned address 5
usb 2-1: new device strings: Mfr=1, Product=2, SerialNumber=0
usb 2-1: Product: USB-PS/2 Mouse
usb 2-1: Manufacturer: Logitech
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: usb_new_device - registering interface 2-1:0
drivers/usb/core/usb.c: usb_hotplug
hid 2-1:0: usb_device_probe
hid 2-1:0: usb_device_probe - got id
input: USB HID v1.00 Mouse [Logitech USB-PS/2 Mouse] on usb-0000:00:02.1-1

# cat usb-port3-mouse-out
ehci_hcd 0000:00:02.2: GetStatus port 3 status 001002 POWER sig=se0  CSC
hub 1-0:0: port 3, status 100, change 1, 12 Mb/s
ohci-hcd 0000:00:02.1: GetStatus roothub.portstatus [1] = 0x00030300 
PESC CSC LSDA PPS
hub 2-0:0: port 1, status 300, change 3, 1.5 Mb/s
usb 2-1: USB disconnect, address 5
usb 2-1: unregistering interfaces
usb 2-1: hcd_unlink_urb dc5ef524 fail -22
usb 2-1: hcd_unlink_urb dc5ef268 fail -22
drivers/usb/core/usb.c: usb_hotplug
usb 2-1: unregistering device
drivers/usb/core/usb.c: usb_hotplug
ohci-hcd 0000:00:02.1: GetStatus roothub.portstatus [1] = 0x00020300 
PESC LSDA PPS
hub 2-0:0: port 1 enable change, status 300

The other ports are respectively similar.

# cat /proc/interrupts
           CPU0      
  0:    1083773          XT-PIC  timer
  1:       3317          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  5:      31286          XT-PIC  sym53c8xx, ohci-hcd, eth0
  8:          2          XT-PIC  rtc
 11:       6048          XT-PIC  sym53c8xx, sym53c8xx, ehci_hcd, NVidia 
nForce2
 12:         61          XT-PIC  i8042
 14:        719          XT-PIC  ide0
 15:          9          XT-PIC  ide1
NMI:          0
LOC:    1083344
ERR:       1039
MIS:          0

# cat /proc/cpuinfo   
processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : Unknown CPU Type
stepping        : 0
cpu MHz         : 1837.905
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de tsc msr pae mce cx8 apic sep mtrr pge mca 
cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3629.05


I'll put the lspci and dmesg and .config up on the web 
(http://stuph.org/2.6.0-test1-issues) due to the size.

david


