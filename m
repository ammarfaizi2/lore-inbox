Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUIMStg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUIMStg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 14:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268849AbUIMStg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 14:49:36 -0400
Received: from fw.osdl.org ([65.172.181.6]:31903 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268851AbUIMStC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 14:49:02 -0400
Date: Mon, 13 Sep 2004 11:48:56 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Tonnerre <tonnerre@thundrix.ch>
cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Add sparse "__iomem" infrastructure to check PCI address usage
In-Reply-To: <20040913183126.GA19399@thundrix.ch>
Message-ID: <Pine.LNX.4.58.0409131142370.2378@ppc970.osdl.org>
References: <200409110726.i8B7QTGn009468@hera.kernel.org> <4144E93E.5030404@pobox.com>
 <Pine.LNX.4.58.0409121922450.13491@ppc970.osdl.org> <414508F6.7020301@pobox.com>
 <Pine.LNX.4.58.0409121945500.13491@ppc970.osdl.org> <20040913183126.GA19399@thundrix.ch>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 13 Sep 2004, Tonnerre wrote:
> 
> On Sun, Sep 12, 2004 at 08:00:48PM -0700, Linus Torvalds wrote:
> > Generally, you shouldn't ever use __force in a driver or anything like 
> > that.
> 
> Why don't we send the __force attribute into some #ifdef that is never
> defined unless  you're in  arch specific code?  This way  we'd prevent
> stupid people from doing stupid things.

Hey, the thing is, that may well prevent smart people from doing smart 
things too. Give 'em rope, within reason.

The point behind __force is not so much that you should never use it, but 
that you should never use it by _mistake_. It's very easy (and often 
_required_) to have a regular typecast in C, and it can often hide bugs 
when you cast something in a way that you didn't really think through.

For example, we often have generic "void *" or "unsigned long" things that
are used for passing opaque data around, and they need casts when working
with them. It is quite conceivable that you need an address space cast
too, and that you need to use "__force" to do so. It might be ok, even in
a driver. But hopefully it's something where the action of having to force 
the cast makes people think about it more. And the fact that there 
probably never will be very _man_ casts like that means that they'll stand 
out.

If people start using "__force" to hide their own bugs, we'll just have to 
start stringing them up. Hang'em high, I say. But maybe somebody has a 
valid reason at times.

		Linus
