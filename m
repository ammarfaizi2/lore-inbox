Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132916AbRARSPR>; Thu, 18 Jan 2001 13:15:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132902AbRARSPI>; Thu, 18 Jan 2001 13:15:08 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:57351 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130541AbRARSO7>; Thu, 18 Jan 2001 13:14:59 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14951.12943.134031.151865@wire.cadcamlab.org>
Date: Thu, 18 Jan 2001 12:14:39 -0600 (CST)
To: idalton@ferret.phonewave.net
Cc: James Bottomley <J.E.J.Bottomley@HansenPartnership.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
In-Reply-To: <mike@UDel.Edu>
	<200101171616.LAA01194@localhost.localdomain>
	<20010118065012.B26045@cadcamlab.org>
	<20010118095906.A8983@ferret.phonewave.net>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[idalton@ferret.phonewave.net]
> Multiple bus types... Compaq server with PCI and EISA, for example?
> IIRC the EISA bus is bridged onto one of the PCI busses.  Perhaps a
> breadth-first scan; PCI busses first, then bridged devices on PCI,
> then internal non-PCI busses, then external busses.

No, bridging is transparent to most drivers, so this doesn't
necessarily make sense.  The thing to do is just decree "drivers will
be registered in *this* order..." and then list the busses in some
arbitrary order, and specify some sub-scheme for enumerating drivers on
each bus.

...Which still doesn't solve the problem of multiple device types on a
single bus, for which I think my proposal (passing a meta-address of
some sort into scsi_register() and similar, and letting it sort devices
as they come in.  (Until the end of the bootstrap, of course.  Modules
all go in at the end.)

> Are there any systems where a non-PCI bus is not connected through a
> PCI-foo bridge?

There are lots of non-PCI systems out there.  And quite a few, I
suspect, where PCI is bridged off the "native" bus rather than the
other way 'round.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
