Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135585AbREIV3H>; Wed, 9 May 2001 17:29:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135635AbREIV26>; Wed, 9 May 2001 17:28:58 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:23058 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135585AbREIV2q>; Wed, 9 May 2001 17:28:46 -0400
Date: Wed, 9 May 2001 16:50:18 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: page_launder() bug
In-Reply-To: <15097.45528.322497.299933@pizda.ninka.net>
Message-ID: <Pine.LNX.4.21.0105091638540.14172-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 9 May 2001, David S. Miller wrote:

> 
> Marcelo Tosatti writes:
>  > > Let me state it a different way, how is the new writepage() framework
>  > > going to do things like ignore the referenced bit during page_launder
>  > > for dead swap pages?
>  > 
>  > Its not able to ignore the referenced bit. 
>  > 
>  > I know we want that, but I can't see any clean way of doing that. 
> 
> Unfortunately, one way would involve pushing the referenced bit check
> into the writepage() method.  But that is the only place we have the
> kind of information necessary to make these decisions.
> 
> This is exactly the kind of issue Linus and myself were talking
> about when the "cost analysis" parts of thie discussion began.

I'm not convinced that moving the referenced bit check inside writepage()
is worth it. We will duplicate code which is purely a VM job (ie check the
referenced bit and possibly remove the page from the inactive dirty list
and add it to the active list, _with_ the pagemap_lru_lock held), not a
pager job.

The PageDirty bit handling is different IMHO --- the pager is the one who
knows if it actually wrote the page or not. 










