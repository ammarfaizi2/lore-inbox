Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266306AbUANFNV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 00:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUANFNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 00:13:21 -0500
Received: from [81.193.98.140] ([81.193.98.140]:132 "EHLO
	puma-vgertech.no-ip.com") by vger.kernel.org with ESMTP
	id S266306AbUANFNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 00:13:13 -0500
Message-ID: <4004D084.1050106@vgertech.com>
Date: Wed, 14 Jan 2004 05:15:48 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] udev 013 release
References: <20040113235213.GA7659@kroah.com>
In-Reply-To: <20040113235213.GA7659@kroah.com>
Content-Type: multipart/mixed;
 boundary="------------080109080504070003020200"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080109080504070003020200
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

[I'm in lkml, but not in linux-hotplug-devel, so please CC: me]

Hi!

I'm trying udev for the first time and I must say good work!

A sugestion and a question:

- Make udev print a /etc/udev/udev.rules line every time a device is 
found because default behaviour is too silent and "make DEBUG=true" is 
too noisy. This would make adding our private/static entries easily.
Something like:

udev[1234]: found device BUS="scsi", SYSFS_model="CD-Writer cd4f", 
KERNEL="sr0", SYSFS_serial="AAAAAAAA"

This way one can easily make entries for a device with copy+paste, 
remove a few parameters and adding a few *'s

- I have a USB cd-writer and udev makes /udev/sr0 but it doesn't create 
/udev/sg0. In the first run I had the hotplug packege from debian but I 
just installed hotplug-2004_01_05 and it's the same, no sg0 is created.

The kernel detects it:
Jan 14 05:04:40 puma kernel: sr0: scsi3-mmc drive: 20x/20x writer cd/rw 
xa/form2 cdda pop-up
Jan 14 05:04:40 puma kernel: Attached scsi CD-ROM sr0 at scsi19, channel 
0, id 0, lun 0
Jan 14 05:04:40 puma kernel: Attached scsi generic sg0 at scsi19, 
channel 0, id 0, lun 0,  type 5
Jan 14 05:04:40 puma kernel: WARNING: USB Mass Storage data integrity 
not assured
Jan 14 05:04:40 puma kernel: USB Mass Storage device found at 20

The full udev run, from syslog, is attached.

Do I need a new rule? The log sugests that in that single run udev only 
cares about sr0, but I can be reading it wrong :) Or sysfs/udev doesn't 
support scsi_generic yet?

Thanks,
Nuno Silva


Greg KH wrote:
> I've released the 013 version of udev.  It can be found at:
>  	kernel.org/pub/linux/utils/kernel/hotplug/udev-013.tar.gz


--------------080109080504070003020200
Content-Type: text/plain;
 name="syslog"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="syslog"

Jan 14 05:04:36 puma kernel: hub 4-0:1.0: new USB device on port 1, assigned address 20
Jan 14 05:04:37 puma udev[15057]: main: version 013
Jan 14 05:04:37 puma udev[15057]: get_dirs: sysfs_path='/sys'
Jan 14 05:04:37 puma udev[15057]: parse_config_file: reading '/etc/udev/udev.conf' as config file
Jan 14 05:04:37 puma udev[15057]: main: called by hotplug
Jan 14 05:04:37 puma udev[15057]: udev_hotplug: looking at '/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0'
Jan 14 05:04:37 puma udev[15057]: udev_hotplug: not a block or class device
Jan 14 05:04:38 puma udev[15059]: main: version 013
Jan 14 05:04:38 puma udev[15059]: get_dirs: sysfs_path='/sys'
Jan 14 05:04:38 puma udev[15059]: parse_config_file: reading '/etc/udev/udev.conf' as config file
Jan 14 05:04:38 puma udev[15059]: main: called by hotplug
Jan 14 05:04:38 puma udev[15059]: udev_hotplug: looking at '/devices/pci0000:00/0000:00:1d.2/usb4/4-1'
Jan 14 05:04:38 puma udev[15059]: udev_hotplug: not a block or class device
Jan 14 05:04:40 puma udev[15069]: main: version 013
Jan 14 05:04:40 puma udev[15069]: get_dirs: sysfs_path='/sys'
Jan 14 05:04:40 puma udev[15069]: parse_config_file: reading '/etc/udev/udev.conf' as config file
Jan 14 05:04:40 puma udev[15069]: main: called by hotplug
Jan 14 05:04:40 puma udev[15069]: udev_hotplug: looking at '/class/scsi_host/host19'
Jan 14 05:04:40 puma udev[15069]: udev_hotplug: don't care about 'scsi_host' devices
Jan 14 05:04:40 puma kernel: scsi19 : SCSI emulation for USB Mass Storage devices
Jan 14 05:04:40 puma scsi.agent[15071]: how to add device type= at /devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/host19/19:0:0:0 ??
Jan 14 05:04:40 puma udev[15082]: main: version 013
Jan 14 05:04:40 puma udev[15082]: get_dirs: sysfs_path='/sys'
Jan 14 05:04:40 puma udev[15082]: parse_config_file: reading '/etc/udev/udev.conf' as config file
Jan 14 05:04:40 puma udev[15082]: main: called by hotplug
Jan 14 05:04:40 puma udev[15082]: udev_hotplug: looking at '/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/host19/19:0:0:0'
Jan 14 05:04:40 puma udev[15082]: udev_hotplug: not a block or class device
Jan 14 05:04:40 puma kernel:   Vendor: HP        Model: CD-Writer cd4f    Rev: 1.0A
Jan 14 05:04:40 puma kernel:   Type:   CD-ROM                             ANSI SCSI revision: 02
Jan 14 05:04:40 puma udev[15089]: main: version 013
Jan 14 05:04:40 puma udev[15089]: get_dirs: sysfs_path='/sys'
Jan 14 05:04:40 puma udev[15089]: parse_config_file: reading '/etc/udev/udev.conf' as config file
Jan 14 05:04:40 puma udev[15089]: main: called by hotplug
Jan 14 05:04:40 puma udev[15089]: udev_hotplug: looking at '/block/sr0'
Jan 14 05:04:40 puma udev[15089]: namedev_init_rules: reading '/etc/udev/udev.rules' as rules file
Jan 14 05:04:40 puma udev[15089]: namedev_init_permissions: reading '/etc/udev/udev.permissions' as permissions file
Jan 14 05:04:40 puma udev[15089]: sleep_for_dev: looking for '/sys/block/sr0/dev'
Jan 14 05:04:40 puma udev[15089]: get_class_dev: looking at '/sys/block/sr0'
Jan 14 05:04:40 puma udev[15089]: get_class_dev: class_dev->name='sr0'
Jan 14 05:04:40 puma udev[15089]: get_major_minor: dev='11:0 '
Jan 14 05:04:40 puma udev[15089]: get_major_minor: found major=11, minor=0
Jan 14 05:04:40 puma udev[15096]: main: version 013
Jan 14 05:04:40 puma udev[15096]: get_dirs: sysfs_path='/sys'
Jan 14 05:04:40 puma udev[15089]: get_sysfs_device: filename = /sys/block/sr0
Jan 14 05:04:40 puma udev[15096]: parse_config_file: reading '/etc/udev/udev.conf' as config file
Jan 14 05:04:40 puma udev[15089]: get_sysfs_device: temp2 = 
Jan 14 05:04:40 puma udev[15096]: main: called by hotplug
Jan 14 05:04:40 puma udev[15089]: get_sysfs_device: looking for '/sys/block/device'
Jan 14 05:04:40 puma udev[15096]: udev_hotplug: looking at '/class/scsi_device/19:0:0:0'
Jan 14 05:04:40 puma udev[15096]: udev_hotplug: don't care about 'scsi_device' devices
Jan 14 05:04:40 puma kernel: sr0: scsi3-mmc drive: 20x/20x writer cd/rw xa/form2 cdda pop-up
Jan 14 05:04:40 puma kernel: Attached scsi CD-ROM sr0 at scsi19, channel 0, id 0, lun 0
Jan 14 05:04:40 puma kernel: Attached scsi generic sg0 at scsi19, channel 0, id 0, lun 0,  type 5
Jan 14 05:04:40 puma kernel: WARNING: USB Mass Storage data integrity not assured
Jan 14 05:04:40 puma kernel: USB Mass Storage device found at 20
Jan 14 05:04:41 puma udev[15089]: get_sysfs_device: looking for '/sys/block/device'
Jan 14 05:04:42 puma udev[15089]: sysfs_path_is_link: stat() failed 
Jan 14 05:04:42 puma udev[15089]: sysfs_path_is_link: stat() failed 
Jan 14 05:04:42 puma udev[15089]: namedev_name_device: sysfs_device->path='/sys/devices/pci0000:00/0000:00:1d.2/usb4/4-1/4-1:1.0/host19/19:0:0:0'
Jan 14 05:04:42 puma udev[15089]: namedev_name_device: sysfs_device->bus_id='19:0:0:0'
Jan 14 05:04:42 puma udev[15089]: namedev_name_device: sysfs_device->bus='scsi'
Jan 14 05:04:42 puma udev[15089]: wait_for_device_to_initialize: looking for file 'vendor' on bus 'scsi'
Jan 14 05:04:42 puma udev[15089]: namedev_name_device: kernel_number='0'
Jan 14 05:04:42 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:42 puma udev[15089]: namedev_name_device: check for BUS dev->bus='scsi' sysfs_device->bus='scsi'
Jan 14 05:04:42 puma udev[15089]: namedev_name_device: BUS matches
Jan 14 05:04:42 puma udev[15089]: namedev_name_device: check PROGRAM
Jan 14 05:04:42 puma udev[15089]: apply_format: substitute bus_id '19:0:0:0'
Jan 14 05:04:42 puma udev[15089]: execute_program: executing '/bin/echo -n test-19:0:0:0'
Jan 14 05:04:43 puma udev[15089]: execute_program: result is 'test-19:0:0:0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: PROGRAM returned successful
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for RESULT dev->result='test-42:0:0:1', udev->program_result='test-19:0:0:0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: RESULT is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for BUS dev->bus='usb' sysfs_device->bus='scsi'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: BUS is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for BUS dev->bus='usb' sysfs_device->bus='scsi'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: BUS is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for BUS dev->bus='usb' sysfs_device->bus='scsi'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: BUS is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for BUS dev->bus='pci' sysfs_device->bus='scsi'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: BUS is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for BUS dev->bus='pci' sysfs_device->bus='scsi'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: BUS is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for BUS dev->bus='usb' sysfs_device->bus='scsi'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: BUS is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for BUS dev->bus='usb' sysfs_device->bus='scsi'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: BUS is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for BUS dev->bus='usb' sysfs_device->bus='scsi'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: BUS is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='ttyUSB1' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='ttyUSB0' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for BUS dev->bus='ide' sysfs_device->bus='scsi'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: BUS is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='dm-[0-9]*' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='card*' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='controlC[0-9]*' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='hw[CD0-9]*' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='pcm[CD0-9cp]*' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='midi[CD0-9]*' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='timer' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: process rule
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: check for KERNEL dev->kernel='seq' class_dev->name='sr0'
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: KERNEL is not matching
Jan 14 05:04:43 puma udev[15089]: namedev_name_device: name, 'sr0' is going to have owner='', group='', mode = 0600
Jan 14 05:04:43 puma udev[15089]: udev_add_device: name='sr0'
Jan 14 05:04:43 puma udev[15089]: create_node: mknod(/udev/sr0, 060600, 11, 0)
Jan 14 05:04:43 puma udev[15089]: create_node: chmod(/udev/sr0, 060600)

--------------080109080504070003020200--

