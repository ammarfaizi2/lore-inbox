Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268239AbUHXTpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268239AbUHXTpR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 15:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268254AbUHXTpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 15:45:17 -0400
Received: from cantor.suse.de ([195.135.220.2]:19078 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S268239AbUHXToz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 15:44:55 -0400
Subject: Re: [PATCH][1/7] xattr consolidation - libfs
From: Andreas Gruenbacher <agruen@suse.de>
To: Christoph Hellwig <hch@infradead.org>, James Morris <jmorris@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20040824110555.A27385@infradead.org>
References: <20040823194936.A20008@infradead.org>
	 <Xine.LNX.4.44.0408240026460.17851-100000@thoron.boston.redhat.com>
	 <20040824110555.A27385@infradead.org>
Content-Type: text/plain
Organization: SUSE Labs
Message-Id: <1093376572.20259.115.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 21:42:53 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-08-24 at 12:05, Christoph Hellwig wrote:
> On Tue, Aug 24, 2004 at 12:32:13AM -0400, James Morris wrote:
> > > limit on the number of xattrs.
> > 
> > Then you can't dynamically regsiter an xattr handler (e.g. as a module).  
> > Is this really desirable?
> 
> IMHO yes.  This is an integral part of the filesystem, and the handlers are
> really small anyway.  And it makes the code really a lot simpler.

Dynamically handler registration seemed a good idea to me when I wrote
the original code, but there never was a real-world user for all I know,
so I'm fine with removing the rwlock. (The rest of the code can stay the
same.)

> > > Also s/simple_// for most symbols as this stuff isn't simple, in fact it's
> > > quite complex :)
> > 
> > Removing the prefix would imply that this was the 'proper' way to
> > implement xattr support.  Really, these are just helper functions for the 
> > simplest xattr implementations.  I think they should have some prefix, but 
> > don't care too much what it actually is.  Suggestions?
> 
> I'd call them generic_.  I've done some research and they should work very
> well for any xattr implementation in the tree.

I would just remove the simple_ to get xattr_register, xattr_unregister,
xattr_resolve_name, xattr_handler.

simple_xattr_list makes no sense in the general case, so this seems to
fit.

If we decide to remove dynamic handler registration, simple_xattr_list
should go as well, and the listxattr iops can enumerate all existing
handlers explicitly.

> [...]

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG


