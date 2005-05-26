Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVEZUu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVEZUu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 16:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVEZUtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 16:49:42 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:20474 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S261757AbVEZUqm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 16:46:42 -0400
Subject: Re: RT patch acceptance
From: Sven-Thorsten Dietrich <sdietrich@mvista.com>
To: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>, dwalker@mvista.com, bhuey@lnxw.com,
       nickpiggin@yahoo.com.au, hch@infradead.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050526202747.GB86087@muc.de>
References: <20050525005942.GA24893@nietzsche.lynx.com>
	 <1116982977.19926.63.camel@dhcp153.mvista.com>
	 <20050524184351.47d1a147.akpm@osdl.org> <4293DCB1.8030904@mvista.com>
	 <20050524192029.2ef75b89.akpm@osdl.org> <20050525063306.GC5164@elte.hu>
	 <m1br6zxm1b.fsf@muc.de> <1117044019.5840.32.camel@sdietrich-xp.vilm.net>
	 <20050526193230.GY86087@muc.de>
	 <1117138270.1583.44.camel@sdietrich-xp.vilm.net>
	 <20050526202747.GB86087@muc.de>
Content-Type: text/plain
Date: Thu, 26 May 2005 13:46:37 -0700
Message-Id: <1117140397.1583.60.camel@sdietrich-xp.vilm.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-05-26 at 22:27 +0200, Andi Kleen wrote:
> > Here, I am talking about separating out the patch, and applying it
> > first, not dropping it from the RT implementation. 
> 
> I really dislike the idea of interrupt threads. It seems totally
> wrong to me to make such a fundamental operation as an interrupt
> much slower.  If really any interrupts take too long they should
> move to workqueues instead and be preempted there. But keep
> the basic fundamental operations fast please (at least that used to be one
> of the Linux mottos that served it very well for many years, although more
> and more people seem to forget it now) 
> 

IRQ threads are configurable.  If you don't want them, you CAN turn them
off (if you have already turned them on). 

You don't HAVE to turn them on. 

The IRQ option option adds "responsiveness" to the not forgotten, but
configurable, "progress, throughput, fairness, resource sharing"
principles of Unix found in the Linux kernel.

A lot of the IRQ stuff is already in bottom halves, where it runs in a
thread sometimes. But when it doesn't, its not preemptable, sometimes
for a long time. Add other non-preemptable regions, and you get big
aggregates. 

The IRQ thread option runs SoftIRQd in a thread always, if you want to
configure it that way, and eliminates the IRQ latency burstyness.

As far as the hard IRQs, you can leave them off too, and maybe turn on 
one for a while, until you forget that you did that. 

Then try another.

Your other questions are probably covered by Ingo's current remarks.

Cheers,

Sven




