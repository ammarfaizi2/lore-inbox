Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264485AbTK2WXE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 17:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264494AbTK2WXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 17:23:04 -0500
Received: from mail013.syd.optusnet.com.au ([211.29.132.67]:11976 "EHLO
	mail013.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S264485AbTK2WXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 17:23:00 -0500
Date: Sun, 30 Nov 2003 09:27:22 +1100
From: Andrew Clausen <clausen@gnu.org>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>, Apurva Mehta <apurva@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bug-parted@gnu.org
Subject: Re: Disk Geometries reported incorrectly on 2.6.0-testX
Message-ID: <20031129222722.GA505@gnu.org>
References: <20031128045854.GA1353@home.woodlands> <20031128142452.GA4737@win.tue.nl> <20031129022221.GA516@gnu.org> <Pine.LNX.4.58.0311290550190.21441@ua178d119.elisa.omakaista.fi> <20031129123451.GA5372@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031129123451.GA5372@win.tue.nl>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 29, 2003 at 01:34:51PM +0100, Andries Brouwer wrote:
> On Sat, Nov 29, 2003 at 07:16:31AM +0200, Szakacsits Szabolcs wrote:
> 
> > 	http://mlf.linux.rulez.org/mlf/ezaz/ntfsresize.html#troubleshoot
> > 
> > Some users, having problems, did mention the usage of 2.6 kernel. If the
> > geometry changed during the fdisk, etc process then it could result also
> > booting problem?
> 
> Let me continue to stress: geometry does not exist.

Let me continue to stress: geometry DOES exist.

It is an abstract construct that is stored in your BIOS that some
configurations use and need for booting.

> Consequently, it cannot change.

The geometry can be changed in many BIOSes.

> fdisk does not set any geometry, it writes a partition table.

But the way it writes the partition table is affected by what it
believes the geometry to be.  If its beliefs don't match the BIOS,
there can be trouble.  However, since fdisk isn't typically used to
resize Windows partitions, you don't see problems so much.

> Start and size of each partition are given twice: in absolute sector
> units (LBA) and in CHS units. The former uses 32 bits, and with 512-byte
> sectors this works up to 2TB. People are starting to hit that boundary now.
> The latter uses 24 bits, which works up to 8GB. Modern systems no longer
> use it (but the details are complicated).

You mean "modern software".  I'm not sure how true this is.  Have you
got any evidence?

(i.e. have you got any evidence that, say, that 99.x% of Windows XP
installations use LBA to bootstrap?)

> Usually booting goes like this: the BIOS reads sector 0 (the MBR)
> from the first disk, and starts the code found there. What happens
> afterwards is up to that code. If that code uses CHS units to find
> a partition, and if the program that wrote the table has different
> ideas about those units than the BIOS, booting may fail.

Exactly.

Moreover, booting can fail while reading the file system.  I reverse
engineered several of the Microsoft boot loaders (Windows
95/9x/ME/2000/NT).  The boot sector understands FAT, and depending
on the configuration, may use CHS to load in info.

I wrote about this in the doc/FAT file in the Parted tarball.

Cheers,
Andrew

