Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTDUJkK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 05:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTDUJkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 05:40:10 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5760 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263798AbTDUJkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 05:40:08 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304210955.h3L9tCVx000292@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Mon, 21 Apr 2003 10:55:12 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), josh@stack.nl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030421113236.3955d5e6.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 21, 2003 11:32:36 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > > > Fault tolerance in a filesystem layer means in practical terms
> > > > > > that you are guessing what a filesystem should look like, for the
> > > > > > disk doesn't answer that question anymore. IMHO you don't want
> > > > > > that to be done automagically, for it might go right sometimes,
> > > > > > but also might trash everything on RW filesystems.
> > > > > 
> > > > > Let me clarify again: I don't want fancy stuff inside the filesystem
> > > > > that magically knows something about right-or-wrong. The only _very
> > > > > small_ enhancement I would like to see is: driver tells fs there is an
> > > > > error while writing a certain block => fs tries writing the same
> > > > > data onto another block. That's it, no magic, no RAID
> > > > > stuff. Very simple. 
> > > > 
> > > > That doesn't belong in the filesystem.
> > > > 
> > > > Imagine you have ten blocks free, and you allocate data to all of them
> > > > in the filesystem.  The write goes to cache, and succeeds.
> > > > 
> > > > 30 seconds later, the write cache is flushed, and an error is reported
> > > > back from the device.
> > > 
> > > And where's the problem?
> > > Your case:
> > > Immediate failure. Disk error.
> > > 
> > > My case:
> > > Immediate failure. Disk error (no space left for replacement)
> > > 
> > > There's no difference.
> > 
> > In my case, the machine can continue as normal.  The filesystem is
> > intact, (with no blocks free).  The block device driver has to cope
> > with the error, which could be as simple as holding the data in RAM
> > until an operator has been paged to replace the disk.
> 
> Forgive my ignorance, but I have not seen a case up to today where
> ide, aicX or 3ware has called me up for a replacement unit, written
> to it and been ok afterwards. What the heck are you talking of?

Modern disks error correct on write.  The user doesn't even know that
they are doing it.  If a disk actually reports back a write error, it
is usually very broken.

Incidentally, I don't see how your idea would even be implementable
without disabling write caching.

> I am not really interested in what a low-level driver could do
> unless there is none that does it...

I assume you mean 'one that does it'.

If nobody was interested in what a low-level driver could do unless
there was one that does it already, we wouldn't be innovating anything
new.

> And again, how do you think this should work out on your _root_
> partition? (see below)

1. Hot plug a new disk
2. Duplicate the read-only root file system on to it
3. Pivot root

> > In your case, the filesystem is no longer in a usable state.
> 
> I have yet to see an fs thats in a writeable state after the medium
> is full ...

It is perfectly writable, for example, for a delete operation.

> >  If that
> > was the root filesystem, the machine will, at best, probably go in to
> > single user mode, with a read-only root filesystem.
> 
> How come?

In my opinion, that would be the best course of action, if the device
holding the root filesystem is faulty.

> > > Thing is: If there are 11 blocks free and not ten, then you fail
> > 
> > Wrong.  See above.
> 
> Please tell me when you were last "paged to replace the disk"? If you can't
> tell me, then you know I am right by now.

I have never been paged to replace a disk by a Linux system.

That is why I would like to see this functionality added to Linux.

John.
