Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964823AbVLGC0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964823AbVLGC0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 21:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964855AbVLGC0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 21:26:16 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:17069 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964823AbVLGC0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 21:26:16 -0500
Date: Wed, 7 Dec 2005 02:26:10 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Paul Mackerras <paulus@samba.org>
Cc: Pekka Enberg <penberg@cs.helsinki.fi>, Arnd Bergmann <arnd@arndb.de>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       arjan@infradead.org
Subject: Re: [PATCH 02/14] spufs: fix local store page refcounting
Message-ID: <20051207022610.GI27946@ftp.linux.org.uk>
References: <20051206035220.097737000@localhost> <200512061118.19633.arnd@arndb.de> <1133869108.7968.1.camel@localhost> <200512061949.33482.arnd@arndb.de> <1133895947.3279.4.camel@localhost> <17301.65082.251692.675360@cargo.ozlabs.ibm.com> <1133905298.8027.13.camel@localhost> <17302.3696.364669.18755@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17302.3696.364669.18755@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:19:28AM +1100, Paul Mackerras wrote:
> Think about someone changing the VFS layer interface and fixing up all
> the filesystems to accommodate that change.  That person is doing some
> of your work for you, so you want to make it easy for him/her to find
> your filesystem.  That's the sort of thing I was referring to as
> maintenance.

FWIW, I think it's not a serious argument.  Interface changes => grep time.
And that means grep over the tree anyway.
 
> As for changes on the cell-specific side, the people doing those
> changes will know where to find it, so it isn't a problem having it in
> fs/.
> 
> Having it in fs/ also means that it is more likely that people
> familiar with VFS internals will look through your code and comment on
> it.  I know that can be painful in the short term, but in the long
> term it will lead to better code.

That's solved by asking for review...

As far as I'm concerned, the only thing here that looks like a possible
reason to move the entire thing is highly unusual semantics of final
close and interesting use of VFS interfaces in spu_create().  I.e. it's
not that we have a filesystem there.

OTOH, if you go looking for analogs as far as unusual interaction with VFS
is concerned...  net/unix is unlikely to get moved.
