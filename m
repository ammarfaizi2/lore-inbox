Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265108AbUGBXzq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265108AbUGBXzq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 19:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUGBXzq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 19:55:46 -0400
Received: from mlf.linux.rulez.org ([192.188.244.13]:34064 "EHLO
	mlf.linux.rulez.org") by vger.kernel.org with ESMTP id S265108AbUGBXzl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 19:55:41 -0400
Date: Sat, 3 Jul 2004 01:55:36 +0200 (MEST)
From: Szakacsits Szabolcs <szaka@sienet.hu>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: Andries Brouwer <Andries.Brouwer@cwi.nl>, bug-parted@gnu.org,
       "K.G." <k_guillaume@libertysurf.fr>,
       Steffen Winterfeldt <snwint@suse.de>, Thomas Fehr <fehr@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Restoring HDIO_GETGEO semantics (was: Re: workaround for
 BIOS / CHS stuff)
In-Reply-To: <s5gzn6iz2or.fsf@patl=users.sf.net>
Message-ID: <Pine.LNX.4.21.0407030050330.30622-100000@mlf.linux.rulez.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2 Jul 2004, Patrick J. LoPresti wrote:

> >     2) use EDD, it does a much better job -- maybe this suggestions
> >        doesn't make much sense overall, so only 1) left if you don't 
> >        want to keep guessing.
> 
> Using EDD to deduce the geometry is the "right" answer.  But this is
> sufficiently complex and special-purpose that it has no place in the
> kernel.

Currently no code or a way to do this for all kernels neither in user, 
nor in kernel space, AFAIK. 

Several tools need it. 

Old kernels gave a non-perfect solutions. Today there is a worse approach,
no alternativa and uncontrolled, released, buggy zombie tools are
following what the kernel says: trash the partition table.

Due to the geometry change reported by the kernel and _additional_
partitioning software bugs, sometimes even the layout of existing
partitions are changed, aligned to new, bogus cylinder boundary. Thus not
only Windows but Linux or any other partitions get trashed too in cases.

This kernel geometry change exposed several _different_ partitioning bugs.
 
> Why does this stupid idea keep coming up?  Inferring the geometry from
> the existing partition table is just plain wrong.  It is even more
> wrong than the old 2.4 behavior, because it is still a guess, just a
> worse guess.

In different situations you must use different methods to get the needed
"geometry". 

When you read the geometry from an existing partition table then you
basically don't care about geometry. If it was broken then you won't break
it. If it was good then your values must be good too. But see below.

However there are cases like empty partition table, fixing partition table
if asked, mkntfs, ntfsck, etc when you need the bootloader friendly
geometry what I suspect is the EDD geometry, usually. Linux can't do that:
HDIO_GETGEO doesn't tell and no user space code that could be used for all
kernels.

	Szaka

