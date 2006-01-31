Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750736AbWAaKbm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750736AbWAaKbm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 05:31:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbWAaKbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 05:31:41 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:54001 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750736AbWAaKbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 05:31:41 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 31 Jan 2006 11:30:18 +0100
To: schilling@fokus.fraunhofer.de, j@bitron.ch
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43DF3C3A.nail2RF112LAB@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <200  <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
In-Reply-To: <1138642683.7404.31.camel@juerg-pd.bitron.ch>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jürg Billeter <j@bitron.ch> wrote:

> Hi JÃ¶rg
>
> On Mon, 2006-01-30 at 12:43 +0100, Joerg Schilling wrote:
> > > Hm, this ATAPI stuff makes me a headache. Well, anyway, out of 
> > > curiosity, what is an ATAPI drive (IDE-ATAPI) supposed to return when asked 
> > > for bus number, id or lun - independent of OS and/or cdrecord?
> > 
> > The drive does not return this information, but the SCSI subsystem creates
> > these instance numbers. A SCSI drive (like a CD/DVD burner) is supposed to
> > be known to the SCSI sub-system and thus needs to have a SCSI subsystem
> > related instance number.
>
> Whenever someone talks about ATAPI drives, you respond with
> s/ATAPI/SCSI/. Why do you insist that every transport should be used as
> it was a SCSI bus? ATAPI drives use the same SCSI command set as SCSI
> drives do, but that won't change the fact that ATAPI drives are not
> connected to a SCSI bus.

Well, this is simple: it is SCSI.

When SCSI started from modifying the SASI (Shugart Asociated System Interface)
system around 1984 and at that time come with it's own transport only
(a 50 wire cable), this did change soon (around 1986) by introducing
transports that use one or two 68 wire cable(s) (16 resp. 32 Bit SCSI).

Around 1990, even this did change while ATAPI (ATA Packet Interface) was
introduced. 

Around 1995, the T10 standard group (SCSI) did split up the SCSI standard
into a transport specific part and a protocol specific part. SCSI is now using
many different transport mechanisms.

This is a list of some known SCSI transports: 
 
	-	Good old Parallel SCSI 50/68 pin (what most people call SCSI) 
	-	SCSI over fiber optics (e.g. FACL - there are others too) 
	-	SCSI over a copper variant of FCAL (used in modern servers) 
	-	SCSI over IEEE 1394 (Fire Wire) 
	-	SCSI over USB 
	-	SCSI over IDE/ATA (ATAPI) 
	-	SCSI over TCI/IP (iSCSI)
	-	SCSI over SSCSI (see below)

SCSI over Serial SCSI cabling uses the same transport (cable type) as SATA uses.
If you buy a SATA HBA card for your PC, you may connect SSCSI & SATA
disks to this HBA using the same cables and connectors.

So the circle is closing again....


> It makes sense to address parallel SCSI devices via target id. If an
> operating system likes to simulate virtual SCSI buses for other bus
> types as well, ok, I have no objections. But if the operating system
> doesn't like to simulate virtual SCSI buses and allows applications to
> address devices by a filename, you should have no objections, too.

It seems that you missunderstand this. No operating system uses file names
internally. OS instead typically handle SCSI devices that are not connected
via an arbitraring Bus like the "Good old Parallel SCSI 50/68 pin" system
by asuming they are all on separate SCSI busses that only have one single drive 
conected each.

What Linux does is to artificially prevent this view to been seen from outside the
Linux kernel, or to avoid integrating a particular device into a unique SCSI
driver system although it would be apropriate.

Users like to be able to get a list of posible targets for a single protocol.
Nobody would ever think about trying to prevent people from getting a unified
view on the list possible hosts that talk TCP/IP. What cdrecord does with
-scanbus is nothing really different. 

In addition, nobody would ever think about implementing a separate TCP/IP stack 
for network interfaces that are PPP connections via a modem vs. network 
interfaces that go via a Ethernet adaptor. Nobody would ever try to convince
me that you could save code in the kernel by avoiding the usual network stack 
as a specific machine may not have Ethernet but a Modem connection only.

So why do people try to convince me that there is a need to avoid the standard 
SCSI protocol stack because a PC might have only ATAPI? 

Major OS implementations use a unique view on SCSI (MS-win [*], FreeBSD, Solaris, 
...). Why do people believe that Linux needs to be different? What does it buy 
you to go this way?


*] MS-WIN-NT even includes SCSI emulation (it allows you to connect to the
SCSI subsystem, set the Address and use SCSI commands from a limited list
to read/write sector from ATA only hard disks).

If the Linux folks could give technical based explanations for the questions 
from above and if they would create a new completely orthogonal view on SCSI [*]
I had no problem. But up to now, the only answer was: "We do it this 
way because we do it this way". 

*] Note that this would need to implement SCSI Generic support for drives that
have no native driver in the system.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
