Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281236AbRKMAIt>; Mon, 12 Nov 2001 19:08:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281252AbRKMAIj>; Mon, 12 Nov 2001 19:08:39 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62971
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281236AbRKMAI3>; Mon, 12 Nov 2001 19:08:29 -0500
Date: Mon, 12 Nov 2001 16:08:22 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andrew Morton <akpm@zip.com.au>, Ben Israel <ben@genesis-one.com>,
        linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-ID: <20011112160822.E32099@mikef-linux.matchmail.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Andrew Morton <akpm@zip.com.au>, Ben Israel <ben@genesis-one.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net> <3BEFF9D1.3CC01AB3@zip.com.au> <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> <3BF02702.34C21E75@zip.com.au> <200111121959.fACJxsj08462@vindaloo.ras.ucalgary.ca> <20011112150740.B32099@mikef-linux.matchmail.com> <200111130004.fAD04v912703@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111130004.fAD04v912703@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 05:04:57PM -0700, Richard Gooch wrote:
> Mike Fedyk writes:
> > On Mon, Nov 12, 2001 at 12:59:54PM -0700, Richard Gooch wrote:
> > > Here's an idea: add a "--compact" option to tar, so that it creates
> > > *all* inodes (files and directories alike) in the base directory, and
> > > then renames newly created entries to shuffle them into their correct
> > > positions. That should limit the number of block groups that are used,
> > > right?
> > > 
> > > It would probably also be a good idea to do that for cp as well, so
> > > that when I do a "cp -al" of a virgin kernel tree, I can keep all the
> > > directory inodes together. It will make a cold diff even faster.
> > 
> > I don't think that would help at all... With the current file/dir
> > allocator it will choose a new block group for each directory no
> > matter what the parent is...
> 
> I thought the current implementation was that when creating a
> directory, ext2fs searches forward from the block group the parent
> directory is in, looking for a "relatively free" block group. So, a
> number of successive calls to mkdir(2) with the same parent directory
> will result in the child directories being in the same block group.
> 
> So, creating the directory tree by creating directories in the base
> directory and then shuffling should result in the directories be
> spread out over a modest number of block groups, rather than a large
> number.
> 
> Addendum to my scheme: leaf nodes should be created in their
> directories, not in the base directory. IOW, it's only directories
> that should use this trick.
> 
> Am I wrong in my understanding of the current algorithm?
> 

You are almost describing the new algo to a "T"...

It deals very well with fast growth, but not so well with slow growth, as
mentioned in previous posts in this thread...

There is a lengthy thread in ext2-devel right now, if you read it it'll
answer many of your questions.

Mike
