Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262490AbUKDXLI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262490AbUKDXLI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262489AbUKDXJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:09:12 -0500
Received: from hal-4.inet.it ([213.92.5.23]:32942 "EHLO hal-4.inet.it")
	by vger.kernel.org with ESMTP id S262466AbUKDWhI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:37:08 -0500
From: Fabio Coatti <cova@ferrara.linux.it>
Organization: FerraraLUG
To: Pete Zaitcev <zaitcev@redhat.com>
Subject: Re: Patch for ub in 2.6.10-rc1
Date: Thu, 4 Nov 2004 23:36:39 +0100
User-Agent: KMail/1.7.1
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, azarah@nosferatu.za.org
References: <20041104000840.56412e6f@lembas.zaitcev.lan>
In-Reply-To: <20041104000840.56412e6f@lembas.zaitcev.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200411042336.40294.cova@ferrara.linux.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alle 09:08, giovedì 04 novembre 2004, Pete Zaitcev ha scritto:
> This is a relatively small changeset, to address small nagging problems.
> Andrew pointed me at the double registration specifically, so I had to do
> something about it. At least now Fabio's box won't collapse if he
> configures UB by mistake. Also, a few people complained that the help text
> was misleading.
>
> I have not done anything about the oops on disconnect which happens to
> Martin Schlemmer. It's next. After that I can get to Peter Jones' CD
> burning patch and doing resets.

If this can help, I've tried the same kernel (2.6.10-rc1-mm1) _without_ 
compiling ub module. (if this adds no new informations, please excuse time 
and bandwith waste) 
Plugging the flash key, I get some errors, like reported below, like this: 
uhci_hcd 0000:00:1d.1: uhci_result_control: failed with status 440000
The logs reports several plugging/unplugging operation (I haven't cut 
anything). Please note that under 2.6.8.1-12mdk (as shipped with mdk cooker) 
the flash key works just fine, I can plug and remove it any number of times, 
and it's seen as sda1.
Anyway, after several tries the key is found, but with a not-so-nice error :) 
in kobject_register. As before, something seems to happen twice.

syslog here:

<device plugged>
Nov  4 23:10:34 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov  4 23:10:34 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov  4 23:10:35 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov  4 23:10:35 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov  4 23:10:35 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov  4 23:10:35 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 16
Nov  4 23:10:35 kefk kernel: ehci_hcd 0000:00:1d.7: devpath 3 ep0in 3strikes
Nov  4 23:10:35 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 full speed --> 
companion
Nov  4 23:10:35 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
003801 POWER OWNER sig=j  CONNECT
Nov  4 23:10:35 kefk kernel: uhci_hcd 0000:00:1d.1: wakeup_hc
Nov  4 23:10:35 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0083,00
Nov  4 23:10:35 kefk kernel: hub 2-0:1.0: port 1, status 0101, change 0001, 12 
Mb/s
Nov  4 23:10:35 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x101
Nov  4 23:10:35 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 24
Nov  4 23:10:35 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov  4 23:10:35 kefk kernel: [f7a7d240] link (37a7d1b2) element (2baf5000)
Nov  4 23:10:35 kefk kernel:   0: [ebaf5000] link (2baf5040) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=2b805480)
Nov  4 23:10:35 kefk kernel:   1: [ebaf5040] link (2baf5080) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=314cae80)
Nov  4 23:10:35 kefk kernel:   2: [ebaf5080] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov  4 23:10:35 kefk kernel:
Nov  4 23:10:35 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov  4 23:10:35 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov  4 23:10:35 kefk kernel: [f7a7d240] link (37a7d1b2) element (2baf5000)
Nov  4 23:10:35 kefk kernel:   0: [ebaf5000] link (2baf5040) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=2b805900)
Nov  4 23:10:35 kefk kernel:   1: [ebaf5040] link (2baf5080) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=314cae80)
Nov  4 23:10:35 kefk kernel:   2: [ebaf5080] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov  4 23:10:35 kefk kernel:
Nov  4 23:10:35 kefk kernel: usb 2-1: device descriptor read/64, error -71

<several tries> 

Nov  4 23:10:36 kefk kernel: usb 2-1: new full speed USB device using uhci_hcd 
and address 25
Nov  4 23:10:36 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov  4 23:10:36 kefk kernel: [f7a7d240] link (37a7d1b2) element (2baf5000)
Nov  4 23:10:36 kefk kernel:   0: [ebaf5000] link (2baf5040) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=2b805900)
Nov  4 23:10:36 kefk kernel:   1: [ebaf5040] link (2baf5080) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=314cae80)
Nov  4 23:10:36 kefk kernel:   2: [ebaf5080] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov  4 23:10:36 kefk kernel:
Nov  4 23:10:36 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov  4 23:10:36 kefk kernel: uhci_hcd 0000:00:1d.1: uhci_result_control: 
failed with status 440000
Nov  4 23:10:36 kefk kernel: [f7a7d240] link (37a7d1b2) element (2baf5000)
Nov  4 23:10:36 kefk kernel:   0: [ebaf5000] link (2baf5040) e0 Stalled 
CRC/Timeo Length=7 MaxLen=7 DT0 EndPt=0 Dev=0, PID=2d(SETUP) (buf=2b805900)
Nov  4 23:10:36 kefk kernel:   1: [ebaf5040] link (2baf5080) e3 SPD Active 
Length=0 MaxLen=3f DT1 EndPt=0 Dev=0, PID=69(IN) (buf=314cae80)
Nov  4 23:10:36 kefk kernel:   2: [ebaf5080] link (00000001) e3 IOC Active 
Length=0 MaxLen=7ff DT1 EndPt=0 Dev=0, PID=e1(OUT) (buf=00000000)
Nov  4 23:10:36 kefk kernel:
Nov  4 23:10:36 kefk kernel: usb 2-1: device descriptor read/64, error -71
Nov  4 23:10:44 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov  4 23:10:44 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov  4 23:10:44 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x100
Nov  4 23:10:44 kefk kernel: uhci_hcd 0000:00:1d.1: port 1 portsc 0082,00
Nov  4 23:10:44 kefk kernel: hub 2-0:1.0: port 1, status 0100, change 0001, 12 
Mb/s
Nov  4 23:10:44 kefk kernel: hub 2-0:1.0: debounce: port 1: total 100ms stable 
100ms status 0x100
Nov  4 23:10:45 kefk kernel: uhci_hcd 0000:00:1d.1: suspend_hc

<uhu, now something different>

Nov  4 23:10:49 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001803 POWER sig=j  CSC CONNECT
Nov  4 23:10:49 kefk kernel: hub 5-0:1.0: port 3, status 0501, change 0001, 
480 Mb/s
Nov  4 23:10:50 kefk kernel: hub 5-0:1.0: debounce: port 3: total 100ms stable 
100ms status 0x501
Nov  4 23:10:50 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov  4 23:10:50 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov  4 23:10:50 kefk kernel: usb 5-3: new high speed USB device using ehci_hcd 
and address 17
Nov  4 23:10:50 kefk kernel: ehci_hcd 0000:00:1d.7: port 3 high speed
Nov  4 23:10:50 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001005 POWER sig=se0  PE CONNECT
Nov  4 23:10:50 kefk kernel: usb 5-3: ep0 maxpacket = 64
Nov  4 23:10:50 kefk kernel: usb 5-3: new device strings: Mfr=1, Product=2, 
SerialNumber=3
Nov  4 23:10:50 kefk kernel: usb 5-3: default language 0x0409
Nov  4 23:10:50 kefk kernel: usb 5-3: Product: Mass storage
Nov  4 23:10:50 kefk kernel: usb 5-3: Manufacturer: USB
Nov  4 23:10:50 kefk kernel: usb 5-3: SerialNumber: 142E19413C2FCA34
Nov  4 23:10:50 kefk kernel: usb 5-3: hotplug
Nov  4 23:10:50 kefk kernel: usb 5-3: adding 5-3:1.0 (config #1, interface 0)
Nov  4 23:10:50 kefk kernel: usb 5-3:1.0: hotplug
Nov  4 23:10:50 kefk kernel: Initializing USB Mass Storage driver...
Nov  4 23:10:50 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface
Nov  4 23:10:50 kefk kernel: usb-storage 5-3:1.0: usb_probe_interface - got id
Nov  4 23:10:50 kefk kernel: scsi3 : SCSI emulation for USB Mass Storage 
devices
Nov  4 23:10:50 kefk kernel: usbcore: registered new driver usb-storage
Nov  4 23:10:50 kefk kernel: USB Mass Storage support registered.
Nov  4 23:10:50 kefk kernel: usb-storage: device found at 17
Nov  4 23:10:50 kefk kernel: usb-storage: waiting for device to settle before 
scanning
Nov  4 23:10:55 kefk kernel:   Vendor: 512MB     Model: USB2.0FlashDrive  Rev: 
2.00
Nov  4 23:10:55 kefk kernel:   Type:   Direct-Access                      ANSI 
SCSI revision: 02
Nov  4 23:10:55 kefk kernel: sdb: Unit Not Ready, sense:
Nov  4 23:10:55 kefk kernel: Current : sense = 70  6
Nov  4 23:10:55 kefk kernel: ASC=28 ASCQ= 0
Nov  4 23:10:55 kefk kernel: Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 
0x0a 0x00 0x00 0x00 0x00 0x28 0x00 0x00 0x00 0x00 0x00
Nov  4 23:10:55 kefk kernel: sdb : READ CAPACITY failed.
Nov  4 23:10:55 kefk kernel: sdb : status=1, message=00, host=0, driver=08
Nov  4 23:10:55 kefk kernel: Current sd: sense = 70  6
Nov  4 23:10:55 kefk kernel: ASC=28 ASCQ= 0
Nov  4 23:10:55 kefk kernel: Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 
0x0a 0x00 0x00 0x00 0x00 0x28 0x00 0x00 0x00 0x00 0x00
Nov  4 23:10:55 kefk kernel: sdb: test WP failed, assume Write Enabled
Nov  4 23:10:55 kefk kernel: sdb: assuming drive cache: write through
Nov  4 23:10:55 kefk kernel: sdb: Unit Not Ready, sense:
Nov  4 23:10:55 kefk kernel: Current : sense = 70  6
Nov  4 23:10:55 kefk kernel: ASC=28 ASCQ= 0
Nov  4 23:10:55 kefk kernel: Raw sense data:0x70 0x00 0x06 0x00 0x00 0x00 0x00 
0x0a 0x00 0x00 0x00 0x00 0x28 0x00 0x00 0x00 0x00 0x00
Nov  4 23:10:55 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov  4 23:10:55 kefk kernel: sdb: Write Protect is off
Nov  4 23:10:55 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov  4 23:10:55 kefk kernel: sdb: assuming drive cache: write through
Nov  4 23:10:55 kefk kernel: SCSI device sdb: 1024000 512-byte hdwr sectors 
(524 MB)
Nov  4 23:10:55 kefk kernel: sdb: Write Protect is off
Nov  4 23:10:55 kefk kernel: sdb: Mode Sense: 03 00 00 00
Nov  4 23:10:55 kefk kernel: sdb: assuming drive cache: write through
Nov  4 23:10:55 kefk kernel:  sdb: sdb1
Nov  4 23:10:55 kefk kernel:  sdb: sdb1
Nov  4 23:10:55 kefk kernel: kobject_register failed for sdb1 (-17)
Nov  4 23:10:55 kefk kernel:  [<c01f1fd7>] kobject_register+0x51/0x5f
Nov  4 23:10:55 kefk kernel:  [<c0184720>] add_partition+0xbb/0xf0
Nov  4 23:10:55 kefk kernel:  [<c0184898>] register_disk+0xee/0x11d
Nov  4 23:10:55 kefk kernel:  [<c024ba2e>] add_disk+0x36/0x41
Nov  4 23:10:55 kefk kernel:  [<c024b9e4>] exact_match+0x0/0x7
Nov  4 23:10:55 kefk kernel:  [<c024b9eb>] exact_lock+0x0/0xd
Nov  4 23:10:55 kefk kernel:  [<c028c382>] sd_probe+0x224/0x32f
Nov  4 23:10:55 kefk kernel:  [<c0185e31>] sysfs_make_dirent+0x1c/0x89
Nov  4 23:10:55 kefk kernel:  [<c02435a8>] bus_match+0x32/0x6a
Nov  4 23:10:55 kefk kernel:  [<c0243626>] device_attach+0x46/0xaa
Nov  4 23:10:55 kefk kernel:  [<c0168b96>] dput+0x76/0x209
Nov  4 23:10:55 kefk kernel:  [<c02438d6>] bus_add_device+0x55/0x97
Nov  4 23:10:55 kefk kernel:  [<c0242975>] device_add+0x9c/0x128
Nov  4 23:10:55 kefk kernel:  [<c026a6c2>] scsi_sysfs_add_sdev+0xa0/0x309
Nov  4 23:10:55 kefk kernel:  [<c02692c2>] scsi_add_lun+0x2d9/0x32f
Nov  4 23:10:55 kefk kernel:  [<c02693d5>] scsi_probe_and_add_lun+0xbd/0x1a9
Nov  4 23:10:55 kefk kernel:  [<c0269b30>] scsi_scan_target+0x9a/0x106
Nov  4 23:10:55 kefk kernel:  [<c0269c18>] scsi_scan_channel+0x7c/0x9a
Nov  4 23:10:55 kefk kernel:  [<c0269caf>] scsi_scan_host_selected+0x79/0xd8
Nov  4 23:10:55 kefk kernel:  [<c0269d2f>] scsi_scan_host+0x21/0x25
Nov  4 23:10:55 kefk kernel:  [<f8b4686e>] usb_stor_scan_thread+0x134/0x145 
[usb_storage]
Nov  4 23:10:55 kefk kernel:  [<c012d9c1>] autoremove_wake_function+0x0/0x43
Nov  4 23:10:55 kefk kernel:  [<c0103c9a>] ret_from_fork+0x6/0x14
Nov  4 23:10:55 kefk kernel:  [<c012d9c1>] autoremove_wake_function+0x0/0x43
Nov  4 23:10:55 kefk kernel:  [<f8b4673a>] usb_stor_scan_thread+0x0/0x145 
[usb_storage]
Nov  4 23:10:55 kefk kernel:  [<c0102025>] kernel_thread_helper+0x5/0xb
Nov  4 23:10:55 kefk kernel: Attached scsi removable disk sdb at scsi3, 
channel 0, id 0, lun 0
Nov  4 23:10:55 kefk kernel: Attached scsi generic sg4 at scsi3, channel 0, id 
0, lun 0,  type 0
Nov  4 23:10:55 kefk kernel: usb-storage: device scan complete
Nov  4 23:10:55 kefk scsi.agent[17606]: disk 
at /devices/pci0000:00/0000:00:1d.7/usb5/5-3/5-3:1.0/host3/target3:0:0/3:0:0:0

<removal, of course it oopses>

Nov  4 23:29:37 kefk kernel: ehci_hcd 0000:00:1d.7: GetStatus port 3 status 
001002 POWER sig=se0  CSC
Nov  4 23:29:37 kefk kernel: hub 5-0:1.0: port 3, status 0100, change 0001, 12 
Mb/s
Nov  4 23:29:37 kefk kernel: usb 5-3: USB disconnect, address 17
Nov  4 23:29:37 kefk kernel: usb 5-3: usb_disable_device nuking all URBs
Nov  4 23:29:37 kefk kernel: usb 5-3: unregistering interface 5-3:1.0
Nov  4 23:29:37 kefk kernel: Unable to handle kernel NULL pointer dereference 
at virtual address 00000050
Nov  4 23:29:37 kefk kernel:  printing eip:
Nov  4 23:29:37 kefk kernel: c0186373
Nov  4 23:29:37 kefk kernel: *pde = 00000000
Nov  4 23:29:37 kefk kernel: Oops: 0000 [#1]
Nov  4 23:29:37 kefk kernel: PREEMPT SMP
Nov  4 23:29:37 kefk kernel: Modules linked in: usb_storage hidp hci_usb tun 
md5 ipv6 rfcomm l2cap bluetooth snd_seq_oss snd_seq_midi_event snd_seq 
snd_pcm_oss snd_mixer_oss snd_emu10k1 snd_rawmidi snd_seq_device 
snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd 
soundcore lp ipt_REJECTiptable_filter ip_tables loop nls_utf8 ide_cd i2c_dev 
w83781d i2c_sensor i2c_isa i2c_i801 isofs zlib_inflate e1000 parport_pc ppa 
parport usblp ehci_hcd uhci_hcd genrtc
Nov  4 23:29:37 kefk kernel: CPU:    0
Nov  4 23:29:37 kefk kernel: EIP:    0060:[<c0186373>]    Not tainted VLI
Nov  4 23:29:37 kefk kernel: EFLAGS: 00010246   (2.6.10-rc1-mm1pnoub)
Nov  4 23:29:37 kefk kernel: EIP is at sysfs_remove_dir+0x1d/0xef
Nov  4 23:29:37 kefk kernel: eax: d925cf08   ebx: d925cf08   ecx: c18ff480   
edx: c1000000
Nov  4 23:29:37 kefk kernel: esi: eb805b20   edi: 00000000   ebp: f7a9fd94   
esp: c198dde4
Nov  4 23:29:37 kefk kernel: ds: 007b   es: 007b   ss: 0068
Nov  4 23:29:37 kefk kernel: Process khubd (pid: 125, threadinfo=c198d000 
task=c198a530)
Nov  4 23:29:37 kefk kernel: Stack: 00000000 d925cf08 eb805b20 00000001 
f7a9fd94 c01f20e7 d925cf08 c01f20f7
Nov  4 23:29:37 kefk kernel:        e072a880 c0184aa0 f7a9fd94 eb805b20 
f4d06c00 f7a9fd94 c028c4a4 f7a9fd94
Nov  4 23:29:37 kefk kernel:        c03afa04 c0243765 f7a9fd94 f79d8e04 
c024396b f7a9fd94 f79d8e04 c0242a86
Nov  4 23:29:37 kefk kernel: Call Trace:
Nov  4 23:29:37 kefk kernel:  [<c01f20e7>] kobject_del+0x14/0x1c
Nov  4 23:29:37 kefk kernel:  [<c01f20f7>] kobject_unregister+0x8/0x10
Nov  4 23:29:37 kefk kernel:  [<c0184aa0>] del_gendisk+0x1d/0xd5
Nov  4 23:29:37 kefk kernel:  [<c028c4a4>] sd_remove+0x17/0x5b
Nov  4 23:29:37 kefk kernel:  [<c0243765>] device_release_driver+0x56/0x58
Nov  4 23:29:37 kefk kernel:  [<c024396b>] bus_remove_device+0x53/0x90
Nov  4 23:29:37 kefk kernel:  [<c0242a86>] device_del+0x54/0x91
Nov  4 23:29:37 kefk kernel:  [<c026a980>] scsi_remove_device+0x55/0xa6
Nov  4 23:29:37 kefk kernel:  [<c0269d60>] scsi_forget_host+0x2d/0x4f
Nov  4 23:29:37 kefk kernel:  [<c026403b>] scsi_remove_host+0x8/0x59
Nov  4 23:29:37 kefk kernel:  [<f8b46b19>] storage_disconnect+0x7d/0x8f 
[usb_storage]
Nov  4 23:29:37 kefk kernel:  [<c029826d>] usb_unbind_interface+0x5e/0x60
Nov  4 23:29:37 kefk kernel:  [<c0243765>] device_release_driver+0x56/0x58
Nov  4 23:29:37 kefk kernel:  [<c024396b>] bus_remove_device+0x53/0x90
Nov  4 23:29:37 kefk kernel:  [<c0242a86>] device_del+0x54/0x91
Nov  4 23:29:37 kefk kernel:  [<c02a0007>] usb_disable_device+0xda/0x147
Nov  4 23:29:37 kefk kernel:  [<c029aa8a>] usb_disconnect+0xab/0x198
Nov  4 23:29:37 kefk kernel:  [<c029bfec>] hub_port_connect_change+0x371/0x4a4
Nov  4 23:29:37 kefk kernel:  [<c029c3f3>] hub_events+0x2d4/0x4ac
Nov  4 23:29:37 kefk kernel:  [<c029c600>] hub_thread+0x35/0x10e
Nov  4 23:29:37 kefk kernel:  [<c0115111>] finish_task_switch+0x3b/0x87
Nov  4 23:29:37 kefk kernel:  [<c012d9c1>] autoremove_wake_function+0x0/0x43
Nov  4 23:29:37 kefk kernel:  [<c0103c9a>] ret_from_fork+0x6/0x14
Nov  4 23:29:37 kefk kernel:  [<c012d9c1>] autoremove_wake_function+0x0/0x43
Nov  4 23:29:37 kefk kernel:  [<c029c5cb>] hub_thread+0x0/0x10e
Nov  4 23:29:37 kefk kernel:  [<c0102025>] kernel_thread_helper+0x5/0xb
Nov  4 23:29:37 kefk kernel: Code: ce 3e 32 c0 e9 4d ff ff ff e9 23 ff ff ff 
55 57 56 53 83 ec 04 8b 78 30 85 ff 74 0d 8b 07 85 c0 0f 84 ca 00 00 00 f0 ff 
07 85 ff <8b> 57 50 0f 84 b4 00 00 00 8b 47 10 8d 48 78 f0 ff 48 78 0f 88


-- 
Fabio Coatti       http://members.ferrara.linux.it/cova     
Ferrara Linux Users Group           http://ferrara.linux.it
GnuPG fp:9765 A5B6 6843 17BC A646  BE8C FA56 373A 5374 C703
Old SysOps never die... they simply forget their password.
