Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317861AbSIJQq2>; Tue, 10 Sep 2002 12:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317876AbSIJQq2>; Tue, 10 Sep 2002 12:46:28 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10258 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317861AbSIJQq1>; Tue, 10 Sep 2002 12:46:27 -0400
Date: Tue, 10 Sep 2002 09:51:07 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: David Brownell <david-b@pacbell.net>
cc: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>, Greg KH <greg@kroah.com>,
       <linux-usb-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>
Subject: Re: [linux-usb-devel] Re: [BK PATCH] USB changes for 2.5.34
In-Reply-To: <3D7E1EA2.3080506@pacbell.net>
Message-ID: <Pine.LNX.4.44.0209100947481.2842-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 10 Sep 2002, David Brownell wrote:
> > In short:
> >  
> >   Either you want debugging (in which case BUG() is the wrong thing to
> >   do), or you don't want debugging (in which case BUG() is the wrong thing
> >   to do). You can choose either, but in neither case is BUG() acceptable.
> 
> Or in even shorter sound bite format:  "Just say no to BUG()s."

Well, the thing is, BUG() _is_ sometimes useful. It's a dense and very 
convenient way to say that something catastrophic happened.

And actually, outside of drivers and filesystems you can often know (or
control) the number of locks the surrounding code is holding, and then a
BUG() may not be as lethal. At which point the normal "oops and kill the
process" action is clearly fine - the machine is still perfectly usable.

(In fact, on UP a BUG() tends to be quite usable just about anywhere 
except in an interrupt handler: there may be some local locks like 
directory semaphores etc that are held and not released, but _most_ of the 
time the machine is quite usable. SMP really does make things harder to 
debug even quite apart from the races it introduces. Sad.)

		Linus

