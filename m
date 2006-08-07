Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932140AbWHGTcj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbWHGTcj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 15:32:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932218AbWHGTcj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 15:32:39 -0400
Received: from A.painless.aaisp.net.uk ([81.187.81.51]:45723 "EHLO
	smtp.aaisp.net.uk") by vger.kernel.org with ESMTP id S932140AbWHGTci
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 15:32:38 -0400
Message-ID: <44D79574.8080703@digital-domain.net>
Date: Mon, 07 Aug 2006 20:33:08 +0100
From: Andrew Clayton <andrew@digital-domain.net>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Andrew Clayton <andrew@digital-domain.net>
Subject: 2.6.18-rc strange hotplug/udev/uevent problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Got a weird problem here.

On x86 Fedora Core 5 with 2.6.17 with GNOME, plugging in a usb stick 
would result in it being mounted. With 2.6.18-rc this no longer occurs. 
FC5 got an update to hal to work with 2.6.18 kernels, but it don't work 
for me. I'm having the same problem on 3 x86 FC5 machines.

The weird thing is, this all works on my x86-64 FC5 workstation with 
2.6.18-rc both before and after the hal update.

Anyway I submitted a bug report against HAL suspecting it broken

https://bugs.freedesktop.org/show_bug.cgi?id=7756

Perhaps not. So I turn my attention more to the kernel.


2.6.17 was working fine. You could plug/unplug/plug a USB memory stick 
and it would get mounted each time.

2.6.18-rc[23] works the same as above on my x86-64 FC5 box.

2.6.18-rc[23] and 2.6.18-rc3-git7 on x86 built with 
usb/scsi/sd/vfat/nls_* built as modules will mount on the first plug but 
not subsequent plugs.

If you rmmod the sd_mod module and plug in, then it will get mounted.

When the kernel is built non-modular then plugging in will not mount it. 
If you boot with the device plugged in then when you log into GNOME it 
will be mounted. But subsequent unmount/plug ins will not get it mounted.

The following is from the udevmonitor program running under 2.6.18-rc 
built modular.

Plugging device in with sd_mod not loaded.

UEVENT[1154789226.207797] add@/devices/pci0000:00/0000:00:11.2/usb1/1-2
UEVENT[1154789226.207985] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/usbdev1.11_ep00
UEVENT[1154789226.210770] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0
UDEV  [1154789226.210770] add@/devices/pci0000:00/0000:00:11.2/usb1/1-2
UEVENT[1154789226.211037] add@/class/scsi_host/host9
UEVENT[1154789226.211097] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/usbdev1.11_ep81
UEVENT[1154789226.211157] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/usbdev1.11_ep02
UEVENT[1154789226.211215] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/usbdev1.11
UDEV  [1154789226.211690] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/usbdev1.11_ep00
UDEV  [1154789226.452013] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/usbdev1.11
UDEV  [1154789226.956997] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0
UDEV  [1154789226.959419] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/usbdev1.11_ep81
UDEV  [1154789226.959466] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/usbdev1.11_ep02
UDEV  [1154789226.959875] add@/class/scsi_host/host9
UEVENT[1154789231.647515] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/host9/target9:0:0/9:0:0:0
UDEV  [1154789231.647515] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/host9/target9:0:0/9:0:0:0
UEVENT[1154789231.647570] add@/class/scsi_device/9:0:0:0
UEVENT[1154789231.749919] add@/module/sd_mod
UEVENT[1154789231.751494] add@/bus/scsi/drivers/sd
UEVENT[1154789231.752839] add@/class/scsi_disk/9:0:0:0
UDEV  [1154789231.753751] add@/class/scsi_disk/9:0:0:0
UEVENT[1154789231.832312] add@/block/sda
UEVENT[1154789231.834681] add@/block/sda/sda1
UDEV  [1154789231.836590] add@/class/scsi_device/9:0:0:0
UDEV  [1154789231.933474] add@/block/sda
UDEV  [1154789232.106892] add@/block/sda/sda1
UEVENT[1154789235.937510] mount@/block/sda/sda1
UDEV  [1154789235.937510] mount@/block/sda/sda1


Plugging device in with sd_mod loaded.

UEVENT[1154789359.096963] add@/devices/pci0000:00/0000:00:11.2/usb1/1-2
UDEV  [1154789359.096963] add@/devices/pci0000:00/0000:00:11.2/usb1/1-2
UEVENT[1154789359.097052] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/usbdev1.12_ep00
UDEV  [1154789359.098126] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/usbdev1.12_ep00
UEVENT[1154789359.100369] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0
UEVENT[1154789359.100418] add@/class/scsi_host/host10
UEVENT[1154789359.100427] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/usbdev1.12_ep81
UEVENT[1154789359.100435] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/usbdev1.12_ep02
UEVENT[1154789359.100444] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/usbdev1.12
UDEV  [1154789359.106148] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/usbdev1.12
UDEV  [1154789359.187500] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0
UDEV  [1154789359.189198] add@/class/scsi_host/host10
UDEV  [1154789359.190078] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/usbdev1.12_ep81
UDEV  [1154789359.191020] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/usbdev1.12_ep02
UEVENT[1154789364.540249] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/host10/target10:0:0/10:0:0:0
UDEV  [1154789364.540249] 
add@/devices/pci0000:00/0000:00:11.2/usb1/1-2/1-2:1.0/host10/target10:0:0/10:0:0:0
UEVENT[1154789364.540355] add@/class/scsi_disk/10:0:0:0
UDEV  [1154789364.541272] add@/class/scsi_disk/10:0:0:0
UEVENT[1154789364.586896] add@/block/sda
UEVENT[1154789364.586954] add@/block/sda/sda1
UEVENT[1154789364.586963] add@/class/scsi_device/10:0:0:0
UDEV  [1154789364.598962] add@/class/scsi_device/10:0:0:0
UDEV  [1154789364.719350] add@/block/sda
UDEV  [1154789364.874149] add@/block/sda/sda1


No mount events here, this is similar output to the non-modular case..


Here's udevmonitor output from my x86-64 FC5 2.6.18-rc[23]

UEVENT[1154510664.116702] add@/devices/pci0000:00/0000:00:10.4/usb1/1-8
UEVENT[1154510664.116905] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/usbdev1.12_ep00
UEVENT[1154510664.116911] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0
UEVENT[1154510664.116915] add@/class/scsi_host/host12
UEVENT[1154510664.116919] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0/usbdev1.12_ep81
UEVENT[1154510664.116924] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0/usbdev1.12_ep02
UEVENT[1154510664.116928] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0/usbdev1.12_ep83
UEVENT[1154510664.116932] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/usbdev1.12
UDEV  [1154510664.200847] add@/devices/pci0000:00/0000:00:10.4/usb1/1-8
UDEV  [1154510664.364513] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/usbdev1.12_ep00
UDEV  [1154510664.371420] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/usbdev1.12
UDEV  [1154510664.631746] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0
UDEV  [1154510664.652152] add@/class/scsi_host/host12
UDEV  [1154510664.776377] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0/usbdev1.12_ep81
UDEV  [1154510664.785827] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0/usbdev1.12_ep02
UDEV  [1154510664.795277] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0/usbdev1.12_ep83
UEVENT[1154510669.116889] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0/host12/target12:0:0/12:0:0:0
UEVENT[1154510669.116915] add@/class/scsi_disk/12:0:0:0
UDEV  [1154510669.118308] 
add@/devices/pci0000:00/0000:00:10.4/usb1/1-8/1-8:1.0/host12/target12:0:0/12:0:0:0
UDEV  [1154510669.136236] add@/class/scsi_disk/12:0:0:0
UEVENT[1154510670.246094] add@/block/sdb
UEVENT[1154510670.246115] add@/block/sdb/sdb1
UEVENT[1154510670.246119] add@/class/scsi_device/12:0:0:0
UDEV  [1154510670.250690] add@/class/scsi_device/12:0:0:0
UDEV  [1154510670.383650] add@/block/sdb
UDEV  [1154510670.555570] add@/block/sdb/sdb1
UEVENT[1154510671.433544] mount@/block/sdb/sdb1
UDEV  [1154510671.434129] mount@/block/sdb/sdb1


I guess the next thing is to try and narrow down when this started, but 
as that could take some time, I'm posting this now.


Cheers,

Andrew
