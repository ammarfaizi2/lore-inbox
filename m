Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261358AbVBWAZh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261358AbVBWAZh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Feb 2005 19:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261362AbVBWAZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Feb 2005 19:25:37 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:42387 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261358AbVBWAZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Feb 2005 19:25:29 -0500
Message-ID: <421BCD6E.3080105@nortel.com>
Date: Tue, 22 Feb 2005 18:25:18 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-os@analogic.com
CC: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Anthony DiSante <theant@nodivisions.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: uninterruptible sleep lockups
References: <421A3414.2020508@nodivisions.com> <200502211945.j1LJjgbZ029643@turing-police.cc.vt.edu> <421A4375.9040108@nodivisions.com> <421B12DB.70603@aitel.hist.no> <421B14A8.3000501@nodivisions.com> <Pine.LNX.4.61.0502220824440.25089@chaos.analogic.com> <421B9018.7020007@nodivisions.com> <200502222024.j1MKOtlZ007512@laptop11.inf.utfsm.cl> <421B9C86.8090800@nortel.com> <Pine.LNX.4.61.0502221619330.5460@chaos.analogic.com> <421BBD75.6040504@nortel.com> <Pine.LNX.4.61.0502221835190.5814@chaos.analogic.com>
In-Reply-To: <Pine.LNX.4.61.0502221835190.5814@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux-os wrote:

Before I get into the reply, I just want to make it clear that I'm not 
arguing that we *should* do any of this, just that it is not technically 
impossible.  It's a thought experiment, not a design suggestion.

> All wonderful. However, it dosn't fix the problem. You are,
> again, assuming that the problem is the symptom! The problem
> is that some piece of code is not handling an exception
> properly. It is waiting forever for something that will
> never happen. It's that CODE that needs to be fixed.

Absolutely. I'm just theorizing that it is possible to devise a system 
that would be able to deal with such a situation, analogous to the way 
the kernel can deal with bugs in userspace processes (segfaults, traps, 
etc.).

> "Cleaning" up the immediate symptoms doesn't let
> the next thread that acquires the "cleaned up" lock
> use the hardware because it has jammed code between
> that thread and the hardware.

If the system is designed such that all resources are tracked, then you 
could clean them up when the "hung" entity is killed (the way we do it 
for userspace resources).  In this case there is no more jammed code. 
The next guy to aquire the mutex knows the hardware is in an 
undetermined state, and is responsable for reinitializing it to a known 
state.  This would be horribly complicated, but I don't think it would 
be impossible.

> The bad code needs to be fixed. If the bad code is
> fixed, you will __never__ have a process stuck
> in 'D' state unless you run for the 1000 years
> that could statistically result in a bit in
> the semaphore getting flipped.

I don't disagree with you on this.  I think that fixing the bad code is 
absolutely the way to go.  I'm  simply indulging in a thought experiment 
as to whether or not it is theoretically possible to create a system 
that would be able to clean up after this sort of thing once it has 
happened.

Chris

