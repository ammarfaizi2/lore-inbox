Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263308AbUDMEt7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:49:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263334AbUDMEt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:49:59 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:55444 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S263308AbUDMEtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:49:55 -0400
Subject: Re: [PATCH] eliminate nswap and cnswap
From: Albert Cahalan <albert@users.sf.net>
To: Matt Mackall <mpm@selenic.com>
Cc: Andrew Morton OSDL <akpm@osdl.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040413042710.GC1175@waste.org>
References: <1081827102.1593.227.camel@cube>
	 <20040412204223.2a07d123.akpm@osdl.org>  <20040413042710.GC1175@waste.org>
Content-Type: text/plain
Organization: 
Message-Id: <1081831651.1587.251.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 13 Apr 2004 00:47:31 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-04-13 at 00:27, Matt Mackall wrote:
> On Mon, Apr 12, 2004 at 08:42:23PM -0700, Andrew Morton wrote:
> > Albert Cahalan <albert@users.sourceforge.net> wrote:
> > >
> > > > The nswap and cnswap variables counters have never
> > > > been incremented as Linux doesn't do task swapping.
> > > 
> > > I'm pretty sure they were used for paging activity.
> > > We don't eliminate support for "swap space", do we?
> > > 
> > > Somebody must have broken nswap and cnswap while
> > > hacking on some vm code. I hate to see the variables
> > > get completely ripped out of the kernel instead of
> > > getting fixed.
> > 
> > There's nothing in 2.4 which increments these, nor was there in 2.6.  Which
> > tends to imply that they weren't very important.
> > 
> > We could sort-of do this - move them into mm_struct (doing it in
> > task_struct was always wrong) and increment them in the VM.  But we'd need
> > some reason why these statistics are interesting, and we'd need an
> > explanation of what nswap and cnswap are actually supposed to represent.  
> 
> It's used in 2.0 and 2.2 to satisfy the getrusage(2) syscall. The
> getrusage page only documents it as 'swaps', but says:
> 
>        The above struct was taken from BSD 4.3 Reno. Not all fields
>        are meaningful under Linux. Right now (Linux 2.4) only the
>        fields ru_utime, ru_stime, ru_minflt, ru_majflt, and ru_nswap
>        are maintained.
> 
> the BSD manpage says:
> 
> ru_nswap
>     the number of times a process was swapped out of main memory.
> 
> Which means it's a count of full process swaps like ancestral UNIX,
> which Linux has never had.

Well, that's the BSD man page.

I've always considered "swapped" to mean "paged"
when dealing with Linux. We still have our swap
partitions and swapon command, not paging partitions
and pageon command.

I suppose "paged out the area with the stack pointer"
would be a good approximation to the BSD behavior.

> So the 2.0/2.2 attempt to increment said variables was actually bogus.

If the variables counted paging, I consider them
correct for Linux.


