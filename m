Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266522AbUHBNqk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUHBNqk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 09:46:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266521AbUHBNqk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 09:46:40 -0400
Received: from smtp800.mail.sc5.yahoo.com ([66.163.168.179]:44708 "HELO
	smtp800.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266522AbUHBNpL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 09:45:11 -0400
From: tabris <tabris@tabris.net>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-cd problems
Date: Mon, 2 Aug 2004 09:45:02 -0400
User-Agent: KMail/1.6.1
Cc: Jens Axboe <axboe@suse.de>, "Alexander E. Patrakov" <patrakov@ums.usu.ru>
References: <20040730193651.GA25616@bliss> <cehqak$1pq$1@sea.gmane.org> <20040801155753.GA13702@suse.de>
In-Reply-To: <20040801155753.GA13702@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_eVkDBa+k/s0gGob"
Message-Id: <200408020945.05297.tabris@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_eVkDBa+k/s0gGob
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 01 August 2004 11:57 am, Jens Axboe wrote:
> On Sun, Aug 01 2004, Alexander E. Patrakov wrote:
> > Zinx Verituse wrote:
> > >I don't believe command filtering is neccessary, since all of the
> > >ide-cd ioctls are still there (ioctls that allow playing, reading,
> > > etc) Only the SG_IO ioctl itself would have to be checked (i.e.,
> > > not each individual command available with SG_IO, just the
> > > overall ioctl itself, categorizing all of SG_IO more or less as
> > > raw IO.  If this isn't doable with the current design, then the
> > > ide-cd interface should at least be very conspicuously documented
> > > as being extremely insecure as far as "read" access is concerned,
> > > as I know I wouldn't expect users to be able to overwrite my
> > > drive's firmware simply by granting the read access.
> >
> > Remember that it is still possible to write CDs through ide-cd in
> > 2.4.x using some pre-alpha code in cdrecord:
> >
> > cdrecord dev=3DATAPI:1,1,0 image.iso
>
> (don't trim cc lists on linux-kernel!)
>
> Don't ever use that interface, period. It's not just the cdrecord
> code that may be alpha (I doubt it matters, it's easy to use), the
> interface it uses is not worth the lines of code it occupies.
	Then we have a severe disagreement between the cdrecord code (or at=20
least the runtime warnings) and the Linux-Kernel IDE folks.=20
specifically, these lines, while running with cdrecord dev=3D/dev/cdrom

scsidev: '/dev/cdrom'
devname: '/dev/cdrom'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.

	I've attached two logs, one using the ATAPI interface, one using your=20
suggested interface. Frankly, both have rather nasty warnings on them,=20
and one gets to wondering what the cdrecord authors want...

	Maybe we should be cc:ing the authors of cdrecord as well?

=2D --
tabris
=2D -
Remember, Grasshopper, falling down 1000 stairs begins by tripping over
the first one.
		-- Confusion
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBDkVf1U5ZaPMbKQcRAukeAJ9y33IURJFheeJ39rtvJXHI6Ii5AwCgihup
Vo50HwMaGJe53L/zPFayGEY=3D
=3Dudwi
=2D----END PGP SIGNATURE-----

--Boundary-00=_eVkDBa+k/s0gGob
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="cdrecord-ATAPI.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="cdrecord-ATAPI.log"

cdrecord: No write mode specified.
cdrecord: Asuming -tao mode.
cdrecord: Future versions of cdrecord may have different drive dependent defaults.
scsidev: 'ATAPI:0,0,0'
devname: 'ATAPI'
scsibus: 0 target: 0 lun: 0
Warning: Using ATA Packet interface.
Warning: The related libscg interface code is in pre alpha.
Warning: There may be fatal problems.
SCSI buffer size: 64512
Cdrecord-Clone 2.01a27-dvd (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to <warly@mandrakesoft.com>.
Note: The author of cdrecord should not be bothered with problems in this version.
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.8'.
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   : 
Vendor_info    : 'TDK     '
Identifikation : 'CDRW241040B     '
Revision       : '57S2'
Device seems to be: Generic mmc CD-RW.
Current: 0x0009
Profile: 0x000A 
Profile: 0x0009 (current)
Profile: 0x0008 
Profile: 0x0002 (current)
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Drive buf size : 1966272 = 1920 KB
FIFO size      : 4194304 = 4096 KB

--Boundary-00=_eVkDBa+k/s0gGob
Content-Type: text/x-log;
  charset="iso-8859-1";
  name="cdrecord.log"
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment;
	filename="cdrecord.log"

cdrecord: No write mode specified.
cdrecord: Asuming -tao mode.
cdrecord: Future versions of cdrecord may have different drive dependent defaults.
scsidev: '/dev/cdrom'
devname: '/dev/cdrom'
scsibus: -2 target: -2 lun: -2
Warning: Open by 'devname' is unintentional and not supported.
Linux sg driver version: 3.5.27
cdrecord: Warning: using inofficial libscg transport code version (warly-scsi-linux-sg.c-1.80-mdk '@(#)scsi-linux-sg.c	1.80 04/03/08 Copyright 1997 J. Schilling').
SCSI buffer size: 64512
Cdrecord-Clone 2.01a27-dvd (i686-pc-linux-gnu) Copyright (C) 1995-2004 Jörg Schilling
Note: This version is an unofficial (modified) version with DVD support
Note: and therefore may have bugs that are not present in the original.
Note: Please send bug reports or support requests to <warly@mandrakesoft.com>.
Note: The author of cdrecord should not be bothered with problems in this version.
TOC Type: 1 = CD-ROM
Using libscg version 'schily-0.8'.
atapi: 1
Device type    : Removable CD-ROM
Version        : 0
Response Format: 2
Capabilities   : 
Vendor_info    : 'TDK     '
Identifikation : 'CDRW241040B     '
Revision       : '57S2'
Device seems to be: Generic mmc CD-RW.
Current: 0x0009
Profile: 0x000A 
Profile: 0x0009 (current)
Profile: 0x0008 
Profile: 0x0002 (current)
Using generic SCSI-3/mmc   CD-R/CD-RW driver (mmc_cdr).
Driver flags   : MMC-3 SWABAUDIO BURNFREE 
Supported modes: TAO PACKET SAO SAO/R96P SAO/R96R RAW/R16 RAW/R96P RAW/R96R
Drive buf size : 1966272 = 1920 KB
FIFO size      : 4194304 = 4096 KB
Track 01: data   405 MB        
Total size:      466 MB (46:10.90) = 207818 sectors
Lout start:      466 MB (46:12/68) = 207818 sectors
Current Secsize: 2048
ATIP info from disk:
  Indicated writing power: 4
  Is not unrestricted
  Is not erasable
  Disk sub type: Medium Type A, high Beta category (A+) (3)
  ATIP start of lead in:  -11849 (97:24/01)
  ATIP start of lead out: 359848 (79:59/73)
Disk type:    Long strategy type (Cyanine, AZO or similar)
Manuf. index: 25
Manufacturer: Taiyo Yuden Company Limited
Blocks total: 359848 Blocks current: 359848 Blocks remaining: 152030
Starting to write CD/DVD at speed   8.0 in dummy TAO mode for single session.
Last chance to quit, starting dummy write in 9 seconds.   8 seconds.cdrecord: fifo had 64 puts and 0 gets.
cdrecord: fifo was 0 times empty and 1 times full, min fill was 0%.

--Boundary-00=_eVkDBa+k/s0gGob--
