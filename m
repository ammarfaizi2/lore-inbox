Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbVKIQWT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbVKIQWT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Nov 2005 11:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbVKIQWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Nov 2005 11:22:19 -0500
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:21656 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750969AbVKIQWT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Nov 2005 11:22:19 -0500
Date: Wed, 9 Nov 2005 08:22:15 -0800 (PST)
From: Vadim Lobanov <vlobanov@speakeasy.net>
To: "J.A. Magallon" <jamagallon@able.es>
cc: Kyle Moffett <mrmacman_g4@mac.com>, linas <linas@austin.ibm.com>,
       Douglas McNaught <doug@mcnaught.org>,
       Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
       bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, linuxppc64-dev@ozlabs.org
Subject: Re: typedefs and structs
In-Reply-To: <20051109111640.757f399a@werewolf.auna.net>
Message-ID: <Pine.LNX.4.58.0511090816300.4260@shell2.speakeasy.net>
References: <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com>
 <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com>
 <20051107204136.GG19593@austin.ibm.com> <1131412273.14381.142.camel@localhost.localdomain>
 <20051108232327.GA19593@austin.ibm.com> <B68D1F72-F433-4E94-B755-98808482809D@mac.com>
 <20051109003048.GK19593@austin.ibm.com> <m27jbihd1b.fsf@Douglas-McNaughts-Powerbook.local>
 <20051109004808.GM19593@austin.ibm.com> <19255C96-8B64-4615-A3A7-9E5A850DE398@mac.com>
 <20051109111640.757f399a@werewolf.auna.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Nov 2005, J.A. Magallon wrote:

> On Tue, 8 Nov 2005 20:51:25 -0500, Kyle Moffett <mrmacman_g4@mac.com> wrote:
>
> >
> > Pass by value in C:
> > do_some_stuff(arg1, arg2);
> >
> > Pass by reference in C:
> > do_some_stuff(&arg1, &arg2);
> >
> > This is very obvious what it does.  The compiler does type-checks to
> > make sure you don't get it wrong.  There are tools to check stack
> > usage of functions too.  This is inherently obvious what the code
> > does without looking at a completely different file where the
> > function is defined.
> >
> >
> > Pass by value in C++:
> > do_some_stuff(arg1, arg2);
> >
> > Pass by reference in C++:
> > do_some_stuff(arg1, arg2);
> >
> > This is C++ being clever and hiding stuff from the programmer, which
> > is Not Good(TM) for a kernel.  C++ may be an excellent language for
> > userspace programmers (I say "may" here because some disagree,
> > including myself), however, many of the features are extremely
> > problematic for a kernel.
> >
>
> Why is it not good for kernel ?
> You want to pass an struct to a function in the best way you can.
> Reference just pases a pointer instead of copying, but you don't
> realize.
> If you want the funcion to be able to modify the struct, code it as
>
> void do_some_stuff(T& arg1,T&  arg2)
>
> If you DO NOT want the funcion to be able to modify the struct, code it as
>
> void do_some_stuff(const T& arg1,const T& arg2)

A diligent C programmer would write this as follows:
	void do_some_stuff (struct T * a, struct T * b);
versus
	void do_more_stuff (const struct T * a, const struct T * b);
So I don't see C++ winning at all here.

> This is far better than in C,. because you get the benefits from
> reference pass without the problems of accidental modification of
> pointer contents. And get rid of arrows -> ;).
>
> If the function modifies the struct it should be obvious from its name,
> not depending if you put an & in the call or not.
> And you stop worrying about argument pass methods.

I think I'll call this my rule #1:
The moment you stop worrying about something is the moment it bites you
in the butt. :-) Much firsthand experience.

> The person who programs the function decides and can even change it without
> you user even noticing.

And if the caller is passing in something that's not meant to be
modified, then the modification causes much badness. Happens with both
languages, too.

> And gcc does nice optimizations when you mix const& and inlining...

As far as I know, nothing stops GCC from doing the exact same
optimizations in the function prototypes given above.

>
> --
> J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
> werewolf!able!es                         \         It's better when it's free
> Mandriva Linux release 2006.1 (Cooker) for i586
> Linux 2.6.14-jam1 (gcc 4.0.2 (4.0.2-1mdk for Mandriva Linux release 2006.1))
>

-Vadim Lobanov
