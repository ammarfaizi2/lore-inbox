Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932166AbVJKQMZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932166AbVJKQMZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 12:12:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932168AbVJKQMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 12:12:25 -0400
Received: from xproxy.gmail.com ([66.249.82.197]:47136 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932166AbVJKQMY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 12:12:24 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=MH8Z3qYa3H0CS7QaeElyexVpQ2gGSNgg+/r9Cugh4ygpOA8Y7PJz6NYboSjegr+iANdBX7lWknj7mhVESYrxpf2C1NK/HSlh5giYK+/JkSSEdo405LpG8ZQiQynqjmJX2es0NgvtJW9Kn+XUWos1wAHiuB6+SYhdnb2AtoufQCY=
Message-ID: <5bdc1c8b0510110912m1b564at3599e340726d9f77@mail.gmail.com>
Date: Tue, 11 Oct 2005 09:12:23 -0700
From: Mark Knecht <markknecht@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.14-rc4-rt1 - scsi_eh_4/7835[CPU#0]: BUG in __schedule at kernel/sched.c:3326
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Following on my report about not getting device names, they did start
showing up a bit later. That's a bit strange. There is a bug reported
in dmesg.

I'll send the kernel config if requested. Same as it's been for some days.

ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[66] 
MMIO=[da014000-da0147ff]  Max Packet=[4096]
sbp2: $Rev: 1306 $ Ben Collins <bcollins@debian.org>
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[0800286410000f43]
eth0: no IPv6 routers present
ieee1394: Error parsing configrom for node 0-00:1023
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[0050c504e0006463]
scsi4 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Error logging into SBP-2 device - login timed-out
prev->state: 2 != TASK_RUNNING??
scsi_eh_4/7835[CPU#0]: BUG in __schedule at kernel/sched.c:3326

Call Trace:<ffffffff80132221>{__WARN_ON+97} <ffffffff803e79f0>{__schedule+608}
       <ffffffff801342bf>{do_exit+1007}
<ffffffff801467c0>{keventd_create_kthread+0}
       <ffffffff8010e5ed>{child_rip+15}
<ffffffff801467c0>{keventd_create_kthread+0}
       <ffffffff801466b0>{kthread+0} <ffffffff8010e5de>{child_rip+0}

sbp2: probe of 0050c504e0006463-0 failed with error -16
ieee1394: Node added: ID:BUS[0-00:1023]  GUID[00303c020010645c]
ieee1394: Node changed: 0-00:1023 -> 0-01:1023
ieee1394: Node changed: 0-01:1023 -> 0-02:1023
scsi5 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-00:1023: Max speed [S800] - Max payload [4096]
  Vendor: Maxtor 6  Model: Y160P0            Rev: YAR4
  Type:   Direct-Access-RBC                  ANSI SCSI revision: 04
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
SCSI device sdb: 320173056 512-byte hdwr sectors (163929 MB)
sdb: asking for cache data failed
sdb: assuming drive cache: write through
 sdb: sdb1 sdb2
Attached scsi disk sdb at scsi5, channel 0, id 0, lun 0
scsi6 : SCSI emulation for IEEE-1394 SBP-2 Devices
ieee1394: sbp2: Logged into SBP-2 device
ieee1394: Node 0-01:1023: Max speed [S400] - Max payload [2048]
  Vendor: Maxtor 6  Model: Y160P0            Rev: YAR4
  Type:   Direct-Access-RBC                  ANSI SCSI revision: 04
SCSI device sdc: 320173056 512-byte hdwr sectors (163929 MB)
sdc: asking for cache data failed
sdc: assuming drive cache: write through
SCSI device sdc: 320173056 512-byte hdwr sectors (163929 MB)
sdc: asking for cache data failed
sdc: assuming drive cache: write through
 sdc: sdc1 sdc2 sdc3
Attached scsi disk sdc at scsi6, channel 0, id 0, lun 0
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Realtime LSM initialized (all groups, mlock=1)
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sdc3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
lightning ~ #
