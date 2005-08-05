Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263028AbVHEOOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263028AbVHEOOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 10:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263035AbVHEOOe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 10:14:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:52122 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S263028AbVHEOOc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 10:14:32 -0400
Date: Fri, 5 Aug 2005 16:14:30 +0200
From: Andi Kleen <ak@suse.de>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andi Kleen <ak@suse.de>, Ingo Molnar <mingo@elte.hu>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       John B?ckstrand <sandos@home.se>
Subject: Re: lockups with netconsole on e1000 on media insertion
Message-ID: <20050805141426.GU8266@wotan.suse.de>
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de> <1123249743.18332.16.camel@localhost.localdomain> <20050805135551.GQ8266@wotan.suse.de> <1123251013.18332.28.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1123251013.18332.28.camel@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 10:10:13AM -0400, Steven Rostedt wrote:
> On Fri, 2005-08-05 at 15:55 +0200, Andi Kleen wrote:
> > > This is fixing the symptom and is not the cure.  Unfortunately I don't
> > > have a e1000 card so I can't try a fix. But I did have a e100 card that
> > > would lock up the same way.  The problem was that netpoll_poll calls the
> > > cards netpoll routine (in e1000_main.c e1000_netpoll).  In the e100
> > > case, when the transmit buffer would fill up, the queue would go down.
> > > But the netpoll routine in the e100 code never put it back up after it
> > > was all transfered. So this would lock up the kernel when that happened.
> > 
> > In my case the hang happened when no cable was connected.
> 
> But should come back when the cable is reconnected. 

Which might be never. Not an option.

> Hmm, how bad is it to have a printk in a routine that is registered to
> printk?   If this does print, a "static once" variable should be added
> so that this is only printed once and not everytime it tries to print
> this message.

printk notices it is recursing and will not try to output it.

-Andi
