Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269501AbUJFWgz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269501AbUJFWgz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269580AbUJFWdk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:33:40 -0400
Received: from smtp08.auna.com ([62.81.186.18]:17878 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S269501AbUJFWaY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:30:24 -0400
Date: Wed, 06 Oct 2004 22:30:22 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: PS2 mouse/kbd problems (gremlins?)
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <1096998302l.5347l.0l@werewolf.able.es>
	<200410052332.34837.dtor_core@ameritech.net>
In-Reply-To: <200410052332.34837.dtor_core@ameritech.net> (from
	dtor_core@ameritech.net on Wed Oct  6 06:32:34 2004)
X-Mailer: Balsa 2.2.5
Message-Id: <1097101822l.5054l.0l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	Format=Flowed
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2004.10.06, Dmitry Torokhov wrote:
> On Tuesday 05 October 2004 12:45 pm, J.A. Magallon wrote:
> > Hi all...
> > 
> > I got time to track my ps2 problems. I run 2.6.9-rc2-mm[123] (that was
> > enough).
> > 
> > Results:
> > - mm1: mouse and kbd work ok, both in console and X
> > - mm2: mouse works, no kbd. I had to unplug/plug the keyboard to get it
> >   responding.
> > - mm3: kbd ok, but ps2 mouse is sluggish.
> > 
> > In latest -rc3-mm2, behavior is like mm3 and above.
> > 
> 
> What about vanilla -rc3 and vanilla -rc3 with bk-input patch applied (if you
> have some time of course). Do they exibit the same symptoms as -mm tree?
> 

Both rc3 and rc3-bk.input work. Even rc3-mm2 works, depending on how I boot ;).
This is getting really strange....look:

ll /boot:
lrwxrwxrwx  1 root root      21 2004.10.05 14:16 vmlinuz -> vmlinuz-2.6.9-rc3-mm2
-rw-r--r--  1 root root 1485335 2004.09.16 23:28 vmlinuz-2.6.9-rc2-mm1
-rw-r--r--  1 root root 1500553 2004.09.23 22:50 vmlinuz-2.6.9-rc2-mm2
-rw-r--r--  1 root root 1501867 2004.09.24 16:20 vmlinuz-2.6.9-rc2-mm3
-rw-r--r--  1 root root 1498557 2004.10.01 01:05 vmlinuz-2.6.9-rc2-mm4
-rw-r--r--  1 root root 1448740 2004.10.06 22:49 vmlinuz-2.6.9-rc3
-rw-r--r--  1 root root 1451900 2004.10.06 23:57 vmlinuz-2.6.9-rc3-bk.input
-rw-r--r--  1 root root 1506097 2004.10.04 00:32 vmlinuz-2.6.9-rc3-mm1
-rw-r--r--  1 root root 1505218 2004.10.05 20:12 vmlinuz-2.6.9-rc3-mm2

lilo.conf:
root=/dev/sda1
read-only
default="linux"
append="psmouse.proto=exps"
image=/boot/vmlinuz
    label="linux"
...
image=/boot/vmlinuz-2.6.9-rc3-mm2
    label="linux-2.6.9-rc3-mm2"

If I boot with the default entry, mouse does not work. If I boot with
the specific entry in lilo for rc3-mm2, it works.

dmesg diff:
--- dm-1	2004-10-07 00:22:10.616105982 +0200
+++ dm-2	2004-10-07 00:22:10.616105982 +0200
@@ -45,10 +45,10 @@
 Using ACPI (MADT) for SMP configuration information
 Built 1 zonelists
 Initializing CPU#0
-Kernel command line: BOOT_IMAGE=linux ro root=801 psmouse.proto=exps 3
+Kernel command line: BOOT_IMAGE=linux-2.6.9-rc3-mm2 ro root=801 psmouse.proto=exps 3
 CPU 0 irqstacks, hard=b03d2000 soft=b03ce000
 PID hash table entries: 4096 (order: 12, 65536 bytes)
-Detected 2405.595 MHz processor.
+Detected 2405.625 MHz processor.
 Using tsc for high-res timesource
 Console: colour VGA+ 80x60
 Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
@@ -225,17 +225,17 @@
 md: raid1 personality registered as nr 3
 md: raid5 personality registered as nr 4
 raid5: automatically using best checksumming function: pIII_sse
-   pIII_sse  :  3072.000 MB/sec
-raid5: using function: pIII_sse (3072.000 MB/sec)
+   pIII_sse  :  3044.000 MB/sec
+raid5: using function: pIII_sse (3044.000 MB/sec)
 raid6: int32x1    664 MB/s
 raid6: int32x2    882 MB/s
-raid6: int32x4    613 MB/s
+raid6: int32x4    617 MB/s
 raid6: int32x8    464 MB/s
 raid6: mmxx1     1949 MB/s
-raid6: mmxx2     2441 MB/s
-raid6: sse1x1    1164 MB/s
+raid6: mmxx2     2437 MB/s
+raid6: sse1x1    1160 MB/s
 raid6: sse1x2    2386 MB/s
-raid6: sse2x1    2605 MB/s
+raid6: sse2x1    2601 MB/s
 raid6: sse2x2    2707 MB/s
 raid6: using algorithm sse2x2 (2707 MB/s)
 md: raid6 personality registered as nr 8
@@ -296,14 +296,14 @@
 usb 2-1: new full speed USB device using address 2
 hub 5-0:1.0: USB hub found
 hub 5-0:1.0: 2 ports detected
+drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x3404
+usbcore: registered new driver usblp
+drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
 usbcore: registered new driver usbhid
 drivers/usb/input/hid-core.c: v2.0:USB HID core driver
 Initializing USB Mass Storage driver...
 usbcore: registered new driver usb-storage
 USB Mass Storage support registered.
-drivers/usb/class/usblp.c: usblp0: USB Bidirectional printer dev 2 if 0 alt 0 proto 2 vid 0x03F0 pid 0x3404
-usbcore: registered new driver usblp
-drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
 EXT3 FS on sda1, internal journal
 Adding 1052248k swap on /dev/sda3.  Priority:-1 extents:1
 Linux agpgart interface v0.100 (c) Dave Jones
@@ -357,5 +357,5 @@
 ACPI: PCI interrupt 0000:00:1f.5[B] -> GSI 17 (level, low) -> IRQ 17
 PCI: Setting latency timer of device 0000:00:1f.5 to 64
 AC'97 0 analog subsections not ready
-intel8x0_measure_ac97_clock: measured 49595 usecs
+intel8x0_measure_ac97_clock: measured 50582 usecs
 intel8x0: clocking to 48000

(NOTE: look at the diff in usblp position....)

Somebody understands this ? Are there gremlins in my box ?
Why the init order of usblp is dependent on lilo entry ? It does not depend even
on different builds, as if some link order was broken, it is the same
kernel image accessed with a different name...

???

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.1 (Community) for i586
Linux 2.6.9-rc3-mm2 (gcc 3.4.1 (Mandrakelinux 10.1 3.4.1-4mdk)) #2


