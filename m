Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263633AbTDTRFR (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 13:05:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263636AbTDTRFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 13:05:17 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:34176 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263633AbTDTRFQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 13:05:16 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304201720.h3KHKG9A000716@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sun, 20 Apr 2003 18:20:16 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), josh@stack.nl, alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030420190119.048d3a43.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 20, 2003 07:01:19 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Fault tolerance in a filesystem layer means in practical terms
> > > > that you are guessing what a filesystem should look like, for the
> > > > disk doesn't answer that question anymore. IMHO you don't want
> > > > that to be done automagically, for it might go right sometimes,
> > > > but also might trash everything on RW filesystems.
> > > 
> > > Let me clarify again: I don't want fancy stuff inside the filesystem that
> > > magically knows something about right-or-wrong. The only _very small_
> > > enhancement I would like to see is: driver tells fs there is an
> > > error while writing a certain block => fs tries writing the same
> > > data onto another block. That's it, no magic, no RAID
> > > stuff. Very simple. 
> > 
> > That doesn't belong in the filesystem.
> > 
> > Imagine you have ten blocks free, and you allocate data to all of them
> > in the filesystem.  The write goes to cache, and succeeds.
> > 
> > 30 seconds later, the write cache is flushed, and an error is reported
> > back from the device.
> 
> And where's the problem?
> Your case:
> Immediate failure. Disk error.
> 
> My case:
> Immediate failure. Disk error (no space left for replacement)
> 
> There's no difference.

In my case, the machine can continue as normal.  The filesystem is
intact, (with no blocks free).  The block device driver has to cope
with the error, which could be as simple as holding the data in RAM
until an operator has been paged to replace the disk.

In your case, the filesystem is no longer in a usable state.  If that
was the root filesystem, the machine will, at best, probably go in to
single user mode, with a read-only root filesystem.

> Thing is: If there are 11 blocks free and not ten, then you fail

Wrong.  See above.

> and I succeed (if there's one bad block). You loose data, I don't.

John.
