Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263590AbTDTOGx (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 10:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263587AbTDTOGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 10:06:52 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:5248 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263586AbTDTOGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 10:06:51 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304201421.h3KELqIU000303@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sun, 20 Apr 2003 15:21:52 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), linux-kernel@vger.kernel.org
In-Reply-To: <20030419223858.6781064d.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 19, 2003 10:38:58 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sat, 19 Apr 2003 21:04:28 +0100 (BST)
> John Bradford <john@grabjohn.com> wrote:
> 
> > > > > I wonder whether it would be a good idea to give the linux-fs
> > > > > (namely my preferred reiser and ext2 :-) some fault-tolerance.
> > > > 
> > > > Fault tollerance should be done at a lower level than the filesystem.
> > > 
> > > I know it _should_ to live in a nice and easy world. Unfortunately
> > > real life is different. The simple question is: you have tons of
> > > low-level drivers for all kinds of storage media, but you have
> > > comparably few filesystems. To me this sound like the preferred
> > > place for this type of behaviour can be fs, because all drivers
> > > inherit the feature if it lives in fs.
> > 
> > The sort of feature you are describing would really belong in a
> > separate layer, somewhat analogous to the MD driver, but for defect
> > management.  You could create a virtual block device that has 90% of
> > the capacity of the real block device, then allocte spare blocks from
> > the real device if and when blocks failed.
> 
> Well, of all work-arounds for the problem this one is probably the
> worst: it wastes space on good drives and runs out of space for sure
> on bad ones.

If 10% of the disk is bad, I wouldn't continue using it.

> What is so bad about the simple way: the one who wants to write
> (e.g. fs) and knows _where_ to write simply uses another newly
> allocated block and dumps the old one on a blacklist. The blacklist
> only for being able to count them (or get the sector-numbers) in
> case you are interested. If you weren't you might as well mark them
> allocated and that's it (which I would presume a _bad_ idea). If
> there are no free blocks left, well, then the medium is full. And
> that is just about the only cause for a write error then (if the
> medium is writeable at all).

Modern disks generally do this kind of thing themselves.  By the time
a disk actually reports write errors, I wouldn't want to continue
using it.  Preferably, I want to know _before_ then, generally by
using S.M.A.R.T. data.

> Don't make the thing bigger than it really is...

The problem you are describing doesn't really exist in a lot of
cases.  Modern hard disks do not have fixed areas corresponding to
specific blocks - they allocate the available space to blocks as
required.  The disk will just allocate a different area to hold the
block that was originally on the defective part of the media when that
block is re-written.

John.
