Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265581AbSKFElv>; Tue, 5 Nov 2002 23:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265579AbSKFElu>; Tue, 5 Nov 2002 23:41:50 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:43231 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S265578AbSKFElt>;
	Tue, 5 Nov 2002 23:41:49 -0500
Date: Tue, 5 Nov 2002 23:48:25 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Mike Diehl <mdiehl@dominion.dyndns.org>
cc: kcorry@austin.rr.com, evms-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Evms-devel] EVMS announcement
In-Reply-To: <20021106022549.C849B55A9@dominion.dyndns.org>
Message-ID: <Pine.GSO.4.21.0211052332360.6521-100000@steklov.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 5 Nov 2002, Mike Diehl wrote:

> Na, I can't ignore the debate.  I can't wait to see how user-land descovery 
> will be implemented.  There is something intrinsically "nice" about having an 
> OS automatically discover every aspect of a machine I'm installing on.  I 

Kernel _can't_ do that.  In principle.  Simply because part of the kernel
that would know how to talk with that PCI card (which just happens to be
a SCSI adapter) happens to be a module that lives on a filesystem that
lives on a different server and will be accessible only after we configure
this NIC.  There is no way in hell to tell what devices sit on the SCSI
bus behind that card.  Not without userland participation in the process.

So like it or not, userland is involved.  The best thing that can be done
is exposing the list of block devices (with information about them) that
kernel knows of + passing events (device added/removed/etc.) to userland.

We have both - one in sysfs and another as calls of /sbin/hotplug.  What's
more, we are about to get them very early, so a lot of warts become not
necessary (all drivers' setup happens with early userland already in place,
so we the things that had to be done manually can use generic mechanisms).

Note that both interfaces are still changing and figuring out what is
really needed will certainly be easier with non-trivial users of these
mechanisms.  EVMS definitely will be one of such users...

