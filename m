Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261631AbUD0Pvt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261631AbUD0Pvt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 11:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262930AbUD0Pvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 11:51:49 -0400
Received: from ns.suse.de ([195.135.220.2]:37564 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261631AbUD0Pvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 11:51:48 -0400
Subject: Re: [PATCH 0/11] nfsacl
From: Andreas Gruenbacher <agruen@suse.de>
To: "J. Bruce Fields" <bfields@fieldses.org>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040427151802.GA1490@fieldses.org>
References: <1082975143.3295.68.camel@winden.suse.de>
	 <20040427151802.GA1490@fieldses.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1083081107.19655.160.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Tue, 27 Apr 2004 17:51:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-27 at 17:18, J. Bruce Fields wrote:
> On Mon, Apr 26, 2004 at 12:28:47PM +0200, Andreas Gruenbacher wrote:
> > nfsacl-lazy-alloc
> >    Allow to allocate pages in the receive buffers lazily. ACLs may have
> >    up to 1024 entries in nfsacl but usually are small, so allocating
> >    space for them on demand makes sense.
> 
> Is there any reason we couldn't set the maximum smaller than that?  It
> looks like the acl entries are pretty compact (12 bytes if I'm reading
> the xdr code right?) so if we limited the length of an xdr-encoded acl
> to a page that would still allow a few hundred entries.  Are there
> really people that need 1000-entry acls?

Well, that's what the protocol allows so I don't see why we shouldn't
implement it fully. Besides, nfsacl-lazy-alloc benefits the common case
even more, because with small acls that fit into xdr_buf->head entirely,
no page needs to be allocated.

Cheers,
-- 
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX AG

