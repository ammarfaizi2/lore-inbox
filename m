Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbULJRgf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbULJRgf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 12:36:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261765AbULJRgf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 12:36:35 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:3545 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261761AbULJRgd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 12:36:33 -0500
Date: Fri, 10 Dec 2004 18:35:54 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       marcelo.tosatti@cyclades.com, LKML <linux-kernel@vger.kernel.org>,
       nickpiggin@yahoo.com.au
Subject: Re: [PATCH] oom killer (Core)
Message-ID: <20041210173554.GW16322@dualathlon.random>
References: <20041202033619.GA32635@dualathlon.random> <1101985759.13353.102.camel@tglx.tec.linutronix.de> <1101995280.13353.124.camel@tglx.tec.linutronix.de> <20041202164725.GB32635@dualathlon.random> <20041202085518.58e0e8eb.akpm@osdl.org> <20041202180823.GD32635@dualathlon.random> <1102013716.13353.226.camel@tglx.tec.linutronix.de> <20041202233459.GF32635@dualathlon.random> <20041203022854.GL32635@dualathlon.random> <20041210163614.GN2714@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041210163614.GN2714@holomorphy.com>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2004 at 08:36:14AM -0800, William Lee Irwin III wrote:
> On Fri, Dec 03, 2004 at 03:28:54AM +0100, Andrea Arcangeli wrote:
> > +	if (mm == &init_mm) {
> > +		mmput(mm);
> > +		return NULL;
> > +	}
> 
> On Fri, Dec 03, 2004 at 03:28:54AM +0100, Andrea Arcangeli wrote:
> > +	if (PTR_ERR(p) == -1UL)
> > +		goto out;
> > +
> >  	/* Found nothing?!?! Either we hang forever, or we panic. */
> >  	if (!p) {
> > +		read_unlock(&tasklist_lock);
> >  		show_free_areas();
> >  		panic("Out of memory and no killable processes...\n");
> >  	}
> 
> Maybe the mm == &init_mm case should return an ERR_PTR also, as that is
> a sign of a transient error, not cause for a hard panic.

It can't be a transient error as far as I can tell, it's just like the
issue of alloc_pages returning NULL (and potentially scheduling first)
before mounting the root fs.
