Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291653AbSBHRHU>; Fri, 8 Feb 2002 12:07:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291654AbSBHRHK>; Fri, 8 Feb 2002 12:07:10 -0500
Received: from bitmover.com ([192.132.92.2]:34284 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S291653AbSBHRG5>;
	Fri, 8 Feb 2002 12:06:57 -0500
Date: Fri, 8 Feb 2002 09:06:34 -0800
From: Larry McVoy <lm@bitmover.com>
To: Nigel Gamble <nigel@nrg.org>
Cc: Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>,
        Martin Wirth <Martin.Wirth@dlr.de>, linux-kernel@vger.kernel.org,
        mingo@elte.hu
Subject: Re: [RFC] New locking primitive for 2.5
Message-ID: <20020208090634.L22379@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Nigel Gamble <nigel@nrg.org>, Andrew Morton <akpm@zip.com.au>,
	Robert Love <rml@tech9.net>, Martin Wirth <Martin.Wirth@dlr.de>,
	linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <3C62D49A.4CBB6295@zip.com.au> <Pine.LNX.4.40.0202080003360.613-100000@cosmic.nrg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.40.0202080003360.613-100000@cosmic.nrg.org>; from nigel@nrg.org on Fri, Feb 08, 2002 at 12:20:37AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 12:20:37AM -0800, Nigel Gamble wrote:
> On Thu, 7 Feb 2002, Andrew Morton wrote:
> > I dunno.  The spin-a-bit-then-sleep lock has always struck me as
> > i_dont_know_what_the_fuck_im_doing_lock().  Martin's approach puts
> > the decision in the hands of the programmer, rather than saying
> > "Oh gee I goofed" at runtime.
> 
> I completely agree, and I couldn't have put it better!  Kernel
> programmers really should know exactly why, what, where and for how long
> they are holding a lock.

Should != do.

And any kernel programmer who says they do in a fine grained multithreaded
kernel is full of it.  Look at IRIX, look at Solaris, and show me someone
who says they know for a fact how long they hold each lock and I'll show
you a liar.

Furthermore, while adaptive spin-then-sleep locks may look stupid, I think
you may be missing the point.  If you are running an SMP kernel on a UP,
you want the lock to sleep immediately.  If you are running an SMP kernel
on an SMP, then you want to spin if the lock is held by some other CPU
but sleep if it is held by this CPU.  I suspect that that is what was
really meant by spin-a-bit-then-sleep, it just got lost in translation.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
