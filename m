Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbSJONJW>; Tue, 15 Oct 2002 09:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262621AbSJONJW>; Tue, 15 Oct 2002 09:09:22 -0400
Received: from thunk.org ([140.239.227.29]:58317 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S262547AbSJONJV>;
	Tue, 15 Oct 2002 09:09:21 -0400
Date: Tue, 15 Oct 2002 09:15:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] Add extended attributes to ext2/3
Message-ID: <20021015131507.GC31235@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
References: <E181IS8-0001DQ-00@snap.thunk.org> <20021015125816.A22877@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021015125816.A22877@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 15, 2002 at 12:58:16PM +0100, Christoph Hellwig wrote:
> It doesn't look like you addressed any comments raised, i.e. my
> complaints or sct's superblock fields.  I"ll start feeding some updates
> to akpm to address a few issues, but I don't really have time to
> care of all that.  

Actually, I did, for those comments that made sense.  The fs/Config.in
logic has been cleaned up, as well as removing excess header files,
stray LINUX_VERSION_CODE #ifdef's that I had missed the first time
around, etc.

fs/mbcache.c is still there because it applies to both ext2 and ext3
filesystems, and so your suggestion of moving it into the ext2 and
ext3 directories would cause code duplication and maintenance
headaches.  It also *can* be used by other filesystems, as it is
written in a generic way.  The fs/Config.in only compiles it in if
necessary (i.e., if ext2/3 extended attribute is enabled) so it won't
cause code bloat for other filesystems if it is not needed.

The superblock fields are more of an issue with the posix acl changes
than for the extended attribute patches.  I had wanted to get the
extended attribute changes in first, since they stand alone, and so I
have fewer patches to juggle.

						- Ted
