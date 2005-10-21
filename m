Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964900AbVJUHrG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964900AbVJUHrG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 03:47:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964899AbVJUHrF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 03:47:05 -0400
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:10940
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S964900AbVJUHrE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 03:47:04 -0400
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@elte.hu>, john stultz <johnstul@us.ibm.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0510210157080.1946@localhost.localdomain>
References: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain>
	 <20051020073416.GA28581@elte.hu>
	 <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain>
	 <20051020080107.GA31342@elte.hu>
	 <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain>
	 <20051020085955.GB2903@elte.hu>
	 <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain>
	 <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain>
	 <1129826750.27168.163.camel@cog.beaverton.ibm.com>
	 <20051020193214.GA21613@elte.hu>
	 <Pine.LNX.4.58.0510210157080.1946@localhost.localdomain>
Content-Type: text/plain
Organization: linutronix
Date: Fri, 21 Oct 2005 09:49:37 +0200
Message-Id: <1129880977.16447.116.camel@tglx.tec.linutronix.de>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-10-21 at 02:03 -0400, Steven Rostedt wrote:
> On Thu, 20 Oct 2005, Ingo Molnar wrote:

> With rc4-rt13 and changing cycle_t to u64, my machine ran all night
> without one backward step.  Since it use to show up after a couple of
> hours, I would say that this is the fix.
> 
> John, Do you want me to take a crack at changing the periodic_hook into
> using the ktimer code?  I understand Ingo's kernel much more than you, but
> you definitely understand the timing code better than I.

Steve, 

I think the hook is too complex to move it into the timer interrupt
context. We still have to reimplement the dynamic priority adjustment of
the ktimer softirq in a clean way. Once this is done, we can move it
over and set a proper priority up for that.

	tglx


