Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261723AbTJWRdD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 13:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTJWRdC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 13:33:02 -0400
Received: from thunk.org ([140.239.227.29]:14316 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261723AbTJWRdA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 13:33:00 -0400
Date: Thu, 23 Oct 2003 13:28:52 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Valdis.Kletnieks@vt.edu
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, results are in
Message-ID: <20031023172852.GB2265@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>, Valdis.Kletnieks@vt.edu,
	root@chaos.analogic.com, linux-kernel@vger.kernel.org
References: <175701c397e6$b36e5310$24ee4ca5@DIAMONDLX60> <20031021193128.GA18618@helium.inexs.com> <Pine.LNX.4.53.0310211558500.19942@chaos> <200310212021.h9LKLQK3009397@turing-police.cc.vt.edu> <20031021215346.GA15109@thunk.org> <200310220232.h9M2WY08007068@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310220232.h9M2WY08007068@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.4i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 21, 2003 at 10:32:34PM -0400, Valdis.Kletnieks@vt.edu wrote:
> Yes, I knew this was doable if the filesystem was unmounted - the fun is of
> course that if you get a bad block in /usr or someplace similar, it would
> REALLY be nice to be able to do something about it without taking it offline..

Agreed, it wouldn't be that hard to add some kernel code to do this
on-line, at least if the block isn't already allocated.  If the block
is already allocated, there would need to have to be some userspace
help to find which file the block actually belongs to, so the block
could be substituted out and the user appropriatly warned.

> I admit I haven't cooked up a test filesystem and actually checked what happens
> if you feed the -l flag a block that's already in a file (presumably it
> deallocates it from the inode and leaves a sparse hole) or a block that
> contains inodes or a superblock copy...

It gets treated as a block that has been claimed by two inodes (which
it is; the original inode and the bad block inode).  E2fsck gives the
user the option of (a) allocating a new block so that the file gets
replacement block with whatever data could be copied from the bad
block, or (b) if the user declines the first option, e2fsck next gives
the user the option of deleting the file containing bad block.

						- Ted



