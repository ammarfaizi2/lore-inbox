Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281161AbRKLXIH>; Mon, 12 Nov 2001 18:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281174AbRKLXH6>; Mon, 12 Nov 2001 18:07:58 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:56816
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281161AbRKLXHr>; Mon, 12 Nov 2001 18:07:47 -0500
Date: Mon, 12 Nov 2001 15:07:40 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>
Cc: Andrew Morton <akpm@zip.com.au>, Ben Israel <ben@genesis-one.com>,
        linux-kernel@vger.kernel.org
Subject: Re: File System Performance
Message-ID: <20011112150740.B32099@mikef-linux.matchmail.com>
Mail-Followup-To: Richard Gooch <rgooch@ras.ucalgary.ca>,
	Andrew Morton <akpm@zip.com.au>, Ben Israel <ben@genesis-one.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <00b201c16b81$9d7aaba0$5101a8c0@pbc.adelphia.net> <3BEFF9D1.3CC01AB3@zip.com.au> <00da01c16ba2$96aeda00$5101a8c0@pbc.adelphia.net> <3BF02702.34C21E75@zip.com.au> <200111121959.fACJxsj08462@vindaloo.ras.ucalgary.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200111121959.fACJxsj08462@vindaloo.ras.ucalgary.ca>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 12, 2001 at 12:59:54PM -0700, Richard Gooch wrote:
> Here's an idea: add a "--compact" option to tar, so that it creates
> *all* inodes (files and directories alike) in the base directory, and
> then renames newly created entries to shuffle them into their correct
> positions. That should limit the number of block groups that are used,
> right?
> 
> It would probably also be a good idea to do that for cp as well, so
> that when I do a "cp -al" of a virgin kernel tree, I can keep all the
> directory inodes together. It will make a cold diff even faster.
> 

I don't think that would help at all... With the current file/dir allocator
it will choose a new block group for each directory no matter what the
parent is...

The new allocator would spread them accross the different block groups only
if they are created *directly* off of the root of the FS. Your idea would
make things worse for the new allocator *if* the tree is uncompressed into
the root of the FS, and *no* difference if not...

Mike
