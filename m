Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263852AbUDFO7u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 10:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263864AbUDFO7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 10:59:04 -0400
Received: from fed1rmmtao10.west.cox.net ([68.230.241.29]:15820 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S263861AbUDFO5n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 10:57:43 -0400
Date: Tue, 6 Apr 2004 07:57:41 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Stelian Pop <stelian@popies.net>, kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <amitkale@emsyssoft.com>, ganzinger@mvista.com
Subject: Re: [Kgdb-bugreport] [KGDB] Make kgdb get in sync with it's I/O drivers for the breakpoint
Message-ID: <20040406145741.GX31152@smtp.west.cox.net>
References: <20040405233058.GV31152@smtp.west.cox.net> <20040406145102.GQ2718@deep-space-9.dsnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406145102.GQ2718@deep-space-9.dsnet>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 04:51:02PM +0200, Stelian Pop wrote:
> On Mon, Apr 05, 2004 at 04:30:58PM -0700, Tom Rini wrote:
> 
> > Hello.  The following interdiff, vs current kgdb-2 CVS makes kgdb core
> > and I/O drivers get in sync in order to cause a breakpoint.  This kills
> > off the init/main.c change, and makes way for doing things much earlier,
> > if other support exists. 
> 
> And it works perfectly for me too (with the pcmcia net card, debug
> started by sysrq+g).

Great!

> 
> There are however a couple of cleanups and a compile fix attached.

Whoops, thanks.

> > What would be left, tangentally, is some sort
> > of queue to register with, so we can handle the case of KGDBOE on a
> > pcmcia card.  George? Amit? Comments ?
> 
> Maybe this could be done in a more kgdb-independent way in the
> netpoll layer. There is already some code there who waits for
> the carrier on a net card. Maybe this could be extended to also
> wait for the network card to appear...

I was thinking about that as well.  But what I'm guessing happens now is
that netpoll_setup(&np) fails causing us init_kgdboe to fail.  If we're
going to queue up the signal and wait for an eth0, what would it return
to let us known it'll be ready 'someday' ?

-- 
Tom Rini
http://gate.crashing.org/~trini/
