Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268231AbUHQNWi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268231AbUHQNWi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 09:22:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268230AbUHQNWi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 09:22:38 -0400
Received: from vsmtp12.tin.it ([212.216.176.206]:44250 "EHLO vsmtp12.tin.it")
	by vger.kernel.org with ESMTP id S268239AbUHQNVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 09:21:08 -0400
Subject: Re: 2.6.8.1-mm1
From: Frediano Ziglio <freddyz77@tin.it>
To: Christoph Hellwig <hch@infradead.org>, petero2@telia.com, axboe@suse.de,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040816224749.A15510@infradead.org>
References: <20040816143710.1cd0bd2c.akpm@osdl.org>
	 <20040816224749.A15510@infradead.org>
Content-Type: text/plain
Message-Id: <1092748824.4253.10.camel@freddy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 17 Aug 2004 15:20:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il lun, 2004-08-16 alle 23:47, Christoph Hellwig ha scritto:
> On Mon, Aug 16, 2004 at 02:37:10PM -0700, Andrew Morton wrote:
> > - The packet-writing patches should be ready to go, but I haven't even
> >   looked at them yet, and am not sure that anyone else has reviewed the code.
> 
> It's still messing with the elevator setting directly which is a no-go.
> That's not the packet-writing drivers fault but needs solving first.
> 

I tried 2.6.8.1-mm1 ASAP and DVD+/-RW works very well.
I even used two drives together (a CD writer and a DVD writer).

Compiling kernel (using 2.6.8.1 + Petero Patch, cd not used) I got this
error using mkinitrd

Unable to handle kernel NULL pointer dereference at virtual address
00000050
 printing eip:
e0abd8a6
*pde = 00000000
Oops: 0000 [#1]
Modules linked in: loop ext3 jbd nls_iso8859_1 nls_cp437 vfat fat floppy
ipv6 parport_pc lp parport autofs4 sunrpc
forcedeth 3c59x ipt_REJECT ipt_state ip_conntrack iptable_filter
ip_tables dm_mod usblp ohci_hcd ehci_hcd button battery asus_acpi ac
reiserfs aic7xxx sd_mod scsi_mod
CPU:    0
EIP:    0060:[<e0abd8a6>]    Not tainted
EFLAGS: 00010286   (2.6.8)
EIP is at lo_open+0x6/0x30 [loop]
eax: 00000000   ebx: dc8eec00   ecx: e0abd8a0   edx: deef3560
esi: dff5ea00   edi: dff5ea00   ebp: e0abec00   esp: d00abf10
ds: 007b   es: 007b   ss: 0068
Process nash (pid: 4595, threadinfo=d00aa000 task=deea37b0)
Stack: c0156119 c0155cff c0155c10 dff5ea0c deef3560 00000000 deef3560
c9595a0c
       dff5ea00 d535fbcc c01563f5 deef3560 c9595a0c dff63f20 c014e6c6
ffffffe9
       d00abf68 00000000 d1056000 d00aa000 c014e5bc d00abf68 d535fbcc
dff63f20
Call Trace:
 [<c0156119>] do_open+0xe9/0x300
 [<c0155cff>] bdget+0xdf/0xf0
 [<c0155c10>] bdev_set+0x0/0x10
 [<c01563f5>] blkdev_open+0x25/0x60
 [<c014e6c6>] dentry_open+0x106/0x1a0
 [<c014e5bc>] filp_open+0x4c/0x50
 [<c014e788>] get_unused_fd+0x28/0xb0
 [<c014e8ad>] sys_open+0x4d/0xa0
 [<c0105d29>] sysenter_past_esp+0x52/0x71
Code: 8b 40 50 8b 40 38 8d 88 08 01 00 00 ff 88 08 01 00 00 0f 88

I got some error using cdrwtool (it seems to send an ABORT, perhaps
cause it expect that recorder write at 12x ?? I have a 2x CD
rewriter...). I don't know it this information it's useful

scsi0:0:5:0: Attempting to queue an ABORT message
CDB: 0x25 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0 0x0
scsi0: At time of recovery, card was not paused
>>>>>>>>>>>>>>>>>> Dump Card State Begins <<<<<<<<<<<<<<<<<
scsi0: Dumping Card State in Message-in phase, at SEQADDR 0x43
Card was paused
ACCUM = 0x0, SINDEX = 0x3, DINDEX = 0x8c, ARG_2 = 0x0
HCNT = 0x0 SCBPTR = 0x0
SCSISIGI[0x0] ERROR[0x0] SCSIBUSL[0x0] LASTPHASE[0xe0]
SCSISEQ[0x12] SBLKCTL[0x2] SCSIRATE[0x0] SEQCTL[0x10]
SEQ_FLAGS[0x0] SSTAT0[0x5] SSTAT1[0xa] SSTAT2[0x0]
SSTAT3[0x0] SIMODE0[0x0] SIMODE1[0xa4] SXFRCTL0[0x80]
DFCNTRL[0x0] DFSTATUS[0x29]
STACK: 0x0 0x150 0xf3 0xed
SCB count = 4
Kernel NEXTQSCB = 3
Card NEXTQSCB = 2
QINFIFO entries: 2
Waiting Queue entries:
Disconnected Queue entries:
QOUTFIFO entries:
Sequencer Free SCB List: 0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15
Sequencer SCB Info:
  0 SCB_CONTROL[0xc0] SCB_SCSIID[0x57] SCB_LUN[0x0] SCB_TAG[0xff]
  1 SCB_CONTROL[0x88] SCB_SCSIID[0x37] SCB_LUN[0x0] SCB_TAG[0xff]
  2 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  3 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  4 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  5 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  6 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  7 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  8 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
  9 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 10 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 11 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 12 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 13 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 14 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
 15 SCB_CONTROL[0x0] SCB_SCSIID[0xff] SCB_LUN[0xff] SCB_TAG[0xff]
Pending list:
  2 SCB_CONTROL[0x40] SCB_SCSIID[0x57] SCB_LUN[0x0]
Kernel Free SCB list: 1 0
Untagged Q(5): 2
DevQ(0:3:0): 0 waiting
DevQ(0:5:0): 0 waiting

<<<<<<<<<<<<<<<<< Dump Card State Ends >>>>>>>>>>>>>>>>>>
scsi0:0:5:0: Cmd aborted from QINFIFO
aic7xxx_abort returns 0x2002

Trying to mount an iso cd with packet writing I got some warnings
(system continue to be stable)

cdrom: This disc doesn't have any tracks I recognize!
cdrom: This disc doesn't have any tracks I recognize!
cdrom: This disc doesn't have any tracks I recognize!
cdrom: This disc doesn't have any tracks I recognize!
cdrom: This disc doesn't have any tracks I recognize!
Device not ready.  Make sure there is a disc in the drive.
Device not ready.  Make sure there is a disc in the drive.
cdrom: This disc doesn't have any tracks I recognize!
pktcdvd: writer pktcdvd0 mapped to sr1
scsi0: ERROR on channel 0, id 5, lun 0, CDB: Read (10) 00 00 00 00 20 00
00 20 00
Info fld=0x20 (nonstd), Current sr1: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr1, sector 128
Buffer I/O error on device pktcdvd0, logical block 16
scsi0: ERROR on channel 0, id 5, lun 0, CDB: Read (10) 00 00 00 00 22 00
00 1e 00
Info fld=0x22 (nonstd), Current sr1: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr1, sector 136
Buffer I/O error on device pktcdvd0, logical block 17
SCSI error : <0 0 5 0> return code = 0x8000002
Info fld=0x0, Current sr1: sense key Aborted Command
end_request: I/O error, dev sr1, sector 144
Buffer I/O error on device pktcdvd0, logical block 18
scsi0: ERROR on channel 0, id 5, lun 0, CDB: Read (10) 00 00 00 00 26 00
00 1a 00
Info fld=0x26 (nonstd), Current sr1: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr1, sector 152
Buffer I/O error on device pktcdvd0, logical block 19
SCSI error : <0 0 5 0> return code = 0x8000002
Info fld=0x0, Current sr1: sense key Aborted Command
end_request: I/O error, dev sr1, sector 160
Buffer I/O error on device pktcdvd0, logical block 20
scsi0: ERROR on channel 0, id 5, lun 0, CDB: Read (10) 00 00 00 00 20 00
00 02 00
Info fld=0x20 (nonstd), Current sr1: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr1, sector 128
Buffer I/O error on device pktcdvd0, logical block 16
scsi0: ERROR on channel 0, id 5, lun 0, CDB: Read (10) 00 00 00 00 2a 00
00 16 00
Info fld=0x2a (nonstd), Current sr1: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr1, sector 168
Buffer I/O error on device pktcdvd0, logical block 21
scsi0: ERROR on channel 0, id 5, lun 0, CDB: Read (10) 00 00 00 00 2c 00
00 14 00
Info fld=0x2c (nonstd), Current sr1: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr1, sector 176
Buffer I/O error on device pktcdvd0, logical block 22
scsi0: ERROR on channel 0, id 5, lun 0, CDB: Read (10) 00 00 00 00 2e 00
00 12 00
Info fld=0x2e (nonstd), Current sr1: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr1, sector 184
Buffer I/O error on device pktcdvd0, logical block 23
...
scsi0: ERROR on channel 0, id 5, lun 0, CDB: Read (10) 00 00 00 00 3c 00
00 04 00
Info fld=0x3c (nonstd), Current sr1: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr1, sector 240
Buffer I/O error on device pktcdvd0, logical block 30
scsi0: ERROR on channel 0, id 5, lun 0, CDB: Read (10) 00 00 00 00 3e 00
00 02 00
Info fld=0x3e (nonstd), Current sr1: sense key Medium Error
Additional sense: No seek complete
end_request: I/O error, dev sr1, sector 248
Buffer I/O error on device pktcdvd0, logical block 31
pktcdvd: inserted media is CD-RW
pktcdvd: Fixed packets, 32 blocks, Mode-2 disc
pktcdvd: Max. media speed: 2
pktcdvd: write speed 2
pktcdvd: 549888kB available on disc
FAT: bogus number of reserved sectors
VFS: Can't find a valid FAT filesystem on dev pktcdvd0.

freddy77


