Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267386AbUHXKHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267386AbUHXKHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 06:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267373AbUHXKHn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 06:07:43 -0400
Received: from imladris.demon.co.uk ([193.237.130.41]:55304 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S267386AbUHXKGG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 06:06:06 -0400
Date: Tue, 24 Aug 2004 11:05:55 +0100
From: Christoph Hellwig <hch@infradead.org>
To: James Morris <jmorris@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       viro@parcelfarce.linux.theplanet.co.uk,
       Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][1/7] xattr consolidation - libfs
Message-ID: <20040824110555.A27385@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	James Morris <jmorris@redhat.com>, Andrew Morton <akpm@osdl.org>,
	viro@parcelfarce.linux.theplanet.co.uk,
	Stephen Smalley <sds@epoch.ncsc.mil>, linux-kernel@vger.kernel.org
References: <20040823194936.A20008@infradead.org> <Xine.LNX.4.44.0408240026460.17851-100000@thoron.boston.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Xine.LNX.4.44.0408240026460.17851-100000@thoron.boston.redhat.com>; from jmorris@redhat.com on Tue, Aug 24, 2004 at 12:32:13AM -0400
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2004 at 12:32:13AM -0400, James Morris wrote:
> > limit on the number of xattrs.
> 
> Then you can't dynamically regsiter an xattr handler (e.g. as a module).  
> Is this really desirable?

IMHO yes.  This is an integral part of the filesystem, and the handlers are
really small anyway.  And it makes the code really a lot simpler.

> 
> > Also s/simple_// for most symbols as this stuff isn't simple, in fact it's
> > quite complex :)
> 
> Removing the prefix would imply that this was the 'proper' way to
> implement xattr support.  Really, these are just helper functions for the 
> simplest xattr implementations.  I think they should have some prefix, but 
> don't care too much what it actually is.  Suggestions?

I'd call them generic_.  I've done some research and they should work very
well for any xattr implementation in the tree.  As I mentioned in the
previous mail I'd like to get rid of the old inode operations for xattrs
completely in the long-term (I had been researching this before your patch
because I wanted to get rid of the access control checks in the filesystem
that are inherent with theses)

