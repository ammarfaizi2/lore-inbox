Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263513AbTLIXlQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 18:41:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbTLIXlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 18:41:15 -0500
Received: from email-out1.iomega.com ([147.178.1.82]:5349 "EHLO
	email.iomega.com") by vger.kernel.org with ESMTP id S263497AbTLIXlJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 18:41:09 -0500
Subject: Re: partially encrypted filesystem
From: Pat LaVarre <p.lavarre@ieee.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Phillip Lougher <phillip@lougher.demon.co.uk>,
       Matthew Wilcox <willy@debian.org>, Erez Zadok <ezk@cs.sunysb.edu>,
       =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Kallol Biswas <kbiswas@neoscale.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-Reply-To: <1070883425.31993.80.camel@hades.cambridge.redhat.com>
References: <20031205191447.GC29469@parcelfarce.linux.theplanet.co.uk>
	 <200312051947.hB5Jlupp030878@agora.fsl.cs.sunysb.edu>
	 <20031205202838.GD29469@parcelfarce.linux.theplanet.co.uk>
	 <3FD127D4.9030007@lougher.demon.co.uk>
	 <1070883425.31993.80.camel@hades.cambridge.redhat.com>
Content-Type: text/plain
Organization: 
Message-Id: <1071013254.24032.13.camel@patibmrh9>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 09 Dec 2003 16:40:54 -0700
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2003 23:41:08.0580 (UTC) FILETIME=[EB7A8240:01C3BEAD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Even if you were going to admit to having a block size of 64KiB to the
> layers above you,

Within pdt x05 dvd/ cd, as contrasted with pdt x00 hdd/ flash, since
1999 we have an ansi t10 paper standard for a device to report bytes per
write block inequal to bytes per read block i.e. the 1999 mmc x0020
RandomWritable "feature" that describes a disc in a drive.

I haven't yet seen an fs run in Linux that bothers to fetch this plug 'n
play data, hence my op x46 GPCMD_GET_CONFIGURATION patches of
linux-scsi.

> you just can't _do_ atomic replacement of blocks,
> which is required for normal file systems to operate correctly.

Google tells me cd-rw and dvd+rw likewise do not support random writing
without load balancing e.g.

http://fy.chalmers.se/~appro/linux/DVD+RW/
http://fy.chalmers.se/~appro/linux/DVD+RW/#udf

"... As you might know DVD+RW media can sustain only around 1000
overwrites. The thing about fully fledged file systems is that every
read [or tight bunch of 'em] is accompanied by corresponding i-node
update or in other words a write! ..."

> These characteristics of flash have often been dealt with by
> implementing a 'translation layer' -- a kind of pseudo-filesystem --
> which pretends to be a block device with the normal 512-byte
> atomic-overwrite behaviour. You then use a traditional file system on
> top of that emulated block device. 

Ick.

Naive read-modify-write to raise bytes-per-write-block passed-thru drops
thruput like 7X in the benchmarks I've seen.

Pat LaVarre


