Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263679AbTK3Kf7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Nov 2003 05:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263745AbTK3Kf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Nov 2003 05:35:58 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:3968 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263679AbTK3Kf5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Nov 2003 05:35:57 -0500
Date: Sun, 30 Nov 2003 10:40:25 GMT
From: John Bradford <john@grabjohn.com>
Message-Id: <200311301040.hAUAePk6000149@81-2-122-30.bradfords.org.uk>
To: Arjan van de Ven <arjanv@redhat.com>, Andrew Clausen <clausen@gnu.org>
Cc: John Bradford <john@grabjohn.com>, Andries Brouwer <aebr@win.tue.nl>,
       Szakacsits Szabolcs <szaka@sienet.hu>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
In-Reply-To: <1070182676.5214.2.camel@laptop.fenrus.com>
References: <20031128045854.GA1353@home.woodlands>
 <20031128142452.GA4737@win.tue.nl>
 <20031129022221.GA516@gnu.org>
 <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi>
 <20031129123451.GA5372@win.tue.nl>
 <200311291350.hATDo0CY001142@81-2-122-30.bradfords.org.uk>
 <20031129223103.GB505@gnu.org>
 <1070182676.5214.2.camel@laptop.fenrus.com>
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Arjan van de Ven <arjanv@redhat.com>:
> On Sat, 2003-11-29 at 23:31, Andrew Clausen wrote:
> > On Sat, Nov 29, 2003 at 01:50:00PM +0000, John Bradford wrote:
> > > Why don't we take the opporunity to make all CHS code configurable out
> > > of the kernel, and define a new, more compact, partition table format
> > > which used LBA exclusively, and allowed more than four partitions in
> > > the main partition table?
> >
> > Intel's EFI GPT partition table format seems quite acceptable.
> 
> EFI GPT has some severe downsides (like requiring the last sector on
> disk, which in linux may not be accessible if the total number of
> sectors is not a multiple of 2, and making dd of one disk to another
> impossible if the second one is bigger)

EFI GPT is also a far more elaborate scheme than is necessary for a
lot of installations.

My 'requirements' are:

* Good magic

We have seen support for not very widely used partitioning schemes
broken in the past when other schemes are checked for ahead of them.
A simple scheme with well defined magic values reduces this risk.

* Simple

The code for some of the partitioning schemes is full of workarounds
for different implementations.  Added complexity, and more variations
increase the likelyhood of bugs.

* All partition information stored in one partition table

Linked lists make re-arranging partitions, and backing up the
partition table more difficult.

* Support for more than 4 partitions

This is a common requirement now.

* Support for partitions > 2TB

This will become a standard requirement in a few years.

* No mention of CHS

CHS is so last year.  Modern systems don't even need it to boot.  We
could allow all of the CHS-related code to be configured out of the
kernel, which would be useful on some embedded systems.

The Ultrix partition code comes fairly close to what I'm thinking of,
but not close enough :-).

John.
