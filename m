Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318257AbSGXHhC>; Wed, 24 Jul 2002 03:37:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318258AbSGXHhB>; Wed, 24 Jul 2002 03:37:01 -0400
Received: from ns1.systime.ch ([194.147.113.1]:7434 "EHLO mail.systime.ch")
	by vger.kernel.org with ESMTP id <S318257AbSGXHhA>;
	Wed, 24 Jul 2002 03:37:00 -0400
From: "Martin Brulisauer" <martin@uceb.org>
To: Joshua MacDonald <jmacd@namesys.com>
Date: Wed, 24 Jul 2002 09:39:53 +0200
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
CC: neilb@cse.unsw.edu.au, linux-kernel@vger.kernel.org
Message-ID: <3D3E75E9.28151.2A7FBB2@localhost>
In-reply-to: <20020723220745.GD2090@reload.namesys.com>
References: <20020723114703.GM11081@unthought.net>
X-mailer: Pegasus Mail for Win32 (v3.12c)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jul 2002, at 2:07, Joshua MacDonald wrote:
> 
> This may interest you.  We have written a type-safe doubly-linked list
> template which is used extensively in reiser4.  This is the kind of thing that
> some people like very much and some people hate, so I'll spare you the
> advocacy.
> 
> Comments are welcome.

Hi,

In my oppinion the attached template is a very good school 
example of how to excessively use C-style macros. But macros 
tend to make debugging difficult and as you know every new code 
has bugs (if it seems not to have one, then it has at least two 
which "correct" each other until you fix one of them ...), and finding 
the bugs is mainly done by others. 

And who needs a "type-save" template for such a trivial thing like a 
dubbly-linked-list? If this is not buttom-line knowledge one should 
not try to do kernel level programming. By the way: Multiline C 
Macros are depreached and will not be supported by a future 
version of gcc and as for today will generate a bunch of warnings.

I have one additional comment to the current implementation:
> 
> #define TS_LINK_TO_ITEM(ITEM_TYPE,LINK_NAME,LINK) \
> 	((ITEM_TYPE *)((char *)(LINK)-(unsigned long)(&((ITEM_TYPE *)0)->LINK_NAME)))

As long as your pointers are 32bit this seems to be ok. But on 
64bit implementations pointers are not (unsigned long) so this cast 
seems to be wrong.

Regards,
Martin

