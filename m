Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263184AbUD2EUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263184AbUD2EUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 00:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbUD2EUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 00:20:51 -0400
Received: from florence.buici.com ([206.124.142.26]:64134 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S263184AbUD2EUs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 00:20:48 -0400
Date: Wed, 28 Apr 2004 21:20:47 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Jeff Garzik <jgarzik@pobox.com>, Andrew Morton <akpm@osdl.org>,
       brettspamacct@fastclick.com, linux-kernel@vger.kernel.org,
       Russell King <rmk@arm.linux.org.uk>
Subject: Re: ~500 megs cached yet 2.6.5 goes into swap hell
Message-ID: <20040429042047.GB26845@buici.com>
References: <409021D3.4060305@fastclick.com> <20040428170106.122fd94e.akpm@osdl.org> <409047E6.5000505@pobox.com> <40904A84.2030307@yahoo.com.au> <20040429005801.GA21978@buici.com> <40907AF2.2020501@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40907AF2.2020501@yahoo.com.au>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 01:48:02PM +1000, Nick Piggin wrote:
> Marc Singer wrote:
> >On Thu, Apr 29, 2004 at 10:21:24AM +1000, Nick Piggin wrote:
> >
> >>Anyway, I have a small set of VM patches which attempt to improve
> >>this sort of behaviour if anyone is brave enough to try them.
> >>Against -mm kernels only I'm afraid (the objrmap work causes some
> >>porting difficulty).
> >
> >
> >Is this the same patch you wanted me to try?  
> >
> >  Remember, the embedded system where NFS IO was pushing my
> >  application out of memory.  Setting swappiness to zero was a
> >  temporary fix.
> >
> >
> 
> Yes this is the same patch I wanted you to try. Yes I
> remember your problem!
> 
> Didn't anyone come up with a patch for you to test the
> stale PTE theory? If so, what where the results?

Russell King is working on a lot of things for the MMU code in ARM.
I'm waiting to see where he ends up.  I believe he's planning on
removing the lazy PTE release logic.

I hacked at it for some time.  And I'm convinced that I correctly
forced the TLBs to be flushed.  Still, I was never able to get the
system to behave.

Now, I just read a comment you or WLI made about the page cache
use-once logic.  I wonder if that's the real culprit?  As I wrote to
Andrew Morton, the kernel seems to be assigning an awful lot of value
to page cache pages that are used once (or twice?).  I know that it
would be expensive to perform an HTG aging algorithm where the head of
the LRU list is really LRU.  Does your patch pursue this line of
thought?

