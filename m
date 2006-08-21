Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWHUNer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWHUNer (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 09:34:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030404AbWHUNer
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 09:34:47 -0400
Received: from mail.dotsterhost.com ([72.5.54.21]:64456 "HELO
	mail.dotsterhost.com") by vger.kernel.org with SMTP
	id S1030290AbWHUNeq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 09:34:46 -0400
Date: Mon, 21 Aug 2006 21:33:45 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-kernel@vger.kernel.org, aviro@redhat.com
Subject: Re: [PATCH] NFS: Replace null dentries that appear in readdir's list
 [try #2]
In-Reply-To: <323.1156162567@warthog.cambridge.redhat.com>
Message-ID: <Pine.LNX.4.64.0608212112350.28902@raven.themaw.net>
References: <Pine.LNX.4.64.0608211932300.27275@raven.themaw.net> 
 <Pine.LNX.4.64.0608202223220.29268@raven.themaw.net> <20060819094840.083026fd.akpm@osdl.org>
 <13319.1155744959@warthog.cambridge.redhat.com> <1155743399.5683.13.camel@localhost>
 <20060813133935.b0c728ec.akpm@osdl.org> <20060813012454.f1d52189.akpm@osdl.org>
 <5910.1155741329@warthog.cambridge.redhat.com> <2138.1155893924@warthog.cambridge.redhat.com>
 <3976.1156079732@warthog.cambridge.redhat.com> <30856.1156153373@warthog.cambridge.redhat.com>
  <323.1156162567@warthog.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2006, David Howells wrote:

> Ian Kent <raven@themaw.net> wrote:
> 
> > That makes it a bit hard as the /net functionality that Andrew is using is 
> > meant to mount all exports from the given server.
> 
> But does it _matter_ that the thing is mounted or dismounted as a unit?  And
> if so, why?

Yes with autofs version 4, because of the nesting of mounts which also 
introduces issues with expiration. Its basically due to the dependencies 
and the relatively simple minded way they are handled.

In version 5 they are mounted and umounted on demand.

> 
> > In v4 that are mounted and umounted as a unit to deal with the nesting.
> 
> Why does the automounter daemon have to do the mounting of submounts?  What's
> wrong with having the kernel do it?  The one problem with having the kernel do
> it that I can see, is that the kernel doesn't update /etc/mtab.

v2 and v3 won't do the expire, will they?
Not updating the mtab will be a problem for me also and possibly for 
users that expect to see mounts in it.

The "/net" functionality is a standard, expected automounter function.

> 
> 
> Note that rather than manually mounting the submounts, you could just open and
> close those directories as that should cause them to automount - though the
> xdev mountpoints will expire and become automatically unmounted after a
> certain period.

The xdev (assume you mean NFSv4 submounts) mounts will be the area I need 
to work on, for sure.

I don't quite understand the "open will cause the automount" for NFS 
version < 4. The automounter calls mount(8) when it gets a packet from the 
autofs[4] kernel module due to an access.

I expect that I won't have to do much at all for xdev mounts except to be 
able to recoginize them and their owners so I can leave them alone. The 
expire function might be a bit interesting.

Ian
