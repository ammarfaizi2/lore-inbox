Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262997AbUKRXxm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262997AbUKRXxm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 18:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261200AbUKRXwQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 18:52:16 -0500
Received: from mid-2.inet.it ([213.92.5.19]:34254 "EHLO mid-2.inet.it")
	by vger.kernel.org with ESMTP id S262996AbUKRXn2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 18:43:28 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: 2.6.10-rc2-mm2 usb storage still oopses
Date: Fri, 19 Nov 2004 00:42:40 +0100
User-Agent: KMail/1.7.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-usb-devel@lists.sourceforge.net
References: <200411182203.02176.cova@ferrara.linux.it> <20041118133557.72f3b369.akpm@osdl.org> <20041118135809.3314ce41@lembas.zaitcev.lan>
In-Reply-To: <20041118135809.3314ce41@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_xNTnBxII5Tfmalt"
Message-Id: <200411190042.41199.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Boundary-00=_xNTnBxII5Tfmalt
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

Alle 22:58, giovedì 18 novembre 2004, Pete Zaitcev ha scritto:
> On Thu, 18 Nov 2004 13:35:57 -0800, Andrew Morton <akpm@osdl.org> wrote:
> > Fabio Coatti <cova@ferrara.linux.it> wrote:
> > > Just a reminder: it's possible to cause a kernel oops simply inserting
> > > and removing a usb storage (flash pen); using ub driver doesn't improve
> > > the situation; noticed in 2.6.9-rc4-mm1 and present in 2.6.10-rc2-mm2.
> > > The same device works just fine with 2.6.8.1 (mdk cooker)
> >
> > OK, that's something we'd like to get fixed prior to 2.6.10.
>
> Actually Fabio told me that his oops was fixed by the patch present in
> 2.6.10-rc2. The problem is that his device needs special handling which
> I do not know how to provide, so it does not work in the end. I hope it
> will resolve itself eventually, as I get testers.
>
> There was one last oops from Martin Schleminger ("Sahara") which I think
> I fixed but I need a confirmation before pushing to Greg. Apparently, it
> only happens on kernels with preempt enabled. If anyone knows of any other
> problems, I'm all ears.

Well, that's the whole story: in fact using ub driver with your patch applied 
i can avoid oops (as said in this thread: 
http://marc.theaimsgroup.com/?l=linux-kernel&m=109943374727804&w=2)

But the behaviour imho is still buggy and not related to ub driver; it sems 
that something goes wrong before ub; in fact I get almost the same behaviour 
without ub compiled in, scsi fails in the (quite) the same way, it seems that 
something is activated twice. Anyway below I've posted the full syslog 
cut&paste, with some comments.
in short: inserting and removing the device causes some errors (maybe 
timeouts?) for some tries, (first part of logs) then suddenly, after 3/4 
tries, the device is identified and then scsi layer gets activated (and 
confused). this time, the removal of device causes a kernel oops. After, you 
can also find the behavoiur with ub: no oopses, but the operation is not 
complete. I've also tried to turn on the box with key inserted, but I'm 
unable to report because the keyboard/mouse (ps/2) was dead, so maybe 
something has gone wrong...but i can't tell what. Maybe I can try with serial 
console to pickup some messages. Anyway, the key is perfectly working on 
first try with another HW and with 2.6.8.1. I've also attached config.gz.
I've checked also config but I can't find something wrong or misconfigured.

anyway, if more infos (or test) are needed, just let me know.

Many thanks.


reports:

>No UB module compiled:

Nov 18 20:30:13 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 18 20:30:13 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov 18 20:30:13 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov 18 20:30:13 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov 18 20:30:13 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 18 20:30:13 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 18 20:30:13 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 3
Nov 18 20:30:13 kefk kernel: ehci_hcd 0000:00:1d.7: devpath 3 ep0in 3strikes
Nov 18 20:30:13 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 full speed --> 
companion
Nov 18 20:30:13 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
003801 POWER OWNER sig=j  CONNECT
Nov 18 20:30:13 kefk kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Nov 18 20:30:13 kefk kernel: hub 2-0:1.0: state 5 ports 2 chg fffc evt 0002
Nov 18 20:30:13 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0093,00
Nov 18 20:30:13 kefk kernel: hub 2-0:1.0: port 1, status 0101, change 0001, 12 
Mb/s
Nov 18 20:30:13 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x101
Nov 18 20:30:13 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 2
Nov 18 20:30:13 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 18 20:30:13 kefk kernel: [f7a35240] link (37a351b2) element (37a31040)
Nov 18 20:30:13 kefk kernel:   0: [f7a31040] link (37a31080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=37caa7e0)
Nov 18 20:30:13 kefk kernel:   1: [f7a31080] link (37a310c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=36b89200)
Nov 18 20:30:13 kefk kernel:   2: [f7a310c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 18 20:30:13 kefk kernel:
Nov 18 20:30:13 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 18 20:30:13 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 18 20:30:13 kefk kernel: [f7a35240] link (37a351b2) element (37a31040)
Nov 18 20:30:13 kefk kernel:   0: [f7a31040] link (37a31080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=368d9320)
Nov 18 20:30:13 kefk kernel:   1: [f7a31080] link (37a310c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=36b89200)
Nov 18 20:30:13 kefk kernel:   2: [f7a310c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 18 20:30:13 kefk kernel:
Nov 18 20:30:14 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 18 20:30:14 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 3
Nov 18 20:30:14 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 18 20:30:14 kefk kernel: [f7a35240] link (37a351b2) element (37a31040)
Nov 18 20:30:14 kefk kernel:   0: [f7a31040] link (37a31080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=368d9320)
Nov 18 20:30:14 kefk kernel:   1: [f7a31080] link (37a310c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=36b89200)
Nov 18 20:30:14 kefk kernel:   2: [f7a310c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 18 20:30:14 kefk kernel:
Nov 18 20:30:14 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 18 20:30:14 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov 18 20:30:14 kefk kernel: [f7a35240] link (37a351b2) element (37a31040)
Nov 18 20:30:14 kefk kernel:   0: [f7a31040] link (37a31080) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=368d9320)
Nov 18 20:30:14 kefk kernel:   1: [f7a31080] link (37a310c0) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=36b89200)
Nov 18 20:30:14 kefk kernel:   2: [f7a310c0] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov 18 20:30:14 kefk kernel:
Nov 18 20:30:14 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov 18 20:30:14 kefk kernel: hub 2-0:1.0: state 5 ports 2 chg fffc evt 0002

> the device is removed:

Nov 18 20:31:54 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 18 20:31:54 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov 18 20:31:54 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov 18 20:31:54 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x100
Nov 18 20:31:54 kefk kernel: hub 2-0:1.0: state 5 ports 2 chg fffc evt 0002
Nov 18 20:31:54 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0082,00
Nov 18 20:31:54 kefk kernel: hub 2-0:1.0: port 1, status 0100, change 0001, 12 
Mb/s
Nov 18 20:31:55 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x100
Nov 18 20:31:55 kefk kernel: uhci_hcd 0000:00:1d.1: suspend_hc

> several, (3/4) tries with the very same result

(...)

> something different this time, with some noise from kernel :)

Nov 18 20:32:59 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 18 20:32:59 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov 18 20:32:59 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov 18 20:32:59 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov 18 20:32:59 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 18 20:32:59 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 18 20:32:59 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 7
Nov 18 20:32:59 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 18 20:32:59 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 18 20:32:59 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Nov 18 20:32:59 kefk kernel: usb 5-3: default language 0x0409
Nov 18 20:32:59 kefk kernel: usb 5-3: Product: Mass storage
Nov 18 20:32:59 kefk kernel: usb 5-3: Manufacturer: USB
Nov 18 20:32:59 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Nov 18 20:32:59 kefk kernel: usb 5-3: hotplug
Nov 18 20:32:59 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Nov 18 20:32:59 kefk kernel: usb 5-3:1.0: hotplug
Nov 18 20:33:00 kefk kernel: Initializing USB Mass Storage driver...
Nov 18 20:33:00 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface
Nov 18 20:33:00 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface - got id
Nov 18 20:33:00 kefk kernel: scsi3 : SCSI emulation for USB Mass Storage 
devices
Nov 18 20:33:00 kefk kernel: usbcore: registered new driver usb-storage
Nov 18 20:33:00 kefk kernel: USB Mass Storage support registered.
Nov 18 20:33:00 kefk kernel: usb-storage: device found at 7
Nov 18 20:33:00 kefk kernel: usb-storage: waiting for device to settle before 
scanning
Nov 18 20:33:05 kefk kernel:   Vendor: 512MB     Model: USB2.0FlashDrive  Rev: 
2.00
Nov 18 20:33:05 kefk kernel:   Type:   Direct-Access                      ANSI 
SCSI revision: 02
Nov 18 20:33:05 kefk kernel: sdb: Unit Not Ready, sense:
Nov 18 20:33:05 kefk kernel: : Current: sense key=0x6
Nov 18 20:33:05 kefk kernel:     ASC=0x28 ASCQ=0x0
Nov 18 20:33:05 kefk kernel: sdb : READ CAPACITY failed.
Nov 18 20:33:05 kefk kernel: sdb : status=1, message=00, host=0, driver=08
Nov 18 20:33:05 kefk kernel: sd: Current: sense key=0x6
Nov 18 20:33:05 kefk kernel:     ASC=0x28 ASCQ=0x0
Nov 18 20:33:05 kefk kernel: sdb: test WP failed, assume Write Enabled
Nov 18 20:33:05 kefk kernel: sdb: assuming drive cache: write through
Nov 18 20:33:05 kefk kernel: sdb: Unit Not Ready, sense:
Nov 18 20:33:05 kefk kernel: : Current: sense key=0x6
Nov 18 20:33:05 kefk kernel:     ASC=0x28 ASCQ=0x0
Nov 18 20:33:05 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov 18 20:33:05 kefk kernel: sdb: Write Protect is off
Nov 18 20:33:05 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 18 20:33:05 kefk kernel: sdb: assuming drive cache: write through
Nov 18 20:33:05 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov 18 20:33:05 kefk kernel: sdb: Write Protect is off
Nov 18 20:33:05 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 18 20:33:05 kefk kernel: sdb: assuming drive cache: write through
Nov 18 20:33:05 kefk kernel:  sdb: sdb1
Nov 18 20:33:05 kefk kernel:  sdb: sdb1
Nov 18 20:33:05 kefk kernel: kobject_register failed for sdb1 (-17)
Nov 18 20:33:05 kefk kernel:  [bitmap_parse+577/590] 
kobject_register+0x51/0x5f
Nov 18 20:33:05 kefk kernel:  [<c01f281f>] kobject_register+0x51/0x5f
Nov 18 20:33:05 kefk kernel:  [show_stat+2489/2532] add_partition+0xbb/0xf0
Nov 18 20:33:05 kefk kernel:  [<c01851b0>] add_partition+0xbb/0xf0
Nov 18 20:33:05 kefk kernel:  [filesystems_read_proc+5/84] 
register_disk+0xee/0x11d
Nov 18 20:33:05 kefk kernel:  [<c0185328>] register_disk+0xee/0x11d
Nov 18 20:33:05 kefk kernel:  [register_blkdev+278/338] add_disk+0x36/0x41
Nov 18 20:33:05 kefk kernel:  [<c025770a>] add_disk+0x36/0x41
Nov 18 20:33:05 kefk kernel:  [register_blkdev+204/338] exact_match+0x0/0x7
Nov 18 20:33:05 kefk kernel:  [<c02576c0>] exact_match+0x0/0x7
Nov 18 20:33:05 kefk kernel:  [register_blkdev+211/338] exact_lock+0x0/0xd
Nov 18 20:33:05 kefk kernel:  [<c02576c7>] exact_lock+0x0/0xd
Nov 18 20:33:05 kefk kernel:  [sd_probe+664/815] sd_probe+0x224/0x32f
Nov 18 20:33:05 kefk kernel:  [<c02981e2>] sd_probe+0x224/0x32f
Nov 18 20:33:05 kefk kernel:  [msdos_partition+303/804] 
sysfs_make_dirent+0x1c/0x89
Nov 18 20:33:05 kefk kernel:  [<c01868cf>] sysfs_make_dirent+0x1c/0x89
Nov 18 20:33:05 kefk kernel:  [msdos_partition+303/804] 
sysfs_make_dirent+0x1c/0x89
Nov 18 20:33:05 kefk kernel:  [<c01868cf>] sysfs_make_dirent+0x1c/0x89
Nov 18 20:33:05 kefk kernel:  [bus_remove_file+58/61] 
driver_probe_device+0x29/0x6a
Nov 18 20:33:05 kefk kernel:  [<c024eed4>] driver_probe_device+0x29/0x6a
Nov 18 20:33:05 kefk kernel:  [__bus_for_each_drv+12/114] 
device_attach+0x46/0xaa
Nov 18 20:33:05 kefk kernel:  [<c024ef5b>] device_attach+0x46/0xaa
Nov 18 20:33:05 kefk kernel:  [fcntl_setlk+245/707] dput+0x76/0x209
Nov 18 20:33:05 kefk kernel:  [<c0168d8a>] dput+0x76/0x209
Nov 18 20:33:05 kefk kernel:  [driver_attach+103/133] bus_add_device+0x55/0x97
Nov 18 20:33:05 kefk kernel:  [<c024f222>] bus_add_device+0x55/0x97
Nov 18 20:33:05 kefk kernel:  [dev_hotplug_filter+35/43] device_add+0xb9/0x15c
Nov 18 20:33:05 kefk kernel:  [<c024e222>] device_add+0xb9/0x15c
Nov 18 20:33:05 kefk kernel:  [scsi_sysfs_add_sdev+455/777] 
scsi_sysfs_add_sdev+0xa0/0x309
Nov 18 20:33:05 kefk kernel:  [<c0276585>] scsi_sysfs_add_sdev+0xa0/0x309
Nov 18 20:33:05 kefk kernel:  [scsi_probe_and_add_lun+96/425] 
scsi_add_lun+0x2d9/0x32f
Nov 18 20:33:05 kefk kernel:  [<c0275138>] scsi_add_lun+0x2d9/0x32f
Nov 18 20:33:05 kefk kernel:  [scsi_probe_and_add_lun+371/425] 
scsi_probe_and_add_lun+0xbd/0x1c2
Nov 18 20:33:05 kefk kernel:  [<c027524b>] scsi_probe_and_add_lun+0xbd/0x1c2
Nov 18 20:33:05 kefk kernel:  [scsi_scan_channel+138/154] 
scsi_scan_target+0x9a/0x106
Nov 18 20:33:05 kefk kernel:  [<c02759c5>] scsi_scan_target+0x9a/0x106
Nov 18 20:33:05 kefk kernel:  [scsi_scan_host+17/37] 
scsi_scan_channel+0x7c/0x9a
Nov 18 20:33:05 kefk kernel:  [<c0275aad>] scsi_scan_channel+0x7c/0x9a
Nov 18 20:33:05 kefk kernel:  [scsi_get_host_dev+41/46] 
scsi_scan_host_selected+0x6e/0xc7
Nov 18 20:33:05 kefk kernel:  [<c0275b39>] scsi_scan_host_selected+0x6e/0xc7
Nov 18 20:33:05 kefk kernel:  [.text.lock.scsi_scan+53/54] 
scsi_scan_host+0x21/0x25
Nov 18 20:33:05 kefk kernel:  [<c0275bb3>] scsi_scan_host+0x21/0x25
Nov 18 20:33:05 kefk kernel:  [pg0+946550792/1069159424] 
usb_stor_scan_thread+0x134/0x145 [usb_storage]
Nov 18 20:33:05 kefk kernel:  [<f8b10808>] usb_stor_scan_thread+0x134/0x145 
[usb_storage]
Nov 18 20:33:05 kefk kernel:  [do_timer_gettime+100/297] 
autoremove_wake_function+0x0/0x43
Nov 18 20:33:05 kefk kernel:  [<c012cfad>] autoremove_wake_function+0x0/0x43
Nov 18 20:33:05 kefk kernel:  [copy_thread+542/592] ret_from_fork+0x6/0x14
Nov 18 20:33:05 kefk kernel:  [<c0102506>] ret_from_fork+0x6/0x14
Nov 18 20:33:05 kefk kernel:  [do_timer_gettime+100/297] 
autoremove_wake_function+0x0/0x43
Nov 18 20:33:05 kefk kernel:  [<c012cfad>] autoremove_wake_function+0x0/0x43
Nov 18 20:33:05 kefk kernel:  [pg0+946550484/1069159424] 
usb_stor_scan_thread+0x0/0x145 [usb_storage]
Nov 18 20:33:05 kefk kernel:  [<f8b106d4>] usb_stor_scan_thread+0x0/0x145 
[usb_storage]
Nov 18 20:33:05 kefk kernel:  [huft_build+637/1249] 
kernel_thread_helper+0x5/0xb
Nov 18 20:33:05 kefk kernel:  [<c01008a5>] kernel_thread_helper+0x5/0xb
Nov 18 20:33:05 kefk kernel: Attached scsi removable disk sdb at scsi3, 
channel 0, id 0, lun 0
Nov 18 20:33:05 kefk kernel: Attached scsi generic sg4 at scsi3, channel 0, id 
0, lun 0,  type 0
Nov 18 20:33:05 kefk kernel: usb-storage: device scan complete
Nov 18 20:33:05 kefk scsi.agent[7530]: disk 
at /devices/pci0000:00/0000:00:1d.7/usb5/5-3/5-3:1.0/host3/target3:0:0/3:0:0:0

> now, removing the thing, the kernel is not so happy
(maybe to have twice the lines:

================================
Nov 18 20:33:05 kefk kernel: sdb: Write Protect is off
Nov 18 20:33:05 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 18 20:33:05 kefk kernel: sdb: assuming drive cache: write through
Nov 18 20:33:05 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov 18 20:33:05 kefk kernel: sdb: Write Protect is off
Nov 18 20:33:05 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov 18 20:33:05 kefk kernel: sdb: assuming drive cache: write through
Nov 18 20:33:05 kefk kernel:  sdb: sdb1
Nov 18 20:33:05 kefk kernel:  sdb: sdb1
================================
is not a good sign...)


Nov 18 20:35:24 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 18 20:35:24 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov 18 20:35:24 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov 18 20:35:24 kefk kernel: usb 5-3: USB disconnect, address 7
Nov 18 20:35:24 kefk kernel: usb 5-3: usb_disable_device nuking all URBs
Nov 18 20:35:24 kefk kernel: usb 5-3: unregistering interface 5-3:1.0
Nov 18 20:35:24 kefk kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000050
Nov 18 20:35:24 kefk kernel:  printing eip:
Nov 18 20:35:24 kefk kernel: c0186e32
Nov 18 20:35:24 kefk kernel: *pde = 00000000
Nov 18 20:35:24 kefk kernel: Oops: 0000 [#1]
Nov 18 20:35:24 kefk kernel: PREEMPT SMP
Nov 18 20:35:24 kefk kernel: Modules linked in: nls_cp850 usb_storage md5 ipv6 
rfcomm l2cap bluetooth snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec
snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd soundcore 
ipt_REJECT iptable_filter ip_tables loop nls_utf8 ide_cd i2c_dev w83781d 
i2c_sensor i2c_isa i2c_i801 isofs zlib_inflate e1000 parport_pc ppa parport 
ehci_hcd usblp uhci_hcd genrtc
Nov 18 20:35:24 kefk kernel: CPU:    0
Nov 18 20:35:24 kefk kernel: EIP:    0060:[sysfs_hash_and_remove+174/241]    
Not tainted VLI
Nov 18 20:35:24 kefk kernel: EIP:    0060:[<c0186e32>]    Not tainted VLI
Nov 18 20:35:24 kefk kernel: EFLAGS: 00010246   (2.6.10-rc2-mm2)
Nov 18 20:35:24 kefk kernel: EIP is at sysfs_remove_dir+0x1d/0x10b
Nov 18 20:35:24 kefk kernel: eax: f6e79988   ebx: f6e79988   ecx: c18ff480   
edx: c1000000
Nov 18 20:35:24 kefk kernel: esi: f78b8b00   edi: 00000000   ebp: f7bd5d24   
esp: c1b7ddd8
Nov 18 20:35:24 kefk kernel: ds: 007b   es: 007b   ss: 0068
Nov 18 20:35:24 kefk kernel: Process khubd (pid: 139, threadinfo=c1b7d000 
task=c199c020)
Nov 18 20:35:24 kefk kernel: Stack: 00000000 00000001 f6e79988 f78b8b00 
00000001 f7bd5d24 c01f292f f6e79988
Nov 18 20:35:24 kefk kernel:        c01f293f f246ae80 c0185530 f7948994 
f78b8b00 c03bf4e4 f7bd5d24 c0298304
Nov 18 20:35:24 kefk kernel:        f79489b8 f7948994 c024f0b1 f7948994 
f7b7fc04 f7948994 c024f2b7 f7948994
Nov 18 20:35:24 kefk kernel: Call Trace:
Nov 18 20:35:24 kefk kernel:  [bitmap_scnlistprintf+259/292] 
kobject_del+0x14/0x1c
Nov 18 20:35:24 kefk kernel:  [<c01f292f>] kobject_del+0x14/0x1c
Nov 18 20:35:24 kefk kernel:  [bitmap_scnlistprintf+275/292] 
kobject_unregister+0x8/0x10
Nov 18 20:35:24 kefk kernel:  [<c01f293f>] kobject_unregister+0x8/0x10
Nov 18 20:35:24 kefk kernel:  [get_kcore_size+54/69] del_gendisk+0x1d/0xd5
Nov 18 20:35:24 kefk kernel:  [<c0185530>] del_gendisk+0x1d/0xd5
Nov 18 20:35:24 kefk kernel:  [scsi_disk_release+57/82] sd_remove+0x17/0x52
Nov 18 20:35:24 kefk kernel:  [<c0298304>] sd_remove+0x17/0x52
Nov 18 20:35:24 kefk kernel:  [driver_probe_device+10/106] 
device_release_driver+0x6d/0x6f
Nov 18 20:35:24 kefk kernel:  [<c024f0b1>] device_release_driver+0x6d/0x6f
Nov 18 20:35:24 kefk kernel:  [driver_detach+8/31] bus_remove_device+0x53/0x90
Nov 18 20:35:24 kefk kernel:  [<c024f2b7>] bus_remove_device+0x53/0x90
Nov 18 20:35:24 kefk kernel:  [device_initialize+43/70] device_del+0x54/0x91
Nov 18 20:35:24 kefk kernel:  [<c024e34a>] device_del+0x54/0x91
Nov 18 20:35:24 kefk kernel:  [scsi_sysfs_add_host+37/303] 
scsi_remove_device+0x4e/0xab
Nov 18 20:35:24 kefk kernel:  [<c027683c>] scsi_remove_device+0x4e/0xab
Nov 18 20:35:24 kefk kernel:  [check_set+14/139] scsi_forget_host+0x2d/0x4f
Nov 18 20:35:24 kefk kernel:  [<c0275be4>] scsi_forget_host+0x2d/0x4f
Nov 18 20:35:24 kefk kernel:  [__scsi_iterate_devices+26/90] 
scsi_remove_host+0x8/0x7c
Nov 18 20:35:24 kefk kernel:  [<c026faf7>] scsi_remove_host+0x8/0x7c
Nov 18 20:35:24 kefk kernel:  [pg0+946551473/1069159424] 
storage_disconnect+0x7b/0x8d [usb_storage]
Nov 18 20:35:24 kefk kernel:  [<f8b10ab1>] storage_disconnect+0x7b/0x8d 
[usb_storage]
Nov 18 20:35:24 kefk kernel:  [usb_register+114/159] 
usb_unbind_interface+0x5e/0x60
Nov 18 20:35:24 kefk kernel:  [<c02a4005>] usb_unbind_interface+0x5e/0x60
Nov 18 20:35:24 kefk kernel:  [driver_probe_device+10/106] 
device_release_driver+0x6d/0x6f
Nov 18 20:35:24 kefk kernel:  [<c024f0b1>] device_release_driver+0x6d/0x6f
Nov 18 20:35:24 kefk kernel:  [driver_detach+8/31] bus_remove_device+0x53/0x90
Nov 18 20:35:24 kefk kernel:  [<c024f2b7>] bus_remove_device+0x53/0x90
Nov 18 20:35:24 kefk kernel:  [device_initialize+43/70] device_del+0x54/0x91
Nov 18 20:35:24 kefk kernel:  [<c024e34a>] device_del+0x54/0x91
Nov 18 20:35:24 kefk kernel:  [usb_disable_device+190/327] 
usb_disable_device+0xda/0x147
Nov 18 20:35:24 kefk kernel:  [<c02abdcf>] usb_disable_device+0xda/0x147
Nov 18 20:35:24 kefk kernel:  [usb_disconnect+288/392] 
usb_disconnect+0xa8/0x188
Nov 18 20:35:24 kefk kernel:  [<c02a6811>] usb_disconnect+0xa8/0x188
Nov 18 20:35:24 kefk kernel:  [hub_port_connect_change+851/1143] 
hub_port_connect_change+0x344/0x477
Nov 18 20:35:24 kefk kernel:  [<c02a7cc6>] hub_port_connect_change+0x344/0x477
Nov 18 20:35:24 kefk kernel:  [set_port_led+38/195] 
clear_port_feature+0x48/0x4d
Nov 18 20:35:24 kefk kernel:  [<c02a4fa8>] clear_port_feature+0x48/0x4d
Nov 18 20:35:24 kefk kernel:  [hub_events+825/1270] hub_events+0x32a/0x4f6
Nov 18 20:35:24 kefk kernel:  [<c02a8123>] hub_events+0x32a/0x4f6
Nov 18 20:35:24 kefk kernel:  [hub_thread+68/270] hub_thread+0x35/0x10e
Nov 18 20:35:24 kefk kernel:  [<c02a8324>] hub_thread+0x35/0x10e
Nov 18 20:35:24 kefk kernel:  [do_timer_gettime+100/297] 
autoremove_wake_function+0x0/0x43
Nov 18 20:35:24 kefk kernel:  [<c012cfad>] autoremove_wake_function+0x0/0x43
Nov 18 20:35:24 kefk kernel:  [copy_thread+542/592] ret_from_fork+0x6/0x14
Nov 18 20:35:24 kefk kernel:  [<c0102506>] ret_from_fork+0x6/0x14
Nov 18 20:35:24 kefk kernel:  [do_timer_gettime+100/297] 
autoremove_wake_function+0x0/0x43
Nov 18 20:35:24 kefk kernel:  [<c012cfad>] autoremove_wake_function+0x0/0x43
Nov 18 20:35:24 kefk kernel:  [hub_thread+15/270] hub_thread+0x0/0x10e
Nov 18 20:35:24 kefk kernel:  [<c02a82ef>] hub_thread+0x0/0x10e
Nov 18 20:35:24 kefk kernel:  [huft_build+637/1249] 
kernel_thread_helper+0x5/0xb
Nov 18 20:35:24 kefk kernel:  [<c01008a5>] kernel_thread_helper+0x5/0xb
Nov 18 20:35:24 kefk kernel: Code: 5a 15 33 c0 e9 39 ff ff ff e9 0e ff ff ff 
55 57 56 53 83 ec 08 8b 78 30 85 ff 74 0d 8b 07 85 c0 0f 84 e6 00 00 00 f0 ff 
07 85 ff <8b> 4f 50 0f 84 ab 00 00 00 8b 57 10 f0 ff 4a 78 0f 88 03 07 00

> and now with UB

(I've removed first tries, that has gone exactly as did before, with some 
errors and nothing more)

Nov 18 20:49:02 kefk kernel: hub 5-0:1.0: state 5 ports 8 chg ff00 evt 0008
Nov 18 20:49:02 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov 18 20:49:02 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov 18 20:49:03 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov 18 20:49:03 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 18 20:49:03 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 18 20:49:03 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 8
Nov 18 20:49:03 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov 18 20:49:03 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov 18 20:49:03 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Nov 18 20:49:03 kefk kernel: usb 5-3: default language 0x0409
Nov 18 20:49:03 kefk kernel: usb 5-3: Product: Mass storage
Nov 18 20:49:03 kefk kernel: usb 5-3: Manufacturer: USB
Nov 18 20:49:03 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Nov 18 20:49:03 kefk kernel: usb 5-3: hotplug
Nov 18 20:49:03 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Nov 18 20:49:03 kefk kernel: usb 5-3:1.0: hotplug
Nov 18 20:49:03 kefk kernel: ub 5-3:1.0: usb_probe_interface
Nov 18 20:49:03 kefk kernel: ub 5-3:1.0: usb_probe_interface - got id
Nov 18 20:49:03 kefk kernel: uba: device 8 capacity nsec 0 bsize 512

> it should appear "uba1", not only "uba", or am I wrong?

(but this time I got no oopses)

[root@kefk root]# lspci -v
00:00.0 Host bridge: Intel Corp. 82875P Memory Controller Hub (rev 02)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, fast devsel, latency 0
        Memory at e8000000 (32-bit, prefetchable) [size=128M]
        Capabilities: [e4] #09 [2106]
        Capabilities: [a0] AGP version 3.0

00:01.0 PCI bridge: Intel Corp. 82875P Processor to AGP Controller (rev 02) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 64
        Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
        Memory behind bridge: f8000000-f9ffffff
        Prefetchable memory behind bridge: f0000000-f7ffffff

00:03.0 PCI bridge: Intel Corp. 82875P Processor to PCI to CSA Bridge (rev 02) 
(prog-if 00 [Normal decode])
        Flags: bus master, 66Mhz, fast devsel, latency 32
        Bus: primary=00, secondary=02, subordinate=02, sec-latency=0
        I/O behind bridge: 00009000-00009fff
        Memory behind bridge: fa000000-fa0fffff

00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #1 (rev 
02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 185
        I/O ports at bc00 [size=32]

00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #2 (rev 
02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 193
        I/O ports at b000 [size=32]

00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #3 (rev 
02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 169
        I/O ports at b400 [size=32]

00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB UHCI #4 (rev 
02) (prog-if 00 [UHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 185
        I/O ports at b800 [size=32]

00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 EHCI 
Controller (rev 02) (prog-if 20 [EHCI])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 201
        Memory at fa200000 (32-bit, non-prefetchable) [size=1K]
        Capabilities: [50] Power Management version 2
        Capabilities: [58] #0a [20a0]

00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 00 [Normal 
decode])
        Flags: bus master, fast devsel, latency 0
        Bus: primary=00, secondary=03, subordinate=03, sec-latency=32
        I/O behind bridge: 0000a000-0000afff
        Memory behind bridge: fa100000-fa1fffff

00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge (rev 02)
        Flags: bus master, medium devsel, latency 0

00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra ATA 100 
Storage Controller (rev 02) (prog-if 8a [Master SecP PriP])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, medium devsel, latency 0, IRQ 169
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at <unassigned>
        I/O ports at f000 [size=16]
        Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

00:1f.2 IDE interface: Intel Corp. 82801EB (ICH5) Serial ATA 150 Storage 
Controller (rev 02) (prog-if 8f [Master SecP SecO PriP PriO])
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 169
        I/O ports at c000 [size=8]
        I/O ports at c400 [size=4]
        I/O ports at c800 [size=8]
        I/O ports at cc00 [size=4]
        I/O ports at d000 [size=16]

00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller (rev 02)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: medium devsel, IRQ 9
        I/O ports at 0500 [size=32]

01:00.0 VGA compatible controller: nVidia Corporation NV34 [GeForce FX 5200] 
(rev a1) (prog-if 00 [VGA])
        Subsystem: Unknown device 1682:1280
        Flags: bus master, 66Mhz, medium devsel, latency 32, IRQ 10
        Memory at f8000000 (32-bit, non-prefetchable) [size=16M]
        Memory at f0000000 (32-bit, prefetchable) [size=128M]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [60] Power Management version 2
        Capabilities: [44] AGP version 3.0

02:01.0 Ethernet controller: Intel Corp. 82547EI Gigabit Ethernet Controller 
(LOM)
        Subsystem: ABIT Computer Corp.: Unknown device 1014
        Flags: bus master, 66Mhz, medium devsel, latency 0, IRQ 169
        Memory at fa000000 (32-bit, non-prefetchable) [size=128K]
        I/O ports at 9000 [size=32]
        Capabilities: [dc] Power Management version 2

03:04.0 Multimedia audio controller: Creative Labs SB Audigy (rev 04)
        Subsystem: Creative Labs SB Audigy 2 ZS (SB0350)
        Flags: bus master, medium devsel, latency 32, IRQ 209
        I/O ports at a000 [size=64]
        Capabilities: [dc] Power Management version 2

03:04.1 Input device controller: Creative Labs SB Audigy MIDI/Game port (rev 
04)
        Subsystem: Creative Labs SB Audigy MIDI/Game Port
        Flags: bus master, medium devsel, latency 32
        I/O ports at a400 [size=8]
        Capabilities: [dc] Power Management version 2

03:04.2 FireWire (IEEE 1394): Creative Labs SB Audigy FireWire Port (rev 04) 
(prog-if 10 [OHCI])
        Subsystem: Creative Labs SB Audigy FireWire Port
        Flags: bus master, medium devsel, latency 32, IRQ 5
        Memory at fa104000 (32-bit, non-prefetchable) [size=2K]
        Memory at fa100000 (32-bit, non-prefetchable) [size=16K]
        Capabilities: [44] Power Management version 2

03:06.0 SCSI storage controller: Adaptec AHA-7850 (rev 03)
        Subsystem: Adaptec AHA-2904/Integrated AIC-7850
        Flags: bus master, medium devsel, latency 32, IRQ 177
        I/O ports at a800 [disabled] [size=256]
        Memory at fa105000 (32-bit, non-prefetchable) [size=4K]
        Capabilities: [dc] Power Management version 1


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.

--Boundary-00=_xNTnBxII5Tfmalt
Content-Type: application/x-gzip;
  name="config.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
	filename="config.gz"

H4sIAIaqnEECA4w8W5PauNLv+ytcuw9fUpVsgGHIzFblQcgyaLEsxZK57IuLzDgJXxiYw0A28+9P
yxeQbcmch1zc3ZJarb7qwh+//eGh03H/tD5uHtbb7av3Ldtlh/Uxe/Se1j8y72G/+7r59pf3uN/9
39HLHjdHaBFudqdf3o/ssMu23s/s8LLZ7/7yBn+O/uz33h8eBu+fngZApr6fvGj/0+vfef3hX7d3
f930vEGvN/ztj98wjwI6SZd3o0+v1QdjyeUjoX7fwE1IRGKKUypR6jNkQXCGBICh7z88vH/MgP3j
6bA5vnrb7CewuX8+Apcvl7HJUkBLRiKFQmgIrQo4DgmKUsyZoCHxNi/ebn/0XrJj1W4c8xmJLhwU
3ymPUsnEBRxyPEtnJI5IWLE1yUW71Z2dni+MACUK5ySWlEeffv+9AssFMrqTKzmnAl8Agku6TNnn
hCTEYEb6qYg5JlKmCGNlTqyJS+c3lunBQFjVBIISnyoLZcihzyRI5ZQG6lP/toJPuRJhMrkwNePj
vwmMl5A5SPsCp7PiP21IzqfJA2Fj4vvEt7AxQ2EoV0ya5BUMFlnFKBVISkvLIFFkeRmcCB7WNUEk
kqhaywsOp1woyug/JA14nEr4j02aU0bYZQhohUI6iWDoCCtYb/mp18KFaExCK4JzYYP/nbAcfmZO
0WhVDG2ylOtguF8/rr9swTz2jyf45+X0/Lw/HC/ayLifhEQaZpkD0iQKOfJN8ZQImD2u0BYJ8LHk
IVFEkwsUs1rHpdZLS7cyxiUWZhna1h0IDftQXKQM4SmNSGVv4rB/yF5e9gfv+Pqceevdo/c1014h
e6m5oFTUdE1DSIgi67pr5Jyv0ITETnyUMPTZiZUJY3V7qqHHdAJ+xD02lQvpxJbeEMV46qQh8mOv
17Oi2c3dyI4YuhC3HQglsRPH2NKOG7k6FOA7aMIovYLuxjOLJlW4YU0NZw4+Zh8d8Ds7HMeJ5MSO
I0FAMeF2VWMLGoE+CzzqRA86sTe+g6tVTJdOYc0pwjfp4JqeWWSpsZiJJZ4abl0Dl8j365Cwn2Iw
WFIGkI8VLl5IwlLdAzQB45/wmKopa8d8CJt0HCPwLT7Y66re+0KkCx7PZMpndQSN5qFoMDeuB9vc
J3CB/FbjCefAkqC42aciYQrRIsZcNBgBaCognqUwVTwD67+gp4IocNaMxIYjM5OIKM6D0KfBGQud
+EBjRFERE8JEG5COZ2FD4DrRsHHPLUAw3jqAYdICpBF8oiKBamDEUE1JzOq5leKw1mNk1St6N7Mr
I8WQDHCfOLSNybg+OkiM+lUMCDaHp3/Xh8zzDxudqRb5YRnwfbtxRHxKJ83oWS1ZgRlOzGmVwNFw
4m5hrDoAhCI1Z4PUFHKcJEQ6KbC5KBXHtXwooBYqGn8eI4hc5kpN0VzbB84T0gs4JpMyGhehMjt8
3R+e1ruH7P3Tfrc57g+b3TfI/k+7I0itnSZA7hxgVeOpBIExUNBqIpUt56qI5jRWiak3l9aKxHEC
+isTIXis2iTaJHTaMaaQEkYgPGlMTKfcqZiuwPCDANK3T30jLSRLglspkdj/mx2gXNitv2VP2e5Y
lQreG4QFfechwd4aE2e1OTOQ7TiZWPVI8kAtUAwOLpEQYvzWyLp/GOXxp5b7I5QtutY6QfUFw+fp
SsEa1Wvwdf2QvfVkcx10F5fJ6690zLlqgHKhgl9QpLZiOU6GhNjzjRyNsBs3Rgp6XFmWuUAnSvGo
NeCc+oS72gQoavBeliw8bsAt7qVgGKTtZpmOmRvZ5Z5yApxAnglLLn3lnHSI8CykUqUrgmIzK8/R
LW2pC0w2JklwUxp8QZqSELipAlDEKcKaSS0oax5sOubHoRqGDDpuq6pghqYWesnOJvPWG1MuDe28
dCvaNQjYrxccsv+cst3Dq/fysN6CrzEbAUEaxORzq+X49HKxTpj2O09ghil65xEq4W+G4S/4n2mv
uXAuBospBPGcW5sUCjRjxWcHiU9jKGltDi5Ho8jIAjRIj1iHFD3UYdXADahsTSEkE4RXuW04eIgQ
M6s4EEotfsC3IzG0wyX+NXBUDWW9r1et7VsxFCO+Xiu9TB/w+vAIa/jWiCfGtHLSdg/vH6CV9+Ww
efxmFm5Fl1oE40vFh6k33R+ft6dvNmWsONVkzXHIr+zhdMxL468b/ZcOh0djvDGNAqagMgyM7ZYC
hniiWkBG8wwq79zPfm4ezBzksh+0eSjBHj/vUF2krlDko5BHtuQH/LneT0kDGrM8zIwTGtYq9GCR
6qrcYs4se9ofXj2VPXzf7bf7b68li2BWTPlvTR7gu70o68N6u822npawJTlAcR65nxoAXWhbYFAw
hH1AXFShREE+TZGt9jfaBjTgNeu4oCCBgA643YpLMq7DSMcI/cHd8KxdWq3ysLxdv1pmHYkaI5Fo
e/tqX+K4f9hva0sNBgkt7LxGoumwLpgyASjc43b/8MN7LFbS0NxwBpzM08A3hVxBl75LQNS3l626
JRafUx91ojGVsotGD+4jfD/qdZIk9kS8QutNMdu0cLwSimtsR+NobBWJXN51szTuRMfIxrBOiwET
SMgLkxhS9N9/vzQNx7a9M+zHkG2ImcL+3L9YTg2st2ADEstPd0b8rBEs8iq7pYVgGPLhe6Z3AQ+G
soCi5TVmpOX62oQi2Yb5BPlhse3WwODgc6WaUCR+gD+CfmAB+xCHYdt+QN0MJ1rKsgCW5petXzKY
ADjS/cNJ5x15pvxh85j9efx11C7b+55tnz9sdl/3HqTQWoEftXOtWZrRdSqBp861nPoptZaeRi8+
NQuQEpBCNaeo3s20zwpbNQ8QICTSyRLQBCEXYnWNSmJp39/RM1dQNcFCYRW2NQMm/PB98wyAapU+
fDl9+7r5ZXoV3Um5E1M7Zajsj/mjYe8aiw2XZyEwc9viO5VTHe2g2LWNC1XfmDcSiQZJB9d6T380
6Heb9z/9xgaqRSUYamaeDWy+bW7j8tI6RYmqxbYSxaNwpVWsk0tE8GiwXHbThLR/u7zppmH+x+G1
fhSlS9FJkqtDdy8qpkFIumnw6m6AR/fdLGN5ezvoXSW56SaZCnVzhWNNMhp1kkjcH3QqiwDR2dQk
kncfh/3bzs6Fjwc9WOSUh/7/RhiRRTe788VMdlNQytCEXKEB8fa7F0mG+L5HrkhPxWxw371Mc4pA
JZYODdVOCsXMidNb5M0zPqu9WsyQzsdu822a7iWetNxt7qaLpK0dFDXS2ByGr7zoSwNZhcW8edmu
OOh687h5+fHOO66fs3ce9t9DMvC2nQ3KWqmAp3EBtZ9MVWgupeqQlYxtc5ZxCoWKz2159nncyXk+
+6fMlAmUJNmf3/6EiXj/f/qRfdn/OpeP3tNpe9w8Q7UWJtFLXWhl/AWEyVKOgf/rwspxspuThHwy
odHEvlbqsN695OOj4/Gw+XI61hOMvAept6KUijsGCfA1Cpr/3SK6sLLd//u+uN/w2N7fruR/s0jB
PpaQl1LfPRZQ3bvMKCfQx4YBkg4NKThtlvAN9BT1bwfLKwTDQQcBws1Z1NAUf4Q5GLthBUCHH6n3
j7U8KOTeo2GTIibgB4qDpJTJT+C0za27kiiv51ISobH1akidLN+XtnQSk7x2V0rv39CoS5xlC5d7
PxPdd62bL1RKB7yjB3+OIrnq0sNo4DwzJhOkl0SHFkisummKbSvX6ulkvGWsGgh6gambu5wEIpdT
KwDdDLOXhtH8Ss/gbxmV5Nr4y+E1ChpepZBXKJLwmhwgHl6lUER2zWecSPB/FLspoLwPcJf/9Nny
pn/f71BbX+GbwV3PTUBcpdkZC4vaodVBohIoE3zOEI3cZBNfTTuw5VFzhOPbmy5uG4QpY128QdLR
ZWxUdTaOKOpbc8oiPRDIrCyLJox19PcPFSkRoj+6QgNasUixit1k+ezxsDfq0sEVA5o7cGuDLgF1
jCKQ7OIVKientzoTDAa9DksSkg6GXQSfcwNJIRxepaFSXO8HXyXpdxqLQZT2e0OncnwO0aAIkM32
aNDvCiKaYHCN4KbXu0IwGHQSjG761wi6epAETZAi13Rv2KU9Pr65v/3Vje91xGwFa+DGJv1hejMM
OghCFSOpeJeRSXHTIQT7njPfPpalQJUpem80gW7yLieFwqW274/1HqBtG6k4QNCZ9/t61eK9yXMz
vUMezln9EKFd9gQnfW3YY0K1i5/LCUYiGxciih0qQojXv7kfem+CzSFbwJ+3lg1FoNJE4A6LjPn0
5eX15Zg92Y5aKmIoVeIxl8R9rH+m5AlI21oDVhTF9dPqygWvX1I9U13w4PfyWTXn2zo/ancCTi1c
RcsubjhkUaY8qnMIo9+WMPRZfdmmiZNjMXCAiwsYzbL5LBU1bc6yTeTPmzRNihgtKLcwgJmwQBHz
lahmrtNht9I1kuUcFWXHf/eHH/pSTEvPIqKq4tUga104FwjPiHngm39DpoBq50bQW0ijvHKzzD6J
6nksFQzcGtc9Waihr3RGVoY4Cl6N5kWdjJGjrAOCvDzAxAcFTZTj9gCQ2bdyNQdUUGNFCsgkJmaW
gmJhLepW+iY+n9HaUbbuAU3rk0qJFA0IFfoSfwOokqi4kX9hXGHhUzQxCM8w+O98VK0tFX95883h
eFpvPZkd9JFt7cZOTYVEOrdtKuX9PZlfugacQ1FUn9+oNcFRe4Yj6xRH1RzrwzSBQBnQsHEh6Ax0
RBEtAlDxr5vt0TL7y9yjQDu1CJwfntXkqhGqeplgp4e6OZ61sEqXYYpDiFOi2WPQBtEYN0GqIDOX
CKCI6RN2l04DQf7AwrqS+ThC6b0A2RyMIYWnaUgZVXYUJLgomhA7kiFsR4iZUivhbBXPHBht4vUT
eROtuIP/mGD9YMOKIziyI3yJhR2Dpg0dNkVFoomaOvhToQOBBZMO3qckFKDcVpxUkCXaUU61LdB8
Ebk6Rb4fuxcnJihkDm4sKl0xw5hzATSn7iWfIjm1ql9p9E3jQPEEvGNM9EMdBxJKDAcmcaPsSxQh
ZQGB+4G0y2/aftkTQxJsMUY+cTJfXqmyo8G36UhrR0rEiI2j/Mp0I2CWKBkxkY6RtF6Dv5BZPJEG
W3yWBqvApgvRJHRN2mK7JcZioCXGZqFnIbcVqkThEElJg5UL7VDHc+tEgt7R1sCQxbkWjFsNEVIF
u88FhF25AXERYmMldfxEea4wRTSSHYHgTBkskM8sofHn6H8KjqNzVDH5HLmiyagjnIycIcPAxK4m
XCjXSEFcz4cM1DR0cWALMqMO1zlyh66RGSjnoynRl9gcBGjaCCqjrqhiIElCR8MWrq1CI7cPHNnt
c9RhUaOW0i8D81Wc/spfkpyrVggPjavhb8y3q28beWdOb73hq+ybgOOY+o4D3XmIovSuN+jbn7P5
4GOsdUcYGtoIH4O64S0d/KHQfqdhObCfg4dI2G9i6Uzfp1DJ24saAv8SO2oBE27XObmIP++l3tv4
sD94X9ebg/efU3bKGjeX9cD53SdHKYRDWXTfKBi9Y/ZyLPoyqCHdm5DIlN1s4o85sXfefL5agtJ4
6ZJRjgYn6yrccry+Ex7Df+qVwhQxCMWUW1+h+OhcaB8guX427jueaUCzDLOIdapjfvuo2Ao7F1+6
o1ZJndMVj8ggOoF5SvMZV44NNDyOG9C8vDn3vft6WB+yx/f5Jla5L/BYv6sradzGnHvUZ3lAUc3a
3+++ba1bCz7XvsK6O9c9QnEf9jJE3iI7bKAWfbwyWvP4sNh9s412bpjIcS4n+y4jnYADJaG+eGzX
LImduAWNxjzynfjyCYYTLxnW2uIeAIXUiZuHsgNJW6NWDtIIaWNQsgE288ixtnhe+46DujqfQVDK
GIU+gMcRqXelASnD6bk2b6CKKtiCnVL/vL013p6y435//O5UKN0AU1jm2uAFKJ+OeY2jQCCHMy3Q
Y8wGvZtlF0UAfVulq7Fz+FPbnCgO6o1tHz9hbFW7Mwl61LijcfHwnxNQhH+sV7tVUnOpucseN6/0
FZdWY7zLjsaFamO/qhn5ikcEx+/6RzGO3pt+z4M4Ab2yL5vj27pbJ/rOeWRuBTJKTZamSIgVI8hx
XpxEE8Kcca+4apPegL45gmaEybXWYGbXSCA3R+27o+q03TxDfHzabF+9XRnc3FutxZZcSF0ZS/+j
40hJ3wS1u6ep6Dva5JuCjncvebhzXDIoQmFzi7W14DBqtdjGqyoSOQ7S/XAws2gn0R1dLCH/hNJQ
1O6SRvLu5s5xxREis/4ZBCtuRcKQLwLHeXh81x/d21Vudn8XOlopOuHRzRXJWERDlxN78iYHtL3/
rvY/sp0X6411izmqdramz4S22cuLp3/J4c1uv3v/ff10WD9u9m+bCthKZIoO1jtvU728rI22cPw2
ROD7drFPqRB2jHCpvhCOU2NXAz0R1zEy+BOrJ4Q2+i4cz6uXIhWSfgR2Wp6T1d+n+O1zOAUifv6+
373aXluJaePdUplsPZ+OzuuONBLJ+TAleckOW32aWFsGkzJlPNFHdXNz99yEp0KiZOnEShwTEqXL
T/3eYNhNs/r0cWQ8sSiI/uarxjFNg0DJbjyZX8Nbt+FzGdIP3Ja7TRAjOlu0HafwBFKvisC4Vqqf
STU+U3rXGw6aQPi7LPEv2pUjsLob4I99x/l/TiKgEh77XQSYCjmw8Z2jQzoGdO3qQg6HYtohodax
aU22M7LKXwqYb8cLCAQe4LT2g0IVBoKvaxJnmnB2lWSprpJEZKGsvwVg6Kf5Yzr570zIQRNUvKEz
F6yAQy/ckdEVBPpGieOxdDkY7vd7AvkdJHO5XC4R6lBwsCCpKJ512RBP8LSwQrc0qPlzFQVMYClm
cW3nIYcn+T/tV8nf14f1g966az2gmxu2Ms+3OnOfefmNhYUBq2knCvVPZBTPOC2PW6sKrqmgZdO7
wW2vboElsM2Ciaz/JoCJieJU5/Hy09CGJUsFqR3xLZPI8QxFq1RrjXTYaEVofaBjEvhE6R8EAwqn
OzgPWm0rXqWM66ldsb0CcV8jAZJL2v5etewF87gtUQ1si1sfw9/fpUKtalc6qmfZamV9rRnnv8Ng
amQoqr5t9EJHtv82djXPietI/F9JvcueXg22sTGHPchf4IeNPZYgZC4UL2Ez1GZCKpB6Nf/9dssG
JFst9jCpoX+tD0stqSV1t36pqhbMoYaT5zJXD5jLHHTAZVLoJUl6zUAb3Uq3YeOlRZl3BtJtxIgM
1Ff17BJNDfIe4RHPUhP9WLTs4hRUWXZRLB535+efL8fXB3QB72lTbQZmzekRpnfYbhDbnbXZ1bIR
yvHjDBZvE2Gr2VEkgjh7bLxpYDZVgU1akVO7LF4tn+qh2VTWOmWAbvzwn7fjx8dv6aWhb9M1+6e+
N+Cl7JlmMwI/8eDDXE3EhAUrExsWjM3FtzGP+pVoAyGVRPgx5Fiu84QwUUaYMoGWmAzoRMJrS7am
QFuXnm+0QBnwcyuSzHySgSCoTyUj0YYy/5MgS6hgXwjnIaE/taBnAaeEpxiC5YyuLtXc5SNbmw8J
QNuClHi2bop1VKunGjK8FY60diVQqX2jJ5iwZjI+1jBCSWewFRs2C6665rvxNoZ1p50yr4nY2+vx
83D++eukpZNhxaJc6OmRWMeZNm1eycxYqTlMZzK+FIYmMdqSxa2bpWfuoCseeHZ8Y8HLZOIHNjh0
HIfE0yJdCKNzFqKwDXCUuV1SnFGPwlm/zZbSv9UlC+3iK9zDQemfzQVRNfTpGPcLrpuKszXloYgc
LTy2hDkBDSqik6Nz49S34QExVDt4GmxoWKzooqkZrsPg02m4qpKqomUI5Lt/NibF+CrffP9+On6e
QE0+fBiHIihMS4zSpG0NkcK3LClhg+0QGpzK49/n8e7kI89yrSwJd4I7tcnwEq+xsswK3wl5aVSF
W45chBNTcxRl4FmSFeXEv40vhToxUkMTNRwZqZ6RaiwtNJY2HZk+qGQbJ3Cm1uaq43DiBfaO4SWP
x5PSsTQOiHkQBmxYt8fQm4ROYgSKSeirtg4KFLiT+VVJrfDMUk7rZim/pEtT9AkztQSsHqE/Gd9p
CeCZ2uUPVs3QJ/ROHGuthyHuTe6w4Np1hyUi4qUp5cz1Q8f2knP39rY7/ev04Pz5zwEmiL+/dLXe
GfoMHE7PptPbPCph2JZmH4Nf+5fDzpRKmqb3raTbmh1eD2fY7K0PL/vjQ/R53L087+T1+iXKkXZJ
qrtxt5GZPncfPw/PxhU9M11itZXhsJTG4haFHGbMN9DqD6cPDBjUavdDqVrPmOn4oEyYZW8ob8OU
ZJ3r9Nf7iyKueNx3ke1r7LY2eLtkfWCfzz8P5/0zxkRW0i3VYbRMuhClGqmOS50wf0zUq0wkgapY
grKvE3n6fZUuY31z2gHtV5lGP+AV5xghU9mgA7HMN2mD0KB2Q+K1ZAlp2cBwu3yjVqfOF6TduZv3
h8hmNpa+hPcyyK5MZPnWdd50LaclKUXN1mQtugOLlRP4/ojkKuvVeDQcm7j2ExVliROOQzLDmI9d
ak2+wK4dDkg4haU6DG1wSDml4Un3irdWi7GNBZ100jK1scACR8LypITcLmkcoN1FJBeGnpm6m3vN
fWG70+ySzaNrzaPQgjmBBWSP9KfiV2ZNRTm1Y4eXsJP1RpaKFx5ntMDwGSvY5onGedw7MrlGBhyc
60rpjqeTLYYXjvujDbZd/tinm9gS9eYGywBQJc20CqlN/wV27bClKdkP4Xku3c8R6Kcb28gMNlbY
DR1i/oKJ2hktnH6LLqpm5rgO3bkwnVNmJggvS9enJbMpU8tEA+g0sKM+nXqecLqnBUbKs4j8U5lR
pgWtnPEx6a/cjhhbctAYHW8yuoM7tjl06lmn2GlAwyVLuWiIjSUyZLAXoQvP49SZWARC4u7YOrUW
4WZ0l4Eegrxa5vE6j1JOssgYQ5axsN64ultye33NI2pJRSsrfFalIrNEjhXfuE9DW8GP/XunvvHB
LX17w1ujbbCxPgPlE03Afis/dMtI1Nj3oOa/749fJ5nBwASzTYN3BhnXc4rYMnnMEzFXtVrJ/rRk
ZR7DaF9WRPQbaYY2jJqt4ZUwBVKWTdu0HjDbeZzodboi6At7tTOA75ofT2fU2M+fx7c30NIHd8aY
OoVEMs9fAyqvixytiyq9PIk1VSW281W0FaLfFFWXI/Ehq1uB15p2l9oxbL5OlO3mQLauqW+mgUI8
PTzv3h+O72+/H/7eP3ydYHPwzwGNBg8njIP7ojAbTUKwJFRTyR5icUl82O0qTO1wUTVspjlpKGQy
dLbK0zx2d4v9hr5mwgTLWEQLXceXNWlK3e2ofDlPqLjIWrF1fD+veQ2L/Wh/l48nSTOa/l9svn+X
Tb4eNK+EUVxUO4qBlM3zxJgI6RGIzc3BnBBTygZCChYaENCSldciXZDwI7P13SISFgmQN5clFUZC
Vk1aJJBwKjVUEt5QJhPyuwRMF2lZCfP0nf/avRImcLJiSRxahFG+pGFrtnkNf43hHrBw+3GMnNhZ
1LPxlRzyHGbcnjtcQkUgz37/ApMMRm01Zq8sVtc6XNwl2Mvu42yQqJiJmO532LkIut9q6Djq7QDE
G1GEjk83L/wz2QRjtVvHAvMgWHE+cUfGZJ15CCxLkPCsnR3pQ3kQJ/vWadoKTlQhLfPApeW5zN2A
REU+K2hxXqUNf2QFLfBNXvkWkS3SWSVwQNIccWJJTWPxk3xAgpaGOXpFiQXxVJfCAq2/ruj2SblZ
JpgovyW86DuaIDTbvbzuzyabSsxxxrDUoWkBRq1vF2ntlUPhblXNrCNsNxhVcEhunxVksXazfwF5
Gq+aXJhOrYDF65fjmcvxbOV4d8r5S7fLg5+kXgAZlZF0DlJTNGkOHZbhFY8pewncqvsXVVUEqIIR
QxfzHC3blMyovDaD2iiPHy2BnwCbqqRTfl9Vevy0y8HxshLoxXsLkbgSVfvVv3TSWAkyGu+ef6on
JxlvG/YWkxx/yjxafhlq6FuyTqRcDsQSFOVpEIy0Uv+qilw1H/gBTGpftL+1JKsk07oLfy+La62T
in/LmPgGe3NjLTJ0xFafOuSQQqOs+yz4O0kztiqEPDWqUWEdexMTnldokIBvEP1xOB3D0J/+6Sgx
35di0HvtUdVp//VylK9QDGp8i/2qEhY9y7UnnmlmabA/owUFwFrw61A1OcyUtZ6fJAzZb9YcK5ig
iogosEO3de+S/mpgUt7kTl++9Ca5Gfgk9NexjMbmVqguViQcpXTSiIYsqWL52WbHNMv8MK8tM8By
M6ZRfFCWwlZmwbwoX3Kl4cN+WNKlAWReitMNmnkY52JeRtpgx98wuC/DS30yrwVaxfnffzx/wIC8
vqMb5zKTW0vn3fRMdERuFW0Jy1nc/J1xTfZwhd6olJSaZ4Ld5/kgPb7F7w9d3a5ZIzBM5PIansn0
apycz66sV5/j3RlUjodi9/76tXvdDx8Va6fQ249rk9/mMf8PFb/MhFtoeMWLT0UmNKKaO2hI6I9I
xCUROjeqBmFAlhM4JELWIPBIZEwiZK2DgESmBDL1qDRTskWnHvU90zFVTjjpfQ+s0Cge25BI4Lhk
+QD1mprxOM/N+Tu6eF7IrpnbM5OJuvtmcmAmT8zkKVFvoioOURfH1z90UeXhttF5JW2l01YiC5Uo
f7Bu6oHrbtNIU2V5YYp0vmhfd/+5e/5vL8ZBaxPSPm1OaBTI0D1DalJBO7OTWXe9rj1ZBetgChOs
PB407TNYU3Rxs5UgYeMFTOjxgusPgWY5Hu+X9bb/qJp8NrSuUTe7mk7sn9vX4o/D0JCL9Mns8dDu
UnQnh5aGrnVorWxJBipzzSJofJGnXLcl6hjw3BjfKyMshTou+E+xLu7xQB+vNkOfl8/fH+fja2vt
Mjzbb99QUp4vl7+3cww20ycuV4USGaYjlsnYQPMHND5njono+oGJ7DvugPxYm6iJGkyno0XSBZbP
BwD0mJGOTm9aGK6OzlK+9cNhDTGYom+kDnlFyob5NvGw2RZz9oMlQ97lKsq54buzQotxdmn8HLYk
aKGfx8MKNrHnxoYacnGZS4rD35+7z98Pn8ev8+F9r4lKvI3jXGitFKtrSpFH/RJ+AG2bL3tVldTB
B1wCbKOJd95858PnoIF6fQ1QfW+97L3sPBe9x5/zCnVH/dlU+QQyzEV1pT9tJZ+K/x8m9bdJNoMA
AA==

--Boundary-00=_xNTnBxII5Tfmalt--
