Return-Path: <linux-kernel-owner+w=401wt.eu-S932245AbXAIRE3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbXAIRE3 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 12:04:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbXAIRE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 12:04:28 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:50935 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbXAIRE1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 12:04:27 -0500
Date: Tue, 9 Jan 2007 18:04:26 +0100
From: Jan Kara <jack@suse.cz>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Erez Zadok <ezk@cs.sunysb.edu>, Andrew Morton <akpm@osdl.org>,
       "Josef 'Jeff' Sipek" <jsipek@cs.sunysb.edu>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       hch@infradead.org, viro@ftp.linux.org.uk, torvalds@osdl.org,
       mhalcrow@us.ibm.com, David Quigley <dquigley@cs.sunysb.edu>
Subject: Re: [PATCH 01/24] Unionfs: Documentation
Message-ID: <20070109170426.GB23174@atrey.karlin.mff.cuni.cz>
References: <20070108111852.ee156a90.akpm@osdl.org> <200701082051.l08KpV8b011212@agora.fsl.cs.sunysb.edu> <20070109122644.GB1260@atrey.karlin.mff.cuni.cz> <1168360778.6054.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1168360778.6054.26.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, 2007-01-09 at 13:26 +0100, Jan Kara wrote:
> >   Yes, making fs readonly at VFS level would not work for already opened
> > files. But you if you create new union, you could lock down the
> > filesystems you are unioning (via s_umount semaphore), go through lists
> > of all open fd's on those filesystems and check whether they are open
> > for write or not. If some fd is open for writing, you simply fail to
> > create the union (and it's upto user to solve the problem). Otherwise
> > you mark filesystems as RO and safely proceed with creating the union.
> > I guess you must have come up with this solution. So what is the problem
> > with it?
> 
> Aside from the fact that this is racy (s_umount doesn't protect you
> against a process opening a new file while you are busy running through
> the open fds to see if you can reset the MS_RDONLY flag) all you will
  Ok, but if we first set MS_RDONLY and then check, we should be safe
against new open's.

> have achieved is ensure that your client won't write to the file. You
> will still be able to Oops.
  But once you have MS_RDONLY set, there should be no modifications of
the underlying filesystem, should they? And I have understood that the
only problem is modifying the filesystem underneath unionfs. But maybe
I'm missing something.

								Honza
-- 
Jan Kara <jack@suse.cz>
SuSE CR Labs
