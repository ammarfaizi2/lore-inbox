Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269436AbUICRB6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269436AbUICRB6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 13:01:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269416AbUICRB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 13:01:57 -0400
Received: from cantor.suse.de ([195.135.220.2]:38101 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S269515AbUICQ4f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 12:56:35 -0400
Subject: Re: The argument for fs assistance in handling archives
From: Chris Mason <mason@suse.com>
To: Hans Reiser <reiser@namesys.com>
Cc: David Masover <ninja@slaphack.com>, Steve Bergman <steve@rueb.com>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       Linus Torvalds <torvalds@osdl.org>, Jamie Lokier <jamie@shareable.org>,
       Horst von Brand <vonbrand@inf.utfsm.cl>, Adrian Bunk <bunk@fs.tum.de>,
       viro@parcelfarce.linux.theplanet.co.uk, Christoph Hellwig <hch@lst.de>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Alexander Lyamin aka FLX <flx@namesys.com>,
       reiserfs <reiserfs-list@namesys.com>
In-Reply-To: <413810B6.7020805@namesys.com>
References: <20040826150202.GE5733@mail.shareable.org>
	 <200408282314.i7SNErYv003270@localhost.localdomain>
	 <20040901200806.GC31934@mail.shareable.org>
	 <Pine.LNX.4.58.0409011311150.2295@ppc970.osdl.org>
	 <20040902002431.GN31934@mail.shareable.org> <413694E6.7010606@slaphack.com>
	 <Pine.LNX.4.58.0409012037300.2295@ppc970.osdl.org>
	 <4136A14E.9010303@slaphack.com>
	 <Pine.LNX.4.58.0409012259340.2295@ppc970.osdl.org>
	 <4136C876.5010806@namesys.com>
	 <Pine.LNX.4.58.0409020030220.2295@ppc970.osdl.org>
	 <4136E0B6.4000705@namesys.com>  <14260000.1094149320@flay>
	 <1094154744.12730.64.camel@voyager.localdomain>
	 <4137BC3C.4010207@slaphack.com>  <413810B6.7020805@namesys.com>
Content-Type: text/plain
Message-Id: <1094227041.6301.21.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 03 Sep 2004 12:02:49 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-09-03 at 02:35, Hans Reiser wrote:

> All this stuff about how no filesystem should be allowed to have 
> semantic features others don't, it seems very Bolshevist to me.
> 
> Let Linux have an ecosystem with a diverse ecology of filesystems, and 
> the features that work will reproduce to other filesystems.  I thought 
> that was the Linus way?
> 

There's no reason you can't have semantics the other filesystems don't. 
There's also no reason you shouldn't continue researching in any
direction you choose.

When you submit to the kernel (even just -mm), call the FS stable and
suggest people start broadly using it, you're telling them the parts you
have submitted are in fact fixed and reliable.

This implies you are done changing the semantics you have submitted,
which also implies you would like applications to start seriously using
it.  Those application writers will want other filesystems to be able to
support these new semantics, which means they should have a race free
framework vetted by the kernel community and available for reuse by the
other filesystems.  In other words, the semantics should be in the VFS,
without any requirement other FS's implement them, but the possibility
for every FS to implement them.

If you don't want the framework to be agreed on by the community and
available for other implementations, you either haven't stabilized the
semantics, or you don't want anyone else using them.  Either way, it
precludes inclusion in the kernel.  There are simply higher expectations
for a filesystem in these cases, and a higher burden for stable
semantics and interfaces.

This doesn't mean new semantics are impossible, it just means that
constantly changing semantics of the filesystem core are bad for users
and applications.  They belong in patches that live outside the kernel
until they are sufficiently researched to justify their inclusion.

The biggest victim of this discussion is the non-semantic part of
reiser4.  You've done a huge amount of research that is being held back
because you haven't separated the semantic research from the storage
layer areas.  If the storage layers are ready now, please please just
submit them.

-chris


