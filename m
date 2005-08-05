Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVHEO2k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVHEO2k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262218AbVHEO2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:28:37 -0400
Received: from ms-smtp-01.nyroc.rr.com ([24.24.2.55]:10705 "EHLO
	ms-smtp-01.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S261809AbVHEO1Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:27:16 -0400
Subject: Re: lockups with netconsole on e1000 on media insertion
From: Steven Rostedt <rostedt@goodmis.org>
To: Andi Kleen <ak@suse.de>
Cc: Ingo Molnar <mingo@elte.hu>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, John B?ckstrand <sandos@home.se>
In-Reply-To: <20050805141426.GU8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel>
	 <p73ek987gjw.fsf@bragg.suse.de>
	 <1123249743.18332.16.camel@localhost.localdomain>
	 <20050805135551.GQ8266@wotan.suse.de>
	 <1123251013.18332.28.camel@localhost.localdomain>
	 <20050805141426.GU8266@wotan.suse.de>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Fri, 05 Aug 2005 10:27:06 -0400
Message-Id: <1123252026.18332.37.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-05 at 16:14 +0200, Andi Kleen wrote:
> On Fri, Aug 05, 2005 at 10:10:13AM -0400, Steven Rostedt wrote:
> > On Fri, 2005-08-05 at 15:55 +0200, Andi Kleen wrote:
> > > > This is fixing the symptom and is not the cure.  Unfortunately I don't
> > > > have a e1000 card so I can't try a fix. But I did have a e100 card that
> > > > would lock up the same way.  The problem was that netpoll_poll calls the
> > > > cards netpoll routine (in e1000_main.c e1000_netpoll).  In the e100
> > > > case, when the transmit buffer would fill up, the queue would go down.
> > > > But the netpoll routine in the e100 code never put it back up after it
> > > > was all transfered. So this would lock up the kernel when that happened.
> > > 
> > > In my case the hang happened when no cable was connected.
> > 
> > But should come back when the cable is reconnected. 
> 
> Which might be never. Not an option.

Hey! You removed my admission to this. Don't make me look stupid
here ;-)

> 
> > Hmm, how bad is it to have a printk in a routine that is registered to
> > printk?   If this does print, a "static once" variable should be added
> > so that this is only printed once and not everytime it tries to print
> > this message.
> 
> printk notices it is recursing and will not try to output it.

Darn it, since this should really be reported.  Yes, the core netpoll
should bail out, but it is also a problem with the driver and should be
fixed.

Come to think of it, I should have submitted a patch that did what you
did when I discovered the problem with the e100. But that network card
was slow and could easily lock up when doing a sysrq-t.  I wasn't
removing cables, so I just submitted the fix for the e100, not thinking
that the netpoll shouldn't lock up itself.

-- Steve


