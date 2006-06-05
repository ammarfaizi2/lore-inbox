Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932366AbWFEBKJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366AbWFEBKJ (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 21:10:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932368AbWFEBKJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 21:10:09 -0400
Received: from smtp.osdl.org ([65.172.181.4]:63122 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932366AbWFEBKH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 21:10:07 -0400
Date: Sun, 4 Jun 2006 18:10:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: laurent.riffard@free.fr, linux-kernel@vger.kernel.org, jbeulich@novell.com
Subject: Re: 2.6.17-rc5-mm1
Message-Id: <20060604181002.57ca89df.akpm@osdl.org>
In-Reply-To: <200606042101_MC3-1-C19B-1CF4@compuserve.com>
References: <200606042101_MC3-1-C19B-1CF4@compuserve.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.17; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 4 Jun 2006 20:59:50 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <44833955.9000104@free.fr>
> 
> On Sun, 04 Jun 2006 21:49:41 +0200, Laurent Riffard wrote:
> 
> > > Something strange is happening with the stack.  Can you try with 8K stacks?
> > > 
> > > kernel hacking --->
> > >    [ ] Use 4Kb for kernel stacks instead of 8Kb
> > > 
> > 
> > Good catch!
> 
> Jan Beulich was the one who noticed the stack overflow.
> 
> > I just tried with 2.6.17-rc5-mm3. The BUG still happens with 4K stacks,
> > but the system runs fine with 8K stacks.
> 
> Can you try -mm3 with "check for stack overflows" and 4k stacks?

Maybe we could modify the check-for-stack-overflows code with 8k stacks to
be "check for overflows which would kill a 4k stack kernel".  By decreasing
the thresholds to 3k (say).

> > Another info: the system is able to run fine with the following scenario,
> > even with 4K stack:
> > - boot to runlevel 1
> > - load pktcdvd (modprobe + pktsetup)
> > - then go to runlevel 5 
> > It fails if pktcdvd is loaded at runlevel 2 or higher.
> 
> I have no idea why that would happen.

I'd be surprised if it has to do with the packet code - more likely someone
screwed something up in the lockdep/genirq/unwind area and the kernel went
recursive.

I tried it here, couldn't reproduce it.  Laurent, can you (re?)send the
offending .config?

