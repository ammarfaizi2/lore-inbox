Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269153AbUHZQ3m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269153AbUHZQ3m (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 12:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269180AbUHZQ3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 12:29:00 -0400
Received: from verein.lst.de ([213.95.11.210]:26074 "EHLO mail.lst.de")
	by vger.kernel.org with ESMTP id S269152AbUHZQYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 12:24:07 -0400
Date: Thu, 26 Aug 2004 18:23:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: Christoph Hellwig <hch@lst.de>, Christophe Saout <christophe@saout.de>,
       Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040826162354.GA4891@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Jamie Lokier <jamie@shareable.org>,
	Christophe Saout <christophe@saout.de>,
	Andrew Morton <akpm@osdl.org>, Hans Reiser <reiser@namesys.com>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	flx@namesys.com, torvalds@osdl.org, reiserfs-list@namesys.com
References: <20040825152805.45a1ce64.akpm@osdl.org> <412D9FE6.9050307@namesys.com> <20040826014542.4bfe7cc3.akpm@osdl.org> <1093522729.9004.40.camel@leto.cs.pocnet.net> <20040826124929.GA542@lst.de> <1093525234.9004.55.camel@leto.cs.pocnet.net> <20040826130718.GB820@lst.de> <20040826144422.GD5733@mail.shareable.org> <20040826160306.GA4326@lst.de> <20040826161911.GK5733@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040826161911.GK5733@mail.shareable.org>
User-Agent: Mutt/1.3.28i
X-Spam-Score: -4.901 () BAYES_00
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 26, 2004 at 05:19:11PM +0100, Jamie Lokier wrote:
> Remember that reiser4 allows you to operate on little pieces of data,
> glueing and rearranging them inside files (something like that).
> 
> No other filesystem has that capability, and it's a data model which
> the fancy features (when they exist) will use.
> 
> You can map those pieces to underlying directories and files and
> renames and unlinks, so that the fancy stuff works on other
> filesystems, but it would be a useless model because those other
> filesystems wouldn't be recognisably "ordinary" files any more.
> 
> For reiser4 to expose that model through a VFS interface, and the
> fancy stuff to use it through the VFS interface, and for the fancy
> stuff to work (even imperfectly) on other filesystems which don't
> offer those operations, some kind of fall-back "store metadata and
> fragment rearrangements in auxiliary files with special names" layer
> would be requied.  That's a big job.

I seem to miss those files in the current implementation.  But again the
big question is how will the interface look?  If the smaller objects
interact with normal files (link/rename, contained in normal
directories), they will have to obey the same locking protocols.  If not
a filesystem could experiment with it of course.

