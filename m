Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263872AbUDFPaZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 11:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263874AbUDFPaY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 11:30:24 -0400
Received: from m244.net81-65-141.noos.fr ([81.65.141.244]:16046 "EHLO
	deep-space-9.dsnet") by vger.kernel.org with ESMTP id S263872AbUDFPaR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 11:30:17 -0400
Date: Tue, 6 Apr 2004 17:30:13 +0200
From: Stelian Pop <stelian@popies.net>
To: Tom Rini <trini@kernel.crashing.org>
Cc: kgdb-bugreport@lists.sourceforge.net,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Amit S. Kale" <amitkale@emsyssoft.com>, ganzinger@mvista.com
Subject: Re: [Kgdb-bugreport] [KGDB] Make kgdb get in sync with it's I/O drivers for the breakpoint
Message-ID: <20040406153013.GS2718@deep-space-9.dsnet>
Reply-To: Stelian Pop <stelian@popies.net>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Tom Rini <trini@kernel.crashing.org>,
	kgdb-bugreport@lists.sourceforge.net,
	Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"Amit S. Kale" <amitkale@emsyssoft.com>, ganzinger@mvista.com
References: <20040405233058.GV31152@smtp.west.cox.net> <20040406145102.GQ2718@deep-space-9.dsnet> <20040406145741.GX31152@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040406145741.GX31152@smtp.west.cox.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 07:57:41AM -0700, Tom Rini wrote:

> > Maybe this could be done in a more kgdb-independent way in the
> > netpoll layer. There is already some code there who waits for
> > the carrier on a net card. Maybe this could be extended to also
> > wait for the network card to appear...
> 
> I was thinking about that as well.  But what I'm guessing happens now is
> that netpoll_setup(&np) fails causing us init_kgdboe to fail.

Yup.

> If we're
> going to queue up the signal and wait for an eth0, what would it return
> to let us known it'll be ready 'someday' ?

What about adding a 
	void (*netpoll_up)(struct netpoll *)
callback into the netpoll struct ?

Using this, netpoll_setup() would return immediately, doing its job
in background, and will signal the caller using the 'netpoll_up'
function when the card is ready to go...

Stelian.
-- 
Stelian Pop <stelian@popies.net>
