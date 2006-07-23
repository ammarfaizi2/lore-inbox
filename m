Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbWGWJrI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbWGWJrI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 05:47:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWGWJrI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 05:47:08 -0400
Received: from wip-ec-wd.wipro.com ([203.91.193.32]:53890 "EHLO
	wip-ec-wd.wipro.com") by vger.kernel.org with ESMTP
	id S1751180AbWGWJrH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 05:47:07 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: oops in scsi_device_put after PCMCIA based USB HC is ejected
Date: Sun, 23 Jul 2006 15:17:02 +0530
Message-ID: <0F35D2C4458E9B4A9891BE2D4E0C8390013010B7@PNE-HJN-MBX01.wipro.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: oops in scsi_device_put after PCMCIA based USB HC is ejected
Thread-Index: AcauPPK9M4Squx8AQ6CTW5xVDiM8QA==
From: <deepti.chotai@wipro.com>
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 23 Jul 2006 09:47:03.0235 (UTC) FILETIME=[F373A130:01C6AE3C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a HCD for an OHCI compliant USB Host Controller on a
PCMICIA card for 2.6.15.4 kernel. On inserting a USB key it is
auto-mounted in X-Windows. While carrying out transfer on USB key, on
90% transfer completion, when I manually eject the PCMCIA card, an oops
occurs. This happens occasionally and it occurs only on a dual core
laptop.

Following is the /var/log/messages extract:

Jul  5 17:57:38 localhost kernel: pccard: card ejected from slot 0
Jul  5 17:57:38 localhost kernel: usb usb1: USB disconnect, address 1
Jul  5 17:57:38 localhost kernel: usb 1-1: USB disconnect, address 2
Jul  5 17:57:38 localhost kernel: My-hcd: USB bus 1 deregistered
Jul  5 17:57:39 localhost fstab-sync[7999]: removed mount point
/media/usbdisk for /dev/sdc
Jul  5 17:57:39 localhost kernel:  6:0:0:0: rejecting I/O to dead device
Jul  5 17:57:39 localhost kernel: FAT: bread failed in
fat_clusters_flush
Jul  5 17:57:39 localhost kernel: Unable to handle kernel paging request
at virtual address 1000a5b8
Jul  5 17:57:39 localhost kernel:  printing eip:
Jul  5 17:57:39 localhost kernel: c01564b9
Jul  5 17:57:39 localhost kernel: *pde = 0eaf1001
Jul  5 17:57:39 localhost kernel: Oops: 0000 [#1]
Jul  5 17:57:39 localhost kernel: PREEMPT SMP 
Jul  5 17:57:39 localhost kernel: Modules linked in: serial_cs 8250
serial_core my_cs my_hcd vfat fat usb_storage parport_pc lp parport
autofs4 rfcomm l2cap bluetooth sunrpc dm_mod video button battery
asus_acpi ac ipv6 ohci1394 ieee1394 yenta_socket rsrc_nonstatic shpchp
i2c_i801 i2c_core snd_hda_intel snd_hda_codec snd_seq_dummy snd_seq_oss
snd_seq_midi_event snd_seq snd_seq_device snd_pcm_oss snd_mixer_oss
snd_pcm snd_timer snd soundcore snd_page_alloc r8169 joydev ext3 jbd
ata_piix libata sd_mod scsi_mod
Jul  5 17:57:39 localhost kernel: CPU:    1
Jul  5 17:57:39 localhost kernel: EIP:    0060:[<c01564b9>]    Not
tainted VLI
Jul  5 17:57:39 localhost kernel: EFLAGS: 00010082   (2.6.15.4SMP) 
Jul  5 17:57:39 localhost kernel: EIP is at kfree+0x39/0x70
Jul  5 17:57:39 localhost kernel: eax: 00000001   ebx: cebe28c0   ecx:
d4bd4934   edx: c1000000
Jul  5 17:57:39 localhost fstab-sync[8048]: removed mount point
/media/USBDISKPRO for /dev/sdb1
Jul  5 17:57:39 localhost kernel: esi: 445f4253   edi: 1000a5b4   ebp:
00000206   esp: ce5bae20
Jul  5 17:57:39 localhost kernel: ds: 007b   es: 007b   ss: 0068
Jul  5 17:57:39 localhost kernel: Process umount (pid: 8039,
threadinfo=ce5ba000 task=df3a7000)
Jul  5 17:57:39 localhost kernel: Stack: cebe28c0 c03dbad8 c03dbb00
df9ed4f8 c01fc735 cebe28d8 c01fc790 cfd15180 
Jul  5 17:57:39 localhost kernel:        cf37484c c01fd11b c03dbad8
c01fc755 d4bd494c c01fc790 d4bd494c c01fc790 
Jul  5 17:57:39 localhost kernel:        c01fd11b c03dbad8 c01fc755
d5fe6d4c c01fc790 d5fe6d4c c01fc790 c01fd11b 
Jul  5 17:57:39 localhost kernel: Call Trace:
Jul  5 17:57:39 localhost kernel:  [<c01fc735>]
kobject_cleanup+0x35/0x90
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fd11b>] kref_put+0x2b/0x80
Jul  5 17:57:39 localhost kernel:  [<c01fc755>]
kobject_cleanup+0x55/0x90
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fd11b>] kref_put+0x2b/0x80
Jul  5 17:57:39 localhost kernel:  [<c01fc755>]
kobject_cleanup+0x55/0x90
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fd11b>] kref_put+0x2b/0x80
Jul  5 17:57:39 localhost kernel:  [<c01fc755>]
kobject_cleanup+0x55/0x90
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fd11b>] kref_put+0x2b/0x80
Jul  5 17:57:39 localhost kernel:  [<c01fc755>]
kobject_cleanup+0x55/0x90
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fd11b>] kref_put+0x2b/0x80
Jul  5 17:57:39 localhost kernel:  [<c01fc755>]
kobject_cleanup+0x55/0x90
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fd11b>] kref_put+0x2b/0x80
Jul  5 17:57:39 localhost kernel:  [<c01fc755>]
kobject_cleanup+0x55/0x90
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fc790>] kobject_release+0x0/0x10
Jul  5 17:57:39 localhost kernel:  [<c01fd11b>] kref_put+0x2b/0x80
Jul  5 17:57:39 localhost kernel:  [<e085512c>]
scsi_device_put+0x3c/0x80 [scsi_mod]
Jul  5 17:57:39 localhost kernel:  [<e082f141>] scsi_disk_put+0x41/0x60
[sd_mod]
Jul  5 17:57:39 localhost kernel:  [<e082f872>] sd_release+0x62/0x80
[sd_mod]
Jul  5 17:57:39 localhost kernel:  [<c017834b>] blkdev_put+0x16b/0x1b0
Jul  5 17:57:39 localhost kernel:  [<c0178320>] blkdev_put+0x140/0x1b0
Jul  5 17:57:39 localhost kernel:  [<c0175f2a>]
deactivate_super+0x9a/0xc0
Jul  5 17:57:39 localhost kernel:  [<c018def9>] sys_umount+0x39/0x80
Jul  5 17:57:39 localhost kernel:  [<c0104451>] syscall_call+0x7/0xb
Jul  5 17:57:39 localhost kernel: Code: 89 7c 24 08 89 6c 24 0c 74 34 9c
5d fa 8b 15 90 7a 4e c0 8d 80 00 00 00 40 c1 e8 0c 8d 04 40 c1 e0 04 8b
7c 10 28 e8 47 bc 0a 00 <8b> 1c 87 8b 03 3b 43 04 73 1c 89 74 83 24 40
89 03 55 9d 8b 1c

I need help in understanding why is the crash happening in
scsi_device_put. Is it due to the order in which the USB bus resources
are released (hcd is removed) and USB key is unmounted? If yes, how can
I prevent this from happening?

I am not subscribed to this list. Please do cc your comments to me.

Thanks for your time and help.

-Deepti 

