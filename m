Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264639AbUGBQSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264639AbUGBQSF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 12:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264686AbUGBQSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 12:18:05 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:49676 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S264639AbUGBQR7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 12:17:59 -0400
Date: Fri, 2 Jul 2004 18:17:53 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: bug-parted@gnu.org, "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       Andries Brouwer <Andries.Brouwer@cwi.nl>, linux-kernel@vger.kernel.org
Subject: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for BIOS
 / CHS stuff)
In-Reply-To: <s5gwu1mwpus.fsf@patl=users.sf.net>
Message-ID: <Pine.LNX.4.21.0407021528150.21499-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


          [kernel related notes are at the end]
Hello,

On 2 Jul 2004, Patrick J. LoPresti wrote:

Parted is looking for (co-)maintainers. Wouldn't you like to be?
Guillaume? Somebody from SUSE, Red Hat, Debian, anybody? I think 
it's a real challenge in its current state ;)

> Parted needs a mechanism to let me FORCE the geometry it uses.  Every
> other partitioning tool has this, usually via command-line switch.

FORCE or FIX if it's _asked_. Fix but not the way parted does now,
silently playing lottery. Only if user explicitely wants to do that, aka
user knows he has a problem, e.g. old parted messed up the partition
table.

The majority of users doesn't really know what is bootloader, MBR,
partition table, geometry, cylinder, sectors, etc and actually they
shouldn't even know.

Currently they blame the BIOS, LILO, GRUB, NTFS, FAT32, Microsoft,
bootloaders, kernel, hardware, firmware, themself(!!), etc. Parted 
is so hidden, embedded in tools, installers and behaves so randomly 
then I think it was very difficult to realise how broken it is, over
the years.

> Having such [geometry] guesswork in Parted itself is a design error,

Yes. Parted must get the geometry from the partition table unless

	1) the partition table is empty

	2) asked to fix the partition table

	3) asked to use user provided values

1) and 2) need a way to get a "sane" geometry from the BIOS or kernel.

Nevertheless, fixing Parted and all broken tools, that trust the kernel
getting the most-of-the-time-right-geometry, won't fix the problem
immediately because nobody can replace all these tools in the wild from
one day to the other. Transition would take several years.

Does anybody find the new HDIO_GETGEO semantic useful? Did it help
_anything_? 

Because the semantic change did break many people data, installations
permanently and keeps doing so every day.

Please also note, so far nobody stepped forward to fix parted.

	Szaka

