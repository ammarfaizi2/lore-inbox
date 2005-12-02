Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750729AbVLBQ4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750729AbVLBQ4z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 11:56:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750823AbVLBQ4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 11:56:55 -0500
Received: from mail22.sea5.speakeasy.net ([69.17.117.24]:17379 "EHLO
	mail22.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750729AbVLBQ4y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 11:56:54 -0500
Date: Fri, 2 Dec 2005 08:56:47 -0800 (PST)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: Bill Davidsen <davidsen@tmr.com>
cc: Coywolf Qi Hunt <coywolf@gmail.com>, Denis Vlasenko <vda@ilport.com.ua>,
       "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Paul Jackson <pj@sgi.com>, francis_moreau2000@yahoo.fr,
       linux-kernel@vger.kernel.org
Subject: Re: Use enum to declare errno values
In-Reply-To: <4390701C.1030803@tmr.com>
Message-ID: <Pine.LNX.4.58.0512020844560.27440@shell4.speakeasy.net>
References: <20051123132443.32793.qmail@web25813.mail.ukl.yahoo.com> 
 <20051123233016.4a6522cf.pj@sgi.com>  <Pine.LNX.4.61.0512011458280.21933@chaos.analogic.com>
  <200512020849.28475.vda@ilport.com.ua>  <2cd57c900512020127m5c7ca8e1u@mail.gmail.com>
  <84144f020512020418x7ebf5e3bt54cde14ec6a7a954@mail.gmail.com>
 <2cd57c900512020456n2f31101k@mail.gmail.com> <4390701C.1030803@tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Dec 2005, Bill Davidsen wrote:

> Coywolf Qi Hunt wrote:
> >
> > That is a bad bad style. It should be `#define FOO 123' if you have to
> > write it.
> >
> > It's also hard to see what the confusing bar is "if you are looking at
> > file.c alone".
> >
> > enum is worse than typdef.  Don't you see why we should use `struct
> > task_struct', rather than `task_t'?
> >
> > Introducing enum alone can't solve the problems from bad macro usage
> > habits. Actually, it's not anything wrong with macros, it's
> > programers' bad coding style.
>
> Using enum doesn't *solve* problems, it does *allow* type checking, and
> *prevent* namespace pollution. Use of typedef allows future changes, if
> you use "struct XXX" you're stuck with it.

You're not stuck with anything onerous in this case. Namely,

If you have "enum XXX" and you want to go to "enum YYY", then...
	sed 's/enum XXX/enum YYY/g'
If you have "struct XXX" and you want to go to "struct YYY", then...
	sed 's/struct XXX/struct YYY/g'
If you have "enum XXX" and you want to go to "struct YYY", then...
This is a big change, and should be done with care anyway. If struct YYY
happens to be large, then suddenly you can get all sorts of nifty stack
overflows.

In general, code that does not typedef enums and structs unless
absolutely necessary is easier to work with for these reasons:
1) The type of the variable is very obvious from its 'name', without the
uglyness that is Hungarian notation.
2) You don't need to include definition (such as from a header file)
just to declare a pointer to the type. Cuts down on #include clutter.
3) The enum namespace is separate from the struct namespace, which is
separate from other namespaces. Less naming collisions.

YMMV; not an invitation to start a coding style religious war

> --
> bill davidsen <davidsen@tmr.com>
>    CTO TMR Associates, Inc
>    Doing interesting things with small computers since 1979
> -

-Vadim Lobanov
