Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263810AbUDFNcG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 09:32:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263813AbUDFNcG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 09:32:06 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:28172 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263810AbUDFNcC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 09:32:02 -0400
Date: Tue, 6 Apr 2004 15:32:46 +0200
To: Sergiy Lozovsky <serge_lozovsky@yahoo.com>
Cc: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: kernel stack challenge
Message-ID: <20040406133246.GA19091@hh.idb.hist.no>
References: <40712952.6040100@aitel.hist.no> <20040405170537.94432.qmail@web40513.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040405170537.94432.qmail@web40513.mail.yahoo.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 10:05:37AM -0700, Sergiy Lozovsky wrote:
> > Consider rewriting your function to use allocated
> > memory instead of stack, this isn't all that hard.
> 
> I put LISP interpreter inside the Kernel -
> http://vxe.quercitron.com
> 
> It works, but it use a lot of stack memory. It's
> impossible to rewrite it easily, though I'll
> investigate why exactly it uses so much of stack
> memory (though it's nature of LISP). There are no
> serious kernel memory allocation (as of my interpreter
> code review, only function calls; recursions in LISP
> application itself are eliminated for sure), but I'll
> trace stack usage more thouroughly.
> 
Consider this.  We're currently experimenting with a
transition from 8k to 4k stacks on x86, and that is
considered a very good thing.  Allocating a single-
page stack is easy, two (contigous) pages might fail.

So a bigger kernel stack is out.

As for rewriting code so it doesn't use stack - it
_is_ easy, but it might be a lot of _work_.

The simple approach is to replace all (big) stack
allocations with an explicit stack structure that you manages
on the heap. There'll be more code, but it won't be slower
because all the extra code is stuff that happen automatically
with the hw stack. (I.e. stuff the compiler normally take
care of.)

There is some more work if your interpreter also does deep recursion.
It involves making one big function of those that do the recursion
and manage the "calls" yourself with an array and a switch statement.
Again, not particularly hard, but it could take some time to implement.

Helge Hafting  
