Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbSKKXgZ>; Mon, 11 Nov 2002 18:36:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262383AbSKKXgY>; Mon, 11 Nov 2002 18:36:24 -0500
Received: from ns.indranet.co.nz ([210.54.239.210]:19944 "EHLO
	mail.acheron.indranet.co.nz") by vger.kernel.org with ESMTP
	id <S261645AbSKKXgJ>; Mon, 11 Nov 2002 18:36:09 -0500
Date: Tue, 12 Nov 2002 12:42:47 +1300
From: Andrew McGregor <andrew@indranet.co.nz>
To: linux-kernel@vger.kernel.org
Subject: [BUG] apm-suspend in 2.5.47 kills USB mouse
Message-ID: <3690000.1037058167@localhost.localdomain>
X-Mailer: Mulberry/3.0.0a5 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When I suspend my laptop, the USB mouse is dead on resume.

Hardware:
Dell Inspiron 8000 w/ integrated ps/2 trackpad and trackpoint
Logitech iFeel USB mouse
NVidia GeForce2go

Software:
RedHat 8.0
linux 2.5.47
NVidia driver build 3123 with patch from http://www.minion.de/nvidia/ plus 
its suspend veto disabled.
APM (this system's BIOS seems to implement APM in terms of ACPI, which 
explains why on the right combination of 2.4 and video drivers it can 
suspend the GeForce2go at all)

I know about the driver for the graphics card being an issue, but the bug 
is reproducable without X or with vesa drivers.

If anyone cares to look at the NVidia driver trace below, that's 
interesting to me too.

The "end_request: I/O error, dev hdb, sector 0" and so forth are gnome 
polling the CD drives for media.  This is an irritation I'd like to know 
how to fix also.

Below is the log of what happens when I suspend (with NVidia's driver 
loaded).

TIA,

Andrew

Nov 12 12:26:27 localhost apmd[688]: User Suspend
Nov 12 12:26:50 localhost kernel: drivers/usb/core/hcd-pci.c: suspend 
00:1f.2 to state 3
Nov 12 12:26:50 localhost kernel: drivers/usb/core/hcd-pci.c: resume 00:1f.2
Nov 12 12:26:50 localhost kernel: drivers/usb/core/usb.c: USB disconnect on 
device 2
Nov 12 12:26:50 localhost kernel: end_request: I/O error, dev hdb, sector 0
Nov 12 12:26:50 localhost last message repeated 2 times
Nov 12 12:26:50 localhost kernel: end_request: I/O error, dev hdc, sector 0
Nov 12 12:26:50 localhost last message repeated 2 times
Nov 12 12:26:50 localhost /sbin/hotplug: no runnable 
/etc/hotplug/input.agent is installed
Nov 12 12:26:51 localhost kernel: floppy0: unexpected interrupt
Nov 12 12:26:51 localhost kernel: floppy0: sensei repl[0]=c0 repl[1]=0
Nov 12 12:26:51 localhost kernel: floppy0: sensei repl[0]=c1 repl[1]=0
Nov 12 12:26:51 localhost kernel: floppy0: sensei repl[0]=c2 repl[1]=0
Nov 12 12:26:51 localhost kernel: floppy0: sensei repl[0]=c3 repl[1]=0
Nov 12 12:26:52 localhost kernel: drivers/usb/core/hub.c: new USB device 
00:1f.2-2, assigned address 3
Nov 12 12:26:52 localhost /etc/hotplug/usb.agent: Bad USB agent invocation
Nov 12 12:26:53 localhost kernel: end_request: I/O error, dev hdb, sector 0
Nov 12 12:26:53 localhost last message repeated 3 times
Nov 12 12:26:53 localhost kernel: end_request: I/O error, dev hdc, sector 0
Nov 12 12:26:53 localhost kernel: end_request: I/O error, dev hdc, sector 0
Nov 12 12:26:53 localhost kernel: bad: scheduling while atomic!
Nov 12 12:26:53 localhost kernel: Call Trace:
Nov 12 12:26:53 localhost kernel:  [<c0118dfb>] schedule+0x30b/0x310
Nov 12 12:26:53 localhost kernel:  [<c012c505>] flush_workqueue+0xd5/0xf0
Nov 12 12:26:53 localhost kernel:  [<c0118e50>] 
default_wake_function+0x0/0x40
Nov 12 12:26:53 localhost kernel:  [<e09afd13>] __nvsym00583+0x1c3/0x1cc 
[NVdriver]
Nov 12 12:26:53 localhost kernel:  [<c0118e50>] 
default_wake_function+0x0/0x40
Nov 12 12:26:53 localhost kernel:  [<e08f9e28>] __nvsym00588+0x10/0x28 
[NVdriver]
Nov 12 12:26:53 localhost kernel:  [<e09d6e80>] nv_linux_devices+0x0/0xc40 
[NVdriver]
Nov 12 12:26:53 localhost kernel:  [<e09d6e80>] nv_linux_devices+0x0/0xc40 
[NVdriver]
Nov 12 12:26:53 localhost kernel:  [<e08e8edb>] nv_kern_close+0x6d/0x17a 
[NVdriver]
Nov 12 12:26:53 localhost kernel:  [<e09d6e80>] nv_linux_devices+0x0/0xc40 
[NVdriver]
Nov 12 12:26:53 localhost kernel:  [<c01624c0>] dput+0x30/0x130
Nov 12 12:26:53 localhost kernel:  [<c014dc30>] __fput+0xf0/0x100
Nov 12 12:26:53 localhost kernel:  [<c014b914>] filp_close+0x74/0xa0
Nov 12 12:26:53 localhost gdm(pam_unix)[939]: session closed for user 
andrewm
Nov 12 12:26:53 localhost kernel:  [<c011fd9c>] put_files_struct+0x6c/0xe0
Nov 12 12:26:53 localhost kernel:  [<c01204ba>] do_exit+0x14a/0x320
Nov 12 12:26:53 localhost kernel:  [<c0126ad2>] sig_exit+0x52/0x60
Nov 12 12:26:53 localhost kernel:  [<c0127e8a>] 
get_signal_to_deliver+0x1ba/0x240
Nov 12 12:26:53 localhost kernel:  [<c010afcb>] do_signal+0xcb/0x100
Nov 12 12:26:54 localhost kernel:  [<c014dbff>] __fput+0xbf/0x100
Nov 12 12:26:54 localhost kernel:  [<c0135445>] unmap_vma+0x75/0x80
Nov 12 12:26:54 localhost kernel:  [<c013546f>] unmap_vma_list+0x1f/0x30
Nov 12 12:26:54 localhost kernel:  [<c013587d>] do_munmap+0x14d/0x190
Nov 12 12:26:54 localhost kernel:  [<c0116540>] do_page_fault+0x0/0x49e
Nov 12 12:26:54 localhost kernel:  [<c010b1ce>] work_notifysig+0x13/0x15
Nov 12 12:26:54 localhost kernel:
Nov 12 12:26:54 localhost kernel: end_request: I/O error, dev hdc, sector 0
Nov 12 12:26:54 localhost kernel: end_request: I/O error, dev hdc, sector 0
Nov 12 12:26:54 localhost gdm[939]: gdm_slave_xioerror_handler: Fatal X 
error - Restarting :0
Nov 12 12:26:54 localhost kernel: e100: eth0 NIC Link is Up 100 Mbps Full 
duplex
Nov 12 12:26:54 localhost kernel: Debug: sleeping function called from 
illegal context at mm/page_alloc.c:417
Nov 12 12:26:54 localhost kernel: Call Trace:
Nov 12 12:26:54 localhost kernel:  [<c013f71a>] __alloc_pages+0x2ba/0x2c0
Nov 12 12:26:54 localhost kernel:  [<c013a9d5>] get_vm_area+0x25/0x110
Nov 12 12:26:54 localhost kernel:  [<c013adc7>] __vmalloc+0xc7/0x130
Nov 12 12:26:54 localhost kernel:  [<c013ae50>] vmalloc+0x20/0x30
Nov 12 12:26:54 localhost kernel:  [<e08ea915>] os_alloc_mem+0x55/0x70 
[NVdriver]
Nov 12 12:26:54 localhost kernel:  [<e08eb21d>] 
os_map_kernel_space+0x59/0x90 [NVdriver]
Nov 12 12:26:54 localhost kernel:  [<e08f8838>] __nvsym00052+0x10/0x24 
[NVdriver]
Nov 12 12:26:54 localhost kernel:  [<e097ccbe>] __nvsym02481+0x72/0x14c 
[NVdriver]
Nov 12 12:26:54 localhost kernel:  [<e097b9ee>] __nvsym00586+0x8e/0x160 
[NVdriver]
Nov 12 12:26:54 localhost kernel:  [<e09d6e80>] nv_linux_devices+0x0/0xc40 
[NVdriver]
Nov 12 12:26:55 localhost kernel:  [<e09d6e80>] nv_linux_devices+0x0/0xc40 
[NVdriver]
Nov 12 12:26:55 localhost kernel:  [<e09f1220>] __nvsym00194+0x0/0x160 
[NVdriver]
Nov 12 12:26:55 localhost kernel:  [<e08f9cb8>] __nvsym00584+0x5c/0xe0 
[NVdriver]
Nov 12 12:26:55 localhost kernel:  [<e08fa934>] rm_init_adapter+0xc/0x10 
[NVdriver]
Nov 12 12:26:55 localhost kernel:  [<e09d6e80>] nv_linux_devices+0x0/0xc40 
[NVdriver]
Nov 12 12:26:55 localhost kernel:  [<e08e8d46>] nv_kern_open+0x106/0x22e 
[NVdriver]
Nov 12 12:26:55 localhost kernel:  [<e09d6e80>] nv_linux_devices+0x0/0xc40 
[NVdriver]
Nov 12 12:26:55 localhost kernel:  [<e09d6e80>] nv_linux_devices+0x0/0xc40 
[NVdriver]
Nov 12 12:26:55 localhost kernel:  [<c015a1cf>] may_open+0x5f/0x1c0
Nov 12 12:26:55 localhost kernel:  [<c014d756>] chrdev_open+0x66/0x80
Nov 12 12:26:55 localhost kernel:  [<c014b57e>] dentry_open+0x18e/0x1c0
Nov 12 12:26:55 localhost kernel:  [<c014b3e8>] filp_open+0x68/0x70
Nov 12 12:26:55 localhost kernel:  [<c014b83b>] sys_open+0x5b/0x90
Nov 12 12:26:55 localhost kernel:  [<c010b183>] syscall_call+0x7/0xb
Nov 12 12:26:55 localhost kernel:
Nov 12 12:27:00 localhost dhclient: DHCPREQUEST on eth0 to 255.255.255.255 
port 67
Nov 12 12:27:02 localhost kernel: drivers/usb/input/hid-core.c: ctrl urb 
status -104 received
Nov 12 12:27:02 localhost kernel: drivers/usb/input/hid-core.c: timeout 
initializing reports
Nov 12 12:27:02 localhost kernel:
Nov 12 12:27:02 localhost kernel: input: USB HID v1.00 Mouse [Logitech Inc. 
iFeel MouseMan] on usb-00:1f.2-2
Nov 12 12:27:02 localhost /sbin/hotplug: no runnable 
/etc/hotplug/input.agent is installed
Nov 12 12:27:04 localhost dhclient: DHCPREQUEST on eth0 to 255.255.255.255 
port 67
Nov 12 12:27:05 localhost /etc/hotplug/usb.agent: Setup usbmouse hid for 
USB product 46d/c032/100
Nov 12 12:27:05 localhost kernel: general protection fault: 0000
Nov 12 12:27:05 localhost kernel: usbmouse snd-maestro3 snd-ac97-codec 
NVdriver apm ipt_REJECT iptable_filter ip_tables ohci1394 ieee1394 hid rtc
Nov 12 12:27:05 localhost kernel: CPU:    0
Nov 12 12:27:05 localhost kernel: EIP:    0060:[<c0235933>]    Tainted: P
Nov 12 12:27:05 localhost kernel: EFLAGS: 00010246
Nov 12 12:27:05 localhost kernel: EIP is at driver_attach+0x53/0x90
Nov 12 12:27:05 localhost kernel: eax: 00000000   ebx: ffffffff   ecx: 
c04fc230   edx: 00000000
Nov 12 12:27:05 localhost kernel: esi: dfd010cc   edi: c051ab04   ebp: 
e08dced8   esp: d48efea0
Nov 12 12:27:05 localhost kernel: ds: 0068   es: 0068   ss: 0068
Nov 12 12:27:05 localhost kernel: Process modprobe (pid: 1866, 
threadinfo=d48ee000 task=db6981e0)
Nov 12 12:27:05 localhost kernel: Stack: dfd010cc e08dceec c051aa04 
c051aa00 e08dced8 e08dceec c0235c6c e08dced8
Nov 12 12:27:05 localhost kernel:        00000042 e08dced8 e08dc9fc 
e08dcefc c0236381 e08dced8 c04c74cc e08dcec0
Nov 12 12:27:05 localhost kernel:        00000000 00000000 e08dc000 
c02d2848 e08dced8 00000202 00000000 00000000
Nov 12 12:27:05 localhost /etc/hotplug/usb.agent: ... can't load module 
usbmouse
Nov 12 12:27:05 localhost kernel: Call Trace:
Nov 12 12:27:05 localhost kernel:  [<e08dceec>] usb_mouse_driver+0x2c/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<e08dced8>] usb_mouse_driver+0x18/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<e08dceec>] usb_mouse_driver+0x2c/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<c0235c6c>] bus_add_driver+0x6c/0x90
Nov 12 12:27:05 localhost /etc/hotplug/usb.agent: missing kernel or user 
mode driver usbmouse
Nov 12 12:27:05 localhost kernel:  [<e08dced8>] usb_mouse_driver+0x18/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<e08dced8>] usb_mouse_driver+0x18/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<e08dc9fc>] 
__module_usb_device_size+0x0/0x484 [usbmouse]
Nov 12 12:27:05 localhost kernel:  [<e08dcefc>] usb_mouse_driver+0x3c/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<c0236381>] driver_register+0x91/0xa0
Nov 12 12:27:05 localhost kernel:  [<e08dced8>] usb_mouse_driver+0x18/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<e08dcec0>] usb_mouse_driver+0x0/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<c02d2848>] usb_register+0x78/0xc0
Nov 12 12:27:05 localhost kernel:  [<e08dced8>] usb_mouse_driver+0x18/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<c022107c>] copy_from_user+0x4c/0x50
Nov 12 12:27:05 localhost kernel:  [<e08dc80f>] usb_mouse_init+0xf/0x20 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<e08dcec0>] usb_mouse_driver+0x0/0x94 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<c011ddc1>] sys_init_module+0x4e1/0x640
Nov 12 12:27:05 localhost kernel:  [<e08dc060>] usb_mouse_irq+0x0/0x1e0 
[usbmouse]
Nov 12 12:27:05 localhost kernel:  [<e08dc060>] usb_mouse_irq+0x0/0x1e0 
[usbmouse]
Nov 12 12:27:05 localhost /etc/hotplug/usb.agent: Setup mousedev for USB 
product 46d/c032/100
Nov 12 12:27:05 localhost kernel:  [<c010b183>] syscall_call+0x7/0xb
Nov 12 12:27:05 localhost kernel:
Nov 12 12:27:05 localhost kernel: Code: 8b 03 0f 18 00 39 fb 75 d4 83 c4 08 
31 c0 5b 5e 5f 5d c3 89
Nov 12 12:27:05 localhost modprobe: modprobe: Can't locate module mousedev
Nov 12 12:27:11 localhost dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 
port 67 interval 5
Nov 12 12:27:15 localhost login(pam_unix)[888]: session opened for user 
root by LOGIN(uid=0)
Nov 12 12:27:15 localhost  -- root[888]: ROOT LOGIN ON tty1
Nov 12 12:27:16 localhost dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 
port 67 interval 6
Nov 12 12:27:22 localhost dhclient: DHCPDISCOVER on eth0 to 255.255.255.255 
port 67 interval 17
Nov 12 12:27:22 localhost dhclient: DHCPOFFER from 192.168.1.1
Nov 12 12:27:22 localhost dhclient: DHCPREQUEST on eth0 to 255.255.255.255 
port 67
Nov 12 12:27:23 localhost dhclient: DHCPACK from 192.168.1.1
Nov 12 12:27:23 localhost dhclient: bound to 192.168.1.30 -- renewal in 
9006 seconds.
Nov 12 12:27:23 localhost netfs: Mounting other filesystems:  succeeded
Nov 12 12:27:23 localhost netfs: Mounting other filesystems:  succeeded
Nov 12 12:27:24 localhost gconfd (andrewm-998): GConf server is not in use, 
shutting down.
Nov 12 12:27:24 localhost gconfd (andrewm-998): Exiting
Nov 12 12:27:24 localhost apmd[688]: Normal Resume after 00:00:57 (100% 
6:01) AC power
