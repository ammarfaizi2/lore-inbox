Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261494AbSJHWNr>; Tue, 8 Oct 2002 18:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261429AbSJHWMO>; Tue, 8 Oct 2002 18:12:14 -0400
Received: from thunk.org ([140.239.227.29]:708 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id <S261427AbSJHWLf>;
	Tue, 8 Oct 2002 18:11:35 -0400
Date: Tue, 8 Oct 2002 18:17:10 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Message-ID: <20021008221710.GA9842@think.thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	"Stephen C. Tweedie" <sct@redhat.com>,
	Christoph Hellwig <hch@infradead.org>,
	Andreas Gruenbacher <agruen@suse.de>, linux-kernel@vger.kernel.org,
	ext2-devel@lists.sourceforge.net
References: <E17yymK-00021n-00@think.thunk.org> <20021008195322.A14585@infradead.org> <200210082114.00576.agruen@suse.de> <20021008202038.A15692@infradead.org> <20021008214143.O2717@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021008214143.O2717@redhat.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 08, 2002 at 09:41:43PM +0100, Stephen C. Tweedie wrote:
> 
> On Tue, Oct 08, 2002 at 08:20:38PM +0100, Christoph Hellwig wrote:
> > On Tue, Oct 08, 2002 at 09:14:00PM +0200, Andreas Gruenbacher wrote:
> > > Users might just fill up all xattr space leaving no space for ACLs (or 
> > > similar). If user xattrs are disabled this can no longer occur, so some 
> > > administrators might be happy to have a choice.
> > 
> > Umm, that's why we have quota..
> 
> It's the per-inode extended attribute space that's at risk here,
> quotas don't help.

Well, how about this as a compromise?  We define a new superblock
field which reserves a certain amount of space in the EA block for
"system" attributes.  The default will be zero, but if we want to
reserve space for the ACL, we can do that by adjusting the superblock
field.  (I'll add support into tune2fs for that purpose.)

I'll then remove the CONFIG #ifdef's and the user_xattr mount options.
(I hate having too many mount options, and this sort of thing should
be a per-filesystem run-time decision, not a compile-time option.)

Andreas, does that sound good to you?

						- Ted

