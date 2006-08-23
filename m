Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbWHWBfn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbWHWBfn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 21:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932240AbWHWBfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 21:35:43 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:38846 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932153AbWHWBfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 21:35:43 -0400
Subject: Re: [PATCH] paravirt.h
From: Rusty Russell <rusty@rustcorp.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Andi Kleen <ak@muc.de>,
       Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Chris Wright <chrisw@sous-sol.org>
In-Reply-To: <1156254965.27114.17.camel@localhost.localdomain>
References: <1155202505.18420.5.camel@localhost.localdomain>
	 <44DB7596.6010503@goop.org>
	 <1156254965.27114.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 23 Aug 2006 11:35:40 +1000
Message-Id: <1156296940.12015.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 14:56 +0100, Alan Cox wrote:
> Ar Iau, 2006-08-10 am 11:06 -0700, ysgrifennodd Jeremy Fitzhardinge:
> > Rusty Russell wrote:
> > > +EXPORT_SYMBOL_GPL(paravirt_ops);
> > >   
> > This should probably be EXPORT_SYMBOL(), otherwise pretty much every 
> > driver module will need to be GPL...
> 
> It would be nice not to export it at all or to protect it, paravirt_ops
> is a rootkit authors dream ticket. I'm opposed to paravirt_ops until it
> is properly protected, its an unpleasantly large security target if not.
> 
> It would be a lot safer if we could have the struct paravirt_ops in
> protected read-only const memory space, set it up in the core kernel
> early on in boot when we play "guess todays hypervisor" and then make
> sure it stays in read only (even to kernel) space.
> 
> Once you can't patch it then the worries about rootkits and patching it
> that might make people want it particularly to be _GPL should mostly go
> away too.

I am writing a test hypervisor interface in a module, so this is a
feature not a bug.

We can certainly move it to some read-protected page, but then the
module will simply unprotect it and alter it.

Now, discarding the patching information makes life harder, but you can
simply scan the text segments to find them again, or just trap when they
happen and patch dynamically (but this won't work for pushf and popf, if
you care about them).

I realize that the virtualizing-root-kit is a sexy idea, I'm just not
sure that paravirt_ops an effective place to be looking for a solution.

Rusty.
-- 
Help! Save Australia from the worst of the DMCA: http://linux.org.au/law

