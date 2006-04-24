Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751215AbWDXVUz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751215AbWDXVUz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 17:20:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWDXVUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 17:20:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:5270 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751215AbWDXVUy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 17:20:54 -0400
Date: Mon, 24 Apr 2006 17:20:38 -0400
From: Alan Cox <alan@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Arjan van de Ven <arjan@infradead.org>, Alan Cox <alan@redhat.com>,
       Stephen Hemminger <shemminger@osdl.org>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: better leve triggered IRQ management needed
Message-ID: <20060424212038.GC4942@devserv.devel.redhat.com>
References: <20060424114105.113eecac@localhost.localdomain> <Pine.LNX.4.64.0604241156340.3701@g5.osdl.org> <Pine.LNX.4.64.0604241203130.3701@g5.osdl.org> <1145908402.3116.63.camel@laptopd505.fenrus.org> <20060424201646.GA23517@devserv.devel.redhat.com> <1145911417.3116.69.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604241354200.3701@g5.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 02:07:01PM -0700, Linus Torvalds wrote:
> debugging standpoint. So even if it's just that every registered SA_SHIRQ 
> would get a heartbeat at least once every five seconds (and we'd limit it 
> to SA_SHIRQ exactly because a driver that doesn't have that set may get 
> confused if it gets extra interrupts), that might sound totally useless, 
> but it might actually help somebody who otherwise might just make a pretty
> useless "the machine hung" bug-report.

Have to watch enable/disable_irq and the other races here.

> The fake interrupt could even print out a warning if somebody returns 
> SA_HANDLED (since normally there _shouldn't_ have been any work to handle 
> for it), and if that means that for somebody, things go from "the machine 
> hung" to "the machine got very slow, and printed out 'fake interrupt for 
> ide0 returned SA_HANDLED!'", that would potentially be a big debug aid.

There are high rate IRQ sources that would trigger that erratically due to
races but it could be useful in some kind of "linux irqdebug" mode

> We've had our ass saved quite a few times now by the irq storm detector 
> ("irq X: nobody cared" and friends), which has helped debug irqs that 
> haven't been set up properly, that I'm convinced things like this might 
> well make a huge deal.

Yep

Alan
--
  "... and for $64000 question, could you get yourself vaguely familiar with
		the notion of on-topic posting?"
				-- Al Viro

