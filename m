Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318938AbSICVoH>; Tue, 3 Sep 2002 17:44:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318941AbSICVoH>; Tue, 3 Sep 2002 17:44:07 -0400
Received: from smtp02.uc3m.es ([163.117.136.122]:31240 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S318938AbSICVoF>;
	Tue, 3 Sep 2002 17:44:05 -0400
Date: Tue, 3 Sep 2002 23:48:32 +0200
Message-Id: <200209032148.g83LmWU14950@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: david.lang@digitalinsight.com
Subject: (fwd) Re: [RFC] mount flag "direct"
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sorry I'm getting behind with the mail. Meetings, and I'm flying
towmorrow.

> On Tue, 3 Sep 2002, Peter T. Breuer wrote:
> > If it doesn't cause the data to be read twice, then it ought to, and
> > I'll fix it (given half a clue as extra pay ..:-)
> 
> writing then reading the same file may cause it to be read from the disk,
> but reading /foo/bar then reading /foo/bar again will not cause two reads
> of all data.

Hmm. I just did a quick check on 2.5.31, and to me it looks as though
two consequtive reads BOTH drop through to the driver. Yes, I am
certain - I've repeated the experiment 4 times reading the same 400K,
and each time the block driver registers 400 read requests.

> some filesystems go to a lot fo work to orginize the metadata in
> particular in memory to access things more efficiantly, you will have to
> go into each filesystem and modify them to not do this.

Well, I'll have to divert them. Is there not some trick that can be
used? A bitmap mmapped to the device, if that's not nonsensical in
kernel space?

> in addition you will have lots of potential races as one system reads a
> block of data, modifies it, then writes it while the other system does the

Uh, I am confident that there can  be no races with respect to data
writes provided I manage to make the VFS operations atomic via
appropriate shared locking. What one has to get rid of is cached
metadata state. I'm open to suggestions.

> yes this is stuff that could be added to all filesystems, but will the
> filesystem maintainsers let you do this major surgery to their systems?

Depends how a patch looks, I guess.

> for example the XFS and JFS teams are going to a lot of effort to maintain
> their systems to be compatable with other OS's, they probably won't

Yes.

> appriciate all the extra conditionals that you will need to put in to
> do all of this.

I don't see any conditionals. These will be methods, i.e. redirects.
Anyway, what's an if test between friends :-).

> even for ext2 there are people (including linus I believe) that are saying
> that major new features should not be added to ext2, but to a new

I agree! But I wouldn't see adding VFS ops to replace FS-specific
code as a new feature, rather a consolidation of common codes.

> filesystem forked off of ext2 (ext3 for example or a fork of it).

Peter
