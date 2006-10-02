Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965106AbWJBUzN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965106AbWJBUzN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Oct 2006 16:55:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965103AbWJBUzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Oct 2006 16:55:12 -0400
Received: from smtp.osdl.org ([65.172.181.4]:14768 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965101AbWJBUzK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Oct 2006 16:55:10 -0400
Date: Mon, 2 Oct 2006 13:54:33 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
cc: Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than
 passing to IRQ handlers
In-Reply-To: <20061002201836.GB31365@elte.hu>
Message-ID: <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>
References: <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com>
 <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com>
 <20061002132116.2663d7a3.akpm@osdl.org> <20061002201836.GB31365@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 2 Oct 2006, Ingo Molnar wrote:
>
> i agree that we should do this in one go and in Linus' tree. I suspect 
> David has a script for this, so we can do it anytime for any tree, 
> right?
> 
> the amount of code that truly relies on regs being present is very low. 
> Mostly only sysrq type of stuff and the timer interrupt is such.

Yeah, well, it's been discussed before, and the real problem is not the 
patch itself, it's the damn drivers maintained outside the tree, and 
people who want to maintain the same driver for multiple different 
versions of the kernel.

Things like the kernel graphics direct-rendering code, for example - 
mostly maintained in X.org trees that then want to compile with other 
kernels too.

I don't personally mind the patch, I just wanted to bring that issue up. 

So far, when this has come up, the gains it gives have not been worth the 
pain. I don't quite see why FRV is so broken that it would matter 20% 
worth, and I suspect that number was somehow really not real, but more a 
matter of "this small code snippet that is part of the irq delivery and 
isn't really measurable improves by 20%", which is a different thing.

That said, it's almost certainly worth it, and I don't think anybody 
really objects deep down.

So if the patch works against my current tree, and nobody objects, I can 
certainly apply it.

So speak up, people...

		Linus
