Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265065AbTB0OXW>; Thu, 27 Feb 2003 09:23:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265097AbTB0OXW>; Thu, 27 Feb 2003 09:23:22 -0500
Received: from smtpzilla1.xs4all.nl ([194.109.127.137]:35080 "EHLO
	smtpzilla1.xs4all.nl") by vger.kernel.org with ESMTP
	id <S265065AbTB0OXV>; Thu, 27 Feb 2003 09:23:21 -0500
Date: Thu, 27 Feb 2003 15:33:10 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: Werner Almesberger <wa@almesberger.net>
cc: Rusty Russell <rusty@rustcorp.com.au>, <kuznet@ms2.inr.ac.ru>,
       <kronos@kronoz.cjb.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Is an alternative module interface needed/possible?
In-Reply-To: <20030227102032.K2092@almesberger.net>
Message-ID: <Pine.LNX.4.44.0302271516140.1336-100000@serv>
References: <20030218050349.44B092C04E@lists.samba.org> <20030218042042.R2092@almesberger.net>
 <Pine.LNX.4.44.0302181252570.1336-100000@serv> <20030218111215.T2092@almesberger.net>
 <20030218142257.A10210@almesberger.net> <Pine.LNX.4.44.0302191454520.1336-100000@serv>
 <20030219231710.Y2092@almesberger.net> <Pine.LNX.4.44.0302212202020.1336-100000@serv>
 <20030226202647.H2092@almesberger.net> <Pine.LNX.4.44.0302271321190.1336-100000@serv>
 <20030227102032.K2092@almesberger.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 27 Feb 2003, Werner Almesberger wrote:

> > There are several module interfaces:
> > - module user interface
> > - module load interface
> > - module driver interface
> 
> Hmm, the "load interface" would be the system calls, while
> the "driver interface" would be initialization and cleanup
> functions in the module ?
> 
> We've already established that most things called from the
> latter isn't actually module specific.

But the module driver interface has an impact on the other driver 
interfaces and that's what I tried to describe in the previous mail.

> > These are quite independent and so far we were talking about the last one, 
> > so I'm a bit confused about your request to talk about the first.
> 
> I'm not so sure about them being independent. E.g. if we
> just had a blocking single-phase cleanup, users would always
> see success, but resources may be tied up indefinitely, which
> would break uses like
> 
> rmmod foo
> insmod foo.o

rmmod could already fail before, because the module is busy, so I'm not 
sure, what should break here.

> On the other hand, with a non-blocking two-phase cleanup, users
> would still always see success, but only "anonymous" resources
> (memory, etc.) would be tied up.
> 
> Last but not least, a non-blocking single-phase cleanup would
> expose all failures to the user, and require some retry strategy.

Now you're skipping ahead. You are already looking at the possible 
consequences for the module user interface, before we actually made clear 
in which ways the module driver interface could be changed.
There are of course dependencies between the interfaces, but you can 
change a lot in one before you have to modify another.

> Furthermore, use counts can have several meanings:
>  - indicate when it's convenient for the module to be removed
>  - indicate when it's possible for the module to be removed
>  - indicate what consequences the user may experience if
>    trying to remove now (e.g. blocking)
> 
> The "old" module count was a bit of a mixture of the first two.
> The "new" count is clearer.

There is/was no count for the first?!
Which "new" count?

bye, Roman


