Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132881AbRARMuk>; Thu, 18 Jan 2001 07:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132543AbRARMua>; Thu, 18 Jan 2001 07:50:30 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:26631 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S130139AbRARMuR>; Thu, 18 Jan 2001 07:50:17 -0500
Date: Thu, 18 Jan 2001 06:50:12 -0600
To: James Bottomley <J.E.J.Bottomley@HansenPartnership.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Linux not adhering to BIOS Drive boot order?
Message-ID: <20010118065012.B26045@cadcamlab.org>
In-Reply-To: <mike@UDel.Edu> <200101171616.LAA01194@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200101171616.LAA01194@localhost.localdomain>; from J.E.J.Bottomley@HansenPartnership.com on Wed, Jan 17, 2001 at 11:16:58AM -0500
From: Peter Samuelson <peter@cadcamlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[James Bottomley]
> The fundamental problem that we all agree on is that SCSI devices are
> detected in the order that the mid-layer hosts.c file calls their
> detect routines.

That was yesterday.  Today they are detected in the order they are
linked into the kernel, cf. the Makefile.  But yes, the problem is
basically the same.

> Further, for multiple cards of the same type, the detection order is
> up to the individual driver.

Yes.  PCI-based drivers will most likely use bus order since the kernel
provides facilities to do this easily.  For a single driver driving
multiple cards on multiple bus types, who knows.

> One of the ways this could be solved would be to impose bus ordering
> on the detection sequence.

This would be rather an intrusive change, since it puts the burden on
hosts.c to know what devices are where rather than on each driver.

A much less intrusive (?) variation: scsi_register() is given the
device location in some form.  It would then use insertion sort to add
the new adapter to the list of known ones.  Obviously this behavior
should only apply until the end of the boot sequence -- modules always
get put on the end of the list.  The bus location would be a 32-bit
number, perhaps, with the high 8 bits for bus type and the low 24 bits
for further enumeration (for PCI: 8 bits each for bus, slot, and fn).

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
