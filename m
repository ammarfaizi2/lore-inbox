Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270299AbRIHU02>; Sat, 8 Sep 2001 16:26:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270773AbRIHU0T>; Sat, 8 Sep 2001 16:26:19 -0400
Received: from mailout03.sul.t-online.com ([194.25.134.81]:44814 "EHLO
	mailout03.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S270299AbRIHU0L>; Sat, 8 Sep 2001 16:26:11 -0400
Message-ID: <3B9A7EBB.E73115AC@t-online.de>
Date: Sat, 08 Sep 2001 22:25:31 +0200
From: SPATZ1@t-online.de (Frank Schneider)
X-Mailer: Mozilla 4.76 [de] (X11; U; Linux 2.4.3-test i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: AIC + RAID1 error? (was: Re: aic7xxx errors)
In-Reply-To: <200109050621.f856LAK00824@ambassador.mathewson.int> <3B95DB22.866EDCA3@mediascape.de> <3B992EC4.ED1F82CB@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Zaplinski schrieb:
> 
> Olaf Zaplinski wrote:
> >
> > Joseph Mathewson wrote:
> > >
> > > I've just woken up this morning to find my internet gateway machine only
> > > responding to pings, and on giving it a keyboard & monitor, a load of
> > >
> > > scsi0:0:1:0: Attempting to queue an ABORT message
> > > scsi0:0:1:0: Cmd aborted from QINFIFO
> > > aic7xxx_abort returns 8194
> > >
> > > errors.
> > [...]
> >
> > /me too. I had this while booting 2.4.9 with a fresh installed SCSI card
> > (AHA2940) + harddisk. What worked for me was to compile the kernel with the
> > old Adaptec driver, so it's a driver issue.
> 

Hello...

I encounter a likely similar problem at the moment with aic7xxx and
RAID5:

I run a RAID5-Array on three SCSI-Disks, all IBM, all LVD on the
AIC7xxx-Controller on the Mobo (ASUS-P2B-DS)...and from time to time
(usually about once per week) always the same partition of the RAID5
gets a readerror and falls out of the array:

-------------------------
Sep  8 20:49:31 falcon kernel: SCSI disk error : host 0 channel 0 id 0
lun 0 return code = 8000002
Sep  8 20:49:31 falcon kernel: [valid=0] Info fld=0x0, Current sd08:04:
sense key Hardware Error
Sep  8 20:49:31 falcon kernel: Additional sense indicates Internal
target failure
Sep  8 20:49:31 falcon kernel:  I/O error: dev 08:04, sector 8545688
Sep  8 20:49:31 falcon kernel: raid5: Disk failure on sda4, disabling
device. Operation continuing on 2 devices
Sep  8 20:49:31 falcon kernel: md: recovery thread got woken up ...
Sep  8 20:49:31 falcon kernel: md0: no spare disk to reconstruct array!
-- continuing in degraded mode
Sep  8 20:49:31 falcon kernel: md: recovery thread finished ...
Sep  8 20:49:31 falcon kernel: md: updating md0 RAID superblock on
device
Sep  8 20:49:31 falcon kernel: sdc1 [events: 000000be](write) sdc1's sb
offset:
8707072
Sep  8 20:49:32 falcon kernel: sdb1 [events: 000000be](write) sdb1's sb
offset:
8707072
Sep  8 20:49:32 falcon kernel: (skipping faulty sda4 )
Sep  8 20:49:32 falcon kernel: .
----------------------------

Ok, i also thought: "Bad disk" and to verify this (i have still
guarantee on the drive) i formated it, let the AIC-BIOS do a "remap of
bad blocks" and ran "badblocks" about 5 times on it with the
"-w"-option...last but not least i copied over 160GB from and to the
drive over two days...nothing, not a single failure of the drive...today
i re-integrated the disk in my array, and got already the first
fall-off.

I now switched also to the old aic7xxx driver, only to get an idea where
to seek the problem...in the raid-code, in the driver or somewhere
else...

Solong..
Frank.

--
Frank Schneider, <SPATZ1@T-ONLINE.DE>.                           
Microsoft isn't the answer.
Microsoft is the question, and the answer is NO.
... -.-
