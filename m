Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUGEOAz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUGEOAz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 10:00:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266120AbUGEOAz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 10:00:55 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:7429 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S266117AbUGEOAt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 10:00:49 -0400
Date: Mon, 5 Jul 2004 16:00:44 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Szakacsits Szabolcs <szaka@sienet.hu>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       "Patrick J. LoPresti" <patl@users.sourceforge.net>, bug-parted@gnu.org,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Clausen <clausen@gnu.org>,
       buytenh@gnu.org, msw@redhat.com
Subject: Re: Restoring HDIO_GETGEO semantics for 2.6 (was: Re: [RFC] Restoring HDIO_GETGEO semantics)
Message-ID: <20040705140044.GB24899@wsdw14.win.tue.nl>
References: <Pine.LNX.4.21.0407041920480.11076-100000@mlf.linux.rulez.org> <200407051513.48334.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407051513.48334.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.4.2i
X-Spam-DCC: dmv.com: mailhost.tue.nl 1181; Body=1 Fuz1=1 Fuz2=1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 03:13:48PM +0200, Bartlomiej Zolnierkiewicz wrote:

> We can restore ide-geometry.c or try to return values obtained from
> EDD code through IDE driver.  Alternatively we can add new ioctl for
> start of partition and remove HDIO_GETGEO from IDE driver completely
> but probably it is too late for this for 2.6 (we should do it early
> in 2.7 then).  Andries?

For Linux purposes geometry is almost irrelevant.
(But, as I remarked in another letter, some RAIDs need something.)

This means as a first approximation that "geometry" is not a kernel
business. Certainly the present discussion is not about the ide-driver.
Indeed, what people want is the geometry that a certain BIOS will assign
to a disk. That depends on the BIOS, and on whether the user has
set things up with Normal / Large / LBA in the BIOS setup.
(In case the disk was left out of the BIOS setup, this particular
concept of geometry does not exist at all.)

So, the question is whether information from the BIOS can be
exposed. Well, that is not impossible, and EDD already does this.

Why would people want to know what a BIOS would do?
So far I have mostly seen two classes of wishes.
One is to install lots of new Windows systems on blank disks
- that is done faster and more conveniently from Linux -
where there is no partition table yet to inspect.
The other is to create or modify NTFS filesystems.

Such are reasonable wishes, but rather special purpose.
For the time being I have good hopes that it will turn out
to be possible to do these things. Maybe using present EDD.
Maybe by extending EDD a little.

Five years ago I wrote a library that takes collected BIOS info,
and collected Linux info, and tries to match BIOS disks with
Linux disks. Of course it is impossible to do this right, but
one can find heuristics that often work. Such heuristics do not
belong in the kernel, but a user space application can decide,
given the known situation, whether a guess is probably right,
or perhaps consult the user.

I am awaiting the discussion with Szaka.

Andries
