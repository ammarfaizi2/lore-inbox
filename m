Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263243AbSJHTNk>; Tue, 8 Oct 2002 15:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263242AbSJHTNh>; Tue, 8 Oct 2002 15:13:37 -0400
Received: from ns.suse.de ([213.95.15.193]:64529 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261319AbSJHTIU> convert rfc822-to-8bit;
	Tue, 8 Oct 2002 15:08:20 -0400
Content-Type: text/plain; charset=US-ASCII
From: Andreas Gruenbacher <agruen@suse.de>
Organization: SuSE Linux AG
To: Christoph Hellwig <hch@infradead.org>, tytso@mit.edu
Subject: Re: [Ext2-devel] [RFC] [PATCH 3/4] Add extended attributes to ext2/3
Date: Tue, 8 Oct 2002 21:14:00 +0200
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org, ext2-devel@lists.sourceforge.net
References: <E17yymK-00021n-00@think.thunk.org> <20021008195322.A14585@infradead.org>
In-Reply-To: <20021008195322.A14585@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200210082114.00576.agruen@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 08 October 2002 20:53, Christoph Hellwig wrote:
> > +#ifdef CONFIG_EXT3_FS_XATTR_USER
> > +		if (!strcmp (this_char, "user_xattr"))
> > +			set_opt (*mount_options, XATTR_USER);
>
> If we really want a user_xattr mount option I'd suggest
> taking it into VFS.  But IMHO it's rather useless, just don't
> access them if you don't want to.

Users might just fill up all xattr space leaving no space for ACLs (or 
similar). If user xattrs are disabled this can no longer occur, so some 
administrators might be happy to have a choice.

> Also please get rid of the registration API for xattr handlers - this
> is inside a single module so hardconding them in the inode operations
> won't hurt.  the additional lock for the registration OTOH may hurt and
> it looks really overengineered.

With the registration API modules doing HSM/LSM/... can just register handlers 
without having to modify the file system code. Otherwise we would have to 
hand code additional hooks for independently loadable modules.

--Andreas.
