Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964878AbWJCKXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964878AbWJCKXN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 06:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964873AbWJCKXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 06:23:13 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40380 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964855AbWJCKXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 06:23:11 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org> 
References: <Pine.LNX.4.64.0610021349090.3952@g5.osdl.org>  <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <20061002132116.2663d7a3.akpm@osdl.org> <20061002201836.GB31365@elte.hu> 
To: Linus Torvalds <torvalds@osdl.org>
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH 3/3] IRQ: Maintain regs pointer globally rather than passing to IRQ handlers 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Tue, 03 Oct 2006 11:21:21 +0100
Message-ID: <10735.1159870881@warthog.cambridge.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:

> So far, when this has come up, the gains it gives have not been worth the 
> pain. I don't quite see why FRV is so broken that it would matter 20% 
> worth, and I suspect that number was somehow really not real, but more a 
> matter of "this small code snippet that is part of the irq delivery and 
> isn't really measurable improves by 20%", which is a different thing.

What appears to make up the difference is the loop in handle_IRQ_event().
That has to resurrect the arguments for the IRQ handler after calling the
previous IRQ handler.

FRV is just the easiest place for me to measure things like this.  Trying to
do so on i386 would be tricky, and Xen wouldn't help as it could affect the
measurement of time - though it might permit me to count the intructions
instead.  I might be able to do so on my power5 box, I suppose, but again,
like Xen, that's virtualised, and I'm not sure what affect that'd have.

So, I'm sure this will affect other archs, but it's much harder for me to
measure those.

But, you're also right: this is a statistic, and I'm sure you know the old
saying about those...

David
