Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932340AbVLNWDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932340AbVLNWDH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932445AbVLNWDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:03:07 -0500
Received: from main.gmane.org ([80.91.229.2]:8404 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932340AbVLNWDG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:03:06 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Erik Meitner <e.spambo1.meitner@willystreet.coop>
Subject: Megaraid abort errors
Date: Wed, 14 Dec 2005 15:45:55 -0600
Message-ID: <dnq3qj$hu5$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host-216-153-255-187.mil.choiceone.net
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a server(SuperMicro SuperServer SS5033C-T) with an
LSI Logic MegaRAID SATA 150-6 card with three ~300Gb disks in a RAID-5
array.

About every 1 to 2 weeks the SCSI driver for the Megaraid card will
cease operating and the system will then require a hard reboot. Logs and
details below. Please let me know if there is any other information that
may help in troubleshooting this.

0000:03:04.0 0104: 11ab:5041
0000:03:02.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID
(rev 01)
        Subsystem: LSI Logic / Symbios Logic MegaRAID SATA 150-6 RAID
Controller
        Flags: bus master, 66MHz, slow devsel, latency 32, IRQ 9
        Memory at fa100000 (32-bit, prefetchable) [size=64K]
        Expansion ROM at fa110000 [disabled] [size=64K]
        Capabilities: <available only to root>

Kernel: plain 2.6.14 (The machine was previously running 2.4.31, same
problem there too.)

CONFIG_MEGARAID_NEWGEN=y
CONFIG_MEGARAID_MM=y
CONFIG_MEGARAID_MAILBOX=y
# CONFIG_MEGARAID_SAS is not set

megaraid cmm: 2.20.2.6 (Release Date: Mon Mar 7 00:01:03 EST 2005)
megaraid: 2.20.4.6 (Release Date: Mon Mar 07 12:27:22 EST 2005)
megaraid: probe new device 0x1000:0x1960:0x1000:0x0523: bus 3:slot 2:func 0
megaraid: fw version:[713N] bios version:[G119]

This is a backup server ustilizing BackupPC and sda7 is a 541Gb
partition for the data pool. A backup was running at the time the crash
ocurred - so the disk was probably fairly busy.

The syslog lines below are prefixed with the number of times they repeated.

1 Dec 14 12:13:27 backup kernel: megaraid: aborting-19463252 cmd=2a <c=1
t=0 l=0>
1 Dec 14 12:16:27 backup kernel: megaraid abort: 19463252:30[255:128],
fw owner
1 Dec 14 12:16:27 backup kernel: megaraid: reseting the host...
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:180
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:175
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:170
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:165
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:160
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:155
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:150
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:145
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:140
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:135
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:130
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:125
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:120
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:115
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:110
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:105
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:100
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:95
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:90
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:85
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:80
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:75
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:70
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:65
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:60
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:55
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:50
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:45
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:40
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:35
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:30
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:25
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:20
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:15
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:10
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:5
1 Dec 14 12:16:27 backup kernel: megaraid mbox: Wait for 1 commands to
complete:0
1 Dec 14 12:16:27 backup kernel: megaraid mbox: critical hardware error!
2 Dec 14 12:16:27 backup kernel: megaraid: reseting the host...
1 Dec 14 12:16:27 backup kernel: end_request: I/O error, dev sda, sector
844780536
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 103153671
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
1 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: EXT3-fs error (device sda7):
ext3_get_inode_loc: unable to read inode block - inode=34309482,
block=68485123
1 Dec 14 12:16:27 backup kernel: Aborting journal on device sda7.
2 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 80917086
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
1 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 81576239
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 81576240
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
1 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 126164332
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 126164333
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 126164334
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 126164335
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 126164336
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
1 Dec 14 12:16:27 backup kernel: Buffer I/O error on device sda7,
logical block 126164337
1 Dec 14 12:16:27 backup kernel: lost page write due to I/O error on sda7
19 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: Aborting journal on device sda1.
1 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: Aborting journal on device sda5.
1 Dec 14 12:16:27 backup kernel: __journal_remove_journal_head: freeing
b_frozen_data
1 Dec 14 12:16:27 backup kernel: EXT3-fs error (device sda5):
ext3_find_entry: reading directory #270913 offset 0
1 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: ext3_abort called.
1 Dec 14 12:16:27 backup kernel: EXT3-fs error (device sda5):
ext3_journal_start_sb: Detected aborted journal
1 Dec 14 12:16:27 backup kernel: Remounting filesystem read-only
1 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: ext3_abort called.
1 Dec 14 12:16:27 backup kernel: EXT3-fs error (device sda7):
ext3_journal_start_sb: Detected aborted journal
1 Dec 14 12:16:27 backup kernel: Remounting filesystem read-only
2 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: EXT3-fs error (device sda5) in
ext3_reserve_inode_write: Journal has aborted
3 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
1 Dec 14 12:16:27 backup kernel: EXT3-fs error (device sda7):
ext3_find_entry: reading directory #20240930 offset 1
2 Dec 14 12:16:27 backup kernel: scsi0 (0:0): rejecting I/O to offline
device
(and so on...until system was rebooted)

Thanks.


