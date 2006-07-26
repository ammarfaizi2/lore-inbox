Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbWGZKZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbWGZKZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 06:25:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932201AbWGZKZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 06:25:58 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:18592 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932170AbWGZKZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 06:25:57 -0400
Date: Wed, 26 Jul 2006 14:25:07 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: Christoph Hellwig <hch@infradead.org>, lkml <linux-kernel@vger.kernel.org>,
       David Miller <davem@davemloft.net>, Ulrich Drepper <drepper@redhat.com>,
       netdev <netdev@vger.kernel.org>
Subject: Re: [3/4] kevent: AIO, aio_sendfile() implementation.
Message-ID: <20060726102507.GC2715@2ka.mipt.ru>
References: <1153905495613@2ka.mipt.ru> <11539054952574@2ka.mipt.ru> <20060726100013.GA7126@infradead.org> <20060726100848.GA2715@2ka.mipt.ru> <20060726101356.GA8443@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20060726101356.GA8443@infradead.org>
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Wed, 26 Jul 2006 14:25:07 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 11:13:56AM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> On Wed, Jul 26, 2006 at 02:08:49PM +0400, Evgeniy Polyakov wrote:
> > On Wed, Jul 26, 2006 at 11:00:13AM +0100, Christoph Hellwig (hch@infradead.org) wrote:
> > > >  struct address_space_operations ext2_aops = {
> > > > +	.get_block		= ext2_get_block,
> > > 
> > > No way in hell.  For whatever you do please provide a interface at
> > > the readpage/writepage/sendfile/etc abstraction layer.  get_block is
> > > nothing that can be exposed to the common code.
> > 
> > Compare this with sync read methods - all they do is exactly the same
> > operations with low-level blocks, which are combined into nice exported
> > function, so there is _no_ readpage layer - it calls only one function
> > which works with blocks.
> 
> No.  The abtraction layer there is ->readpage(s).  _A_ common implementation
> works with a get_block callback from the filesystem, but there are various
> others.  We've been there before, up to mid-2.3.x we had a get_block inode
> operation and we got rid of it because it is the wrong abstraction.

Well, kevent can work not from it's own, but with common implementation,
which works with get_block(). No problem here.

> > So it is not a technical problem, but political one.
> 
> It's a technical problem, and it's called get you abstractions right.  And
> ontop of that a political one and that's called get your abstraction coherent.
> If you managed to argue all of us into accept that get_block is the right
> abstraction (and as I mentioned above that's technically not true) you'd
> still have the burden to update everything to use the same abstraction.

Christoph, I completely understand your point of view.
There is absolutely no technical problem to create common async implementation,
and place it where existing sync lives and call from readpage() level.

It just requires to allow to change BIO callbacks instead of default
one, and (probably) event sync readpage can be used.

-- 
	Evgeniy Polyakov
