Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264536AbUAASl2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 13:41:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264538AbUAASl2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 13:41:28 -0500
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.86]:50115 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S264536AbUAASlZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 13:41:25 -0500
Date: Thu, 01 Jan 2004 13:41:17 -0500
From: Jeff Sipek <jeffpc@optonline.net>
Subject: USB Digital Camera mount problem [WAS: Removable USB device contents
 cached after removal?]
In-reply-to: <20040101114824.GG2432@home.bofhlet.net>
To: Vid Strpic <vms@bofhlet.net>, Matthew Mastracci <mmastrac@canada.com>
Cc: linux-kernel@vger.kernel.org
Message-id: <200401011341.23379.jeffpc@optonline.net>
MIME-version: 1.0
Content-type: Text/Plain; charset=iso-8859-2
Content-transfer-encoding: 7BIT
Content-disposition: inline
Content-description: clearsigned data
User-Agent: KMail/1.5.4
References: <20040101114824.GG2432@home.bofhlet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 01 January 2004 06:48, Vid Strpic wrote:
> > 9.  dd if=/dev/sdd1 of=/dev/null results in "No medium found"
>
> usb-storage behaves differently in 2.6 than in 2.4, maybe this is the
> problem for you now.

I get "No medium found" when I try to mount the SD card inside my digital 
camera (Panasonic DMC-LC33.) It works fine in 2.4.18 that comes with Debian, 
but I get the above message in 2.6.0 (and couple of releases before it - it 
is a fairly new camera, ~2 months old.)

Any ideas how to debug it?

Jeff.

When plugged in:

kernel: hub 2-2:1.0: new USB device on port 4, assigned address 3
kernel: Initializing USB Mass Storage driver...
kernel: scsi1 : SCSI emulation for USB Mass Storage devices
kernel:   Vendor: MATSHITA  Model: DMC-LC33          Rev: 0100
kernel:   Type:   Direct-Access                      ANSI SCSI revision: 02
kernel: SCSI device sda: 246017 512-byte hdwr sectors (126 MB)
kernel: sda: Write Protect is off
kernel: sda: Mode Sense: 00 06 00 00
kernel: sda: assuming drive cache: write through
kernel:  sda: sda1
kernel: Attached scsi removable disk sda at scsi1, channel 0, id 0, lun 0
kernel: Attached scsi generic sg0 at scsi1, channel 0, id 0, lun 0,  type 0
kernel: WARNING: USB Mass Storage data integrity not assured
kernel: USB Mass Storage device found at 3
kernel: drivers/usb/core/usb.c: registered new driver usb-storage
kernel: USB Mass Storage support registered.
scsi.agent[22366]: disk at /devices/pci0000:00/0000:00:1f.4/
usb2/2-2/2-2.4/2-2.4:1.0/host1/1:0:0:0

When I try to mount it, mount refuses, but there are no log messages:

jeff:~# mount /dev/sda1 /mnt/camera/
mount: No medium found
jeff:~#

And when I shut the camera off, I get:

kernel: usb 2-2.4: USB disconnect, address 3

The modules:

jeff:~# lsmod
Module                  Size  Used by
usb_storage            34688  0
nvidia               1704492  10
tvaudio                21888  0
msp3400                22928  0
bttv                  140704  1
video_buf              22400  1 bttv
i2c_algo_bit           10248  1 bttv
btcx_risc               5252  1 bttv
v4l2_common             5376  1 bttv
videodev               10368  2 bttv
uhci_hcd               31240  0
usbcore               109012  4 usb_storage,uhci_hcd
evdev                  10496  0
tuner                  15108  0
i2c_core               24964  5 tvaudio,msp3400,bttv,i2c_algo_bit,tuner
eepro100               31244  0
mii                     5632  1 eepro100

- -- 
You measure democracy by the freedom it gives its dissidents, not the
freedom it gives its assimilated conformists.
		- Abbie Hoffman
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/9GnRwFP0+seVj/4RAnrCAJ92Kp6vkMobqPFnPzxs+HZIeD49rwCgneQf
n3u1o/SmRVOSJMi+IuBjn6g=
=lYLk
-----END PGP SIGNATURE-----

