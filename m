Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262831AbVCPV7Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262831AbVCPV7Z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 16:59:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVCPV5k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 16:57:40 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:63193 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262822AbVCPVyJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 16:54:09 -0500
Date: Wed, 16 Mar 2005 21:54:00 +0000 (GMT)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Andrew Morton <akpm@osdl.org>
cc: Matthew Wilcox <matthew@wil.cx>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CON_BOOT
In-Reply-To: <20050316130948.678ca2f2.akpm@osdl.org>
Message-ID: <Pine.LNX.4.56.0503162153330.30645@pentafluge.infradead.org>
References: <20050315222706.GI21986@parcelfarce.linux.theplanet.co.uk>
 <20050315143711.4ae21d88.akpm@osdl.org> <20050316130759.GL21986@parcelfarce.linux.theplanet.co.uk>
 <20050316130948.678ca2f2.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Where is this patch? The work looks like the stuff I did a few years ago.


On Wed, 16 Mar 2005, Andrew Morton wrote:

> Matthew Wilcox <matthew@wil.cx> wrote:
> >
> >  I think it's doable
> >  if we do something like:
> > 
> >   - Add an int (*takeover)(struct console *); to struct console
> >   - Replace the hunk above with:
> > 
> >  	for (existing = console_drivers; existing; existing = existing->next) {
> >  		if (existing->takeover && existing->takeover(console)) {
> >  			unregister_console(existing);
> >  			console->flags &= ~CON_PRINTBUFFER;
> >  		}
> >  	}
> > 
> >  That puts the onus on the early console to be able to figure out
> >  whether a registering console is its replacement or not; for the x86_64
> >  early_printk, that'd be as simple as comparing the ->name against "ttyS"
> >  or "tty".  It'll be a bit more tricky for PA-RISC, but would solve some
> >  messiness that we could potentially have.  I think that's doable; want
> >  me to try it?
> 
> It doesn't sound terribly important - I was just curious, thanks.  We can
> let this one be demand-driven.
> 
> I'm surprised that more systems don't encounter this - there's potentially
> quite a gap between console_init() and the bringup of the first real
> console driver.  What happens if we crash in mem_init()?  Am I misreading
> the code, or do we just get no info?
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
