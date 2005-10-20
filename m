Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932511AbVJTTcD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVJTTcD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Oct 2005 15:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbVJTTcD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Oct 2005 15:32:03 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:30168 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932511AbVJTTcC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Oct 2005 15:32:02 -0400
Date: Thu, 20 Oct 2005 21:32:14 +0200
From: Ingo Molnar <mingo@elte.hu>
To: john stultz <johnstul@us.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, tglx@linutronix.de,
       linux-kernel@vger.kernel.org
Subject: Re: Ktimer / -rt9 (+custom) monotonic_clock going backwards.
Message-ID: <20051020193214.GA21613@elte.hu>
References: <Pine.LNX.4.58.0510200249080.27683@localhost.localdomain> <20051020073416.GA28581@elte.hu> <Pine.LNX.4.58.0510200340110.27683@localhost.localdomain> <20051020080107.GA31342@elte.hu> <Pine.LNX.4.58.0510200443130.27683@localhost.localdomain> <20051020085955.GB2903@elte.hu> <Pine.LNX.4.58.0510200503470.27683@localhost.localdomain> <Pine.LNX.4.58.0510200603220.27683@localhost.localdomain> <Pine.LNX.4.58.0510200605170.27683@localhost.localdomain> <1129826750.27168.163.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1129826750.27168.163.camel@cog.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* john stultz <johnstul@us.ibm.com> wrote:

> > > John, would this cause any problems to keep cycle_t at s64?
> > 
> > I mean at u64.
> 
> Performance would be the only concern. It had been a u64 before I 
> started optimizing the code a bit.

no, this is really a bad optimization that causes unrobustness. 
Correctness and robustness comes first. It is so easy to cause a 
500-1000msec delay in the kernel, due to a bad driver or anything. The 
timekeeping code should not break like that.

	Ingo
