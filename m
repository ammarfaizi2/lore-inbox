Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262294AbVGAUbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262294AbVGAUbA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVGAU32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:29:28 -0400
Received: from mail.suse.de ([195.135.220.2]:7848 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262277AbVGAU2H (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:28:07 -0400
Date: Fri, 1 Jul 2005 22:28:06 +0200
From: Andi Kleen <ak@suse.de>
To: Christoph Lameter <christoph@lameter.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Read only syscall tables for x86_64 and i386
Message-ID: <20050701202805.GF21330@wotan.suse.de>
References: <Pine.LNX.4.62.0506281141050.959@graphe.net.suse.lists.linux.kernel> <p73r7emuvi1.fsf@verdi.suse.de> <Pine.LNX.4.62.0506281238320.1734@graphe.net> <20050629024903.GA21575@bragg.suse.de> <Pine.LNX.4.62.0507011302090.19234@graphe.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0507011302090.19234@graphe.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 01, 2005 at 01:10:12PM -0700, Christoph Lameter wrote:
> > I think it would make sense in theory to write protect them
> > together with the kernel code and the modules
> > (just to make root kit writing slightly harder)
> 
> Seems that you are evading the question that I asked. Are syscall tables 
> supposed to be writable?

I did answer it. But again: yes I think it makes sense in theory
to make them read only.

Just we cannot do it right now on i386/x86-64 due to the reasons I lined out
in my previous mail.


> 
> > BTW the kernel actually needs to write to code once
> > to apply alternative(), but it would't be a problem to use
> > a temporary mapping for this.
> 
> What does this have to do with the syscall table???


It is directly related to writable .text.

> 
> > > The ability to protect a readonly section may be another issue.
> > 
> > Well, it's the overriding issue here. Just pretending it's readonly
> > when it isn't doesn't seem useful.
> 
> This is all are off-topic talking about a different issue. And we are 
> already "pretending" that lots of other stuff in the readonly section is 
> readonly.

Putting it into a "ro section" when it isn't actually read only is completely 
useless and does not do anything useful. So unless you figure out
a way to make a true ro section without performance penalty I wouldn't bother. 

If you really want it for cosmetic reasons you can still do it,
but it is about at the same usefullness level as shuffling white space in 
the source around.

-Andi

