Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWJ1X7x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWJ1X7x (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 19:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWJ1X7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 19:59:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:37786 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751419AbWJ1X7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 19:59:53 -0400
Date: Sat, 28 Oct 2006 16:55:42 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Adam J. Richter" <adam@yggdrasil.com>
cc: akpm@osdl.org, bunk@stusta.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz,
       matthew@wil.cx, pavel@ucw.cz, shemminger@osdl.org
Subject: Re: [patch] drivers: wait for threaded probes between initcall levels
In-Reply-To: <200610282350.k9SNoljL020236@freya.yggdrasil.com>
Message-ID: <Pine.LNX.4.64.0610281651340.3849@g5.osdl.org>
References: <200610282350.k9SNoljL020236@freya.yggdrasil.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 29 Oct 2006, Adam J. Richter wrote:
> 
> 	If only calls to execute_in_parallel nest, your original
> implementation would always deadlock when the nesting depth exceeds
> the allowed number of threads, and also potentially in some shallower
> nesting depths given a very unlucky order of execution.  In your
> original message, you mentioned allowing the parallelism limit to be
> set as low as 1.

No, I'm saying that nesting simply shouldn't be _done_. There's no real 
reason. Any user would be already either parallel or doesn't need to be 
parallel at all. Why would something that already _is_ parallel start 
another parallel task?

IOW, what I was trying to say (perhaps badly) is that "nesting" really 
isn't a sensible operation - you'd never do it. You'd do the "startup" and 
"shutdown" things at the very highest level, and then in between those 
calls you can start a parallel activity at any depth of the call stack, 
but at no point does it really make sense to start it from within 
something that is already parallel.

Hmm?

(Btw, you do seem to have some strange email setup that doesn't allow me 
to email you directly, I just get a bounce. I'll try again, but you'll 
probably pick this up on linux-kernel rather than in your private 
mailbox).

		Linus
