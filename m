Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265772AbUGCBgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265772AbUGCBgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 21:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265780AbUGCBgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 21:36:43 -0400
Received: from mail004.syd.optusnet.com.au ([211.29.132.145]:476 "EHLO
	mail004.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265772AbUGCBgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 21:36:39 -0400
Date: Sat, 3 Jul 2004 11:35:53 +1000
From: Andrew Clausen <clausen@gnu.org>
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: "Patrick J. LoPresti" <patl@users.sourceforge.net>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>,
       Steffen Winterfeldt <snwint@suse.de>, linux-kernel@vger.kernel.org,
       Thomas Fehr <fehr@suse.de>, bug-parted@gnu.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS / CHS stuff)
Message-ID: <20040703013552.GA630@gnu.org>
References: <s5gwu1mwpus.fsf@patl=users.sf.net> <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org>
X-Accept-Language: en,pt
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 02, 2004 at 06:17:53PM +0200, Szakacsits Szabolcs wrote:
>           [kernel related notes are at the end]
> Hello,
> 
> On 2 Jul 2004, Patrick J. LoPresti wrote:
> 
> Parted is looking for (co-)maintainers. Wouldn't you like to be?
> Guillaume? Somebody from SUSE, Red Hat, Debian, anybody? I think 
> it's a real challenge in its current state ;)

I am the current Parted maintainer.  I am rather busy, and haven't had
time to do a good job.  However, I haven't "dropped" it.  I would
welcome a co-maintainer though :)

> > Parted needs a mechanism to let me FORCE the geometry it uses.  Every
> > other partitioning tool has this, usually via command-line switch.

Would this solve any problems?  The people who get hit aren't going
to use the switch, right?

> Currently they blame the BIOS, LILO, GRUB, NTFS, FAT32, Microsoft,
> bootloaders, kernel, hardware, firmware, themself(!!), etc. Parted 
> is so hidden, embedded in tools, installers and behaves so randomly 
> then I think it was very difficult to realise how broken it is, over
> the years.

For the same reasons, I haven't been getting bug reports.  I first found
out that this was a (non-hypothetical) problem on Slashdot.  I can't
reproduce the bug.  Nor can Jeremy Katz at Red Hat.  If anyone out there
can, please get in touch!

> > Having such [geometry] guesswork in Parted itself is a design error,
> 
> Yes. Parted must get the geometry from the partition table unless
>
> 	1) the partition table is empty
> 
> 	2) asked to fix the partition table
> 
> 	3) asked to use user provided values

You need to add these to the list:

	(4) There aren't any partitions that end before cylinder 1024.
	(5) The partition table is inconsistent.

Parted does inspect the partition table to try to figure out the
geometry.  I'm not sure why Parted is messing up so much.  (The current
analyses don't explain it)  I really need more information.

> 1) and 2) need a way to get a "sane" geometry from the BIOS or kernel.

Shouldn't we just use LBA?  (i.e. x/255/63)

> Nevertheless, fixing Parted and all broken tools, that trust the kernel
> getting the most-of-the-time-right-geometry, won't fix the problem
> immediately because nobody can replace all these tools in the wild from
> one day to the other. Transition would take several years.

Is there any evidence of this?  I think 6 months.  (Seriously, has
anyone done any research?)

> Does anybody find the new HDIO_GETGEO semantic useful? Did it help
> _anything_? 

Remember, back when it was proposed, everyone claimed "everyone uses
LBA", and hence it was irrelevant.  I thought it was better to keep it
as it was.

> Because the semantic change did break many people data, installations
> permanently and keeps doing so every day.

I don't understand this sentence.

> Please also note, so far nobody stepped forward to fix parted.

You know there is a patch.  The problem is that "how-to-fix" is
contentious, not that we can't produce a patch.

Cheers,
Andrew

