Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265063AbUFAN75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265063AbUFAN75 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jun 2004 09:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265064AbUFAN75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jun 2004 09:59:57 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:4736 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S265063AbUFAN72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jun 2004 09:59:28 -0400
Date: Tue, 1 Jun 2004 15:06:03 +0100
From: John Bradford <john@grabjohn.com>
Message-Id: <200406011406.i51E63lR000199@81-2-122-30.bradfords.org.uk>
To: Pavel Machek <pavel@ucw.cz>,
       Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: Giuseppe Bilotta <bilotta78@hotpop.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20040601113113.GA16312@elf.ucw.cz>
References: <xb7aczqb2sv.fsf@savona.informatik.uni-freiburg.de>
 <20040601113113.GA16312@elf.ucw.cz>
Subject: Re: keyboard problem with 2.6.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quote from Pavel Machek <pavel@ucw.cz>:
> Hi!
> 
> > >>>>> "Giuseppe" == Giuseppe Bilotta <bilotta78@hotpop.com> writes:
> > 
> >     Giuseppe> So, while we wait for complete support, at the kernel
> >     Giuseppe> level, for all the multimedia keyboards supported by X,
> >     Giuseppe> we *need* proper raw mode.
> > 
> > My question is: why do everything inside the kernel?
> > 
> > 
> > Even  'khttpd' has  been removed  from  the kernel,  because the  same
> > efficiency has been achieved in  the *userland* apache module.  Why is
> > the input layer moving _backwards_?
> > 
> > I  don't think  converting  between keyboard/mouse  protocols and  the
> > input   system's  "struct   input_event"  has   a   tighter  real-time
> > requirement  than a  heavily loaded  web  server.  How  many keys  per
> > second can  you type  at?  (Even  if you type  extremely fast  and the
> > hardware constraints  (velocity, etc.) are  not reached yet,  there is
> > still  a  limit that  the  keyboard  controller,  e.g.  i8042,  cannot
> > exceed.)  How  many mouse movements are  you making per  second?  Is a
> > userland driver unable  to handle that data rate?   (I don't think so.
> > I believe enve a 386-DX 33MHz  can handle it with ease.)  If not, then
> > please do it  in userland, so as not to waste  kernel memory (which is
> > *NON-swappable*).
> 
> It would be nice to have keyboard in kernel because that means
> keyboard works even on heavilly overloaded system, in case of oops
> etc. (Unfortunately steps back were already taken; console switching
> is no longer so robust w.r.t. kernel crashes :-( ).

I think it's nice to have input handling for the _console_ in the kernel
for the above reasons.  In most cases a PS/2 keyboard and mouse are the
console input devices, but where they aren't, userspace processing might
be more logical.

I think that Vojtech mentioned at some time that the in-kernel PS/2 emulation
was mostly a workaround for X until X was capable of accessing the keyboard
directly.  Well, I would take this one stage further and say that the way I
see it, in normal use, an X-based system shouldn't need a console configured
in the kernel at all.

Of course, I probably wouldn't use a system like that, it wouldn't be likely
to interest me at all, but I can see that it might suit normal desktop
machines quite well.

So, in my opinion, it's all about X, and nothing about the kernel.

However, I don't even have much interest in X itself these days, prefering
to work on the console :-).

John.
