Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287439AbSAUPks>; Mon, 21 Jan 2002 10:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287163AbSAUPkh>; Mon, 21 Jan 2002 10:40:37 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63053 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S287148AbSAUPkT>; Mon, 21 Jan 2002 10:40:19 -0500
To: Hans Reiser <reiser@namesys.com>
Cc: Mark Hahn <hahn@physics.mcmaster.ca>, Rik van Riel <riel@conectiva.com.br>,
        linux-kernel@vger.kernel.org
Subject: Re: Possible Idea with filesystem buffering.
In-Reply-To: <Pine.LNX.4.33.0201201247270.6499-100000@coffee.psychology.mcmaster.ca>
	<3C4B35AB.4040801@namesys.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 21 Jan 2002 08:37:12 -0700
In-Reply-To: <3C4B35AB.4040801@namesys.com>
Message-ID: <m1r8ojg1g7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser <reiser@namesys.com> writes:

> Mark Hahn wrote:
> 
> >On Sun, 20 Jan 2002, Hans Reiser wrote:
> >
> >> Write clustering is one thing it achieves.   When we flush a slum, the
> >
> >sure, that's fine.  when the VM tells you to write a page,
> >you're free to write *more*, but you certainly must give back
> > that particular page.  afaicr, this was the conclusion of the long-ago thread
> > that you're referring to.
> >
> >regards, mark hahn.
> >
> >
> >
> This is bad for use with internal nodes.  It simplifies version 4 a bunch to
> assume that if a node is in cache, its parent is also.  Not sure what to do
> about it, maybe we need to copy the node.  Surely we don't want to copy it
> unless it is a DMA related page cleaning.

Increment the count on the parent page, and don't decrement it until
the child goes away.  This might need a notification from
page_cache_release when so you can decrement the count at the
appropriate time.  But internal nodes are ``meta'' data which has
always had special freeing rules.

Eric
