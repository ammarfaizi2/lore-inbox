Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965778AbWKEBx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965778AbWKEBx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Nov 2006 20:53:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965779AbWKEBx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Nov 2006 20:53:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:30666 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S965778AbWKEBx2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Nov 2006 20:53:28 -0500
Subject: Re: New filesystem for Linux
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Albert Cahalan <acahalan@gmail.com>
Cc: kangur@polcom.net, mikulas@artax.karlin.mff.cuni.cz,
       linux-kernel@vger.kernel.org
In-Reply-To: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
References: <787b0d920611041159y6171ec25u92716777ce9bea4a@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 05 Nov 2006 01:57:35 +0000
Message-Id: <1162691856.21654.61.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sad, 2006-11-04 am 14:59 -0500, ysgrifennodd Albert Cahalan:
> New drives will soon use 4096-byte sectors. This is a better
> match for the normal (non-VAX!) page size and reduces overhead.

The innards of the disk are already a file system in themselves. The
disk is a network storage appliance on a funny cable with an odd command
set, nothing else. The internal storage model of the drive and external
one can be quite different.

> > - old data,
> > - new data,
> > - nothing (unreadable sector - result of not full write and disk
> > internal checksum failute for that sector, happens especially
> > often if you have frequent power outages).

Also theoretically states like "random block you only read in the middle
of moving".

> > And possibly some broken drives may also return you something that
> > they think is good data but really is not (shouldn't happen since
> > both disks and cables should be protected by checksums, but hey...
> > you can never be absolutely sure especially on very big storages).

It happens because
-	There is limited if any protection on the PCI bus generally
-	Many PC systems don't have ECC memory, ECC cache
-	PATA does not CRC protect the command block so if you do enough PATA
I/O (eg you are a US national lab ..) you *will* eventually get a bit
flip that gives you the wrong sector with no error data. SATA fixes that
one.
-	Murphy is out to get you..

Network people use end to end checksums, when working with huge data
sets people generally use app<->app checksums. Serious network using
people with big data sets also often turn off the hardware checksum
support on network cards - its faster but riskier.

> BTW, a person with disk recovery experience told me that drives
> will sometimes reorder the sectors. Sector 42 becomes sector 7732,
> sector 880880 becomes sector 12345, etc. The very best filesystems

Not seen that, although they do move stuff aorund in their internal
block management of bad blocks. I've also seen hardware errors that lead
to data being messed up silently. 

Alan

