Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbUDETC3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 15:02:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263137AbUDETC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 15:02:29 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:4014
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S263125AbUDETC1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 15:02:27 -0400
Date: Mon, 5 Apr 2004 21:02:25 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Marcus Hartig <m.f.h@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-aa1
Message-ID: <20040405190225.GL2234@dualathlon.random>
References: <40707888.80006@web.de> <200404041859.47940.jeffpc@optonline.net> <20040405002028.GB21069@dualathlon.random> <4071A601.5000402@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4071A601.5000402@web.de>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 08:31:29PM +0200, Marcus Hartig wrote:
> Andrea Arcangeli wrote:
> 
> >That should reduce the scope of the problem, I had a look at the
> >diff between rc3 and 2.6.5 final but I found nothing obvious that could
> >explain your problem (yet).
> 
> It seems to be CONFIG_PREEMPT. I have compiled the 2.6.5-aa1 only without 
> it and ET runs now 30min without a signal11.

sounds good, probably a preempt bug in the alsa code or an rcu issue or
something like that. my tree has the most important fixes in the
writeback code from Takashi to provide the same lowlatency w/ or w/o
CONFIG_PREEMPT so you shouldn't notice much difference either ways. It
was a good decision to leave preempt off for higher reliability too,
preempt isn't just a matter of spinlocks, sometime you need explicit
preempt_disable to make it work right.

still it'd be nice to fix it purerly as an exercise, exercises are
useful nevertheless ;).
