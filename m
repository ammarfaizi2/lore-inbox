Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWGCRNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWGCRNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 13:13:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbWGCRNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 13:13:38 -0400
Received: from smtp.osdl.org ([65.172.181.4]:8667 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751202AbWGCRNi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 13:13:38 -0400
Date: Mon, 3 Jul 2006 10:13:12 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: tglx@linutronix.de, mingo@elte.hu, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
In-Reply-To: <20060702173527.cbdbf0e1.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0607031007421.12404@g5.osdl.org>
References: <1151885928.24611.24.camel@localhost.localdomain>
 <20060702173527.cbdbf0e1.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 2 Jul 2006, Andrew Morton wrote:
> 
> The requirement "if you implement this then you must do so as a macro" is a
> bit regrettable.  The ARCH_HAS_HANDLE_DYNAMIC_TICK approach would eliminate
> that requirement.

Btw, this is WRONG.

The whole "ARCH_HAS_XYZZY" is nothing but crap. It's totally unreadable, 
compared to the _much_ simpler

	#ifndef xyzzy
	#define zyzzy() /* empty */
	#endif

which is a hell of a lot more obvious to everybody involved, not to 
mention being a lot easier to "grep" for (try it - "grep xyzzy" ends up 
showing _exactly_ what is going on for cases like this, unlike the 
ARCH_HAS_XYZZY crap).

And no, it does not require implementing xyzzy as a macro AT ALL. 

You can very easily just do

	/*
	 * We have a very complex xyzzy, we don't even want to
	 * inline it!
	 */
	extern void xyxxy(...);

	/* Tell the rest of the world that we do it! */
	#define xyzzy xyzzy

and you're now all set. No need for a new stupid name like ARCH_HAS_XYZZY, 
which adds _nothing_ but unnecessary complexity ("What was the condition 
for using that symbol again?" and ungreppability).

WE SHOULD GET RID OF ARCH_HAS_XYZZY. It's a disease.

			Linus
