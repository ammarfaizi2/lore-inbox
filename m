Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263232AbUDME1b (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 00:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263301AbUDME1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 00:27:31 -0400
Received: from waste.org ([209.173.204.2]:16857 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S263232AbUDME11 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 00:27:27 -0400
Date: Mon, 12 Apr 2004 23:27:10 -0500
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] eliminate nswap and cnswap
Message-ID: <20040413042710.GC1175@waste.org>
References: <1081827102.1593.227.camel@cube> <20040412204223.2a07d123.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040412204223.2a07d123.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 12, 2004 at 08:42:23PM -0700, Andrew Morton wrote:
> Albert Cahalan <albert@users.sourceforge.net> wrote:
> >
> > > The nswap and cnswap variables counters have never
> > > been incremented as Linux doesn't do task swapping.
> > 
> > I'm pretty sure they were used for paging activity.
> > We don't eliminate support for "swap space", do we?
> > 
> > Somebody must have broken nswap and cnswap while
> > hacking on some vm code. I hate to see the variables
> > get completely ripped out of the kernel instead of
> > getting fixed.
> 
> There's nothing in 2.4 which increments these, nor was there in 2.6.  Which
> tends to imply that they weren't very important.
> 
> We could sort-of do this - move them into mm_struct (doing it in
> task_struct was always wrong) and increment them in the VM.  But we'd need
> some reason why these statistics are interesting, and we'd need an
> explanation of what nswap and cnswap are actually supposed to represent.  

It's used in 2.0 and 2.2 to satisfy the getrusage(2) syscall. The
getrusage page only documents it as 'swaps', but says:

       The above struct was taken from BSD 4.3 Reno. Not all fields
       are meaningful under Linux. Right now (Linux 2.4) only the
       fields ru_utime, ru_stime, ru_minflt, ru_majflt, and ru_nswap
       are maintained.

the BSD manpage says:

ru_nswap
    the number of times a process was swapped out of main memory.

Which means it's a count of full process swaps like ancestral UNIX,
which Linux has never had.

So the 2.0/2.2 attempt to increment said variables was actually bogus.

-- 
Matt Mackall : http://www.selenic.com : Linux development and consulting
