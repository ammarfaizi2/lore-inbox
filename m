Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751928AbWCEXTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751928AbWCEXTr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 18:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWCEXTq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 18:19:46 -0500
Received: from lucidpixels.com ([66.45.37.187]:15064 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1751306AbWCEXTp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 18:19:45 -0500
Date: Sun, 5 Mar 2006 18:19:42 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Mark Lord <lkml@rtr.ca>
cc: David Greaves <david@dgreaves.com>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
In-Reply-To: <440B6D83.1070900@rtr.ca>
Message-ID: <Pine.LNX.4.64.0603051816340.5169@p34>
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com>
 <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca>
 <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca>
 <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca>
 <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com>
 <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com>
 <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca>
 <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca>
 <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com>
 <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603050637110.30164@p34>
 <Pine.LNX.4.64.0603050740500.3116@p34> <440B6CFE.4010503@rtr.ca>
 <440B6D83.1070900@rtr.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Mar 2006, Mark Lord wrote:

> Mark Lord wrote:
>> Justin Piszcz wrote:
>>>
>>>> Using 2.6.16-rc5-git4 and removing a directory of around 5.0GB of 
files
>>>> while streaming a 1MB/s video stream on another (SATA disk), the I/O
>>>> seemed to freeze up for a moment and I got this error:
>>>>
>>>> [4342671.839000] ata1: command 0x35 timeout, stat 0x50 host_stat 0x22
>>>>
>>>> Only 1 in dmesg, any idea what causes this error?
>>>
>>> The drive it occured on was a 74GB raptor on an ICH5 controller.
>>>
>>> [4294673.245000]   Vendor: ATA       Model: WDC WD740GD-00FL  Rev: 
33.0
>>> 0000:00:1f.2 IDE interface: Intel Corporation 82801EB (ICH5) SATA
>>> Controller (rev 02)
>>
>> SCSI opcode 0x35 is SYNCHRONIZE_CACHE.
>
> Oh, wait a sec.. on that path, libata actually does show the ATA opcode,
> which would have been WRITE_DMA_EXT.  Not an FUA command.
>
> Dunno what it's complaining about, though.
>

Well I know what it was now...

The hard drive (RAPTOR/74GB failed)...

[4294685.928000] process `syslogd' is using obsolete setsockopt 
SO_BSDCOMPAT
[4342671.839000] ata1: command 0x35 timeout, stat 0x50 host_stat 0x22
[4347012.243000] ata1: command 0x25 timeout, stat 0x50 host_stat 0x20
[4347157.486000] ata1: command 0x25 timeout, stat 0x80 host_stat 0x22
[4347157.486000] ata1: translated ATA stat/err 0x80/00 to SCSI SK/ASC/ASCQ 
0xb/4
7/00
[4347157.486000] ata1: status=0x80 { Busy }
[4347157.486000] sd 0:0:0:0: SCSI error: return code = 0x8000002
[4347157.486000] sda: Current: sense key=0xb
[4347157.486000]     ASC=0x47 ASCQ=0x0
[4347157.486000] end_request: I/O error, dev sda, sector 27646928
[4347157.486000] Buffer I/O error on device sda, logical block 3455866
[4347157.486000] ATA: abnormal status 0x80 on port 0xC007
[4347157.486000] ATA: abnormal status 0x80 on port 0xC007
[4347157.486000] ATA: abnormal status 0x80 on port 0xC007
[4347187.486000] ata1: command 0x25 timeout, stat 0x50 host_stat 0x21
[4347407.657000] ATA: abnormal status 0x80 on port 0xC007
[4347407.657000] ATA: abnormal status 0x80 on port 0xC007
[4347407.657000] ATA: abnormal status 0x80 on port 0xC007
[4347437.656000] ata1: command 0x35 timeout, stat 0x80 host_stat 0x21
[4347437.656000] ata1: translated ATA stat/err 0x80/00 to SCSI SK/ASC/ASCQ 
0xb/4
7/00
[4347437.656000] ata1: status=0x80 { Busy }
[4347437.656000] sd 0:0:0:0: SCSI error: return code = 0x8000002
[4347437.656000] sda: Current: sense key=0xb
[4347437.656000]     ASC=0x47 ASCQ=0x0
[4347437.656000] end_request: I/O error, dev sda, sector 76339746
[4347437.656000] ATA: abnormal status 0x80 on port 0xC007
[4347437.656000] ATA: abnormal status 0x80 on port 0xC007
[4347437.656000] ATA: abnormal status 0x80 on port 0xC007
[4347467.656000] ata1: command 0x35 timeout, stat 0x50 host_stat 0x21
[4347467.656000] Device sda2 - XFS write error in file system meta-data 
block 0x
449af90 in sda2
[4347467.656000] ata1: command 0x35 timeout, stat 0x50 host_stat 0x21
[4347467.656000] Device sda2 - XFS write error in file system meta-data 
block 0x
449af90 in sda2
[4347497.656000] ata1: command 0x25 timeout, stat 0x50 host_stat 0x21
[4347527.663000] ata1: command 0x25 timeout, stat 0x50 host_stat 0x22
[4347527.663000] Unable to handle kernel paging request at virtual address 
858f9
a70
[4347527.663000]  printing eip:
[4347527.663000] c021ff87
[4347527.663000] *pde = 00000000
[4347527.663000] Oops: 0000 [#1]
[4347527.663000] PREEMPT SMP
[4347527.663000] CPU:    0
[4347527.663000] EIP:    0060:[<c021ff87>]    Not tainted VLI
[4347527.663000] EFLAGS: 00210282   (2.6.16-rc5-git4 #3)
[4347527.663000] EIP is at xfs_dir2_block_lookup_int+0xb0/0x1e9
[4347527.663000] eax: 9b86a560   ebx: 00000000   ecx: cdc352b0   edx: 
00000000
[4347527.663000] esi: 177504f0   edi: 5e5cb7f4   ebp: 00000000   esp: 
f6c8bd18
[4347527.663000] ds: 007b   es: 007b   ss: 0068
[4347527.663000] Process nfsd (pid: 1359, threadinfo=f6c8a000 
task=f7c14030)
[4347527.663000] Stack: <0>00000000 c91fa944 00000000 021a0480 00000000 
f6c8bd64
  00000000 f6c8bd84
[4347527.663000]        f6c8bd88 f6c8bdac c73e7438 f6f916c0 00000004 
f7dbc800 00
000000 f3aa2000
[4347527.663000]        61a5869b c91fa9ac f7db9380 c73e7438 00000000 
c91fa944 f6
c8bdac 00000000
[4347527.663000] Call Trace:
[4347527.663000]  [<c02200da>] xfs_dir2_block_lookup+0x1a/0xa1
[4347527.663000]  [<c021f721>] xfs_dir2_lookup+0xd3/0x151
[4347527.663000]  [<c035e9d3>] ip_output+0x171/0x2de
[4347527.663000]  [<c035e1c9>] ip_finish_output+0x0/0x22d
[4347527.663000]  [<c024e836>] xfs_dir_lookup_int+0x40/0x125
[4347527.663000]  [<c0150b0d>] cache_alloc_refill+0xf1/0x50c
[4347527.663000]  [<c0252b39>] xfs_lookup+0x5f/0x88
[4347527.663000]  [<c02613cc>] linvfs_lookup+0x52/0x99
[4347527.663000]  [<c0161563>] __lookup_hash+0xc4/0xf3
[4347527.663000]  [<c016160f>] lookup_one_len+0x7d/0x84
[4347527.663000]  [<c01ad6c7>] nfsd_lookup+0xc0/0x4b2
[4347527.663000]  [<c01b4bcd>] nfsd3_proc_lookup+0xa5/0xf3
[4347527.663000]  [<c01a9497>] nfsd_dispatch+0x9c/0x214
[4347527.663000]  [<c039fb21>] svc_process+0x3bf/0x69e
[4347527.663000]  [<c01a97bc>] nfsd+0x1ad/0x331
[4347527.663000]  [<c01a960f>] nfsd+0x0/0x331
[4347527.663000]  [<c0100e95>] kernel_thread_helper+0x5/0xb
[4347527.663000] Code: 89 44 24 40 89 c2 0f ca 8d 04 d5 00 00 00 00 29 c6 
8d 42
ff 8b 4c 24 24 8b 79 14 31 d2 eb 07 8d 51 01 39 c2 7f 17 8d 0c 02 d1 f9 
<8b> 1c
ce 0f cb 39 df 74 2a 77 e9 8d 41 ff 39 c2 7e e9 8b 74 24
[4347527.663000]
[4347527.663000]  <4>ATA: abnormal status 0x80 on port 0xC007
[4347567.674000] ATA: abnormal status 0x80 on port 0xC007
[4347567.674000] ATA: abnormal status 0x80 on port 0xC007
[4347597.674000] ata1: command 0x35 timeout, stat 0x80 host_stat 0x21
[4347597.674000] ata1: translated ATA stat/err 0x80/00 to SCSI SK/ASC/ASCQ 
0xb/4
7/00
[4347597.674000] ata1: status=0x80 { Busy }
[4347597.674000] sd 0:0:0:0: SCSI error: return code = 0x8000002
[4347597.674000] sda: Current: sense key=0xb
[4347597.674000]     ASC=0x47 ASCQ=0x0
[4347597.674000] end_request: I/O error, dev sda, sector 4401810
[4347597.674000] ATA: abnormal status 0x80 on port 0xC007
[4347597.674000] ATA: abnormal status 0x80 on port 0xC007
[4347597.674000] ATA: abnormal status 0x80 on port 0xC007
[4347627.674000] ata1: command 0x35 timeout, stat 0x80 host_stat 0x21
[4347627.674000] ata1: translated ATA stat/err 0x80/00 to SCSI SK/ASC/ASCQ 
0xb/4
7/00
[4347627.674000] ata1: status=0x80 { Busy }
[4347627.674000] sd 0:0:0:0: SCSI error: return code = 0x8000002
[4347627.674000] sda: Current: sense key=0xb
[4347627.674000]     ASC=0x47 ASCQ=0x0
[4347627.674000] end_request: I/O error, dev sda, sector 110074018
[4347627.674000] ATA: abnormal status 0x80 on port 0xC007
[4347627.674000] ATA: abnormal status 0x80 on port 0xC007
[4347627.674000] ATA: abnormal status 0x80 on port 0xC007

..

ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
     ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66006018
Buffer I/O error on device sda2, logical block 61604208
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
     ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66006019
Buffer I/O error on device sda2, logical block 61604209
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
     ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66006020
Buffer I/O error on device sda2, logical block 61604210
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
     ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66006021
Buffer I/O error on device sda2, logical block 61604211
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
     ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66006018
Buffer I/O error on device sda2, logical block 61604208
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x40 { UncorrectableError }
SCSI error : <0 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
     ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66006019

..

I later ran mkfs.ext2 -c /dev/sda and it kept returning errors such as 
these:

ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
ata3: status=0x51 { DriveReady SeekComplete Error }
ata3: error=0x40 { UncorrectableError }
SCSI error : <2 0 0 0> return code = 0x8000002
sda: Current: sense key=0x3
     ASC=0x11 ASCQ=0x4
end_request: I/O error, dev sda, sector 66006016

I ran WD's tool on the drive, it confirmed it had problems.

Luckily I have a spare raptor and restored from backup and I am now back 
up and running with no errors yet.

Justin.

