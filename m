Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268011AbUIJXLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268011AbUIJXLe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 19:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268005AbUIJXLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 19:11:34 -0400
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:60301 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S268011AbUIJXLN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 19:11:13 -0400
Date: Fri, 10 Sep 2004 16:10:52 -0700
From: Chris Wedgwood <cw@f00f.org>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
Message-ID: <20040910231052.GA3078@taniwha.stupidest.org>
References: <20040902192820.GA6427@taniwha.stupidest.org> <Pine.LNX.4.58L.0409102306420.20057@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58L.0409102306420.20057@blysk.ds.pg.gda.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 10, 2004 at 11:23:20PM +0200, Maciej W. Rozycki wrote:

> > -	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
> > +	printk (KERN_DEBUG "APIC error on CPU%d: %02lx(%02lx)\n",

> This should probably be KERN_ERR even.  This is a serious condition -- if
> you ever get such a message, then inter-APIC messages get corrupted and
> this affects system's stability.

These messages are very common on many platforms, infrequent (once
very few days to twice a day at most in my observations) and seemingly
harmless.

I agree that if you get *many* of these certainly that would indicate
there is a problem but I've not not heard a single instance of this
and if that is the case we need to deal with it differently.

> > -			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
> > +			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);

> You may ever get a single message per system boot from this line.

Sometimes as boot, though often in my experience several minutes after
boot.

> It encourages to have a look at the ERR counter in /proc/interrupts
> to check for possible problems, though admittedly the suggestion
> isn't especially clear.

I think in *both* cases we want to detect a largish (more than 1 ever
n seconds or so) number of these and then complain, not before and
even then not excessively so that we printk our-selves to death.

I'm not inclined to offer such a patch right now as it feels like it's
fixing a problem nobody has reported.


  --cw
