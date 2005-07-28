Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261318AbVG1Hdz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261318AbVG1Hdz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 03:33:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261317AbVG1Hdz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 03:33:55 -0400
Received: from mx2.elte.hu ([157.181.151.9]:15296 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S261323AbVG1Hdw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 03:33:52 -0400
Date: Thu, 28 Jul 2005 09:33:21 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC][PATCH] Make MAX_RT_PRIO and MAX_USER_RT_PRIO configurable
Message-ID: <20050728073321.GB20055@elte.hu>
References: <1122473595.29823.60.camel@localhost.localdomain> <20050727141754.GA25356@elte.hu> <1122474539.29823.68.camel@localhost.localdomain> <20050727143843.GB26303@elte.hu> <1122475591.29823.76.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1122475591.29823.76.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-3.229, required 5.9,
	BAYES_00 -4.90, NO_COST 1.67
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Steven Rostedt <rostedt@goodmis.org> wrote:

> > a fair number of apps assume that there's _at least_ 100 levels of 
> > priorities. The moment you have a custom kernel that offers more than 
> > 100 priorities, there will be apps that assume that there are more than 
> > 100 priority levels, and will break if there are less.
> 
> That's not the same. The apps on my computer right now should not 
> assume that I have 100 priorities.  Since I'm free to work with any 
> kernel that I want.  The customers that ask for a custom kernel are 
> also writing custom apps for a specific product.  Things can be 
> assumed more since the apps are not generic tools that are running on 
> desktops.  In fact, some of these apps require special hardware to 
> work (at least a driver to imitate the hardware).

what i mean is that once there's such a .config option in the generic 
kernel, the cat is out of the bag and there's no way back. In other 
words, increasing the number of priorities is an irreversible change, in 
terms of binary compatibility.

there's absolutely no problem with tweaking your kernel for special 
purposes, and i support all the patches to make it easier (as long as 
there's no cost to the kernel - and there's no such cost so far). But 
whenever some change in the generic kernel has a user-visible effect, 
especially one that is pretty much irreversible, we have to be very 
careful.

(I think in the longer term we might want to do something more clever 
than a blanket increase of the priority levels, we could e.g. put a 
mapping layer between user priorities and kernel priorities, and in fact 
we could make 'user-visible' RT priorities a bit more structured, like a 
hierarchy of levels - while keeping the in-kernel priorities a fast & 
flat thing (which could have more than 100 levels - but that would not 
be visible externally). There's some demand for that, but we'll have to 
wait and see for real demand and real code to crystalise out.)

	Ingo
