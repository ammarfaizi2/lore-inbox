Return-Path: <linux-kernel-owner+w=401wt.eu-S1752028AbWLSOYU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752028AbWLSOYU (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 09:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbWLSOYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 09:24:20 -0500
Received: from aun.it.uu.se ([130.238.12.36]:36659 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752028AbWLSOYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 09:24:19 -0500
Date: Tue, 19 Dec 2006 15:24:07 +0100 (MET)
Message-Id: <200612191424.kBJEO7bD007303@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: Roel.Teuwen@advalvas.be, greg@wildbrain.com
Subject: Re: SATA300 TX4 + WD2500KS = status=0x50 { DriveReady SeekComplete }
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc: linux-ide added)

On Tue, 19 Dec 2006 12:26:07 +0100, Roel Teuwen wrote:
> I am seeing the exact same 'problem'. I have 4 WDC WD2500KS-00MJB0
> drives connected to a promise SATA300 TX4. The messages have been
> flooding syslog since the drives were installed. Running 2.6.18 or
> 2.6.19 vanilla kernels.
> 
> Best regards,
> 
> Roel Teuwen
> 
> On 10/25/06, Gregory Brauer <greg@wildbrain.com> wrote:
> >
> > I have a new Promise SATA300 TX4 4-port SATA controller
> > to which I have attached two older WD2500JD hard drives
> > and two brand new WD2500KS hard drives.  The older drives
> > seem to work fine, but both of the brand new hard drives
> > trigger the following errors every few seconds during
> > i/o:
> >
> >
> > Oct 25 13:57:18 gleep kernel: ata3: no sense translation for status: 0x50
> > Oct 25 13:57:18 gleep kernel: ata3: translated ATA stat/err 0x50/00 to SCSI
> > SK/ASC/ASCQ 0xb/00/00
> > Oct 25 13:57:18 gleep kernel: ata3: status=0x50 { DriveReady SeekComplete }
> > Oct 25 13:57:26 gleep kernel: ata1: no sense translation for status: 0x50
> > Oct 25 13:57:26 gleep kernel: ata1: translated ATA stat/err 0x50/00 to SCSI
> > SK/ASC/ASCQ 0xb/00/00
> > Oct 25 13:57:26 gleep kernel: ata1: status=0x50 { DriveReady SeekComplete }
> > Oct 25 13:57:27 gleep kernel: ata1: no sense translation for status: 0x50
> > Oct 25 13:57:27 gleep kernel: ata1: translated ATA stat/err 0x50/00 to SCSI
> > SK/ASC/ASCQ 0xb/00/00
> > Oct 25 13:57:27 gleep kernel: ata1: status=0x50 { DriveReady SeekComplete }
> > Oct 25 13:57:31 gleep kernel: ata1: no sense translation for status: 0x50
> > Oct 25 13:57:31 gleep kernel: ata1: translated ATA stat/err 0x50/00 to SCSI
> > SK/ASC/ASCQ 0xb/00/00
> > Oct 25 13:57:31 gleep kernel: ata1: status=0x50 { DriveReady SeekComplete }
> > Oct 25 13:57:47 gleep kernel: ata3: no sense translation for status: 0x50
> > Oct 25 13:57:47 gleep kernel: ata3: translated ATA stat/err 0x50/00 to SCSI
> > SK/ASC/ASCQ 0xb/00/00
> > Oct 25 13:57:47 gleep kernel: ata3: status=0x50 { DriveReady SeekComplete }
> >
> >
> > The machine stays running normally, and any processes doing data
> > I/O do not pause noticeably, but these errors are very annoying.
> > Is there anything I can do to help troubleshoot this?
> >
> > (Note that I am aware of the drive id mapping issue with my Promise
> > controller, and I am *positive* that it is the two new drives that
> > are the one's that the error messages refer to.)

If you move the disks around, do the errors stay on the same ports (ata1/ata3),
or do they move to different ports (ata2/ata4)?

I was looking briefly at the port mapping issue on 4-port Promise controllers
yesterday and noticed a bit of programming magic in Promise's driver that
Linux doesn't do, and which affects two of the four ports. That _could_
explain your issues.

/Mikael
