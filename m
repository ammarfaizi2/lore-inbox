Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbTF2UkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 16:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbTF2Ujg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 16:39:36 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54169 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264271AbTF2Uhc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 16:37:32 -0400
Date: Sun, 29 Jun 2003 21:51:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: rmoser <mlmoser@comcast.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File System conversion -- ideas
Message-ID: <20030629205150.GK27348@parcelfarce.linux.theplanet.co.uk>
References: <200306291011.h5TABQXB000391@81-2-122-30.bradfords.org.uk> <20030629132807.GA25170@mail.jlokier.co.uk> <3EFEEF8F.7050607@post.pl> <20030629192847.GB26258@mail.jlokier.co.uk> <20030629194215.GG27348@parcelfarce.linux.theplanet.co.uk> <200306291545410600.02136814@smtp.comcast.net> <20030629200020.GH27348@parcelfarce.linux.theplanet.co.uk> <200306291629450990.023BC35E@smtp.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200306291629450990.023BC35E@smtp.comcast.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 04:29:45PM -0400, rmoser wrote:
 
> NO!  You're not getting the point at all!
> 
> You don't need a pair!  If you have 10 filesystems, you need 10 sets of
> code in each direction, not 90.  You convert from the data/metadata set
> in the first filesystem to a self-contained atom, and then back from the

[snip handwaving]
 
> That would be much harder to maintain as well.  It would have to be altered
> every time the filesystem code in the kernel is changed.

Not really, as long as filesystem _layout_ is stable.
 
> I've beaten the O((FS_COUNT)^2) already.  And by the way, it's
> O((FS_COUNT)*(FS_COUNT - 1_).  There's exactly O(2*FS_COUNT)
> and o(2*FS_COUNT) sets of code needed total to be able to convert
> between any two filesystems.

No, you have not.  You are yet to demonstrate that it's doable.
 
> Now, what's impractical is maintaining two sets of code that do exactly
> the same thing.  Why maintain code here to read the filesystems, and
> also in the kernel?  Just do it in the kernel.  Don't lose sight of the fact
> that the final goal (after all else is done) is to modify VFS to actually
> run this thing as a filesystem.  THAT is what's going to be a bitch.  The
> conversions are simple enough.

The *SHOW* *THEM*.  You keep repeating that it's simple.  Fine, show that
it can be done.  Then we can start talking about the rest - until you can
demonstrate (as in, show the working code) that does what you call simple,
there is no point in going any further.

_That_ is the point of contention.  And no, saying the word "atom" does
not count as proof of feasibility.  Show how to map metadata between different
filesystem types.  Hell, show that you know what types of metadata are there.

Forget about in-core data structures.  Whatever data structures you use,
it boils down to manipulating on-disk ones - that's kinda the point of
exercise, right?  Show what should be done with them - with whatever in-core
objects you like.  Assuming that VFS or any other parts of kernel do not
get into your way and do not impose any restrictions - how would you do this
stuff?  From one on-disk layout to another.  In details.  Then we can go
and see how to make existing kernel objects live with that.  That will be
extra condition and it will only make the problem harder.  Until you have
a solution of easier problem, there's no sense in discussing harder one.
