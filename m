Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269117AbUHZQMp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269117AbUHZQMp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:12:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269153AbUHZQJy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:09:54 -0400
Received: from verein.lst.de ([213.95.11.210]:5850 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269154AbUHZQGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:06:13 -0400
Date: Thu, 26 Aug 2004 18:06:01 +0200
From: Christoph Hellwig <hch@lst.de>
To: Christophe Saout <christophe@saout.de>
Cc: Christoph Hellwig <hch@lst.de>, Andrew Morton <akpm@osdl.org>,
       Hans Reiser <reiser@namesys.com>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, flx@namesys.com, torvalds@osdl.org,
       reiserfs-list@namesys.com
Subject: Re: reiser4 plugins (was: silent semantic changes with reiser4)
Message-ID: <20040826160601.GB4326@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <1093526273.11694.8.camel@leto.cs.pocnet.net> <20040826132439.GA1188@lst.de> <1093527307.11694.23.camel@leto.cs.pocnet.net> <20040826134034.GA1470@lst.de> <1093528683.11694.36.camel@leto.cs.pocnet.net> <20040826153748.GA3700@lst.de> <1093535334.5482.1.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1093535334.5482.1.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 05:48:54PM +0200, Christophe Saout wrote:
> > > I don't know, ask Hans. How could the VFS know it a filesystem wants to
> > > do something specific with a file that is completely transparent to the
> > > VFS?
> > 
> > The VFS shouldn't, that the whole point.  That's why it allows the
> > filesystem to register different method tables for each object.
> 
> Only the objects it can distinguish.

Yes, every inode can have different operation vectors.  Which is the
smallest possible object the VFS knows about.

> >         ops->file    = reiser4_file_operations;
> >         ops->symlink = reiser4_symlink_inode_operations;
> >         ops->special = reiser4_special_inode_operations;
> >         ops->dentry  = reiser4_dentry_operations;
> >         ops->as      = reiser4_as_operations;
> 
> How could reiser4 register other operations for files that should be
> stored encrypted or compressed? It's all under reiser4_file_operations.

Again, your confusing upper and lower plugins.  For things happening
below the pagecache you could register different address_space
operations which sometimes makes sense.  But you want e.g. different
inode_operations for directories vs symlinks vs files.

Please read through some linux filesystem code, okay :)

