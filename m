Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030357AbWAXN7H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030357AbWAXN7H (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 08:59:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbWAXN7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 08:59:06 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:63428 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1030357AbWAXN7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 08:59:05 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 24 Jan 2006 14:58:03 +0100
To: rlrevell@joe-job.com, matthias.andree@gmx.de
Cc: schilling@fokus.fraunhofer.de, linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest) (was: 
 Rationale for RLIMIT_MEMLOCK?)
Message-ID: <43D6326B.nailCGG41YZCG@burner>
References: <20060123105634.GA17439@merlin.emma.line.org>
 <1138014312.2977.37.camel@laptopd505.fenrus.org>
 <20060123165415.GA32178@merlin.emma.line.org>
 <1138035602.2977.54.camel@laptopd505.fenrus.org>
 <20060123180106.GA4879@merlin.emma.line.org>
 <1138039993.2977.62.camel@laptopd505.fenrus.org>
 <20060123185549.GA15985@merlin.emma.line.org>
 <43D530CC.nailC4Y11KE7A@burner> <1138048255.21481.15.camel@mindpipe>
 <20060123212119.GI1820@merlin.emma.line.org>
In-Reply-To: <20060123212119.GI1820@merlin.emma.line.org>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:

> Of course, I think it's sensible to expect that Linux should adhere to
> standards (POSIX) as far as possible, and if any precedent
> implementations that are standards-conformant are found, I'd suggest
> that Linux adheres to their interpretation, too, to reduce the clutter
> and make applications more easily ported to Linux. We'll all benefit.

With respect to SCSI transport, it would also make sense tolook at the 
implementations of various other platforms.


> LIST 1 # REQUIREMENTS
>
> R1 I'll just say we all want cdrecord, dvd recording applications and
> similar to work without setuid root flags or sudo or other excessive
> privilege escalation. (This needs to be split up into I/O access
> privileges, device enumeration, buffer allocation, real-time
> requirements such as locking buffers into memory, scheduling and so on.)

With fine grained privileges and a nice inherent user level framework, this 
kind of problems should not apear inside cdrecord at all.


> LIST 2 # CURRENT STATE
>
> S1 Jörg is unhappy with /dev/hd* because he says that it is inferior to
> the sg-access via ide-scsi. (I believe the original issues were
> DMA-based, and I don't know the details.) I hope Jörg will fill in the
> operations that ide-cd (/dev/hd*) lacks. (Jörg, please don't talk about
> layer violations here).

One original issue was that ide-scsi did cause a kernel panic in case it
was used on top of PCMCIA based ATA.

The other issue is that ide-scsi does not do DMA in case DMA-size is not
a multiple of 512 while is is needed for any size % 4 == 0;
or at least size % 8 == 0


> S2 Jörg is concerned about the SCSI command filter being too
> restrictive. I'm not sure if it still applies to 2.6.16-rc and what the
> exact commands in question were. I'll let Jörg complete this list.

If this change had been announced early anough and if there was a workaround,
there would be no problem. The problem was that someone has a bad dream and
incompatibly changed the Linux kernel over night while cdrecord was in code 
freeze. Later I was called unflexible because I did follow the well known 
quality ensuring rules that are in effect short before a new stable/final 
released is published.


> S3 Device enumeration/probing is a sore spot. Unprivileged "cdrecord
> dev=ATA: -scandisk" doesn't work, and recent discussions on the cdwrite@
> list didn't make any progress. My observation is that cdrecord stops
> probing /dev/hd* devices as soon as one yields EPERM, on the assumption
> "if I cannot access /dev/hda, I will not have sufficient privilege to
> write a CD anyways". I find this wrong, Jörg finds it correct and argues
> "if you can access /dev/hdc as unprivileged user, that's a security
> problem".

This are two problems:

-	users of cdrecord like to run cdrecord -scanbus in order to find all
	SCSI devices. This no longer works since the non-orthogonal /dev/hd* 
	SCSI transport has been added.

	As Linux already implements a Generic SCSI transport interface 
	(/dev/sg*) people would asume to be able to talk to _all_ SCSI devices
	using this interface. To allows this, there is a need for a 
	SCSI HBA driver that sends SCSI commands via a ATA interface.

-	some people seem to set the permissions of some of the /dev/hd* 
	nodes to unsafe values and then complain that the other /dev/hd* 
	nodes cannot be opened.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
