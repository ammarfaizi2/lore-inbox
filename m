Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTK0B0W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 20:26:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTK0B0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 20:26:22 -0500
Received: from smtp804.mail.ukl.yahoo.com ([217.12.12.141]:54661 "HELO
	smtp804.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S264419AbTK0B0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 20:26:20 -0500
Subject: Re: Beaver In Detox AND IEEE1394 badness message
From: James J Myers <myersjj@pacbell.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069896372.1329.4.camel@jjmhome>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 26 Nov 2003 17:26:12 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re this problem: I just installed Arjan's test11 kernel and I can still
see only 1 of 3 firewire devices on my system (gscanbus sees all 3 and I
see from log messages that at least part of the code sees more than 1).
But /proc/scsi/scsi only has: 
cat /proc/scsi/scsi
Attached devices:
Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: Maxtor   Model: 5000XT           Rev: 0100
  Type:   Direct-Access                    ANSI SCSI revision: 06

I also see these slab errors. Relevant parts of dmesg output are:

SCSI subsystem initialized
ohci1394: $Rev: 1045 $ Ben Collins <bcollins@debian.org>
ohci1394_0: Unexpected PCI resource length of 1000!
ohci1394_0: OHCI-1394 1.0 (PCI): IRQ=[9]  MMIO=[cf001000-cf0017ff]  Max
Packet=[1024]
sbp2: $Rev: 1034 $ Ben Collins <bcollins@debian.org>
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
Freeing unused kernel memory: 132k freed
ieee1394: ConfigROM quadlet transaction error for node 0-00:1023
ieee1394: Host added: ID:BUS[0-01:1023]  GUID[0090a94000003903]
ieee1394: Node added: ID:BUS[0-02:1023]  GUID[0010b920007a2273]
ieee1394: Node added: ID:BUS[0-03:1023]  GUID[0001f30240001be7]
ieee1394: The root node is not cycle master capable; selecting a new
root node and resetting...
ieee1394: ConfigROM quadlet transaction error for node 0-00:1023
ieee1394: Node changed: 0-02:1023 -> 0-01:1023
ieee1394: Node changed: 0-03:1023 -> 0-02:1023
ieee1394: Node changed: 0-01:1023 -> 0-03:1023
scsi0 : SCSI emulation for IEEE-1394 SBP-2 Devices
EXT3 FS on hda3, internal journal
Adding 1309256k swap on /dev/hda5.  Priority:-1 extents:1
ieee1394: sbp2: Logged into SBP-2 device
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hdb2, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
Slab corruption: start=297d5758, expend=297d57b7, problemat=297d5788
Last user: [<2a8ab100>](free_hpsb_packet+0x1d/0x22 [ieee1394])
Data: ************************************************D5 D6 D6 D6 01 00
00 00 ***************************************A5 
Next: 71 F0 2C .00 B1 8A 2A 71 F0 2C .....................
slab error in check_poison_obj(): cache `hpsb_packet': object was
modified after freeing
Call Trace:
 [<0213307d>] check_poison_obj+0x132/0x13a
 [<021330b9>] slab_destroy+0x34/0x156
 [<02134eb2>] reap_timer_fnc+0x134/0x190
 [<02134d7e>] reap_timer_fnc+0x0/0x190
 [<02121249>] run_timer_softirq+0x119/0x139
 [<0210d42a>] handle_IRQ_event+0x27/0x4a
 [<0211decd>] do_softirq+0x45/0x87
 [<0210d6c4>] do_IRQ+0xdf/0xe9
 [<02107000>] _stext+0x0/0x19
 [<02107000>] _stext+0x0/0x19
 [<0210a0cf>] default_idle+0x23/0x26
 [<0210a120>] cpu_idle+0x1f/0x34
 [<023185bb>] start_kernel+0x15e/0x162


