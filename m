Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313026AbSC0Orb>; Wed, 27 Mar 2002 09:47:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313027AbSC0OrM>; Wed, 27 Mar 2002 09:47:12 -0500
Received: from sphinx.mythic-beasts.com ([195.82.107.246]:38155 "EHLO
	sphinx.mythic-beasts.com") by vger.kernel.org with ESMTP
	id <S313026AbSC0OrH>; Wed, 27 Mar 2002 09:47:07 -0500
Date: Wed, 27 Mar 2002 14:47:03 +0000 (GMT)
From: Matthew Kirkwood <matthew@hairy.beasts.org>
X-X-Sender: <matthew@sphinx.mythic-beasts.com>
To: Andi Kleen <ak@suse.de>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Filesystem benchmarks: ext2 vs ext3 vs jfs vs minix
In-Reply-To: <p73y9ge3xww.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.33.0203271419230.28110-100000@sphinx.mythic-beasts.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 27 Mar 2002, Andi Kleen wrote:

> > ext3 dd	1303.84	66.87	212.49	66.06	361.04
> > 	dn	1288.03	64.62	209.27	111.41	278.54
> > 	bn	1285.32	65.98	1996.41	90.05	307.79
>
> This is ext3 with ordered data?

Yep.  Everything is default unless otherwise stated.

> > minix dd	1305.26	67.38	207.74	193.90	228.81
> > 	dn	1331.27	67.14	210.07	223.70	214.33
> > 	bn	1299.24	89.58	1988.31	231.17	231.17
>
> Wow minix is faster than ext2 @)  That certainly looks strange.

Yeah, I thought it was a little odd.  Postgres does so much
fsync()ing that I thought it may just have been that the lower
overhead won out over ext2's cleverer layout.  All the I/O was
basically fsync-driven, so this test was only about write
performance.

> Any chance to test XFS too?

Sure.  I'll try to build a more interesting kernel sometime
this week.  ext2 with delalloc might be fun, too.

Do you know of any simple patch or patches which might get
reiserfs working on 2.5.6?

> > 3. The journalled filesystems do have measurable overhead
> >    for this workload.
>
> Normally (non data journaling, noatime) journaling fs shouldn't have
> any overhead for database load, because database files should be
> preallocated and the database should do direct IO in/out the
> preallocated buffers with the FS never doing any metadata writes,
> except for occassional inode updates for mtime depending on what sync
> mode that DB uses (hmm, I guess a nomtime or verylazymtime or
> alwaysasyncmtime mount option could be helpful for that)

Postgres doesn't pre-allocate datafiles.  They reckon it's not
their job to implement a filesystem, and I'm inclined to agree.
They do prefer fdatasync on datafiles and (I think) O_DATASYNC
for their journal files where available, but I haven't checked
that my build is doing that.

> That's the theory, but doesn't seem to be the case in your test. I
> guess your test is not very realistic then.

Or your assumptions about DB vs filesystems are not valid in
this case.

> > 2. What does jfs do in the way of data journalling?  Is it
> >    "ordered" or "writeback", in ext3-speak?  (I assume
> >    fully journalled data would give much worse performance.)
>
> Kind of ordered I believe.

OK, ta.  So it probably does something right that ext3
doesn't?  (Or has rather weaker semantics, of course.)

Matthew.

