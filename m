Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbTK2Sxc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 13:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTK2Sxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 13:53:32 -0500
Received: from cs2417481-26.houston.rr.com ([24.174.81.26]:10633 "EHLO
	dmdtech.org") by vger.kernel.org with ESMTP id S262056AbTK2Sx3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 13:53:29 -0500
Message-ID: <010901c3b6aa$20796cb0$1e01a8c0@dmdtech2>
From: "Darren Dupre" <darren@dmdtech.org>
To: <linux-kernel@vger.kernel.org>
References: <009201c3b6a6$f8e7e800$1e01a8c0@dmdtech2>
Subject: Re: "DV failed to configure device" for Quantum DLT4000 tape drive on Adaptec 2940UW, 2.6.0-test11
Date: Sat, 29 Nov 2003 12:53:50 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The backup just finished.. I unloaded the modules (doing "rmmod st aic7xxx"
exactly like that)

Now the kernel barfs this out at me (again, this is 2.6.0-test11)  right as
or after I unload the modules:

Nov 29 12:47:49 dmdtech kernel: st: Unloaded.
Nov 29 12:47:49 dmdtech kernel: bad: scheduling while atomic!
Nov 29 12:47:49 dmdtech kernel: Call Trace:
Nov 29 12:47:49 dmdtech kernel:  [<c0119963>] schedule+0x563/0x570
Nov 29 12:47:49 dmdtech kernel:  [<c0118b9e>] try_to_wake_up+0x9e/0x160
Nov 29 12:47:49 dmdtech kernel:  [<c0108076>] __down+0x96/0x110
Nov 29 12:47:49 dmdtech kernel:  [<c01199d0>] default_wake_function+0x0/0x20
Nov 29 12:47:49 dmdtech kernel:  [<c01082ac>] __down_failed+0x8/0xc
Nov 29 12:47:49 dmdtech kernel:  [<e0904480>]
.text.lock.aic7xxx_osm+0x19/0x99 [aic7xxx]
Nov 29 12:47:49 dmdtech kernel:  [<e09061e8>] ahc_linux_exit+0x28/0x82
[aic7xxx]
Nov 29 12:47:49 dmdtech kernel:  [<c0131e9c>] sys_delete_module+0x14c/0x1b0
Nov 29 12:47:49 dmdtech kernel:  [<c0144fca>] do_munmap+0x14a/0x190
Nov 29 12:47:49 dmdtech kernel:  [<c010935b>] syscall_call+0x7/0xb
Nov 29 12:47:49 dmdtech kernel:
Nov 29 12:47:49 dmdtech kernel: bad: scheduling while atomic!
Nov 29 12:47:49 dmdtech kernel: Call Trace:
Nov 29 12:47:49 dmdtech kernel:  [<c0119963>] schedule+0x563/0x570
Nov 29 12:47:49 dmdtech kernel:  [<c0134a24>]
__remove_from_page_cache+0x24/0x70
Nov 29 12:47:49 dmdtech kernel:  [<c013da18>] __pagevec_release+0x28/0x40
Nov 29 12:47:49 dmdtech kernel:  [<c013e004>]
truncate_inode_pages+0xf4/0x2c0
Nov 29 12:47:49 dmdtech kernel:  [<c015e003>] cached_lookup+0x23/0x90
Nov 29 12:47:49 dmdtech kernel:  [<c015f062>] __lookup_hash+0x72/0xe0
Nov 29 12:47:49 dmdtech kernel:  [<c016a59e>]
generic_delete_inode+0xfe/0x110
Nov 29 12:47:49 dmdtech kernel:  [<c016a782>] iput+0x62/0x80
Nov 29 12:47:49 dmdtech kernel:  [<c016767f>] dput+0xff/0x220
Nov 29 12:47:49 dmdtech kernel:  [<c018233d>]
sysfs_hash_and_remove+0x4d/0x7d
Nov 29 12:47:49 dmdtech kernel:  [<c01e8f25>] class_device_dev_unlink+0x25/0
x30
Nov 29 12:47:49 dmdtech kernel:  [<c01e9315>] class_device_del+0x75/0xb0
Nov 29 12:47:49 dmdtech kernel:  [<c01e9363>]
class_device_unregister+0x13/0x30
Nov 29 12:47:49 dmdtech kernel:  [<c0210055>] scsi_remove_device+0x45/0x80
Nov 29 12:47:49 dmdtech kernel:  [<c020f5ca>] scsi_forget_host+0x4a/0x90
Nov 29 12:47:49 dmdtech kernel:  [<c0209a4b>] scsi_remove_host+0x2b/0x60
Nov 29 12:47:49 dmdtech kernel:  [<e08ff211>] ahc_platform_free+0x141/0x160
[aic7xxx]
Nov 29 12:47:49 dmdtech kernel:  [<e08f160f>] ahc_free+0xbf/0x130 [aic7xxx]
Nov 29 12:47:49 dmdtech kernel:  [<e09051ea>]
ahc_linux_pci_dev_remove+0x6a/0xa0 [aic7xxx]
Nov 29 12:47:49 dmdtech kernel:  [<c01aa28b>] pci_device_remove+0x3b/0x40
Nov 29 12:47:49 dmdtech kernel:  [<c01e8614>]
device_release_driver+0x64/0x70
Nov 29 12:47:49 dmdtech kernel:  [<c01e8640>] driver_detach+0x20/0x30
Nov 29 12:47:49 dmdtech kernel:  [<c01e886d>] bus_remove_driver+0x3d/0x80
Nov 29 12:47:49 dmdtech kernel:  [<c01e8cc3>] driver_unregister+0x13/0x28
Nov 29 12:47:49 dmdtech kernel:  [<c01aa422>]
pci_unregister_driver+0x12/0x20
Nov 29 12:47:49 dmdtech kernel:  [<e090540f>] ahc_linux_pci_exit+0xf/0x20
[aic7xxx]
Nov 29 12:47:50 dmdtech kernel:  [<e090620e>] ahc_linux_exit+0x4e/0x82
[aic7xxx]
Nov 29 12:47:50 dmdtech kernel:  [<c0131e9c>] sys_delete_module+0x14c/0x1b0
Nov 29 12:47:50 dmdtech kernel:  [<c0144fca>] do_munmap+0x14a/0x190
Nov 29 12:47:50 dmdtech kernel:  [<c010935b>] syscall_call+0x7/0xb
Nov 29 12:47:50 dmdtech kernel:
Nov 29 12:47:50 dmdtech kernel: bad: scheduling while atomic!
Nov 29 12:47:50 dmdtech kernel: Call Trace:
Nov 29 12:47:50 dmdtech kernel:  [<c0119963>] schedule+0x563/0x570
Nov 29 12:47:50 dmdtech kernel:  [<c0119caf>] wait_for_completion+0x8f/0xe0
Nov 29 12:47:50 dmdtech kernel:  [<c01199d0>] default_wake_function+0x0/0x20
Nov 29 12:47:50 dmdtech kernel:  [<c01199d0>] default_wake_function+0x0/0x20
Nov 29 12:47:50 dmdtech kernel:  [<c0209c21>]
scsi_host_dev_release+0x81/0x90
Nov 29 12:47:50 dmdtech kernel:  [<c01e7320>] device_release+0x20/0x80
Nov 29 12:47:50 dmdtech kernel:  [<c01a478a>] kobject_del+0x5a/0x70
Nov 29 12:47:50 dmdtech kernel:  [<c01a448a>] unlink+0x7a/0x80
Nov 29 12:47:50 dmdtech kernel:  [<c01a48a0>] kobject_cleanup+0x80/0x90
Nov 29 12:47:50 dmdtech kernel:  [<e08ff225>] ahc_platform_free+0x155/0x160
[aic7xxx]
Nov 29 12:47:50 dmdtech kernel:  [<e08f160f>] ahc_free+0xbf/0x130 [aic7xxx]
Nov 29 12:47:50 dmdtech kernel:  [<e09051ea>]
ahc_linux_pci_dev_remove+0x6a/0xa0 [aic7xxx]
Nov 29 12:47:50 dmdtech kernel:  [<c01aa28b>] pci_device_remove+0x3b/0x40
Nov 29 12:47:50 dmdtech kernel:  [<c01e8614>]
device_release_driver+0x64/0x70
Nov 29 12:47:50 dmdtech kernel:  [<c01e8640>] driver_detach+0x20/0x30
Nov 29 12:47:50 dmdtech kernel:  [<c01e886d>] bus_remove_driver+0x3d/0x80
Nov 29 12:47:50 dmdtech kernel:  [<c01e8cc3>] driver_unregister+0x13/0x28
Nov 29 12:47:50 dmdtech kernel:  [<c01aa422>]
pci_unregister_driver+0x12/0x20
Nov 29 12:47:50 dmdtech kernel:  [<e090540f>] ahc_linux_pci_exit+0xf/0x20
[aic7xxx]
Nov 29 12:47:50 dmdtech kernel:  [<e090620e>] ahc_linux_exit+0x4e/0x82
[aic7xxx]
Nov 29 12:47:50 dmdtech kernel:  [<c0131e9c>] sys_delete_module+0x14c/0x1b0
Nov 29 12:47:50 dmdtech kernel:  [<c0144fca>] do_munmap+0x14a/0x190
Nov 29 12:47:50 dmdtech kernel:  [<c010935b>] syscall_call+0x7/0xb
Nov 29 12:47:50 dmdtech kernel:

if it helps, here is the entry for the SCSI card from /proc/pci:

 Bus  0, device  12, function  0:
    SCSI storage controller: Adaptec AHA-2940U/UW/D / AIC (rev 0).
      IRQ 16.
      Master Capable.  Latency=64.  Min Gnt=8.Max Lat=8.
      I/O at 0xdc00 [0xdcff].
      Non-prefetchable 32 bit memory at 0xdbfef000 [0xdbfeffff].

