Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275976AbTHOM47 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:56:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275977AbTHOMzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:55:33 -0400
Received: from h008.c007.snv.cp.net ([209.228.33.236]:47803 "HELO
	c007.snv.cp.net") by vger.kernel.org with SMTP id S275974AbTHOMzJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:55:09 -0400
X-Sent: 15 Aug 2003 12:55:08 GMT
Date: Fri, 15 Aug 2003 14:55:18 +0200
From: Uberto Barbini <uberto@ubiland.net>
X-Mailer: The Bat! (v1.62i) Personal
Reply-To: Uberto Barbini <uberto@ubiland.net>
X-Priority: 3 (Normal)
Message-ID: <10192791499.20030815145518@ubiland.net>
To: linux-kernel@vger.kernel.org
Subject: usb Key problem on via M10000 with 2.6.0-test3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I cannot make my usb-key (Acer 32mb flash) working with 2.6.0 kernel.

I report here my experiments:
[scsi support enabled, hotplug enabled in the kernel and all
possible usb-stuff as module with verbose debug where possible]

lspci -v
shows 3 uhci and 1 ehci controllers every one with 2 ports.

First try:
modprobe ehci-hcd
modprobe usb-storage

dmesg reports a good measure of nice things as usb2 detected, 6 ports
available, mass storage enabled, ecc.

I insert my key and the system freeze completely (no keyboard input,
I've not tried telnet).
The usbkey led is green stable (it should pulse).

Second try:
modprobe uhci-hcd
modprobe usb-storage

dmesg still reports a lot of lines with no clear errors.

Then I insert my key and the led blink one time at all.
The system has no problem apart it doesn't seem aware of my key:
dmesg
lsusb
less /proc/bus/usb/devices

doesn't show anything different than before.

I reboot and...
Third try:
modprobe uhci-hcd
modprobe ehci-hcd
modprobe usb-storage

Now something works!
Finally the led shows the exact sequence (a short blinking and then
slow pulsing) and /var/log/messages (dmesg is far more verbose) reports:

...
new USB device on port 2, assigned address 2
Product: DiskOnKey
Manufacturer: M-Sys
Serial Number: <a long number>
SCSI emulation for USB Mass Storage devices
  Vendor: M-Sys  Model: DiskOnKey  Rev:3.04
  Type: Direct Access
scsi_agent: bogus sysfs DEVPATH=/devices/pci00000:00/000000 ....
kernel: SCSI device sda: 33MB
kernel: sda: Write Protect is off

The log ends here but there should be other informations.


Now there's /dev/sda (I'm using devfs) but no sda1 (or /dev/sda/x) so I cannot mount
it and /dev/scsi is void.

lsusb doesn't show anything while
less /proc/bus/usb/ show my Key Manufacturer and Serial Number.

If I remove the Key all data remain static and the same if I
reinsert it.

There's a similar problem on usb-storage ML but they pointed the
problem to somewhere else.


update!
while I'm writing this little poem I wanted to try the compact flash
reader of my camera, just in case... and it worked! (with uhci-hcd and
ehci-hcd both loaded).
So the problem is related to my Key partition (it's a fat but maybe is
corrupted) or M-Sys hardware.

Just writing this mail resolved my biggest problem!

Thanks
Uberto Barbini

