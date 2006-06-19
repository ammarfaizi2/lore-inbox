Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWFSRDi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWFSRDi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964804AbWFSRDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:03:38 -0400
Received: from thunk.org ([69.25.196.29]:4301 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S964802AbWFSRDh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:03:37 -0400
Date: Mon, 19 Jun 2006 13:03:38 -0400
From: Theodore Tso <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 5/8] inode-diet: Eliminate i_blksize and use a per-superblock default
Message-ID: <20060619170338.GB15216@thunk.org>
Mail-Followup-To: Theodore Tso <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
References: <20060619152003.830437000@candygram.thunk.org> <20060619153109.817554000@candygram.thunk.org> <20060619155821.GA27867@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060619155821.GA27867@infradead.org>
User-Agent: Mutt/1.5.11
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 19, 2006 at 04:58:21PM +0100, Christoph Hellwig wrote:
> On Mon, Jun 19, 2006 at 11:20:08AM -0400, Theodore Tso wrote:
> > This eliminates the i_blksize field from struct inode and uses default
> > value in super->s_blksize.  Filesystems that want to provide a
> > per-inode st_blksize can do so by providing their own getattr routine
> > instead of using the generic_fillattr() function.
> > 
> > Note that some filesystems were providing pretty much random (and
> > incorrect) values for i_blksize.
> 
> Blease don't add a field to the superblock for the optimal I/O size.
> Any filesystem that wants to override it can do so directly in ->getattr.

I was mainly adding a field to the superblock for the sake of
reiserfs; it was the easiest way to support it's current insanity of
reporting 128megs as st_blksize, but with a mount option that affected
things on a global scale.  (Hey, at least my patch made resierfs
support the mount option as a per-superblock setting, instead of
setting a global variable that changed the behaviour for all mounts.)

I don't mind espceially removing the superblock field, but if we do, I
refuse to mess with adding a getattr special for reiserfs; someone who
wants to support its current behaviour is free to send me or LKML
patches....


						- Ted
