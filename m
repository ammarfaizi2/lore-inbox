Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319160AbSHTPmu>; Tue, 20 Aug 2002 11:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319166AbSHTPmu>; Tue, 20 Aug 2002 11:42:50 -0400
Received: from pD9E23620.dip.t-dialin.net ([217.226.54.32]:13959 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319160AbSHTPmt>; Tue, 20 Aug 2002 11:42:49 -0400
Date: Tue, 20 Aug 2002 09:45:48 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Daniel Phillips <phillips@arcor.de>
cc: Thunder from the hill <thunder@lightweight.ods.org>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Generic list push/pop
In-Reply-To: <E17hAxg-00011z-00@starship>
Message-ID: <Pine.LNX.4.44.0208200937460.3234-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 20 Aug 2002, Daniel Phillips wrote:
> > +#define slist_add_front(_new, _head)   \
> > +do {                                   \
> > +       _new->next = _head;             \
> > +       _head = _new->next;             \
> > +} while (0)
> 
> The second line is equivalent to _head = _head.

I see. Is there something we'll need to do? Or is it just for the day?

> > +#define slist_add(_new, _head)         \
> > +do {                                   \
> > +       _new->next = _head->next;       \
> > +       _head->next = _new;             \
> > +} while (0)
> 
> I don't see the point of this.  Why doesn't the caller just push_list onto
> head->next?

Because we still want to keep up the old list? If _head->next was NULL, no 
matter, we've added. If not, we've just inserted.

> #define push_list(list, node) do { \
> 	typeof(list) *_LIST_ = &(list), _NODE_ = (node); \
> 	_NODE_->next = *_LIST_; \
> 	*_LIST_ = _NODE_; } while (0)
> 
> #define pop_list(list) ({ \
> 	typeof(list) *_LIST_ = &(list), _NODE_ = *_LIST_; \
> 	*_LIST_ = (*_LIST_)->next; \
> 	_NODE_; })

I'd rather call them push_slist, pop_slist (or as above). Think of the 
millions of innocent people mixing lists and lists...

> On the third hand, if somebody does that they probably need bad things
> to happen to them.

This is perfect evolution. You end up having better code-checking, and a 
third hand.

>   - How do we know gcc will successfully optimize these things to the
>     same code you'd get if you simply wrote the two required assignments
>     out in full?  The local variables should disappear early in constant 
>     expression evaluation, but do they always?

We shall have a look at the assembler output.

>   - We assume the link field is named 'next'.

Must be forced then. Is it really that bad?

>   - They are ugly (but I don't care.  If you need to feast your eyes on
>     ugly, look at any pgtable.h)

We shall comment on them to reduce uglyness.

Summary:
 - We shall do it
 - We shall force it
 - We shall consider using slist names.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

