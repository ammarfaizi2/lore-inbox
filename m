Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262102AbVAYTkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262102AbVAYTkE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 14:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262088AbVAYTju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 14:39:50 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:27034
	"EHLO debian.tglx.de") by vger.kernel.org with ESMTP
	id S262102AbVAYTi7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 14:38:59 -0500
Subject: Re: [PATCH] fix bad locking in drivers/base/driver.c
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Greg KH <greg@kroah.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Mike Waychison <Michael.Waychison@Sun.COM>,
       Bill Davidsen <davidsen@tmr.com>, Jirka Kosina <jikos@jikos.cz>,
       Patrick Mochel <mochel@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20050125191950.GA11445@kroah.com>
References: <Pine.LNX.4.58.0501241921310.5857@twin.jikos.cz>
	 <20050125055651.GA1987@kroah.com> <41F5F623.5090903@sun.com>
	 <41F64E87.8040501@tmr.com> <41F66F86.4000609@sun.com>
	 <Pine.LNX.4.58.0501250817430.2342@ppc970.osdl.org>
	 <20050125191950.GA11445@kroah.com>
Content-Type: text/plain
Date: Tue, 25 Jan 2005 20:38:54 +0100
Message-Id: <1106681934.4538.6.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 (2.0.3-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-01-25 at 11:19 -0800, Greg KH wrote:
> On Tue, Jan 25, 2005 at 08:27:15AM -0800, Linus Torvalds wrote:
> > 
> > 
> > Hmm.. I certainly like the "use completions" patch, since it makes it a
> > lot more obvious what is going on (and it is what completions were
> > designed for).
> > 
> > However, since it does change semantics very subtly: if you call
> > "driver_unregister()" twice (which is wrong, but looking at the code it
> > looks like it would just silently have worked), the old code would just
> > ignore it. The new code will block on the second one.
> > 
> > Now, I don't mind the blocking (it's a bug to call it twice, and blocking
> > should even give a nice callback when you do the "show tasks"  sysrq, so
> > it's a good way to _find_ the bug), but together with Mike's comment about
> > "Compile-tested only", I'd really like somebody (Greg?) to say "trying to
> > doubly remove the driver is so illegal that we don't care, and btw, I
> > tested it and it's all ok".
> 
> I will add it to my queue of patches for the driver core, and test it
> out accordingly before trying it out in the -mm tree for a while.
> 

Exactly the same patch is around since 2004-10-20.

http://marc.theaimsgroup.com/?l=linux-kernel&m=109836020930855&w=2

It never showed any problems and I have it in my kernels since then.
Also Ingo's RT patches have it since October. 

tglx




