Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262882AbUEOOub@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbUEOOub (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 May 2004 10:50:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262974AbUEOOub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 May 2004 10:50:31 -0400
Received: from mailout01.ims-firmen.de ([213.174.32.96]:28854 "EHLO
	mailout01.ims-firmen.de") by vger.kernel.org with ESMTP
	id S262882AbUEOOp3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 May 2004 10:45:29 -0400
Subject: Re: dma ripping
From: Daniele Bernardini <db@sqbc.com>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040515101415.GA24600@suse.de>
References: <1084548566.12022.57.camel@linux.site>
	 <20040515101415.GA24600@suse.de>
Content-Type: text/plain
Message-Id: <1084610731.4666.8.camel@linux.site>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 15 May 2004 10:45:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 2004-05-15 at 12:14, Jens Axboe wrote:
> On Fri, May 14 2004, Daniele Bernardini wrote:
> > Hi Folks, 
> > 
> > I am trying to get cd ripping to work on a freshly installed SuSE 9.1 on
> > IBM thinkpad R50 with dvdram drive. 
> > 
> > It works for a while and then hangs. At this point nothing short of a
> > reboot works. Ripping stop working when the message 
> > 	cdrom: dropping to single frame dma
> > comes up. The system feels slow for a couple of seconds and then is back
> > to normal, but no ripping until next reboot
> > 
> > I am running the 2.6.4 compiled by SuSE.
> 
> Can you retest with this small debug patch applied.
> 
> --- drivers/cdrom/cdrom.c~	2004-05-15 12:12:24.770228291 +0200
> +++ drivers/cdrom/cdrom.c	2004-05-15 12:13:25.101720866 +0200
> @@ -1987,6 +1987,7 @@
>  			struct request_sense *s = rq->sense;
>  			ret = -EIO;
>  			cdi->last_sense = s->sense_key;
> +			printk("rip failed, sense %x/%x/%x\n", s->sense_key, s->asc, s->ascq);
>  		}
>  
>  		if (blk_rq_unmap_user(rq, ubuf, bio, len))

I did it and started ripping a cd it froze after 9 tracks, though did
not see your message. I was looking at /var/log/messages (see below).
BTW the system got instable and then froze had to power down. It
happened before always after the ripping problem.

Should I aswitch on debug for the cdrom?



May 15 09:53:52 linux syslogd 1.4.1: restart.
May 15 09:53:57 linux rcpowersaved: enter 'speedstep-centrino' into
POWERSAVE_CPUFREQD_MODULE in /etc/sysconfig/powersave/com
mon.
May 15 09:53:57 linux rcpowersaved: this will speed up starting
powersaved and avoid unnecessary warnings in syslog.
May 15 09:53:57 linux kernel: klogd 1.4.1, log source = /proc/kmsg
started.
May 15 09:53:57 linux kernel: Inspecting
/boot/System.map-2.6.4-54.5-default
May 15 09:53:58 linux sshd[3733]: Server listening on :: port 22.
May 15 09:53:58 linux kernel: Loaded 23440 symbols from
/boot/System.map-2.6.4-54.5-default.
May 15 09:53:58 linux kernel: Symbols match kernel version 2.6.4.
May 15 09:53:58 linux kernel: No module symbols loaded - kernel modules
not enabled.
May 15 09:53:58 linux kernel: drivers/usb/core/usb.c: registered new
driver usbfs
May 15 09:53:58 linux kernel: drivers/usb/core/usb.c: registered new
driver hub
May 15 09:53:58 linux kernel: Intel(R) PRO/1000 Network Driver - version
5.2.30.1-k2
May 15 09:53:58 linux kernel: Copyright (c) 1999-2004 Intel Corporation.
May 15 09:53:58 linux kernel: e1000: eth0: e1000_probe: Intel(R)
PRO/1000 Network Connection
May 15 09:53:58 linux kernel: Linux Kernel Card Services
May 15 09:53:58 linux kernel:   options:  [pci] [cardbus] [pm]
May 15 09:53:58 linux kernel: Yenta: CardBus bridge found at
0000:02:00.0 [1014:0552]
May 15 09:53:58 linux kernel: Yenta: ISA IRQ mask 0x04b8, PCI irq 11
May 15 09:53:58 linux kernel: Socket status: 30000086
May 15 09:53:58 linux kernel: hostap_crypt: registered algorithm 'NULL'
May 15 09:53:58 linux kernel: ipw2100: no version for
"hostap_get_crypto_ops" found: kernel tainted.
May 15 09:53:58 linux kernel: ipw2100: Intel(R) PRO/Wireless 2100
Network Driver, 0.42
May 15 09:53:58 linux kernel: ipw2100: Copyright(c) 2003-2004 Intel
Corporation
May 15 09:53:58 linux kernel: Detected ipw2100 PCI device at
0000:02:02.0, dev: eth1, mem: 0xC0214000-0xC0214FFF -> fac35000,
 irq: 11
May 15 09:53:58 linux kernel: eth1: Using hotplug firmware load.
May 15 09:53:58 linux kernel: cs: IO port probe 0x0c00-0x0cff: clean.
May 15 09:53:58 linux kernel: cs: IO port probe 0x0820-0x08ff: clean.
May 15 09:53:58 linux kernel: cs: IO port probe 0x0800-0x080f: clean.
May 15 09:53:58 linux kernel: cs: IO port probe 0x03e0-0x04ff: excluding
0x4d0-0x4d7
May 15 09:53:58 linux kernel: cs: IO port probe 0x0100-0x03af: clean.
May 15 09:53:58 linux kernel: cs: IO port probe 0x0a00-0x0aff: clean.
May 15 09:53:58 linux kernel: NET: Registered protocol family 17
May 15 09:53:58 linux kernel: ipw2100: Associated with 'SpeedStream' at
11Mbps, channel 11
May 15 09:53:58 linux [powersaved][3623]: resmgr: server response code
200
May 15 09:53:58 linux kernel: eth1: Association lost.
May 15 09:53:58 linux kernel: ipw2100: Associated with 'SpeedStream' at
11Mbps, channel 11
May 15 09:53:58 linux kernel: hw_random hardware driver 1.0.0 loaded
May 15 09:53:58 linux kernel: ieee1394: Initialized config rom entry
`ip1394'
May 15 09:53:58 linux kernel: ohci1394: $Rev: 1193 $ Ben Collins
<bcollins@debian.org>
May 15 09:53:58 linux kernel: ohci1394: fw-host0: OHCI-1394 1.1 (PCI):
IRQ=[11]  MMIO=[c0215000-c02157ff]  Max Packet=[2048]
May 15 09:53:58 linux kernel: USB Universal Host Controller Interface
driver v2.2
May 15 09:53:58 linux kernel: uhci_hcd 0000:00:1d.0: UHCI Host
Controller
May 15 09:53:58 linux kernel: PCI: Setting latency timer of device
0000:00:1d.0 to 64
May 15 09:53:58 linux kernel: uhci_hcd 0000:00:1d.0: irq 11, io base
00001800
May 15 09:53:58 linux kernel: uhci_hcd 0000:00:1d.0: new USB bus
registered, assigned bus number 1
May 15 09:53:58 linux kernel: usb usb1: Product: UHCI Host Controller
May 15 09:53:58 linux kernel: usb usb1: Manufacturer: Linux
2.6.4-54.5-default uhci_hcd
May 15 09:53:58 linux kernel: usb usb1: SerialNumber: 0000:00:1d.0
May 15 09:53:58 linux kernel: hub 1-0:1.0: USB hub found
May 15 09:53:58 linux kernel: hub 1-0:1.0: 2 ports detected
May 15 09:53:58 linux kernel: uhci_hcd 0000:00:1d.1: UHCI Host
Controller
May 15 09:53:58 linux kernel: PCI: Setting latency timer of device
0000:00:1d.1 to 64
May 15 09:53:58 linux kernel: uhci_hcd 0000:00:1d.1: irq 11, io base
00001820
May 15 09:53:58 linux kernel: uhci_hcd 0000:00:1d.1: new USB bus
registered, assigned bus number 2
May 15 09:53:58 linux kernel: usb usb2: Product: UHCI Host Controller
May 15 09:53:58 linux kernel: usb usb2: Manufacturer: Linux
2.6.4-54.5-default uhci_hcd
May 15 09:53:58 linux kernel: usb usb2: SerialNumber: 0000:00:1d.1
May 15 09:53:58 linux kernel: hub 2-0:1.0: USB hub found
May 15 09:53:58 linux kernel: hub 2-0:1.0: 2 ports detected
May 15 09:53:58 linux kernel: uhci_hcd 0000:00:1d.2: UHCI Host
Controller
May 15 09:53:58 linux kernel: PCI: Setting latency timer of device
0000:00:1d.2 to 64
May 15 09:53:58 linux kernel: uhci_hcd 0000:00:1d.2: irq 11, io base
00001840
May 15 09:53:58 linux kernel: uhci_hcd 0000:00:1d.2: new USB bus
registered, assigned bus number 3
May 15 09:53:58 linux kernel: usb usb3: Product: UHCI Host Controller
May 15 09:53:58 linux kernel: usb usb3: Manufacturer: Linux
2.6.4-54.5-default uhci_hcd
May 15 09:53:58 linux kernel: usb usb3: SerialNumber: 0000:00:1d.2
May 15 09:53:58 linux kernel: hub 3-0:1.0: USB hub found
May 15 09:53:58 linux kernel: hub 3-0:1.0: 2 ports detected
May 15 09:53:58 linux kernel: ehci_hcd 0000:00:1d.7: EHCI Host
Controller
May 15 09:53:58 linux kernel: PCI: Setting latency timer of device
0000:00:1d.7 to 64
May 15 09:53:58 linux kernel: ehci_hcd 0000:00:1d.7: irq 11, pci mem
fa833000
May 15 09:53:58 linux kernel: ehci_hcd 0000:00:1d.7: new USB bus
registered, assigned bus number 4
May 15 09:53:58 linux kernel: PCI: cache line size of 32 is not
supported by device 0000:00:1d.7
May 15 09:53:58 linux kernel: ehci_hcd 0000:00:1d.7: USB 2.0 enabled,
EHCI 1.00, driver 2003-Dec-29
May 15 09:53:58 linux kernel: usb usb4: Product: EHCI Host Controller
May 15 09:53:58 linux kernel: usb usb4: Manufacturer: Linux
2.6.4-54.5-default ehci_hcd
May 15 09:53:58 linux kernel: usb usb4: SerialNumber: 0000:00:1d.7
May 15 09:53:58 linux kernel: hub 4-0:1.0: USB hub found
May 15 09:53:58 linux kernel: hub 4-0:1.0: 6 ports detected
May 15 09:53:58 linux kernel: Linux agpgart interface v0.100 (c) Dave
Jones
May 15 09:53:58 linux kernel: agpgart: Detected an Intel 855PM Chipset.
May 15 09:53:58 linux kernel: agpgart: Maximum main memory to use for
agp memory: 1919M
May 15 09:53:58 linux kernel: agpgart: AGP aperture is 256M @ 0xd0000000
May 15 09:53:58 linux kernel: eth1: Association lost.
May 15 09:53:58 linux kernel: ieee1394: Host added: ID:BUS[0-00:1023] 
GUID[00061b0324000368]
May 15 09:53:58 linux kernel: ipw2100: Associated with 'SpeedStream' at
11Mbps, channel 11
May 15 09:53:58 linux kernel: PCI: Setting latency timer of device
0000:00:1f.5 to 64
May 15 09:53:58 linux kernel: intel8x0_measure_ac97_clock: measured
49524 usecs
May 15 09:53:58 linux kernel: intel8x0: clocking to 48000
May 15 09:53:58 linux kernel: hdc: ATAPI 24X DVD-ROM DVD-R-RAM CD-R/RW
drive, 2048kB Cache
May 15 09:53:58 linux kernel: Uniform CD-ROM driver Revision: 3.20
May 15 09:53:58 linux kernel: ACPI: AC Adapter [AC] (on-line)
May 15 09:53:58 linux kernel: ACPI: Battery Slot [BAT0] (battery
present)
May 15 09:53:58 linux kernel: ACPI: Power Button (FF) [PWRF]
May 15 09:53:58 linux kernel: ACPI: Lid Switch [LID]
May 15 09:53:58 linux kernel: ACPI: Sleep Button (CM) [SLPB]
May 15 09:53:58 linux kernel: ACPI: Processor [CPU] (supports C1 C2 C3,
8 throttling states)
May 15 09:53:58 linux kernel: ACPI: Thermal Zone [THM0] (48 C)
May 15 09:53:58 linux kernel: speedstep-centrino: found "Intel(R)
Pentium(R) M processor 1700MHz": max frequency: 1700000kHz
May 15 09:53:58 linux kernel: NET: Registered protocol family 10
May 15 09:53:58 linux kernel: Disabled Privacy Extensions on device
c03545c0(lo)
May 15 09:53:58 linux kernel: IPv6 over IPv4 tunneling driver
May 15 09:53:58 linux kernel: Disabled Privacy Extensions on device
f6cf0c00(sit0)
May 15 09:53:59 linux modprobe: FATAL: Error inserting sonypi
(/lib/modules/2.6.4-54.5-default/kernel/drivers/char/sonypi.ko)
: No such device
May 15 09:53:59 linux /etc/hotplug/block.agent[3763]: grep:
/sys/class/scsi_host/ide1/proc_name: No such file or directory
May 15 09:53:59 linux /etc/hotplug/block.agent[3763]: grep:
/sys/class/scsi_host/ide1/proc_name: No such file or directory
May 15 09:53:59 linux /etc/hotplug/block.agent[3763]: new block device
/block/hdc
May 15 09:54:00 linux kernel: SCSI subsystem initialized
May 15 09:54:03 linux root: spamd starting
May 15 09:54:03 linux ifup: No configuration found for sit0
May 15 09:54:03 linux kernel: st: Version 20040318, fixed bufsize 32768,
s/g segs 256
May 15 09:54:03 linux kernel: BIOS EDD facility v0.13 2004-Mar-09, 1
devices found
May 15 09:54:04 linux kernel: Non-volatile memory driver v1.2
May 15 09:54:08 linux kernel: eth0: no IPv6 routers present
May 15 09:54:08 linux kernel: eth1: no IPv6 routers present
May 15 09:54:14 linux kernel: parport0: PC-style at 0x3bc
[PCSPP,TRISTATE]
May 15 09:54:14 linux kernel: lp0: using parport0 (polling).
May 15 09:54:15 linux kernel: drivers/usb/serial/usb-serial.c: USB
Serial support registered for Generic
May 15 09:54:15 linux kernel: drivers/usb/core/usb.c: registered new
driver usbserial
May 15 09:54:15 linux kernel: drivers/usb/serial/usb-serial.c: USB
Serial Driver core v2.0
May 15 09:54:15 linux /usr/sbin/cron[4530]: (CRON) STARTUP (fork ok)
May 15 09:54:18 linux kernel: end_request: I/O error, dev fd0, sector 0
May 15 09:54:21 linux kernel: mtrr: 0xe0000000,0x2000000 overlaps
existing 0xe0000000,0x1000000
May 15 09:54:21 linux kernel: [drm] Initialized radeon 1.10.0 20020828
on minor 0: ATI Radeon Lf R250 Mobility 9000 M9
May 15 09:54:21 linux kernel: mtrr: 0xe0000000,0x2000000 overlaps
existing 0xe0000000,0x1000000
May 15 09:54:21 linux kernel: agpgart: Found an AGP 2.0 compliant device
at 0000:00:00.0.
May 15 09:54:21 linux kernel: agpgart: Putting AGP V2 device at
0000:00:00.0 into 1x mode
May 15 09:54:21 linux kernel: agpgart: Putting AGP V2 device at
0000:01:00.0 into 1x mode
May 15 09:54:21 linux kernel: [drm] Loading R200 Microcode
May 15 09:54:50 linux kdm: :0[4425]: pam_unix2: session started for user
dbernardini, service xdm
May 15 09:55:24 linux gconfd (dbernardini-4784): starting (version
2.4.0.1), pid 4784 user 'dbernardini'
May 15 09:55:24 linux gconfd (dbernardini-4784): Resolved address
"xml:readonly:/etc/opt/gnome/gconf/gconf.xml.mandatory" to
a read-only config source at position 0
May 15 09:55:24 linux gconfd (dbernardini-4784): Resolved address
"xml:readwrite:/home/dbernardini/.gconf" to a writable conf
ig source at position 1
May 15 09:55:24 linux gconfd (dbernardini-4784): Resolved address
"xml:readonly:/etc/opt/gnome/gconf/gconf.xml.defaults" to a
 read-only config source at position 2
May 15 09:56:18 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorhshIeb.slave-socket: resmgr: server response code 502
May 15 09:56:21 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502
May 15 09:56:56 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502
May 15 09:57:03 linux last message repeated 16 times
May 15 09:57:15 linux su: (to root) dbernardini on /dev/pts/36
May 15 09:57:15 linux su: pam_unix2: session started for user root,
service su
May 15 09:58:12 linux kernel: spurious 8259A interrupt: IRQ7.
May 15 09:59:00 linux /USR/SBIN/CRON[4857]: (root) CMD ( rm -f
/var/spool/cron/lastrun/cron.hourly)
May 15 09:59:17 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502
May 15 10:00:53 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502
May 15 10:02:12 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502
May 15 10:03:23 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502
May 15 10:06:03 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502
May 15 10:08:07 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502
May 15 10:10:27 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502
May 15 10:12:44 linux kdeinit: kio_audiocd audiocd
/tmp/ksocket-dbernardini/klauncherCe2j3a.slave-socket
/tmp/ksocket-dbernar
dini/konquerorTnSdoa.slave-socket: resmgr: server response code 502


