Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266520AbUFQPkv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266520AbUFQPkv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266535AbUFQPkv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:40:51 -0400
Received: from os.inf.tu-dresden.de ([141.76.48.99]:55202 "EHLO
	os.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id S266520AbUFQPkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:40:31 -0400
From: Carsten Rietzschel <cr7@os.inf.tu-dresden.de>
To: linux-kernel@vger.kernel.org
Subject: ACPI S3 - USB resume problem (kernel 2.6.7)
Date: Thu, 17 Jun 2004 17:44:29 +0200
User-Agent: KMail/1.6.52
MIME-Version: 1.0
Content-Disposition: inline
Organization: TU Dresden - Operating System Group 
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_dxb0A9gqRwkTxrH"
Message-Id: <200406171744.29244.cr7@os.inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_dxb0A9gqRwkTxrH
Content-Type: text/plain;
  charset="us-ascii";
  boundary=""
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,

I tried to get S3 "Suspend to RAM" working. Almost everything works now, but 
USB doesn't respond after resuming (kernel 2.6.7).

The log shows (log appended; lspci -v output also):

usb 1-1: control timeout on ep0out
uhci_hcd 0000:00:10.0: Unlink after no-IRQ?  Different ACPI or APIC settings 
may help.
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 2, error -110
usb 1-1: new low speed USB device using address 3
usb 1-1: control timeout on ep0out
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 3, error -110

Noticed that in /proc/interrupts the values for uhci_hcd are not incremented 
after resume. So are no IRQs where received (is that right ?).
What could be reason ?

So far I tried:
- set CONFIG_USB_DEBUG = y
- disable/enable APIC as suggested
("Unlink after no-IRQ?  Different ACPI or APIC settings" goes away, timeout 
stays)
- disabled USB 1.1 Controller or USB 2.0 Controller  in BIOS
- disabled preemption
- compiled USB-stuff into kernel instead using as modules
  ( even tried to unload before suspend and reloaded after resume )
- ensured CONFIG_PM is on and resume/suspend in is 
  called /drivers/usb/host/uhci-hcd.c
- forced reset_hc(uhci) in uhci_suspend() instead of suspend_hc()
  ( comment says it's for some broken motherboards )
- I saw CONFIG_USB_SUSPEND in some source files under host and core.
  I enabled it directly in these files and recompiled/restarted. No success.
  (doesn't harm, but seems not ready to use: 
     - it's not configureable     ;)
     - usb_suspend/resume_device() functions are nowhere)

Nothing helped :/ 
Still timeout messages and no USB device works after resume.

Anybody any idea where to look next or what to search for, or even a fix ?
If you want more infos I will tell you :)

Regards,
Carsten

--Boundary-00=_dxb0A9gqRwkTxrH
Content-Type: text/x-log;
  charset="us-ascii";
  name="usb_messages.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="usb_messages.log"

usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 11, io base 0000dc00
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
usb usb2: Manufacturer: Linux 2.6.7 uhci_hcd
usb usb2: SerialNumber: 0000:00:10.1
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.0: port 1 portsc 01ab
hub 1-0:1.0: port 1, status 0301, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:10.2: irq 7, io base 0000e000
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
usb usb3: Manufacturer: Linux 2.6.7 uhci_hcd
usb usb3: SerialNumber: 0000:00:10.2
usb usb3: hotplug
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
ehci_hcd: block sizes: qh 128 qtd 96 itd 192 sitd 96
ehci_hcd 0000:00:10.3: VIA Technologies, Inc. USB 2.0
ehci_hcd 0000:00:10.3: reset hcs_params 0x3206 dbg=0 cc=3 pcc=2 ordered !ppc ports=6
ehci_hcd 0000:00:10.3: reset hcc_params 6872 thresh 7 uframes 256/512/1024
ehci_hcd 0000:00:10.3: capability 0001 at 68
ehci_hcd 0000:00:10.3: irq 11, pci mem e0c91000
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 4
ehci_hcd 0000:00:10.3: reset command 080002 (park)=0 ithresh=8 period=1024 Reset HALT
ehci_hcd 0000:00:10.3: init command 010009 (park)=0 ithresh=1 period=256 RUN
ehci_hcd 0000:00:10.3: USB 2.0 enabled, EHCI 1.00, driver 2004-May-10
ehci_hcd 0000:00:10.3: supports USB remote wakeup
usb usb4: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb4: default language 0x0409
usb usb4: Product: VIA Technologies, Inc. USB 2.0
usb usb4: Manufacturer: Linux 2.6.7 ehci_hcd
usb usb4: SerialNumber: 0000:00:10.3
usb usb4: hotplug
uhci_hcd 0000:00:10.0: port 1 portsc 01aa
usb usb4: adding 4-0:1.0 (config #1, interface 0)
usb 4-0:1.0: hotplug
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
hub 4-0:1.0: usb_probe_interface
hub 4-0:1.0: usb_probe_interface - got id
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 6 ports detected
hub 4-0:1.0: standalone hub
hub 4-0:1.0: ganged power switching
hub 4-0:1.0: individual port over-current protection
hub 4-0:1.0: Single TT
hub 4-0:1.0: TT requires at most 8 FS bit times
hub 4-0:1.0: power on to power good time: 20ms
hub 4-0:1.0: local power source is good
hub 4-0:1.0: enabling power on all ports
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
usbcore: registered new driver hiddev
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.0:USB HID core driver
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
PCI: Setting latency timer of device 0000:00:11.5 to 64
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
uhci_hcd 0000:00:10.0: port 1 portsc 01a8
hub 1-0:1.0: debounce: port 1: delay 400ms stable 0 status 0x300
hub 1-0:1.0: connect-debounce failed, port 1 disabled
uhci_hcd 0000:00:10.0: port 2 portsc 008a
hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
ehci_hcd 0000:00:10.3: GetStatus port 1 status 001403 POWER sig=k  CSC CONNECT
hub 4-0:1.0: port 1, status 0501, change 0001, 480 Mb/s
hub 4-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x501
ehci_hcd 0000:00:10.3: port 1 low speed --> companion
ehci_hcd 0000:00:10.3: GetStatus port 1 status 003402 POWER OWNER sig=k  CSC
uhci_hcd 0000:00:10.2: port 1 portsc 008a
hub 3-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
uhci_hcd 0000:00:10.2: port 2 portsc 008a
hub 3-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
uhci_hcd 0000:00:10.0: port 1 portsc 01ab
hub 1-0:1.0: port 1, status 0301, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x301
ohci1394: $Rev: 1223 $ Ben Collins <bcollins@debian.org>
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[10]  MMIO=[db040000-db0407ff]  Max Packet=[2048]
video1394: Installed video1394 module
ieee1394: raw1394: /dev/raw1394 device initialized
usb 1-1: new low speed USB device using address 2
usb 1-1: skipped 1 descriptor after interface
usb 1-1: new device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: hotplug
usb 1-1: adding 1-1:1.0 (config #1, interface 0)
usb 1-1:1.0: hotplug
usbhid 1-1:1.0: usb_probe_interface
usbhid 1-1:1.0: usb_probe_interface - got id
input: USB HID v1.10 Mouse [062a:0000] on usb-0000:00:10.0-1
uhci_hcd 0000:00:10.0: port 2 portsc 0088
hub 1-0:1.0: port 2 enable change, status 00000100
uhci_hcd 0000:00:10.2: port 1 portsc 0088
hub 3-0:1.0: port 1 enable change, status 00000100
uhci_hcd 0000:00:10.2: port 2 portsc 0088
hub 3-0:1.0: port 2 enable change, status 00000100
uhci_hcd 0000:00:10.1: port 1 portsc 018a
hub 2-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:10.1: port 2 portsc 008a
hub 2-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda7, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
uhci_hcd 0000:00:10.1: port 1 portsc 0188
hub 2-0:1.0: port 1 enable change, status 00000300
uhci_hcd 0000:00:10.1: port 2 portsc 0088
hub 2-0:1.0: port 2 enable change, status 00000100
uhci_hcd 0000:00:10.1: suspend_hc
uhci_hcd 0000:00:10.2: suspend_hc
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[001106000000789b]
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
ehci_hcd 0000:00:10.3: remove, state 1
ehci_hcd 0000:00:10.3: roothub graceful disconnect
usb usb4: USB disconnect, address 1
usb usb4: usb_disable_device nuking all URBs
ehci_hcd 0000:00:10.3: shutdown urb de84bed8 pipe 40408180 ep1in-intr
usb usb4: unregistering interface 4-0:1.0
usb 4-0:1.0: hotplug
usb usb4: unregistering device
usb usb4: hotplug
ehci_hcd 0000:00:10.3: stop
ehci_hcd 0000:00:10.3: reset command 01000b (park)=0 ithresh=1 period=256 Reset RUN
ehci_hcd 0000:00:10.3: irq normal 0 err 0 reclaim 0 (lost 0)
ehci_hcd 0000:00:10.3: complete 0 unlink 0
ehci_hcd 0000:00:10.3: ehci_stop completed status 1000 Halt
ehci_hcd 0000:00:10.3: USB bus 4 deregistered
uhci_hcd 0000:00:10.0: remove, state 1
uhci_hcd 0000:00:10.0: roothub graceful disconnect
usb usb1: USB disconnect, address 1
usb 1-1: USB disconnect, address 2
usb 1-1: usb_disable_device nuking all URBs
usb 1-1: unregistering interface 1-1:1.0
usb 1-1:1.0: hotplug
usb 1-1: unregistering device
usb 1-1: hotplug
usb usb1: usb_disable_device nuking all URBs
uhci_hcd 0000:00:10.0: shutdown urb df444c58 pipe 40408180 ep1in-intr
usb usb1: unregistering interface 1-0:1.0
usb 1-0:1.0: hotplug
usb usb1: unregistering device
usb usb1: hotplug
uhci_hcd 0000:00:10.0: USB bus 1 deregistered
uhci_hcd 0000:00:10.1: remove, state 1
uhci_hcd 0000:00:10.1: roothub graceful disconnect
usb usb2: USB disconnect, address 1
usb usb2: usb_disable_device nuking all URBs
uhci_hcd 0000:00:10.1: shutdown urb df444858 pipe 40408180 ep1in-intr
usb usb2: unregistering interface 2-0:1.0
usb 2-0:1.0: hotplug
usb usb2: unregistering device
usb usb2: hotplug
uhci_hcd 0000:00:10.1: USB bus 2 deregistered
uhci_hcd 0000:00:10.2: remove, state 1
uhci_hcd 0000:00:10.2: roothub graceful disconnect
usb usb3: USB disconnect, address 1
usb usb3: usb_disable_device nuking all URBs
uhci_hcd 0000:00:10.2: shutdown urb df444458 pipe 40408180 ep1in-intr
usb usb3: unregistering interface 3-0:1.0
usb 3-0:1.0: hotplug
usb usb3: unregistering device
usb usb3: hotplug
uhci_hcd 0000:00:10.2: USB bus 3 deregistered
usbcore: deregistering driver hiddev
usbcore: deregistering driver usbhid
PM: Preparing system for suspend
Stopping tasks: ============================|
dsmthdat-0462 [33] ds_method_data_get_val: Uninitialized Local[0] at node dff3e50c
PM: Entering state.
 hwsleep-0304 [21] acpi_enter_sleep_state: Entering sleep state [S3]
Back to C!
PM: Finishing up.
dsmthdat-0462 [35] ds_method_data_get_val: Uninitialized Local[0] at node dff3e50c
dsmthdat-0462 [35] ds_method_data_get_val: Uninitialized Local[0] at node dff3e50c
Restarting tasks... done
e1000: eth0: e1000_watchdog: NIC Link is Up 100 Mbps Full Duplex
USB Universal Host Controller Interface driver v2.2
uhci_hcd 0000:00:10.0: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
uhci_hcd 0000:00:10.0: irq 10, io base 0000d800
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 1
uhci_hcd 0000:00:10.0: detected 2 ports
usb usb1: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb1: default language 0x0409
usb usb1: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller
usb usb1: Manufacturer: Linux 2.6.7 uhci_hcd
usb usb1: SerialNumber: 0000:00:10.0
usb usb1: hotplug
usb usb1: adding 1-0:1.0 (config #1, interface 0)
usb 1-0:1.0: hotplug
hub 1-0:1.0: usb_probe_interface
hub 1-0:1.0: usb_probe_interface - got id
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 2 ports detected
hub 1-0:1.0: standalone hub
hub 1-0:1.0: no power switching (usb 1.0)
hub 1-0:1.0: individual port over-current protection
hub 1-0:1.0: power on to power good time: 2ms
hub 1-0:1.0: local power source is good
uhci_hcd 0000:00:10.1: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
uhci_hcd 0000:00:10.1: irq 11, io base 0000dc00
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.1: detected 2 ports
usb usb2: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb2: default language 0x0409
usb usb2: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#2)
usb usb2: Manufacturer: Linux 2.6.7 uhci_hcd
usb usb2: SerialNumber: 0000:00:10.1
usb usb2: hotplug
usb usb2: adding 2-0:1.0 (config #1, interface 0)
usb 2-0:1.0: hotplug
hub 2-0:1.0: usb_probe_interface
hub 2-0:1.0: usb_probe_interface - got id
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
hub 2-0:1.0: standalone hub
hub 2-0:1.0: no power switching (usb 1.0)
hub 2-0:1.0: individual port over-current protection
hub 2-0:1.0: power on to power good time: 2ms
hub 2-0:1.0: local power source is good
uhci_hcd 0000:00:10.2: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
uhci_hcd 0000:00:10.0: port 1 portsc 01ab
hub 1-0:1.0: port 1, status 0301, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:10.2: irq 7, io base 0000e000
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.2: detected 2 ports
usb usb3: new device strings: Mfr=3, Product=2, SerialNumber=1
usb usb3: default language 0x0409
usb usb3: Product: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (#3)
usb usb3: Manufacturer: Linux 2.6.7 uhci_hcd
usb usb3: SerialNumber: 0000:00:10.2
usb usb3: hotplug
usb usb3: adding 3-0:1.0 (config #1, interface 0)
usb 3-0:1.0: hotplug
hub 3-0:1.0: usb_probe_interface
hub 3-0:1.0: usb_probe_interface - got id
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
hub 3-0:1.0: standalone hub
hub 3-0:1.0: no power switching (usb 1.0)
hub 3-0:1.0: individual port over-current protection
hub 3-0:1.0: power on to power good time: 2ms
hub 3-0:1.0: local power source is good
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
uhci_hcd 0000:00:10.0: port 1 portsc 01a9
hub 1-0:1.0: debounce: port 1: delay 100ms stable 4 status 0x301
usb 1-1: new low speed USB device using address 2
uhci_hcd 0000:00:10.1: suspend_hc
uhci_hcd 0000:00:10.2: suspend_hc
usb 1-1: control timeout on ep0out
uhci_hcd 0000:00:10.0: Unlink after no-IRQ?  Different ACPI or APIC settings may help.
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 2, error -110
usb 1-1: new low speed USB device using address 3
usb 1-1: control timeout on ep0out
usb 1-1: control timeout on ep0out
usb 1-1: device not accepting address 3, error -110
uhci_hcd 0000:00:10.0: port 2 portsc 008a
hub 1-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
uhci_hcd 0000:00:10.2: port 1 portsc 008a
hub 3-0:1.0: port 1, status 0100, change 0003, 12 Mb/s
uhci_hcd 0000:00:10.2: port 2 portsc 008a
hub 3-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
uhci_hcd 0000:00:10.0: port 2 portsc 0088
hub 1-0:1.0: port 2 enable change, status 00000100
uhci_hcd 0000:00:10.1: port 1 portsc 018a
hub 2-0:1.0: port 1, status 0300, change 0003, 1.5 Mb/s
uhci_hcd 0000:00:10.1: port 2 portsc 008a
hub 2-0:1.0: port 2, status 0100, change 0003, 12 Mb/s
uhci_hcd 0000:00:10.2: port 1 portsc 0088
hub 3-0:1.0: port 1 enable change, status 00000100
uhci_hcd 0000:00:10.2: port 2 portsc 0088
hub 3-0:1.0: port 2 enable change, status 00000100
uhci_hcd 0000:00:10.1: port 1 portsc 0188
hub 2-0:1.0: port 1 enable change, status 00000300
uhci_hcd 0000:00:10.1: port 2 portsc 0088
hub 2-0:1.0: port 2 enable change, status 00000100

--Boundary-00=_dxb0A9gqRwkTxrH
Content-Type: text/x-log;
  charset="us-ascii";
  name="lspci.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="lspci.log"

0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333] (rev 80)
	Subsystem: Giga-byte Technology: Unknown device 5000
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Memory at c0000000 (32-bit, prefetchable)
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2

0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66Mhz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: d8000000-d9ffffff
	Prefetchable memory behind bridge: d0000000-d7ffffff
	Capabilities: [80] Power Management version 2

0000:00:0b.0 Ethernet controller: Intel Corp. 82541GI Gigabit Ethernet Controller
	Subsystem: Intel Corp.: Unknown device 1176
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 11
	Memory at db020000 (32-bit, non-prefetchable)
	Memory at db000000 (32-bit, non-prefetchable) [size=128K]
	I/O ports at d000 [size=64]
	Capabilities: [dc] Power Management version 2
	Capabilities: [e4] PCI-X non-bridge device.
	Capabilities: [f0] Message Signalled Interrupts: 64bit+ Queue=0/0 Enable-

0000:00:0c.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46) (prog-if 10 [OHCI])
	Subsystem: VIA Technologies, Inc. IEEE 1394 Host Controller
	Flags: bus master, medium devsel, latency 32, IRQ 10
	Memory at db040000 (32-bit, non-prefetchable)
	I/O ports at d400 [size=128]
	Capabilities: [50] Power Management version 2

0000:00:10.0 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at d800 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.1 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 11
	I/O ports at dc00 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.2 USB Controller: VIA Technologies, Inc. USB (rev 80) (prog-if 00 [UHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 7
	I/O ports at e000 [size=32]
	Capabilities: [80] Power Management version 2

0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82) (prog-if 20 [EHCI])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 11
	Memory at db041000 (32-bit, non-prefetchable)
	Capabilities: [80] Power Management version 2

0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2

0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT8233/A/C/VT8235 PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: Giga-byte Technology GA-7VAX Mainboard
	Flags: bus master, medium devsel, latency 32, IRQ 10
	I/O ports at e400 [size=16]
	Capabilities: [c0] Power Management version 2

0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235 AC97 Audio Controller (rev 50)
	Subsystem: Giga-byte Technology GA-7VAX Onboard Audio (Realtek ALC650)
	Flags: medium devsel, IRQ 7
	I/O ports at e800
	Capabilities: [c0] Power Management version 2

0000:01:00.0 VGA compatible controller: nVidia Corporation NV20 [GeForce3 Ti 200] (rev a3) (prog-if 00 [VGA])
	Subsystem: LeadTek Research Inc.: Unknown device 2861
	Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
	Memory at d8000000 (32-bit, non-prefetchable)
	Memory at d0000000 (32-bit, prefetchable) [size=64M]
	Memory at d4000000 (32-bit, prefetchable) [size=512K]
	Capabilities: [60] Power Management version 2
	Capabilities: [44] AGP version 2.0


--Boundary-00=_dxb0A9gqRwkTxrH--
