Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268438AbUH3BpI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268438AbUH3BpI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Aug 2004 21:45:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268430AbUH3Boz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Aug 2004 21:44:55 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:14244 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S268415AbUH3BoH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Aug 2004 21:44:07 -0400
Subject: Re: silent semantic changes with reiser4
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Hans Reiser <reiser@namesys.com>, flx@msu.ru, Paul Jackson <pj@sgi.com>,
       riel@redhat.com, ninja@slaphack.com, diegocg@teleline.es,
       jamie@shareable.org, christophe@saout.de,
       vda@port.imtp.ilyichevsk.odessa.ua, christer@weinigel.se,
       spam@tnonline.net, Andrew Morton <akpm@osdl.org>, wichert@wiggy.net,
       jra@samba.org, hch@lst.de,
       Linux Filesystem Development <linux-fsdevel@vger.kernel.org>,
       linux-kernel@vger.kernel.org, flx@namesys.com,
       reiserfs-list@namesys.com
In-Reply-To: <Pine.LNX.4.58.0408291641070.2295@ppc970.osdl.org>
References: <Pine.LNX.4.44.0408271043090.10272-100000@chimarrao.boston.redhat.com>
	 <412F7D63.4000109@namesys.com> <20040827230857.69340aec.pj@sgi.com>
	 <20040829150231.GE9471@alias> <4132205A.9080505@namesys.com>
	 <20040829183629.GP21964@parcelfarce.linux.theplanet.co.uk>
	 <20040829185744.GQ21964@parcelfarce.linux.theplanet.co.uk>
	 <41323751.5000607@namesys.com>
	 <20040829212700.GA16297@parcelfarce.linux.theplanet.co.uk>
	 <Pine.LNX.4.58.0408291431070.2295@ppc970.osdl.org>
	 <1093821430.8099.49.camel@lade.trondhjem.org>
	 <Pine.LNX.4.58.0408291641070.2295@ppc970.osdl.org>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1093830135.8099.181.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sun, 29 Aug 2004 21:42:15 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På su , 29/08/2004 klokka 19:54, skreiv Linus Torvalds:

> The problem really ends up being directories with attributes (where we
> can't just overmount the existing directory). That's where "openat()" 
> helps us. 

Well, yes there has to be a distinction between a true bind mount which
actually covers the file or directory, and something like the stream
"bind mount" which doesn't.

The stream "bind mount" is just there to allow you to root the
attributes in a single tree. It can be made functionally entirely
equivalent to the openat(), but uses pathname semantics (e.g., "//") to
denote the attribute fork instead of an extra function call.

> > Is it just the fantasy of supporting hard-links across "stream
> > boundaries" (as in "touch a b; ln b a/b; ln a b/a")? I'm pretty sure
> > nobody wants to have to add cyclic graph detection to their filesystems
> > anyway. 8-)
> 
> It's easy enough to do the graph detection at the VFS layer, exactly 
> because of the density of the dentry graph. 

Don't you end up having to lock the entire paths b/c/d and a/e/f in
order to prevent "ln a b/c/d/a; ln b a/e/f/b"?

> > What other issues would need to be addressed?

>  - how to actually test this out in practice (ie getting reiser4 to do the
>    proper thing wrt the VFS layer, but preferably _also_ having another
>    filesystem like NFSv4 or cifs that actually uses this and shows what
>    the problems are).

As I said, NFSv4 can be made ready pretty quickly: Bruce is already
finishing up the xattr implementation.

>  - whether it makes any sense at all unless we also make at least a few 
>    other filesystems support it, so that people start using it as an 
>    "expected feature" rather than a "works only on a couple of machines".

NTFS? ;-)

Cheers,
  Trond
