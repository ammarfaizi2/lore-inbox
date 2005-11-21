Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbVKUNSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbVKUNSg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 08:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVKUNSg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 08:18:36 -0500
Received: from mail.gmx.net ([213.165.64.20]:60069 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932297AbVKUNSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 08:18:35 -0500
X-Authenticated: #428038
Date: Mon, 21 Nov 2005 14:18:32 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: Re: what is our answer to ZFS?
Message-ID: <20051121131832.GB26068@merlin.emma.line.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <11b141710511210144h666d2edfi@mail.gmail.com> <20051121095915.83230.qmail@web36406.mail.mud.yahoo.com> <20051121101959.GB13927@wohnheim.fh-wedel.de> <20051121114654.GA25180@merlin.emma.line.org> <1132574831.15938.14.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1132574831.15938.14.camel@localhost>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2005, Kasper Sandberg wrote:

> On Mon, 2005-11-21 at 12:46 +0100, Matthias Andree wrote:
> > On Mon, 21 Nov 2005, Jörn Engel wrote:
> > 
> > > o Checksums for data blocks
> > >   Done by jffs2, not done my any hard disk filesystems I'm aware of.
> > 
> > Then allow me to point you to the Amiga file systems. The variants
> > commonly dubbed "Old File System" use only 448 (IIRC) out of 512 bytes

Make that 488. Amiga's traditional file system loses 6 longs (at 32 bit
each) according to Ralph Babel's "The Amiga Guru Book".

> > in a data block for payload and put their block chaining information,
> > checksum and other "interesting" things into the blocks. This helps
> > recoverability a lot but kills performance, so many people (used to) use
> > the "Fast File System" that uses the full 512 bytes for data blocks.
> > 
> > Whether the Amiga FFS, even with multi-user and directory index updates,
> > has a lot of importance today, is a different question that you didn't
> > pose :-)
> > 
> > >   yet.  (I barely consider reiser4 to exist.  Any filesystem that is
> > >   not considered good enough for kernel inclusion is effectively still
> > >   in development phase.)

> that isnt true, just because it isnt following the kernel coding style
> and therefore has to be changed, does not make it any bit more unstable.

If the precondition is "adhere to CodingStyle or you don't get it in",
and the CodingStyle has been established for years, I have zero sympathy
with the maintainer if he's told "no, you didn't follow that well-known
style".

> > What the heck is reiserfs? I faintly recall some weirdo crap that broke
> > NFS throughout the better parts of 2.2 and 2.4, would slowly write junk
> > into its structures that reiserfsck could only fix months later.
> well.. i remember that linux 2.6.0 had alot of bugs, is 2.6.14 still
> crap because those particular bugs are fixed now?

Of course not. The point is, it will take many months to shake the bugs
out that are still in it and will only be revealed as it is tested in
more diverse configurations.

> > ReiserFS 3.6 still doesn't work right (you cannot create an arbitrary
> > amount of arbitrary filenames in any one directory even if there's
> > sufficient space), after a while in production, still random flaws in
> > the file systems that then require rebuild-tree that works only halfway.
> > No thanks.

> i have used reiserfs for a long time, and have never had the problem
> that i was required to use rebuild-tree, not have issues requiring other
> actions come, unless i have been hard rebooting/shutting down, in which
> case the journal simply replayed a few transactions.

I have had, without hard shutdowns, problems with reiserfs, and
occasionally problems that couldn't be fixed easily. I have never had
such with ext3 on the same hardware.

> > Why would ReiserFS 4 be any different? IMO reiserfs4 should be blocked
> > from kernel baseline until:
> 
> you seem to believe that reiser4 (note, reiser4, NOT reiserfs4) is just
> some simple new revision of reiserfs. well guess what, its an entirely
> different filesystem, which before they began the changes to have it
> merged, was completely stable, and i have confidence that it will be
> just as stable again soon.

I don't care what its name is. I am aware it is a rewrite, and that is
reason to be all the more chary about adopting it early. People believed
3.5 to be stable, too, before someone tried NFS...

Historical fact is, ext3fs was very usable already in the later 0.0.2x
versions, and pretty stable in 0.0.7x, where x is some letter. All that
happened was applying some polish to make it shine, and that it does.

reiserfs was declared stable and then the problems only began. Certainly
merging kernel-space NFS was an additional obstacle at that time, so we
may speak in favor of Namesys because reiserfs was into a merging
target.

However, as reiser4 is a major (or full) rewrite, I won't consider it
for anything except perhaps /var/cache before 2H2007.

> > - reiserfs 3.6 is fully fixed up
> 
> so you are saying that if for some reason the via ide driver for old
> chipsets are broken, we cant merge a via ide driver for new ide
> controllers?

More generally, quality should be the prime directive. And before the
reiser4 guys focus on getting their gear merged and then the many bugs
shaken out (there will be bugs found), they should have a chance to
reschedule their internal work to get 3.6 fixed. If they can't, well,
time to mark it DEPRECATED before the new work is merged, and the new
stuff should be marked EXPERIMENTAL for a year.

> > - reiserfs 4 has been debugged in production outside the kernel for at
> >   least 24 months with a reasonable installed base, by for instance a
> >   large distro using it for the root fs
> no dist will ever use (except perhaps linspire) before its included in
> the kernel.

So you think? I beg to differ. SUSE have adopted reiserfs pretty early,
and it has never shown the promised speed advantages over ext[23]fs in
my testing. SUSE have adopted submount, which also still lives outside
the kernel AFAIK.

> > - there are guarantees that reiserfs 4 will be maintained until the EOL
> >   of the kernel branch it is included into, rather than the current "oh
> >   we have a new toy and don't give a shit about 3.6" behavior.
> why do you think that reiser4 will not be maintained? if there are bugs
> in 3.6 hans is still interrested, but really, do you expect him to still
> spend all the time trying to find bugs in 3.6, when people dont seem to

I do expect Namesys to fix the *known* bugs, such as hash table overflow
preventing creation of new files. See above about DEPRECATED.

As long as reiserfs 3.6 and/or reiser 4 are standalone projects that
live outside the kernel, nobody cares, but I think pushing forward to
adoption into kernel baseline consistutes a commitment to maintaining
the code.

> have issues, and while he in fact has created an entirely new
> filesystem.

Yup. So the test and fix cycles that were needed for reiserfs 3.5 and
3.6 will start all over. I hope the Namesys guys were to clueful as to
run all  their reiserfs 3.X regression tests against 4.X with all
plugins and switches, too.

> > Harsh words, I know, but either version of reiserfs is totally out of
> > the game while I have the systems administrator hat on, and the recent
> > fuss between Namesys and Christoph Hellwig certainly doesn't raise my
> > trust in reiserfs.
> so you are saying that if two people doesent get along the product the
> one person creates somehow falls in quality?

I wrote "trust", not "quality".

Part of my aversion against stuff that bears "reiser" in its name is the
way how it is supposed to be merged upstream, and there Namesys is a bit
lacking. After all, they want their pet in the kernel, not the kernel
wants reiser4.

-- 
Matthias Andree
