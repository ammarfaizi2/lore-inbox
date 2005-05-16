Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261415AbVEPLCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbVEPLCO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 07:02:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261429AbVEPLCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 07:02:14 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:19614 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261415AbVEPLCI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 07:02:08 -0400
Date: Mon, 16 May 2005 13:02:03 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Linux does not care for data integrity (was: Disk write cache)
Message-ID: <20050516110203.GA13387@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0505151657230.19181@artax.karlin.mff.cuni.cz> <200505151121.36243.gene.heskett@verizon.net> <20050515152956.GA25143@havoc.gtf.org> <20050516.012740.93615022.okuyamak@dd.iij4u.or.jp> <42877C1B.2030008@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42877C1B.2030008@pobox.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 May 2005, Jeff Garzik wrote:

> The ability of a filesystem or fsync(2) to cause a [FLUSH|SYNC] CACHE 
> command to be generated has only been present in the most recent 2.6.x 
> kernels.  See the "write barrier" stuff that people have been discussing.

To make this explicit and unmistakable, Linux should be ashamed of
having put its users' data at risk for as long as it has existed, and
looking at how often I still get "barrier synch failed", it still does
with the kernel SUSE Linux 9.3 shipped with.

This came up several times, from database and mailserver authors, but
found no reasonable solution to date.

The documentation which file systems request cache flush for fsync, and
which device drivers (SCSI as ATA) as well as chipset adaptors pass this
down properly, is still missing. I've asked for help with such a list
several times over the recent years, I've offered my help in setting up
and maintaining the list when sent the raw information, but no-one cared
to provide this kind of information.

I will not try again, it's no good, kernel hackers with a handful of
exceptions, don't care.

If they think they do in spite of my statement, they'll have to prove
their point by growing up and documenting which combinations of
(file system, mount options, block dev driver, hardware/chip driver)
barrier synch is 100% reliable, which file systems, chipset drivers,
block drivers, hardware drivers, are missing links in the chain -- and
request that the kernel switches off the drive's write cache in all
drives unless the whole fsync() stuff works (unless defeated by a
"benchmark" kernel boot parameter).

Until then, my applications will have to recommend that users switch off
drive caches for consistency.

P. S.: Yes, the subject and this mail are provoking and exaggerated a
       tiny bit. I feel that's needed to raise the necessary motivation
       to finally address this issue after a decade or so.

-- 
Matthias Andree
