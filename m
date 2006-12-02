Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424462AbWLBWNb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424462AbWLBWNb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 17:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424460AbWLBWNb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 17:13:31 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:28817 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1424453AbWLBWNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 17:13:30 -0500
Date: Sat, 2 Dec 2006 23:13:21 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Al Viro <viro@ftp.linux.org.uk>
cc: Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
In-Reply-To: <20061202215941.GN3078@ftp.linux.org.uk>
Message-ID: <Pine.LNX.4.64.0612022306360.1867@scrub.home>
References: <20061201172149.GC3078@ftp.linux.org.uk>
 <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk>
 <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, 2 Dec 2006, Al Viro wrote:

> > You need some more magic macros to access/modify the data field.
> 
> Which is done bloody rarely.  grep and you'll see...  BTW, there are
> other reasons why passing struct timer_list * is wrong:
> 	* direct calls of the timer callback

Why should that be wrong?

> 	* callback being the same for two timers embedded into
> different structs

That's done bloody rarely as well.

> 	* see a timer callback, decide it looks better as a tasklet.
> What, need a different glue now?

What's wrong with changing the prototype? If you don't do it, the compiler 
will complain about it anyway.

> Look, it's a delayed call.  The less glue we need, the better - the
> rules are much simpler that way, so that alone means that we'll get
> fewer fsckups.

You have the glue in a different place, so what?
The other alternative has real _practical_ value in almost every case, 
which I very much prefer. What's wrong with that?

bye, Roman
