Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965387AbWI0GgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965387AbWI0GgP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:36:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965389AbWI0GgP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:36:15 -0400
Received: from mail.gmx.de ([213.165.64.20]:4060 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965387AbWI0GgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:36:14 -0400
X-Authenticated: #14349625
Subject: Re: [GIT PATCH] Driver Core patches for 2.6.18
From: Mike Galbraith <efault@gmx.de>
To: Greg KH <gregkh@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060926203948.GB15674@suse.de>
References: <20060926053728.GA8970@kroah.com>
	 <1159274045.6433.31.camel@Homer.simpson.net>
	 <20060926203948.GB15674@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 27 Sep 2006 08:47:22 +0000
Message-Id: <1159346843.6957.21.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 8bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-26 at 13:39 -0700, Greg KH wrote: 
> On Tue, Sep 26, 2006 at 12:34:05PM +0000, Mike Galbraith wrote:
> > On Mon, 2006-09-25 at 22:37 -0700, Greg KH wrote:
> > > Here are a bunch of driver core and sysfs patches and fixes for 2.6.18.
> > 
> > Hi,
> > 
> > Just as an fyi, these patches cause a ~regression on my P4/HT box.
> > 
> > Suspend stopped here working after 2.6.17.
> 
> Does 2.6.18 also have these problems?

Suspend failure, yes, kill box on failure, no.

> If so, it's not due to these patches :)

The 'Mikie's box' killer is definitely somewhere in these patches.  I
decided to test them after having just happened to have tried
2.6.18-rc7-mm1 to see if it the mm tree had fixed my suspend problem for
me, and then seeing your post.  Since 2.6.18 with these patches went
from ho-hum broke to ding-dong dead, I figured I should mention it.

> > I haven't dug into why, but
> > since then, I get a message "Class driver suspend failed for cpu0", and
> > the suspend fails, but everything works fine afterward.  If I ignore the
> > return of drv->suspend(), the box will suspend and resume just fine,
> > both with this patch set and without.  (which is what I've been doing
> > while waiting for it to fix itself or for my round toit to turn up)
> 
> What driver is controling cpu0?
> What driver is failing the suspend?

Dunno, see below.   

> What line did you have to change?

drivers/base/sys.c:409

Adding a WARN_ON() there wasn't particularly illuminating.  I enabled
debugging (this is virgin 2.6.18), and get the following.  I see a
problem I didn't notice before, see 'Hmm' below.  I have no idea if it
has anything to do with box killer problem with patchset applied.

SysRq : Emergency Sync
Emergency Sync complete
ieee1394: Node removed: ID:BUS[0-00:1023]  GUID[000010dc003bb526]
PM: Removing info for ieee1394:000010dc003bb526-0
PM: Removing info for ieee1394:000010dc003bb526
PM: Removing info for ieee1394:fw-host0
eth1: removing device
ACPI: PCI interrupt for device 0000:02:00.0 disabled
Unloaded prism54 driver
PM: suspend-to-disk mode set to 'platform'
Stopping tasks: ==================================================================================================================|
Shrinking memory...  -done (0 pages freed)
eeprom 2-0051: freeze
eeprom 0-0053: freeze
eeprom 0-0052: freeze
eeprom 0-0051: freeze
eeprom 0-0050: freeze
tuner 2-0060: freeze
tuner 2-0043: freeze
tveeprom 2-0050: freeze
ac97 0-0:CMI9761: freeze
ir-kbd-i2c 1-001a: freeze
sd 0:0:0:3: freeze
sd 0:0:0:2: freeze
sd 0:0:0:1: freeze
sd 0:0:0:0: freeze
i8042 i8042: freeze
usbhid 3-2:1.0: freeze
usb 3-2: freeze
usb-storage 3-1:1.0: freeze
usb 3-1: freeze
hub 5-0:1.0: freeze
usb usb5: freeze
hub 4-0:1.0: freeze
usb usb4: freeze
hub 3-0:1.0: freeze
usb usb3: freeze
hub 2-0:1.0: freeze
usb usb2: freeze
hub 1-0:1.0: freeze
usb usb1: freeze
ide-cdrom 1.1: freeze
ide-disk 1.0: freeze
ide-disk 0.0: freeze
serial8250 serial8250: freeze
vesafb vesafb.0: freeze
platform pcspkr: freeze
system 00:0c: freeze
system 00:0b: freeze
mpu401 00:0a: freeze
pnp: Device 00:0a disabled.
i8042 kbd 00:09: freeze
pnp 00:08: freeze
serial 00:07: freeze
pnp: Device 00:07 disabled.
pnp 00:06: freeze
pnp 00:05: freeze
pnp 00:04: freeze
pnp 00:03: freeze
pnp 00:02: freeze
system 00:01: freeze
pnp 00:00: freeze
pci 0000:02:0a.0: freeze
via-rhine 0000:02:09.0: freeze
saa7134 0000:02:03.0: freeze
bt878 0000:02:02.1: freeze
bttv 0000:02:02.0: freeze
pci 0000:02:00.0: freeze
pci 0000:01:00.1: freeze
pci 0000:01:00.0: freeze
Intel ICH 0000:00:1f.5: freeze
ACPI: PCI interrupt for device 0000:00:1f.5 disabled
i801_smbus 0000:00:1f.3: freeze
PIIX_IDE 0000:00:1f.1: freeze
pci 0000:00:1f.0: freeze
pci 0000:00:1e.0: freeze
ehci_hcd 0000:00:1d.7: freeze
ACPI: PCI interrupt for device 0000:00:1d.7 disabled
uhci_hcd 0000:00:1d.3: freeze
ACPI: PCI interrupt for device 0000:00:1d.3 disabled
uhci_hcd 0000:00:1d.2: freeze
ACPI: PCI interrupt for device 0000:00:1d.2 disabled
uhci_hcd 0000:00:1d.1: freeze
ACPI: PCI interrupt for device 0000:00:1d.1 disabled
uhci_hcd 0000:00:1d.0: freeze
ACPI: PCI interrupt for device 0000:00:1d.0 disabled
pci 0000:00:01.0: freeze
agpgart-intel 0000:00:00.0: freeze
acpi acpi: freeze
PM: snapshotting memory.
BUG: warning at drivers/base/sys.c:409/sysdev_suspend()
 [<b1003f65>] show_trace_log_lvl+0x179/0x18f
 [<b10045f4>] show_trace+0x12/0x14
 [<b1004690>] dump_stack+0x19/0x1b
 [<b124540f>] sysdev_suspend+0x282/0x2a1
 [<b1249798>] device_power_down+0x89/0x99
 [<b1037cd0>] swsusp_suspend+0x1b/0x95
 [<b10382c6>] pm_suspend_disk+0x5e/0x11a
 [<b1037244>] enter_state+0xe1/0x1b3
 [<b10373b9>] state_store+0xa3/0xac
 [<b10a2270>] subsys_attr_store+0x20/0x25
 [<b10a2594>] sysfs_write_file+0x82/0xbf
 [<b1063888>] vfs_write+0xa6/0x170
 [<b1063e65>] sys_write+0x3d/0x64
 [<b1002f17>] syscall_call+0x7/0xb
 [<a7e74b8e>] 0xa7e74b8e
Class driver suspend failed for cpu0
Could not power down device à^]H±: error -22
Hmm-------------------------^^^^^
(I had to edit this funky name out and copy/paste it back to convince evolution insert the file)
Some devices failed to power down, aborting suspend
acpi acpi: resuming
ACPI: Unable to turn cooling device [dfff5b80] 'on'
agpgart-intel 0000:00:00.0: resuming
pci 0000:00:01.0: resuming
uhci_hcd 0000:00:1d.0: resuming
PCI: Enabling device 0000:00:1d.0 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.0[A] -> GSI 16 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.0 to 64
uhci_hcd 0000:00:1d.1: resuming
PCI: Enabling device 0000:00:1d.1 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.1[B] -> GSI 19 (level, low) -> IRQ 20
PCI: Setting latency timer of device 0000:00:1d.1 to 64
uhci_hcd 0000:00:1d.2: resuming
PCI: Enabling device 0000:00:1d.2 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.2[C] -> GSI 18 (level, low) -> IRQ 17
PCI: Setting latency timer of device 0000:00:1d.2 to 64
uhci_hcd 0000:00:1d.3: resuming
PCI: Enabling device 0000:00:1d.3 (0000 -> 0001)
ACPI: PCI Interrupt 0000:00:1d.3[A] -> GSI 16 (level, low) -> IRQ 19
PCI: Setting latency timer of device 0000:00:1d.3 to 64
ehci_hcd 0000:00:1d.7: resuming
PCI: Enabling device 0000:00:1d.7 (0000 -> 0002)
ACPI: PCI Interrupt 0000:00:1d.7[D] -> GSI 23 (level, low) -> IRQ 18
PCI: Setting latency timer of device 0000:00:1d.7 to 64
PM: Writing back config space on device 0000:00:1d.7 at offset f (was 400, writing 403)
PM: Writing back config space on device 0000:00:1d.7 at offset 4 (was 0, writing ea200000)
pci 0000:00:1e.0: resuming
PCI: Setting latency timer of device 0000:00:1e.0 to 64
pci 0000:00:1f.0: resuming
PIIX_IDE 0000:00:1f.1: resuming
i801_smbus 0000:00:1f.3: resuming
Intel ICH 0000:00:1f.5: resuming
PCI: Enabling device 0000:00:1f.5 (0000 -> 0003)
ACPI: PCI Interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 22
PCI: Setting latency timer of device 0000:00:1f.5 to 64
pci 0000:01:00.0: resuming
pci 0000:01:00.1: resuming
pci 0000:02:00.0: resuming
bttv 0000:02:02.0: resuming
bttv0: reset, reinitialize
bttv0: PLL: 28636363 => 35468950 .. ok
bt878 0000:02:02.1: resuming
saa7134 0000:02:03.0: resuming
via-rhine 0000:02:09.0: resuming
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
pci 0000:02:0a.0: resuming
pnp 00:00: resuming
system 00:01: resuming
pnp 00:02: resuming
pnp 00:03: resuming
pnp 00:04: resuming
pnp 00:05: resuming
pnp 00:06: resuming
serial 00:07: resuming
pnp: Device 00:07 activated.
pnp 00:08: resuming
i8042 kbd 00:09: resuming
pnp: Failed to activate device 00:09.
mpu401 00:0a: resuming
pnp: Device 00:0a activated.
system 00:0b: resuming
system 00:0c: resuming
platform pcspkr: resuming
vesafb vesafb.0: resuming
serial8250 serial8250: resuming
ide-disk 0.0: resuming
ide-disk 1.0: resuming
ide-cdrom 1.1: resuming
usb usb1: resuming
hub 1-0:1.0: resuming
usb usb2: resuming
hub 2-0:1.0: resuming
usb usb3: resuming
hub 3-0:1.0: resuming
usb usb4: resuming
hub 4-0:1.0: resuming
usb usb5: resuming
hub 5-0:1.0: resuming
usb 3-1: resuming
usb-storage 3-1:1.0: resuming
usb 3-2: resuming
usbhid 3-2:1.0: resuming
i8042 i8042: resuming
serio serio0: resuming
atkbd serio1: resuming
sd 0:0:0:0: resuming
sd 0:0:0:1: resuming
sd 0:0:0:2: resuming
sd 0:0:0:3: resuming
ir-kbd-i2c 1-001a: resuming
ac97 0-0:CMI9761: resuming
tveeprom 2-0050: resuming
tuner 2-0043: resuming
tuner 2-0060: resuming
eeprom 0-0050: resuming
eeprom 0-0051: resuming
eeprom 0-0052: resuming
eeprom 0-0053: resuming
eeprom 2-0051: resuming
Restarting tasks... done
Loaded prism54 driver, version 1.2
PCI: Enabling device 0000:02:00.0 (0010 -> 0012)
ACPI: PCI Interrupt 0000:02:00.0[A] -> GSI 16 (level, low) -> IRQ 19
PM: Adding info for ieee1394:fw-host0
ohci1394: fw-host0: OHCI-1394 1.0 (PCI): IRQ=[21]  MMIO=[ea004000-ea0047ff]  Max Packet=[2048]  IR/IT contexts=[8/8]


