Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264219AbUD0QMm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbUD0QMm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264218AbUD0QMl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:12:41 -0400
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:29956 "EHLO
	pumpkin.fieldses.org") by vger.kernel.org with ESMTP
	id S264219AbUD0QMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:12:38 -0400
Date: Tue, 27 Apr 2004 12:12:33 -0400
To: Andreas Gruenbacher <agruen@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/11] nfsacl
Message-ID: <20040427161232.GC2086@fieldses.org>
References: <1082975143.3295.68.camel@winden.suse.de> <20040427151802.GA1490@fieldses.org> <1083081107.19655.160.camel@winden.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083081107.19655.160.camel@winden.suse.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2004 at 05:51:47PM +0200, Andreas Gruenbacher wrote:
> On Tue, 2004-04-27 at 17:18, J. Bruce Fields wrote:
> > On Mon, Apr 26, 2004 at 12:28:47PM +0200, Andreas Gruenbacher wrote:
> > > nfsacl-lazy-alloc
> > >    Allow to allocate pages in the receive buffers lazily. ACLs may have
> > >    up to 1024 entries in nfsacl but usually are small, so allocating
> > >    space for them on demand makes sense.
> > 
> > Is there any reason we couldn't set the maximum smaller than that?  It
> > looks like the acl entries are pretty compact (12 bytes if I'm reading
> > the xdr code right?) so if we limited the length of an xdr-encoded acl
> > to a page that would still allow a few hundred entries.  Are there
> > really people that need 1000-entry acls?
> 
> Well, that's what the protocol allows so I don't see why we shouldn't
> implement it fully. Besides, nfsacl-lazy-alloc benefits the common case
> even more, because with small acls that fit into xdr_buf->head entirely,
> no page needs to be allocated.

Hm, so looks like xdr_buf->head would fit about 150 entries.  Couldn't
that be enough?

--Bruce Fields
