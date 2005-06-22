Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVFVJVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVFVJVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 05:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262864AbVFVHoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 03:44:00 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:57286 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262755AbVFVFe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 01:34:57 -0400
Date: Wed, 22 Jun 2005 06:34:50 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Hans Reiser <reiser@namesys.com>
Cc: Christoph Hellwig <hch@infradead.org>, Jeff Garzik <jgarzik@pobox.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       ReiserFS List <reiserfs-list@namesys.com>
Subject: Re: reiser4 plugins
Message-ID: <20050622053450.GA28228@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Hans Reiser <reiser@namesys.com>, Jeff Garzik <jgarzik@pobox.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	ReiserFS List <reiserfs-list@namesys.com>
References: <20050620235458.5b437274.akpm@osdl.org> <42B831B4.9020603@pobox.com> <42B87318.80607@namesys.com> <20050621202448.GB30182@infradead.org> <42B8B9EE.7020002@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42B8B9EE.7020002@namesys.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 06:07:58PM -0700, Hans Reiser wrote:
> Christoph,
> 
> Reiser4 users love the plugin concept, and all audiences which have
> listened to a presentation on plugins have been quite positive about
> it.  Many users think it is the best thing about reiser4.  Can you
> articulate why you are opposed to plugins in more detail?  Perhaps you
> are simply not as familiar with it as the audiences I have presented
> to.  Perhaps persons on our mailing list can comment.....

You're duplicating the VFS infrastructure with your pluging system.

> In particular, what is wrong with having a plugin id associated with
> every file, storing the pluginid on disk in permanent storage in the
> stat data, and having that plugin id define the set of methods that
> implement the vfs operations associated with a particular file, rather
> than defining VFS methods only at filesystem granularity?

Hans, this only shows you didn't listen to be the last few times I
explained it to you.  There's nothing wrong with defining plug in IDs
associated with every file, and the linux file_operations, inode_operations,
etc.. are _not_ filesystem granularity but inode granularity (except in
reiser4 where you throw everything together just to add your own
de-multiplexer below).  So the only thing your plugin might need to is to
define it's own file or inode operations (in fact it might need a few
more things speaking from experience with kinda similar things, but it
certainly doesn't need to duplicate what's there)

> What is wrong with having an encryption plugin implemented in this
> manner?  What is wrong with being able to have some files implemented
> using a compression plugin, and others in the same filesystem not.

There's nothing wrong with that, although such things might be better
as a stackable filesystem.  Maybe they're not, and we'll find out once
people are prototyping these things and playing with them. But you don't
need your additional layer of abstraction for those anyway

> What is wrong with having one file in the FS use a write only plugin, in
> which the encrypion key is changed with every append in a forward but
> not backward computable manner, and in order to read a file you must
> either have a key that is stored on another computer or be reading what
> was written after the moment of cracking root?

Because root can read kernel memory this is completely useless :)
But if you want it as your private patch no one forbits you to do it,
just don't expect such security by obscurity to go into mainline.

> What we have hurts no one but us.  I have never seen an audience for one
> of my talks that thought it hurt us..... most audiences think it is
> great.  

most of your audience doesn't understand the fine points of filesystem
implementation.  they want your feature but don't care how it's implemented.
here it's the other way around - we don't care too much about what not so
important features we have but more about how sanely they're implemented.

> Let us tinker with our FS, and you tinker with yours, and so long as
> what we do does not affect your FS, let the users choose.

Now we're getting personal again, right?  My filesystems according to
MAINTAINERS are freevxfs and sysfs, but if you look at commit logs I've
done work on pretty much any filesystem in the tree, and often doing tree-wide
changes.  That's why I care about every new filesystem in the tree and not
a single one.

