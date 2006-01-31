Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWAaMcw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWAaMcw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:32:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750787AbWAaMcw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:32:52 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:40317 "EHLO xsmtp1.ethz.ch")
	by vger.kernel.org with ESMTP id S1750786AbWAaMcw convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:32:52 -0500
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
From: Juerg Billeter <j@bitron.ch>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: mrmacman_g4@mac.com, matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jengelh@linux01.gwdg.de, James@superbug.co.uk, acahalan@gmail.com
In-Reply-To: <43DF3C3A.nail2RF112LAB@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
	 <43D7A7F4.nailDE92K7TJI@burner>
	 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
	 <43D7B1E7.nailDFJ9MUZ5G@burner>
	 <20060125230850.GA2137@merlin.emma.line.org>
	 <43D8C04F.nailE1C2X9KNC@burner> <200  <43DDFBFF.nail16Z3N3C0M@burner>
	 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
	 <43DF3C3A.nail2RF112LAB@burner>
Content-Type: text/plain; charset=UTF-8
Date: Tue, 31 Jan 2006 13:32:44 +0100
Message-Id: <1138710764.17338.47.camel@juerg-t40p.bitron.ch>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 8BIT
X-OriginalArrivalTime: 31 Jan 2006 12:32:45.0559 (UTC) FILETIME=[70132070:01C62662]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for your detailed response.

On Die, 2006-01-31 at 11:30 +0100, Joerg Schilling wrote:
> Jürg Billeter <j@bitron.ch> wrote:
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

Are you sure about that? I don't doubt that many operating systems
handle all devices, that are able to understand the SCSI command set,
exactly as you describe it, but Linux doesn't assume such separate
virtual SCSI buses for non good old Parallel SCSI drives, not even
internally, as far as I understand it. Of course it doesn't use file
names internally, it uses major and minor numbers, but that shouldn't
matter, the major and minor numbers get exported to userspace via sysfs.

> 
> What Linux does is to artificially prevent this view to been seen from outside the
> Linux kernel, or to avoid integrating a particular device into a unique SCSI
> driver system although it would be apropriate.

That's the point where you're not quite right, if I understand it
correctly. The Linux kernel does not artificially prevent userspace
applications viewing virtual SCSI buses, these virtual SCSI buses don't
exist internally in the Linux kernel at all. So Linux doesn't
artificially prevent anything, it just doesn't artificially _create_
virtual SCSI buses.


> Users like to be able to get a list of posible targets for a single protocol.
> Nobody would ever think about trying to prevent people from getting a unified
> view on the list possible hosts that talk TCP/IP. What cdrecord does with
> -scanbus is nothing really different. 

Well, please show me how to get the list of all possible hosts that talk
TCP/IP and are directly or indirectly connected to my computer. As my
computer is attached to the internet, the list would get pretty long...
And even if only considering hosts in the local network, how do you get
a unified view of all TCP/IP hosts conected to any of my two network
adapters?


> So why do people try to convince me that there is a need to avoid the standard 
> SCSI protocol stack because a PC might have only ATAPI? 
> 
> Major OS implementations use a unique view on SCSI (MS-win [*], FreeBSD, Solaris, 
> ...). Why do people believe that Linux needs to be different? What does it buy 
> you to go this way?

Why do you believe that Linux needs to do the same as every other OS?
I'd agree with you if Linux would violate a standard but AFAIK the bus
view with target ids is not part of the ATAPI or a dependant standard.
Please correct me if I'm wrong but the bus/target/lun combination is
only a standard for some SCSI transports, at least it is for good old
Parallel SCSI, yes, but SCSI over ATA doesn't define target-based
addressing.

> *] MS-WIN-NT even includes SCSI emulation (it allows you to connect to the
> SCSI subsystem, set the Address and use SCSI commands from a limited list
> to read/write sector from ATA only hard disks).

Great, I have no objections but you shouldn't mandate the Linux kernel
developers to implement a copy of implementations other operating
systems provide. If the virtual SCSI bus and/or full SCSI emulation
would be part of POSIX or an other standard Linux tries to follow, Linux
should implement it, of course, but last time I checked, it's not in
POSIX.

> 
> If the Linux folks could give technical based explanations for the questions 
> from above and if they would create a new completely orthogonal view on SCSI [*]
> I had no problem. But up to now, the only answer was: "We do it this 
> way because we do it this way". 

Linux' device nodes is such an orthogonal view that should include all
devices able to speak SCSI among others. Enumeration is possible via
sysfs (low-level) or much easier via the userspace HAL library from
freedesktop.org.

> 
> *] Note that this would need to implement SCSI Generic support for drives that
> have no native driver in the system.

If there is a device that supports the SCSI command set and the device
can't be accessed with SG_IO in linux, I'd call this a Linux kernel bug.
You mentioned ATAPI tapes before; if that's really the case, it's a
Linux bug, yes, but it seems that nobody cares about speaking SCSI with
these device types. That happens in projects with limited resources.

My point is that this shouldn't matter to cdrecord. It does matter to
tape drive applications that use libscg, of course. File a bug in
bugzilla about that and if ATAPI tapes are important to a Linux
developer, he will probably implement it. But a Linux bug affecting some
device or bus types doesn't automatically mean that the whole Linux
kernel device addressing is broken by design.

Jürg

-- 
Juerg Billeter <j@bitron.ch>

