Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315748AbSGXJxq>; Wed, 24 Jul 2002 05:53:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316434AbSGXJxq>; Wed, 24 Jul 2002 05:53:46 -0400
Received: from reload.namesys.com ([212.16.7.75]:9103 "EHLO reload.namesys.com")
	by vger.kernel.org with ESMTP id <S315748AbSGXJxp>;
	Wed, 24 Jul 2002 05:53:45 -0400
Date: Wed, 24 Jul 2002 13:56:56 +0400
From: Joshua MacDonald <jmacd@namesys.com>
To: Martin Brulisauer <martin@uceb.org>
Cc: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
Message-ID: <20020724095656.GB11106@reload.namesys.com>
Mail-Followup-To: Martin Brulisauer <martin@uceb.org>,
	neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
References: <20020723114703.GM11081@unthought.net> <3D3E75E9.28151.2A7FBB2@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D3E75E9.28151.2A7FBB2@localhost>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 24, 2002 at 09:39:53AM +0200, Martin Brulisauer wrote:
> On 24 Jul 2002, at 2:07, Joshua MacDonald wrote:
> > 
> > This may interest you.  We have written a type-safe doubly-linked list
> > template which is used extensively in reiser4.  This is the kind of thing that
> > some people like very much and some people hate, so I'll spare you the
> > advocacy.
> > 
> > Comments are welcome.
> 
> Hi,
> 
> In my oppinion the attached template is a very good school 
> example of how to excessively use C-style macros. But macros 
> tend to make debugging difficult and as you know every new code 
> has bugs (if it seems not to have one, then it has at least two 
> which "correct" each other until you fix one of them ...), and finding 
> the bugs is mainly done by others. 
>
> And who needs a "type-save" template for such a trivial thing like a 
> dubbly-linked-list? If this is not buttom-line knowledge one should 
> not try to do kernel level programming. By the way: Multiline C 
> Macros are depreached and will not be supported by a future 
> version of gcc and as for today will generate a bunch of warnings.

The list code is trivial, but when you have 10 classes of list and no type
safety between independent list classes or even between the list head and list
item types, there is a strong possibility you will pass the wrong argument to
some list routine because there is nothing to stop you.

The list code is trivial.  It doesn't make debugging difficult.  It is
bottom-line knowledge.  But why make things difficult for yourself -- just to
prove you can?

I can say a lot of good and bad things about C++, but at least it lets you do
this kind of thing with type safety and without ugly macros.

> I have one additional comment to the current implementation:
> > 
> > #define TS_LINK_TO_ITEM(ITEM_TYPE,LINK_NAME,LINK) \
> > 	((ITEM_TYPE *)((char *)(LINK)-(unsigned long)(&((ITEM_TYPE *)0)->LINK_NAME)))
> 
> As long as your pointers are 32bit this seems to be ok. But on 
> 64bit implementations pointers are not (unsigned long) so this cast 
> seems to be wrong.

-josh
