Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVJTPzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVJTPzS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 11:55:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbVJTPzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 11:55:18 -0400
Received: from mx2.mail.elte.hu ([157.181.151.9]:31457 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932273AbVJTPzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 11:55:16 -0400
Date: Thu, 20 Oct 2005 17:55:25 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: john stultz <johnstul@us.ibm.com>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
Message-ID: <20051020155525.GA10360@elte.hu>
References: <1129747172.27168.149.camel@cog.beaverton.ibm.com> <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu> <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain> <20051020080107.GA31342@elte.hu> <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain> <20051020085955.GB2903@elte.hu> <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain> <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain> <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.4
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > I just switched cycle_t to u64 and hackbench no longer makes the time go
> > backwards.
> >
> > John, would this cause any problems to keep cycle_t at s64?
> 
> I mean at u64.

ugh. There's both cycles_t and cycle_t. We should unify the two and it 
should be 64-bit. The faster systems get, the sooner the 32-bit counter 
overflows. 64-bit systems are keeping 32-bit compatibility for quite 
some time to come. So with an 8GHz CPU the 32-bit cycle_t would wrap in 
like 500 msecs, way too fast to rely on ... (even with a 4GHz CPUs it's 
only one second.)

i've made cycle_t u64 and have uploaded -rt14.

	Ingo
