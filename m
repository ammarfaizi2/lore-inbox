Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268042AbUIKAOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268042AbUIKAOU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 20:14:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268043AbUIKAOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 20:14:19 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:24336 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S268042AbUIKAOR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 20:14:17 -0400
Date: Sat, 11 Sep 2004 02:14:13 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Chris Wedgwood <cw@f00f.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386 reduce spurious interrupt noise
In-Reply-To: <20040910231052.GA3078@taniwha.stupidest.org>
Message-ID: <Pine.LNX.4.58L.0409110156080.20057@blysk.ds.pg.gda.pl>
References: <20040902192820.GA6427@taniwha.stupidest.org>
 <Pine.LNX.4.58L.0409102306420.20057@blysk.ds.pg.gda.pl>
 <20040910231052.GA3078@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Sep 2004, Chris Wedgwood wrote:

> > > -	printk (KERN_INFO "APIC error on CPU%d: %02lx(%02lx)\n",
> > > +	printk (KERN_DEBUG "APIC error on CPU%d: %02lx(%02lx)\n",
> 
> > This should probably be KERN_ERR even.  This is a serious condition -- if
> > you ever get such a message, then inter-APIC messages get corrupted and
> > this affects system's stability.
> 
> These messages are very common on many platforms, infrequent (once
> very few days to twice a day at most in my observations) and seemingly
> harmless.

 These are just as harmless as single-bit RAM errors with ECC working.  
In both cases you want the problem to be reported.

> I agree that if you get *many* of these certainly that would indicate
> there is a problem but I've not not heard a single instance of this
> and if that is the case we need to deal with it differently.

 Please search list archives for lots of such reports.

> > > -			printk("spurious 8259A interrupt: IRQ%d.\n", irq);
> > > +			printk(KERN_DEBUG "spurious 8259A interrupt: IRQ%d.\n", irq);
> 
> > You may ever get a single message per system boot from this line.
> 
> Sometimes as boot, though often in my experience several minutes after
> boot.

 And never again until you reboot.  That's what I mean.

> > It encourages to have a look at the ERR counter in /proc/interrupts
> > to check for possible problems, though admittedly the suggestion
> > isn't especially clear.
> 
> I think in *both* cases we want to detect a largish (more than 1 ever
> n seconds or so) number of these and then complain, not before and
> even then not excessively so that we printk our-selves to death.

 I agree for the latter case.  I won't mind the message going away either.
For the former you only really want to rate-limit the report -- some
people apparently want or need to run broken hardware and they'd probably
appreciate limiting the output.

  Maciej
