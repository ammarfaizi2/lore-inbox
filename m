Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261803AbUDERGA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 13:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263006AbUDERGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 13:06:00 -0400
Received: from web40513.mail.yahoo.com ([66.218.78.130]:17470 "HELO
	web40513.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261803AbUDERFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 13:05:43 -0400
Message-ID: <20040405170537.94432.qmail@web40513.mail.yahoo.com>
Date: Mon, 5 Apr 2004 10:05:37 -0700 (PDT)
From: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Subject: Re: kernel stack challenge
To: Helge Hafting <helgehaf@aitel.hist.no>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <40712952.6040100@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Consider rewriting your function to use allocated
> memory instead of stack, this isn't all that hard.

I put LISP interpreter inside the Kernel -
http://vxe.quercitron.com

It works, but it use a lot of stack memory. It's
impossible to rewrite it easily, though I'll
investigate why exactly it uses so much of stack
memory (though it's nature of LISP). There are no
serious kernel memory allocation (as of my interpreter
code review, only function calls; recursions in LISP
application itself are eliminated for sure), but I'll
trace stack usage more thouroughly.

Serge.

--- Helge Hafting <helgehaf@aitel.hist.no> wrote:
> Sergiy Lozovsky wrote:
> > Hi,
> > 
> > I have a stack hungry code in the kernel. It hits
> the
> > end of stack from time to time. I wrote function
> to
> > which I pass pointers to function and memory area
> > which should be used as stack for function
> execution.
> > (I just load pointer to new stack area into esp
> > register). This function works just fine in user
> space
> > and memory area provided by me is used as stack.
> > 
> > This function doesn't work in the kernel (system
> hungs
> > instantly when my function is called). Does
> antbody
> > have any idea what the reason can be? Some special
> > alignment? Special memory segment? In what
> direction
> > should I look?
> > 
> > (sure I tried some magic with alignment like -
> > __attribute__ ((aligned (8192))) - no any effect)
> > 
> > (there was some patch to increase stack size
> > kernelwide, but I don't want to affect all the
> > system).
> 
> 
> You aren't supposed to need much stack for anything
> in the kernel.
> Consider rewriting your function to use allocated
> memory instead of stack, this isn't all that hard.
> 
> Helge Hafting
> 


__________________________________
Do you Yahoo!?
Yahoo! Small Business $15K Web Design Giveaway 
http://promotions.yahoo.com/design_giveaway/
