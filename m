Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261540AbSJHWQe>; Tue, 8 Oct 2002 18:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261570AbSJHWQS>; Tue, 8 Oct 2002 18:16:18 -0400
Received: from thunk.org ([140.239.227.29]:2756 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261540AbSJHWQB>;
	Tue, 8 Oct 2002 18:16:01 -0400
Date: Tue, 8 Oct 2002 18:21:40 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Message-ID: <20021008222140.GB9842@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E17yymK-00021n-00@think.thunk.org> <20021008195322.A14585@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008195322.A14585@infradead.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 07:53:22PM +0100, Christoph Hellwig wrote:
> 
> Also please get rid of the registration API for xattr handlers - this
> is inside a single module so hardconding them in the inode operations
> won't hurt.  the additional lock for the registration OTOH may hurt and
> it looks really overengineered.

The registration API is also used for the ACL routines.  That's why
it's there.

That being said, I'm not at all convinced that allowing things like
the EA routines and the ACL routines to be separate modules is a good
idea.  Life would be much simpler if everything was compiled into a
single ext3 subsystem, and we eliminate all of the extra overhead of
having separate modules for specific filesystem features.  Certainly
the XFS and JFS folks didn't go down this path.

(That's why I took out to the questions in Config.in; I really felt
that it was wrong.  I however didn't want to go as far as to remove
the #ifdef's and removing the registration API's without at least
having some discussion on the topic.)

						- Ted
