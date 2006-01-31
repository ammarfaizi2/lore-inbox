Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750780AbWAaMKn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750780AbWAaMKn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:10:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbWAaMKn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:10:43 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:35590 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750781AbWAaMKm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:10:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nUFy+A/BJ0X0ENmMgR+qi4wXWC9dsy/GFP7Qh3V4U9gJReMhv3Z/ipGCZ4nE3Ka6NXtAHkyrBPHnRnAAXNAMAsil775vRkXSLkmU2lr3IKDZcR50AOt0SFoBcFb+66vU8eDJcroU/5N9tYmR1r4RzaKd0/Tt7kBFqWYT9BdFFbE=
Message-ID: <58cb370e0601310410r46210e8dvc66f631f208e9b8d@mail.gmail.com>
Date: Tue, 31 Jan 2006 13:10:39 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: j@bitron.ch, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jengelh@linux01.gwdg.de,
       James@superbug.co.uk, acahalan@gmail.com
In-Reply-To: <43DF3C3A.nail2RF112LAB@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7A7F4.nailDE92K7TJI@burner>
	 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	 <43D7B1E7.nailDFJ9MUZ5G@burner>
	 <20060125230850.GA2137@merlin.emma.line.org>
	 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
	 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
	 <43DF3C3A.nail2RF112LAB@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> Jürg Billeter <j@bitron.ch> wrote:
>
> > Hi JÃ¶rg
> >
> > On Mon, 2006-01-30 at 12:43 +0100, Joerg Schilling wrote:
> > > > Hm, this ATAPI stuff makes me a headache. Well, anyway, out of
> > > > curiosity, what is an ATAPI drive (IDE-ATAPI) supposed to return when asked
> > > > for bus number, id or lun - independent of OS and/or cdrecord?
> > >
> > > The drive does not return this information, but the SCSI subsystem creates
> > > these instance numbers. A SCSI drive (like a CD/DVD burner) is supposed to
> > > be known to the SCSI sub-system and thus needs to have a SCSI subsystem
> > > related instance number.
> >
> > Whenever someone talks about ATAPI drives, you respond with
> > s/ATAPI/SCSI/. Why do you insist that every transport should be used as
> > it was a SCSI bus? ATAPI drives use the same SCSI command set as SCSI
> > drives do, but that won't change the fact that ATAPI drives are not
> > connected to a SCSI bus.
>
> Well, this is simple: it is SCSI.
>
> When SCSI started from modifying the SASI (Shugart Asociated System Interface)
> system around 1984 and at that time come with it's own transport only
> (a 50 wire cable), this did change soon (around 1986) by introducing
> transports that use one or two 68 wire cable(s) (16 resp. 32 Bit SCSI).
>
> Around 1990, even this did change while ATAPI (ATA Packet Interface) was
> introduced.
>
> Around 1995, the T10 standard group (SCSI) did split up the SCSI standard
> into a transport specific part and a protocol specific part. SCSI is now using
> many different transport mechanisms.
>
> This is a list of some known SCSI transports:
>
>         -       Good old Parallel SCSI 50/68 pin (what most people call SCSI)
>         -       SCSI over fiber optics (e.g. FACL - there are others too)
>         -       SCSI over a copper variant of FCAL (used in modern servers)
>         -       SCSI over IEEE 1394 (Fire Wire)
>         -       SCSI over USB
>         -       SCSI over IDE/ATA (ATAPI)
>         -       SCSI over TCI/IP (iSCSI)
>         -       SCSI over SSCSI (see below)
>
> SCSI over Serial SCSI cabling uses the same transport (cable type) as SATA uses.
> If you buy a SATA HBA card for your PC, you may connect SSCSI & SATA
> disks to this HBA using the same cables and connectors.
>
> So the circle is closing again....
>
>
> > It makes sense to address parallel SCSI devices via target id. If an
> > operating system likes to simulate virtual SCSI buses for other bus
> > types as well, ok, I have no objections. But if the operating system
> > doesn't like to simulate virtual SCSI buses and allows applications to
> > address devices by a filename, you should have no objections, too.
>
> It seems that you missunderstand this. No operating system uses file names
> internally. OS instead typically handle SCSI devices that are not connected
> via an arbitraring Bus like the "Good old Parallel SCSI 50/68 pin" system
> by asuming they are all on separate SCSI busses that only have one single drive
> conected each.
>
> What Linux does is to artificially prevent this view to been seen from outside the
> Linux kernel, or to avoid integrating a particular device into a unique SCSI
> driver system although it would be apropriate.
>
> Users like to be able to get a list of posible targets for a single protocol.
> Nobody would ever think about trying to prevent people from getting a unified
> view on the list possible hosts that talk TCP/IP. What cdrecord does with
> -scanbus is nothing really different.

Yes and it is Linux limitation (lets face it).   There are 2 problems:

* no generic block layer transport infrastructure so that you cannot
  specify in the low-level driver which transport types your device does
  support (this information would be exported to the applications).

  Jens, maybe sysfs attribute "transports" will be sufficient so that
  application  can use libsysfs to get full list of devices supporting "SCSI"
  transport (/dev/hd* is fine with this scheme).  Does it make sense?
  Having block layer sysfs attributes for device type (disk, tape, cd etc)
  would have additional bonus of not needing to inquire wrong device
  types.  This would probably simplify other applications (HAL?).
  [ These are just quick ideas... ]

  Joerg, I don't see any sense in providing users with fake SCSI
  lun and bus numbers for ATAPI devices.  I think that what users
  would like is the list of devices consisting of "fd" and actual vendor
  name of device (+ optionally serial no + optionally "x:y:z" for real
  SCSI).  Nobody wants to see some artificial "x:y:z" for her/his
  ATAPI device (it has always annoyed me in Windows), not to say
  that the majority of desktop users have absolutely no idea of meaning
  of these numbers.

* ide-* drivers for ATAPI devices are needed (some devices just doesn't
  work with ide-scsi ATM) so please accept this fact that we cannot just
  now simply switch over everything to using ide-scsi and we have to use
  SG_IO ioctl for ide-cd (and ide-{floppy,tape} if anybody cares to add
  support for it).  I'm not saying this won't change in future but this requires
  doing actual work and people seem to be more interested in discussing
  stupid naming issues than doing it so...

> In addition, nobody would ever think about implementing a separate TCP/IP stack
> for network interfaces that are PPP connections via a modem vs. network
> interfaces that go via a Ethernet adaptor. Nobody would ever try to convince
> me that you could save code in the kernel by avoiding the usual network stack
> as a specific machine may not have Ethernet but a Modem connection only.
>
> So why do people try to convince me that there is a need to avoid the standard
> SCSI protocol stack because a PC might have only ATAPI?

SCSI protocol stack is far too Parallel SCSI centric (vide SAS flamewar).
Once again this is Linux problem which will get fixed with time or will fix
itself if we switch to libata for PATA.

> Major OS implementations use a unique view on SCSI (MS-win [*], FreeBSD, Solaris,
> ...). Why do people believe that Linux needs to be different? What does it buy
> you to go this way?

Linux needs to be better, no? ;-)

> *] MS-WIN-NT even includes SCSI emulation (it allows you to connect to the
> SCSI subsystem, set the Address and use SCSI commands from a limited list
> to read/write sector from ATA only hard disks).
>
> If the Linux folks could give technical based explanations for the questions
> from above and if they would create a new completely orthogonal view on SCSI [*]
> I had no problem. But up to now, the only answer was: "We do it this
> way because we do it this way".

The answer is - we do this this way because of historical reasons and we
simply lack resources to change it immediately (be it your "everything is
SCSI" or mine "block layer devices claiming supported transport types").

Please also note things don't change because you say so - they require
somebody doing actual work and work/time is not free (despite what some
people think).  If you think that badmouthing Linux will motivate people to
work, you are wrong (it has the opposite effect of time wasting flamewars).

I would like you to ask to remove warnings from about /dev/hd* interface
from cdrecored - they are just confusing users.  This is the current way
of doing things in Linux and applications have to deal with it for now.

Thanks,
Bartlomiej

> *] Note that this would need to implement SCSI Generic support for drives that
> have no native driver in the system.
