Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWCLQ0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWCLQ0Q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:26:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751368AbWCLQ0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:26:16 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:48105
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751346AbWCLQ0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:26:16 -0500
Subject: Re: [patch 5/8] hrtimer remove state field
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0603121650230.16802@scrub.home>
References: <20060312080316.826824000@localhost.localdomain>
	 <20060312080332.274315000@localhost.localdomain>
	 <Pine.LNX.4.64.0603121302590.16802@scrub.home>
	 <1142169010.19916.397.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121422180.16802@scrub.home>
	 <1142170505.19916.402.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121444530.16802@scrub.home>
	 <1142172917.19916.421.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121523320.16802@scrub.home>
	 <1142175286.19916.459.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121608440.17704@scrub.home>
	 <1142178108.19916.475.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0603121650230.16802@scrub.home>
Content-Type: text/plain
Date: Sun, 12 Mar 2006 17:26:36 +0100
Message-Id: <1142180796.19916.497.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.5 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-12 at 17:00 +0100, Roman Zippel wrote:
> Hi,
> 
> On Sun, 12 Mar 2006, Thomas Gleixner wrote:
> 
> > How do you want to prevent that a signal is dequeued on one CPU while
> > the softirq expires the timer on another CPU ? This can not be
> > prevented.
> 
> This should not be possible in first place, otherwise it's a bug.
> The original problem was a broken state machine, is that so hard to 
> believe? If there is another problem, please provide more details.

Roman,

there was a state machine problem caused by something similar.

But the problem I described now happened with the current patch queue -
without the hrtimer_active() check. I have no direct access to the
machine which lets this surface and I just tried to reconstruct the
scenario from the sparse information which was provided by the customer.
All I can tell, that it is related to something similar and a requeue
happens where none should happen.

I agree, that it should not be handled in the hrtimer code. It has to be
fixed in the posix-timer code.

I make the check a BUG_ON(!hrtimer_active(timer) so it might show up in
-mm again. Ok ?

	tglx


