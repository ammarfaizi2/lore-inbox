Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936575AbWLBWkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936575AbWLBWkW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 17:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936574AbWLBWkW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 17:40:22 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:12218 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S936572AbWLBWkV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 17:40:21 -0500
Date: Sat, 2 Dec 2006 22:40:18 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Matthew Wilcox <matthew@wil.cx>,
       Linus Torvalds <torvalds@osdl.org>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] timers, pointers to functions and type safety
Message-ID: <20061202224018.GO3078@ftp.linux.org.uk>
References: <20061201172149.GC3078@ftp.linux.org.uk> <1165084076.24604.56.camel@localhost.localdomain> <20061202184035.GL3078@ftp.linux.org.uk> <200612022243.58348.zippel@linux-m68k.org> <20061202215941.GN3078@ftp.linux.org.uk> <Pine.LNX.4.64.0612022306360.1867@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612022306360.1867@scrub.home>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 02, 2006 at 11:13:21PM +0100, Roman Zippel wrote:
> Hi,
> 
> On Sat, 2 Dec 2006, Al Viro wrote:
> 
> > > You need some more magic macros to access/modify the data field.
> > 
> > Which is done bloody rarely.  grep and you'll see...  BTW, there are
> > other reasons why passing struct timer_list * is wrong:
> > 	* direct calls of the timer callback
> 
> Why should that be wrong?

Need to arrange a struct timer_list?

> > 	* callback being the same for two timers embedded into
> > different structs
> 
> That's done bloody rarely as well.
> 
> > 	* see a timer callback, decide it looks better as a tasklet.
> > What, need a different glue now?
> 
> What's wrong with changing the prototype? If you don't do it, the compiler 
> will complain about it anyway.

How about "not having to change it at all"?
 
> > Look, it's a delayed call.  The less glue we need, the better - the
> > rules are much simpler that way, so that alone means that we'll get
> > fewer fsckups.
> 
> You have the glue in a different place, so what?

Where?

> The other alternative has real _practical_ value in almost every case, 
> which I very much prefer. What's wrong with that?

Lack of any type safety whatsoever, magic boilerplates in callback instances,
rules more complex than "your callback should take a pointer, don't cast
anything, it's just a way to arrange for a delayed call, nothing magical
needed"?
