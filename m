Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbTEKRKr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 13:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbTEKRKr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 13:10:47 -0400
Received: from mrt-lx1.iram.es ([150.214.224.59]:28375 "EHLO mrt-lx1.iram.es")
	by vger.kernel.org with ESMTP id S261780AbTEKRKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 13:10:46 -0400
Date: Sun, 11 May 2003 17:22:40 +0000
From: paubert <paubert@iram.es>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: desc v0.61 found a 2.5 kernel bug
Message-ID: <20030511172240.A957@mrt-lx1.iram.es>
References: <200305102353_MC3-1-385A-BC35@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200305102353_MC3-1-385A-BC35@compuserve.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 11:50:07PM -0400, Chuck Ebbert wrote:
> Gabriel Paubert wrote:
> 
> > The devil is in the details: you have to edit the TSS, clear the busy bit
> > of the previous TSS, LTR, clear the busy bit of the debug TSS, restore
> > many registers from the previous TSS image, switch to the kernel stack of
> > the interrupted process, push a lot of stuff on the stack to be used by iret.
> > (depending on whether you return to kernel/user/v86 modes). All of this in the 
> > right order, of course (and after having cleared your own NT flag).
> 
>  And this is the way to do it right, but...

And you don't need to keep cr3 in the TSS.
> 
> > Doable I believe but not simple, and there is still the TS issue.
> 
>  I finally realized the TS problem is basically unsolvable.  There is no
> way to know what the value was before a switch happened.

I believe the TS value can be inferred from the thread flags except
between kernel_fpu_begin() and kernel_fpu_end().
 
>  (BTW some other Free kernel has interesting things in its descriptor
> tables: DPL 1 execute-only code segments, conforming code, expand-down
> data, multiple LDTs etc...  It uncovered a bug in my code, too.)

Interesting, but using 3 privilege levels is not very portable, and
you'll need another per process stack.

Multiple LDT, how can this be useful and what are the semantics? 
There are enough problems with LDT eating up vmalloc space (I believe 
I have a solution to that particular problem).

	Gabriel.
