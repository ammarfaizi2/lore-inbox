Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261537AbSJMPaE>; Sun, 13 Oct 2002 11:30:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261539AbSJMPaE>; Sun, 13 Oct 2002 11:30:04 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:22792 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261537AbSJMPaD>; Sun, 13 Oct 2002 11:30:03 -0400
Date: Sun, 13 Oct 2002 16:35:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Clark <michael@metaparadigm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Mark Peloquin <markpeloquin@hotmail.com>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
Message-ID: <20021013163551.A18184@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Clark <michael@metaparadigm.com>,
	Mark Peloquin <markpeloquin@hotmail.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com,
	evms-devel@lists.sourceforge.net
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com> <3DA969F0.1060109@metaparadigm.com> <20021013144926.B16668@infradead.org> <3DA98E48.9000001@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DA98E48.9000001@metaparadigm.com>; from michael@metaparadigm.com on Sun, Oct 13, 2002 at 11:16:24PM +0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 13, 2002 at 11:16:24PM +0800, Michael Clark wrote:
> On 10/13/02 21:49, Christoph Hellwig wrote:
> > On Sun, Oct 13, 2002 at 08:41:20PM +0800, Michael Clark wrote:
> > 
> >>Exactly. I think Christoph is comparing it to the original md
> >>architecture thich was more of an evolutionary design on the existing
> >>block layer
> > 
> > 
> > No, I do not.  MD is in _no_ ways a volume managment framwork but just
> > a few drivers that share common code.  That's somethig entirely different.
> 
> So why then the requirement that internal remapping layers be
> implemented as block devices?

I don't care how a single remapping layers is implemented.  I want
the common Voulme managment API work on public nodes.

> Neither is implementing an internal logical remapping layer as a
> block device just so you can do an ioctl directly to it.

Not without hacks. 

> I think the point is really explaining why they _should_ be accessed.
> If there is some valid reason other than having something you
> can do an ioctl on.

Because that

a) removes hacks like the EVMS pass-though
b) allows userspace to easily access it through read/write

> 
> > argumentation tell me why you haven't submitted a patch to Linus
> > yet to disallow direct access to block devices that are in use
> > by a filesystem.
> 
> I think the issue here is an md block device in use by another md block
> device. Possbily becuase md's design precludes this (a design artifact)
> (ie. md tools need access to the intermediary devices - users don't).

I'm not talksing about MD here.  Why do you want to disallow people
using a device just it has another layer above it.  E.g. write a change
to the ondisk structures (setting a flag, etcc..) is most logically
expressed by simple, O_DIRECT write to the actual device.


> Yes, but the block device encapsulation here removes the need for plugins
> to be implemented as block devices ie. removing complexity elsewhere.
> I must admit to not being an expert on the block layer - but wouldn't
> your suggesed approach mean intermediary layers would each have a
> request queue

It _coukd_ have a request queue, yes.

> and other unneeded stuff - if so, is this desirable?

What unneeded stuff?  block device state contains no state relevant
to userspace access.

> > This argument is NIL if the infrastructure is part of exactly that
> > evolving block layer.  You might have noticed that kernel code
> > compatility to other releases is not really a criteria for the
> > linux kernel development, btw..
> 
> I agree, maybe this would be worth doing for 2.7/2.8.

Yes.

> In the meatime
> do you think this would be feasible? - you are basically suggesting
> a complete rewrite

Exactly.

> (or do you think you can do the rewrite to IBM's
> satisfaction before the freeze ie. in the eternal linux kernel way,
> you want it you write it ;). Me, i'm happy with the current approach
> - but of course, i'm only a user ;).

_I_ don't want to get EVMS in, sorry.  I _do_ want a proper volume
managment framework, but I can live with it not beeing in before 2.8.

