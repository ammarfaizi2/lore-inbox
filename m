Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263235AbTECCwS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 22:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263239AbTECCwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 22:52:18 -0400
Received: from 60.54.252.64.snet.net ([64.252.54.60]:61615 "EHLO
	jaymale.blue-labs.org") by vger.kernel.org with ESMTP
	id S263235AbTECCwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 22:52:17 -0400
Message-ID: <3EB331B5.4080306@blue-labs.org>
Date: Fri, 02 May 2003 23:04:21 -0400
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030429
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       apcupsd-devel@apcupsd.org
Subject: APC USB ups, Back-UPS ES series, 2.5.68
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Please cc: me on reply)

I'm wanting to get this new toy up and running.  I've installed apcupsd, 
but it doesn't want to work well with my kernel (2.5.68) or somewhat.

When apcupsd tries to open the hiddev, open() gets an ENODEV.  Is 
apcupsd doing something wrong or is 2.5.68 doing something wrong?

~# dmesg
hub 1-0:0: debounce: port 1: delay 100ms stable 4 status 0x301
hub 1-0:0: new USB device on port 1, assigned address 4
usb 1-1: new device strings: Mfr=3, Product=1, SerialNumber=2
usb 1-1: Product: Back-UPS ES 350 FW:800.e3.D USB FW:e3
usb 1-1: Manufacturer: APC
usb 1-1: SerialNumber: AB0238241677 
usb 1-1: usb_new_device - registering interface 1-1:0
hid 1-1:0: usb_device_probe
hid 1-1:0: usb_device_probe - got id
drivers/usb/core/file.c: asking for 1 minors, starting at 96
drivers/usb/core/file.c: found a minor chunk free, starting at 96
hiddev96: USB HID v1.10 Device [APC Back-UPS ES 350 FW:800.e3.D USB 
FW:e3] on usb-00:07.2-1


~# ls -l /dev/usb/hid
total 0
crw-r--r--    1 root     root     180, 192 Dec 31  1969 hiddev96
crw-r--r--    1 root     root     180, 193 Dec 31  1969 hiddev97


~# strace -f apcupsd (trimmed)
[...]
open("/dev/usb/hid/hiddev95", O_RDONLY) = -1 ENOENT (No such file or 
directory)
open("/dev/usb/hid/hiddev96", O_RDONLY) = -1 ENODEV (No such device)
open("/dev/usb/hid/hiddev97", O_RDONLY) = -1 ENODEV (No such device)
open("/dev/usb/hid/hiddev98", O_RDONLY) = -1 ENOENT (No such file or 
directory)
write(2, "Couldn\'t find UPS device or no p"..., 43Couldn't find UPS 
device or no permission.
) = 43
_exit(1)                                = ?

ref: http://www.sibbald.com/apcupsd/manual/usb.html
apcupsd version: 3.10.5
Linux kernel: 2.5.68

David
p.s. apcupsd needs patched to handle hiddev from 96 on (minor allocated by kernel)



