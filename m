Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTBIOFY>; Sun, 9 Feb 2003 09:05:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267267AbTBIOFY>; Sun, 9 Feb 2003 09:05:24 -0500
Received: from [195.223.140.107] ([195.223.140.107]:33665 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267266AbTBIOFW>;
	Sun, 9 Feb 2003 09:05:22 -0500
Date: Sun, 9 Feb 2003 15:15:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: Larry McVoy <lm@work.bitmover.com>, lm@bitmover.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5 changeset 1.952.4.2 corrupt in fs/jfs/inode.c
Message-ID: <20030209141502.GA31401@dualathlon.random>
References: <20030205174021.GE19678@dualathlon.random> <20030207145651.GA345@elf.ucw.cz> <20030208182820.GA14035@work.bitmover.com> <20030209105752.GA26151@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030209105752.GA26151@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 09, 2003 at 11:57:52AM +0100, Pavel Machek wrote:
> Hi!
> 
> > > > Note, I'm using my own GPL software to checkout from the bitkeeper
> > > > servers (I don't want to miss the additional information stored in
> > > 
> > > Are you going to put up copy of that sw somewhere? I guess more people
> > > are interested...
> > 
> > Two things:
> > 
> > 1) We're going to make a CVS archive of Linus tree available, automatically
> >    updated, and we'll rsync it to some public place like kernel.org so you
> >    can get at the data in a way you want with no BK involved at all.
> 
> I like that.

Yes. This way the information will be stored in a open standard and
downloadable with an open protocol in real time. The backup of the CVS
repository to kernel.org maybe is enough once per month or less. It is
only meant to be 100% sure not to lose the whole critical info, losing
one month would be nothing compared to losing it all. And at the same
time Linus and others can keep using bitkeeper if they can agree with
its proprietary licence.

I'm sorry Larry has to do all the work to setup the CVS checkins by
himself, I wish I could help him, that would be more than fair, just let
me know if I can contribute in any way with the setup.

As for the format of the checkins I suggested Larry to tag the tree with
an unique ID (changeset number is ok if it's unique and it doesn't
change on the bk side, but we don't care too much about the tag name)
after every checkin of a changeset. The cvs tags will be equivalent to
the changesets in bitkeeper. For the metadata belonging to the checkin I
suggested filling the cvs log this way:

ChangeSet: xxxx
Date: xxx
Author: xxx
Files: [ 'fs/inode.c', 'fs/dquote.c' ]
xxxxxComments herexxxx
xxxxxxxxxx
xxxxxxxxx
xxxx

(unsure if the changeset line is really needed, also unsure about the
files line when files are deleted)

So it will be trivial to extract the whole metadata, shall we need to
feed it in another database, or shall we need to automate searching
function on the information provided in CVS.

A simple `cvs log COPYING` will show all the changesets. A cvs rdiff
between two cvs tags will show the files involved and their revision
numbers, a cvs log will tell us the changeset metadata between these two
revision numbers that is effectively the metadata belonging to the whole
changesets. It's not the most handy format if your object is to extract
the data, but this way we won't need to reinvent the wheel for doing the
checkouts and diffs against Linus's tree that should be by far the
common usage, so it makes sense to me, especially because this format is
just designed to be efficient in doing the checkouts of the tree so it
will be safe to use for Larry's internet connection.

One detail is that the tree will be linearized (the last bit I needed to
make bkweb really useful), in the sense the old checkins in branched
bk trees, will showup as an unique changeset in the CVS, and it will
showup always as the head revision in CVS. I think it should be fine
since it will effectively match the way Linus merge stuff, i.e. a bk
pull will generate a single changeset in CVS.

The first priority is not to risk losing information on the evolution of
Linux, and this will be achieved this way, so I'm very happy! :)

Thanks.

Andrea

PS. if Larry don't want to risk paying an higher internet bill for the
future CVS users that right now obviously have to download from
kernel.org (and also because CVS is more network hungry than than bk I
believe), I'm sure various organizations (I could imagine osdl.org for
istance) could offer to host the kernel CVS tree too and Larry would
only need to pay the upload of the few kbytes of the checkins, without
paying for the plenty mbytes downloads. It obviously makes no difference
to the CVS users, this is definitely up to Larry.
