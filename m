Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268043AbUI1TSr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268043AbUI1TSr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 15:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268037AbUI1TSr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 15:18:47 -0400
Received: from tabit.netstar.se ([195.178.179.33]:24784 "HELO tabit.netstar.se")
	by vger.kernel.org with SMTP id S268031AbUI1TRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 15:17:46 -0400
Subject: 2.6.9-rc2-mm4: after suspend/resume intel_8x0 and USB broken
From: Kristoffer Sjoberg <kristoffer.sjoberg@netstar.se>
Reply-To: kristoffer.sjoberg@netstar.se
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-15
Organization: Netstar AB
Date: Tue, 28 Sep 2004 21:16:30 +0200
Message-Id: <1096398991.4848.13.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.0 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just recently when upgrading my kernel, my machine started to respond
after a resume (instead of a double fault, apparently fixed in 2.6.9-
rc2-mm3).  

Now, it still won't resume properly, presenting a stack trace leading to
a disabled IRQ 11, rendering the machine pretty much useless (although
in a good enough shape for a 'reboot')

I've attached the messages from syslog, and a brief hardware description
(the computer is an HP NC6000 laptop)


$ cat /proc/interrupts 
           CPU0       
  0:    2476531          XT-PIC  timer
  1:       7742          XT-PIC  i8042
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:       1444          XT-PIC  acpi
 10:     527092          XT-PIC  ehci_hcd, uhci_hcd, uhci_hcd, uhci_hcd,
yenta, yenta, yenta
 11:       3270          XT-PIC  Intel 82801DB-ICH4, eth0
 12:       1590          XT-PIC  i8042
 14:      21417          XT-PIC  ide0
NMI:          0 
LOC:    2472921 
ERR:          0
MIS:          0

$ lspci
0000:00:00.0 Host bridge: Intel Corp. 82855PM Processor to I/O
Controller (rev 03)
0000:00:01.0 PCI bridge: Intel Corp. 82855PM Processor to AGP Controller
(rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-
L/ICH4-M) USB UHCI Controller #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-
L/ICH4-M) USB UHCI Controller #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-
L/ICH4-M) USB UHCI Controller #3 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801DB/DBM (ICH4/ICH4-M) USB
2.0 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev 83)
0000:00:1f.0 ISA bridge: Intel Corp. 82801DBM LPC Interface Controller
(rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801DBM (ICH4) Ultra ATA
Storage Controller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
SMBus Controller (rev 03)
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
(ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 03)
0000:00:1f.6 Modem: Intel Corp. 82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M)
AC'97 Modem Controller (rev 03)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV350
[Mobility Radeon 9600 M10]
0000:02:04.0 Ethernet controller: Atheros Communications, Inc. AR5212
802.11abg NIC (rev 01)
0000:02:06.0 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus
MultiMediaBay Controller
0000:02:06.1 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus
MultiMediaBay Controller
0000:02:06.2 System peripheral: O2 Micro, Inc. OZ711Mx MultiMediaBay
Accelerator
0000:02:06.3 CardBus bridge: O2 Micro, Inc. OZ711M3 SmartCardBus
MultiMediaBay Controller
0000:02:0e.0 Ethernet controller: Broadcom Corporation NetXtreme
BCM5705M_2 Gigabit Ethernet (rev 03)



excerpts from /var/log/syslog:

Suspend/Resume:

Sep 28 20:27:48 nc6000 kernel: Stopping tasks:
=================================================|
Sep 28 20:27:48 nc6000 kernel: Freeing memory...  ^H-^H\^H|^H/^H-^H\^H|
^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|^H/^H-^H\^H|
^H/^Hdone (10617 pages freed)
Sep 28 20:27:48 nc6000 kernel: hci_usb 4-1:1.0: resume is unsafe!
Sep 28 20:27:48 nc6000 kernel: hci_usb 4-1:1.1: resume is unsafe!
Sep 28 20:27:48 nc6000 kernel: usb 4-1: no poweroff yet, suspending
instead
Sep 28 20:27:48 nc6000 kernel: usb usb4: no poweroff yet, suspending
instead
Sep 28 20:27:48 nc6000 kernel: usb usb3: no poweroff yet, suspending
instead
Sep 28 20:27:48 nc6000 kernel: usb usb2: no poweroff yet, suspending
instead
Sep 28 20:27:48 nc6000 kernel: usbhid 1-3.3:1.0: resume is unsafe!
Sep 28 20:27:48 nc6000 kernel: usb 1-3.3: no poweroff yet, suspending
instead
Sep 28 20:27:48 nc6000 kernel: usb 1-3: no poweroff yet, suspending
instead
Sep 28 20:27:48 nc6000 kernel: usb usb1: no poweroff yet, suspending
instead
Sep 28 20:27:48 nc6000 kernel: PM: Attempting to suspend to disk.
Sep 28 20:27:48 nc6000 kernel: PM: snapshotting memory.
Sep 28 20:27:48 nc6000 kernel: swsusp: critical section: 
Sep 28 20:27:48 nc6000 kernel: swsusp: Saving Highmem
Sep 28 20:27:48 nc6000 kernel: ..........<7>[nosave pfn 0x3ec]<7>[nosave
pfn 0x3ed].........swsusp: Need to copy 8799 pages
Sep 28 20:27:48 nc6000 kernel: suspend: (pages needed: 8799 + 512 free:
250460)
Sep 28 20:27:48 nc6000 kernel: ..<7>[nosave pfn 0x3ec]<7>[nosave pfn
0x3ed]swsusp: Restoring Highmem
Sep 28 20:27:48 nc6000 kernel: PM: Image restored successfully.
Sep 28 20:27:48 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Sep 28 20:27:48 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Sep 28 20:27:48 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Sep 28 20:27:48 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Sep 28 20:27:48 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Sep 28 20:27:48 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Sep 28 20:27:48 nc6000 kernel: ACPI: PCI interrupt 0000:00:1f.1[A] ->
GSI 10 (level, low) -> IRQ 10
Sep 28 20:27:48 nc6000 kernel: ACPI: PCI interrupt 0000:00:1f.5[B] ->
GSI 11 (level, low) -> IRQ 11
Sep 28 20:27:48 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1f.5 to 64
Sep 28 20:27:48 nc6000 kernel: irq 11: nobody cared!
Sep 28 20:27:49 nc6000 kernel:  [__report_bad_irq+42/144]
__report_bad_irq+0x2a/0x90
Sep 28 20:27:49 nc6000 kernel:  [note_interrupt+129/272] note_interrupt
+0x81/0x110
Sep 28 20:27:49 nc6000 kernel:  [do_IRQ+296/320] do_IRQ+0x128/0x140
Sep 28 20:27:49 nc6000 kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Sep 28 20:27:49 nc6000 kernel:  [acpi_ns_detach_object+65/171]
acpi_ns_detach_object+0x41/0xab
Sep 28 20:27:49 nc6000 kernel:  [handle_IRQ_event+32/112]
handle_IRQ_event+0x20/0x70
Sep 28 20:27:49 nc6000 kernel:  [acpi_ut_status_exit+73/85]
acpi_ut_status_exit+0x49/0x55
Sep 28 20:27:49 nc6000 kernel:  [do_IRQ+143/320] do_IRQ+0x8f/0x140
Sep 28 20:27:49 nc6000 kernel:  [common_interrupt+24/32]
common_interrupt+0x18/0x20
Sep 28 20:27:49 nc6000 kernel:  [ide_do_request+506/896] ide_do_request
+0x1fa/0x380
Sep 28 20:27:49 nc6000 kernel:  [__elv_add_request+69/176]
__elv_add_request+0x45/0xb0
Sep 28 20:27:49 nc6000 kernel:  [ide_do_drive_cmd+208/320]
ide_do_drive_cmd+0xd0/0x140
Sep 28 20:27:49 nc6000 kernel:  [generic_ide_resume+148/192]
generic_ide_resume+0x94/0xc0
Sep 28 20:27:49 nc6000 kernel:  [resume_device+41/48] resume_device
+0x29/0x30
Sep 28 20:27:49 nc6000 kernel:  [dpm_resume+110/112] dpm_resume
+0x6e/0x70
Sep 28 20:27:49 nc6000 kernel:  [device_resume+25/48] device_resume
+0x19/0x30
Sep 28 20:27:49 nc6000 kernel:  [finish+8/64] finish+0x8/0x40
Sep 28 20:27:49 nc6000 kernel:  [pm_suspend_disk+126/192]
pm_suspend_disk+0x7e/0xc0
Sep 28 20:27:49 nc6000 kernel:  [enter_state+183/192] enter_state
+0xb7/0xc0
Sep 28 20:27:49 nc6000 kernel:  [software_suspend+15/32]
software_suspend+0xf/0x20
Sep 28 20:27:49 nc6000 kernel:  [acpi_system_write_sleep+106/132]
acpi_system_write_sleep+0x6a/0x84
Sep 28 20:27:49 nc6000 kernel:  [vfs_write+184/304] vfs_write+0xb8/0x130
Sep 28 20:27:49 nc6000 kernel:  [filp_close+89/144] filp_close+0x59/0x90
Sep 28 20:27:49 nc6000 kernel:  [sys_write+81/128] sys_write+0x51/0x80
Sep 28 20:27:49 nc6000 kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Sep 28 20:27:49 nc6000 kernel: handlers:
Sep 28 20:27:49 nc6000 kernel: [pg0+946923792/1069229056]
(snd_intel8x0_interrupt+0x0/0x240 [snd_intel8x0])
Sep 28 20:27:49 nc6000 kernel: Disabling IRQ #11
Sep 28 20:27:49 nc6000 kernel: usb 1-3: control timeout on ep0in
Sep 28 20:27:49 nc6000 kernel: hci_usb: probe of 4-1:1.2 failed with
error -113
Sep 28 20:27:49 nc6000 kernel: usb 1-3: control timeout on ep0in
Sep 28 20:27:49 nc6000 kernel: hub 1-0:1.0: activate --> -22
Sep 28 20:27:49 nc6000 kernel: hub 1-3:1.0: hub_port_status failed (err
= -19)
Sep 28 20:27:49 nc6000 last message repeated 2 times
Sep 28 20:27:49 nc6000 kernel: hub 1-3:1.0: cannot disable port 3 (err =
-19)
Sep 28 20:27:49 nc6000 kernel: hub 1-3:1.0: hub_port_status failed (err
= -19)
Sep 28 20:27:49 nc6000 kernel: hub 1-3:1.0: activate --> -19
Sep 28 20:27:49 nc6000 kernel: hci_usb: probe of 4-1:1.2 failed with
error -113
Sep 28 20:27:49 nc6000 kernel: hub 2-0:1.0: activate --> -22
Sep 28 20:27:49 nc6000 kernel: hci_usb: probe of 4-1:1.2 failed with
error -113
Sep 28 20:27:49 nc6000 kernel: hub 3-0:1.0: activate --> -22
Sep 28 20:27:49 nc6000 kernel: hci_usb: probe of 4-1:1.2 failed with
error -113
Sep 28 20:27:49 nc6000 kernel: hub 4-0:1.0: activate --> -22
Sep 28 20:27:49 nc6000 kernel: hci_usb: probe of 4-1:1.2 failed with
error -113
Sep 28 20:27:49 nc6000 kernel: Restarting tasks... done
Sep 28 20:27:49 nc6000 kernel: usb 1-3: USB disconnect, address 2
Sep 28 20:27:49 nc6000 kernel: usb 1-3.3: USB disconnect, address 4
Sep 28 20:27:49 nc6000 kernel: usb 3-1: new full speed USB device using
address 2
Sep 28 20:27:50 nc6000 kernel: Synaptics Touchpad, model: 1
Sep 28 20:27:50 nc6000 kernel:  Firmware: 5.9
Sep 28 20:27:50 nc6000 kernel:  Sensor: 27
Sep 28 20:27:50 nc6000 kernel:  new absolute packet format
Sep 28 20:27:50 nc6000 kernel:  Touchpad has extended capability bits
Sep 28 20:27:50 nc6000 kernel:  -> multifinger detection
Sep 28 20:27:50 nc6000 kernel:  -> palm detection
Sep 28 20:27:50 nc6000 kernel:  -> pass-through port
Sep 28 20:27:50 nc6000 kernel: input: SynPS/2 Synaptics TouchPad on
isa0060/serio4
Sep 28 20:27:50 nc6000 kernel: serio: Synaptics pass-through port at
isa0060/serio4/input0
Sep 28 20:27:51 nc6000 kernel: Warning: CPU frequency is 1800000,
cpufreq assumed 600000 kHz.
Sep 28 20:27:54 nc6000 kernel: usb 3-1: control timeout on ep0out
Sep 28 20:27:54 nc6000 kernel: input: PS/2 Generic Mouse on synaptics-
pt/serio0
Sep 28 20:27:59 nc6000 kernel: usb 3-1: control timeout on ep0out
Sep 28 20:28:00 nc6000 kernel: usb 3-1: device not accepting address 2,
error -110
Sep 28 20:28:00 nc6000 kernel: usb 3-1: new full speed USB device using
address 3
Sep 28 20:28:05 nc6000 kernel: usb 3-1: control timeout on ep0out
Sep 28 20:28:10 nc6000 kernel: usb 3-1: control timeout on ep0out
Sep 28 20:28:10 nc6000 kernel: usb 3-1: device not accepting address 3,
error -110
Sep 28 20:28:10 nc6000 kernel: usb 4-1: USB disconnect, address 2
Sep 28 20:28:10 nc6000 hcid[2856]: HCI dev 0 down
Sep 28 20:28:10 nc6000 hcid[2856]: Stoping security manager 0
Sep 28 20:28:11 nc6000 hcid[2856]: HCI dev 0 unregistered
Sep 28 20:28:11 nc6000 kernel: usb 4-1: new full speed USB device using
address 3
Sep 28 20:28:12 nc6000 hcid[2856]: HCI dev 0 registered
Sep 28 20:28:12 nc6000 usb.agent[3396]:      hci_usb: already loaded
Sep 28 20:28:12 nc6000 hcid[2856]: HCI dev 0 up
Sep 28 20:28:12 nc6000 hcid[2856]: Starting security manager 0


rmmod uhci-hcd:

Sep 28 20:28:28 nc6000 kernel: uhci_hcd 0000:00:1d.0: remove, state 1
Sep 28 20:28:28 nc6000 kernel: usb usb2: USB disconnect, address 1
Sep 28 20:28:28 nc6000 kernel: uhci_hcd 0000:00:1d.0: USB bus 2
deregistered
Sep 28 20:28:28 nc6000 kernel: uhci_hcd 0000:00:1d.1: remove, state 1
Sep 28 20:28:28 nc6000 kernel: usb usb3: USB disconnect, address 1
Sep 28 20:28:28 nc6000 kernel: uhci_hcd 0000:00:1d.1: USB bus 3
deregistered
Sep 28 20:28:28 nc6000 kernel: uhci_hcd 0000:00:1d.2: remove, state 1
Sep 28 20:28:28 nc6000 kernel: usb usb4: USB disconnect, address 1
Sep 28 20:28:28 nc6000 kernel: usb 4-1: USB disconnect, address 3
Sep 28 20:28:28 nc6000 hcid[2856]: HCI dev 0 down
Sep 28 20:28:28 nc6000 hcid[2856]: Stoping security manager 0
Sep 28 20:28:29 nc6000 hcid[2856]: HCI dev 0 unregistered
Sep 28 20:28:29 nc6000 kernel: uhci_hcd 0000:00:1d.2: USB bus 4
deregistered


modprobe uhci-hcd:

Sep 28 20:28:41 nc6000 kernel: USB Universal Host Controller Interface
driver v2.2
Sep 28 20:28:41 nc6000 kernel: ACPI: PCI interrupt 0000:00:1d.0[A] ->
GSI 10 (level, low) -> IRQ 10
Sep 28 20:28:41 nc6000 kernel: uhci_hcd 0000:00:1d.0: Intel Corp.
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #1
Sep 28 20:28:41 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
Sep 28 20:28:41 nc6000 kernel: uhci_hcd 0000:00:1d.0: irq 10, io base
0x38c0
Sep 28 20:28:41 nc6000 kernel: uhci_hcd 0000:00:1d.0: new USB bus
registered, assigned bus number 2
Sep 28 20:28:41 nc6000 usb.agent[3569]:      usbcore: already loaded
Sep 28 20:28:42 nc6000 kernel: hub 2-0:1.0: USB hub found
Sep 28 20:28:42 nc6000 kernel: hub 2-0:1.0: 2 ports detected
Sep 28 20:28:42 nc6000 kernel: ACPI: PCI interrupt 0000:00:1d.1[B] ->
GSI 10 (level, low) -> IRQ 10
Sep 28 20:28:42 nc6000 kernel: uhci_hcd 0000:00:1d.1: Intel Corp.
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #2
Sep 28 20:28:42 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
Sep 28 20:28:42 nc6000 kernel: uhci_hcd 0000:00:1d.1: irq 10, io base
0x38e0
Sep 28 20:28:42 nc6000 kernel: uhci_hcd 0000:00:1d.1: new USB bus
registered, assigned bus number 3
Sep 28 20:28:42 nc6000 usb.agent[3609]:      usbcore: already loaded
Sep 28 20:28:43 nc6000 kernel: hub 3-0:1.0: USB hub found
Sep 28 20:28:43 nc6000 kernel: hub 3-0:1.0: 2 ports detected
Sep 28 20:28:43 nc6000 kernel: ACPI: PCI interrupt 0000:00:1d.2[C] ->
GSI 10 (level, low) -> IRQ 10
Sep 28 20:28:43 nc6000 kernel: uhci_hcd 0000:00:1d.2: Intel Corp.
82801DB/DBL/DBM (ICH4/ICH4-L/ICH4-M) USB UHCI Controller #3
Sep 28 20:28:43 nc6000 kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
Sep 28 20:28:43 nc6000 kernel: uhci_hcd 0000:00:1d.2: irq 10, io base
0x3c00
Sep 28 20:28:43 nc6000 kernel: uhci_hcd 0000:00:1d.2: new USB bus
registered, assigned bus number 4
Sep 28 20:28:43 nc6000 usb.agent[3649]:      usbcore: already loaded
Sep 28 20:28:44 nc6000 kernel: usb 3-1: new full speed USB device using
address 2
Sep 28 20:28:44 nc6000 kernel: hub 4-0:1.0: USB hub found
Sep 28 20:28:44 nc6000 kernel: hub 4-0:1.0: 2 ports detected
Sep 28 20:28:48 nc6000 kernel: usb 3-1: control timeout on ep0out
Sep 28 20:28:48 nc6000 kernel: uhci_hcd 0000:00:1d.1: Unlink after no-
IRQ?  Different ACPI or APIC settings may help.
Sep 28 20:28:53 nc6000 kernel: usb 3-1: control timeout on ep0out
Sep 28 20:28:54 nc6000 kernel: usb 3-1: device not accepting address 2,
error -110
Sep 28 20:28:54 nc6000 kernel: usb 3-1: new full speed USB device using
address 3
Sep 28 20:28:59 nc6000 kernel: usb 3-1: control timeout on ep0out
Sep 28 20:29:04 nc6000 kernel: usb 3-1: control timeout on ep0out
Sep 28 20:29:04 nc6000 kernel: usb 3-1: device not accepting address 3,
error -110
Sep 28 20:29:05 nc6000 kernel: usb 4-1: new full speed USB device using
address 2


Thanks in advance,

BR

Kristoffer Sjöberg

