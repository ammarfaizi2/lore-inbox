Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269848AbRHDS3f>; Sat, 4 Aug 2001 14:29:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269850AbRHDS3Z>; Sat, 4 Aug 2001 14:29:25 -0400
Received: from weta.f00f.org ([203.167.249.89]:20624 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S269848AbRHDS3N>;
	Sat, 4 Aug 2001 14:29:13 -0400
Date: Sun, 5 Aug 2001 06:30:03 +1200
From: Chris Wedgwood <cw@f00f.org>
To: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.8-pre3 fsync entire path (+reiserfs fsync semantic change patch)
Message-ID: <20010805063003.B20111@weta.f00f.org>
In-Reply-To: <01080315090600.01827@starship> <Pine.GSO.4.21.0108031400590.3272-100000@weyl.math.psu.edu> <9keqr6$egl$1@penguin.transmeta.com>, <9keqr6$egl$1@penguin.transmeta.com> <20010804100143.A17774@weta.f00f.org> <3B6B4B21.B68F4F87@zip.com.au>, <3B6B4B21.B68F4F87@zip.com.au> <20010804131904.E18108@weta.f00f.org> <3B6B53A9.A9923E21@zip.com.au> <20010804060423.I16516@emma1.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010804060423.I16516@emma1.emma.line.org>
User-Agent: Mutt/1.3.20i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(cc' list trimmed)

On Sat, Aug 04, 2001 at 06:04:23AM +0200, Matthias Andree wrote:

    However, aren't we already at the point that ext3 fsync() flushes
    the corresponding dirents?

Ideally an acceptable solution will also obvioate the needs for +S
under ext2 and also work for reiserfs and more.

    How difficult would it be to have the inode track changes to its
    dirents such as rename or link?

For simple cases, not terrible (I don't think),  but you would have to
limit how much you tracked in extreme cases (like 2 directory inode at
most or something).

    I mean, FFS + softupdates can do it.

So run FFS :)

    The MTA doesn't really care for the implementation, it cares that
    it never loses its files over a crash

By MTA you mean Postfix.  Wietse recently stated he might start
looking at other alternatives which don't relay on undocument FFS
semantics or synchronous metadata updates.

    where finding it renamed
    to /mount/point/lost+found is considered a loss.

Actually, there is enough information on the file to recover things
for postfix.  For sendmail (which has two files, your pretty much
stuffed though).

    unlink and particularly symlink will need separate consideration,
    but that's left for later.

Unlink should be ok, I don't see why symlink should even be
considered (it would make things way too complex for little or no
gain).



Anyhow, if you read recent comments it looks like thre are filesystems
which will be badly affected by placing this logic into the VFS
(eg. Coda).  It may well be this should become a fs-specific thing
(which sucks a little, because it makes the suggestion of tracking
link/unlink directories ugly) and for some filesystems such as
resierfs and ext3, they could be modified to merge the 'related
directories' writes with the metadata write of the file itself.




  --cw
