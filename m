Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263427AbTEIUSD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 16:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263434AbTEIUSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 16:18:03 -0400
Received: from SCULLY.TRAFFORD.DEMENTIA.ORG ([128.2.245.230]:3247 "EHLO
	scully.trafford.dementia.org") by vger.kernel.org with ESMTP
	id S263427AbTEIUR6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 16:17:58 -0400
Date: Fri, 9 May 2003 16:30:32 -0400 (EDT)
From: Derrick J Brashear <shadow@dementia.org>
X-X-Sender: shadow@scully.trafford.dementia.org
To: David Howells <dhowells@redhat.com>
cc: openafs-devel@openafs.org, linux-kernel@vger.kernel.org
Subject: Re: Adding an "acceptable" interface to the Linux kernel for AFS 
In-Reply-To: <3043.1052511582@warthog.warthog>
Message-ID: <Pine.LNX.4.53.0305091624520.31198@scully.trafford.dementia.org>
References: <3043.1052511582@warthog.warthog>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 9 May 2003, David Howells wrote:

> > There are valid reasons to allow a PAG to be specified, but only with
> > priviledge. e.g. user mode protocol translator (afs to nfs)
>
> I suppose I can do that... I can add a hook to the security framework or add a
> an extra capability to allow a finer degree of control.
>
> Perhaps:
>
> 	newpag()	<--- new PAG
> 	setpag(0)	<--- no PAG
> 	setpag(>0)	<--- join PAG if permitted

Sure.

> > The uid of the current process. Again, if you're in a PAG you don't get
> > uid tokens. You could create 2 PAG number spaces, 1 using uid
> > and one sequential alloc, but then you need more management I guess (or to
> > assume kernel code will be able to provide hooks for accepting tokens
> > regardless of PAG and just let people who care deal in their code)
>
> Getting the per-user PAG data from the current process becomes a little
> trickier when worker kernel threads become involved:-/
>
> Maybe each user_struct should _also_ have a normal PAG associated with
> it. Asking for "no PAG" joins the calling process into its owner user's
> PAG. Then you only need one number space...

As long as the PAG number itself is tied to and not directly the uid, that
should work.

> However, doing this would affect authentication tokens for every FS that
> stored them in this way, not just AFS (Samba for instance).

If each FS has its own tokens, I assume there's no problem if you don't
allow setting of any for those that don't support non-PAG tokens?

> > > I don't have documentation on VIOCPREFETCH, but if it's anything like the
> > > other two, then it shouldn't be a problem either.
> >
> > Takes a path to attempt to prefetch as a text string.
>
> I take it that "prefetch" means try and fetch the entire file into the cache?

Yes.

