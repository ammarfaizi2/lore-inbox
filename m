Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263260AbUAKQub (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 11:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUAKQub
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 11:50:31 -0500
Received: from mail.ccur.com ([208.248.32.212]:13317 "EHLO exchange.ccur.com")
	by vger.kernel.org with ESMTP id S263260AbUAKQuZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 11:50:25 -0500
Date: Sun, 11 Jan 2004 11:50:12 -0500
From: Joe Korty <joe.korty@ccur.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Ethan Weinstein <lists@stinkfoot.org>, linux-kernel@vger.kernel.org,
       William Lee Irwin III <wli@holomorphy.com>
Subject: Re: 2.6.1 and irq balancing
Message-ID: <20040111165012.GA24746@tsunami.ccur.com>
Reply-To: joe.korty@ccur.com
References: <40008745.4070109@stinkfoot.org> <1073814681.4431.5.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1073814681.4431.5.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 11, 2004 at 10:51:22AM +0100, Arjan van de Ven wrote:
> On Sun, 2004-01-11 at 00:14, Ethan Weinstein wrote:
> > Greetings all,
> > 
> > I upgraded my server to 2.6.1, and I'm finding I'm saddled with only 
> > interrupting on CPU0 again. 2.6.0 does this as well. This is the 
> > Supermicro X5DPL-iGM-O (E7501 chipset), 2 Xeons@2.4ghz HT enabled. 
> > /proc/cpuinfo is normal as per HT, displaying 4 cpus.
> 
> you should run the userspace irq balance daemon:
> http://people.redhat.com/arjanv/irqbalance/

I have long wondered what is so evil about most interrupts going to
CPU 0 that we felt we had to have a pair of irqdaemons in 2.6.  From my
(admittedly imperfect) experience, the APIC will route an interrupt to
CPU 1 if CPU 0 is busy with another interrupt, to CPU 2 if 0 and 1 are
so occupied, and so on.  I see no harm in this other than the strangely
lopsided /proc/interrupt displays, which I can live with.

Earlier APICs had a variation where the search for where each new
interrupt was to go started with first cpu after the one that got the
last interrupt.  If we call this 'round-robin' allocation, then today's
technique could be described as 'first fit'.

If I am wrong about this, I would dearly love to be corrected :)
Joe
