Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131309AbRCXAc5>; Fri, 23 Mar 2001 19:32:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131311AbRCXAci>; Fri, 23 Mar 2001 19:32:38 -0500
Received: from monza.monza.org ([209.102.105.34]:52484 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S131309AbRCXAc3>;
	Fri, 23 Mar 2001 19:32:29 -0500
Date: Fri, 23 Mar 2001 16:31:29 -0800
From: Tim Wright <timw@splhi.com>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
Message-ID: <20010323163129.B2534@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: "J . A . Magallon" <jamagallon@able.es>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010323162956.A27066@ganymede.isdn.uiuc.edu> <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com> <20010323235909.C3098@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010323235909.C3098@werewolf.able.es>; from jamagallon@able.es on Fri, Mar 23, 2001 at 11:59:09PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 11:59:09PM +0100, J . A . Magallon wrote:
> 
> On 03.23 Linus Torvalds wrote:
> > 
> > I agree. I'd much prefer that syntax also.
> > 
> > Or just remove the "default:" altogether, when it doesn't make any
> > difference.
> > 
> 
> Well, at last some sense. The same is with that ugly out: at the end
> of the function. Just change all that 'goto out' for a return.
> It does not matter, -O2 is going to do what it wants.
> 

This has nothing to do with fastpathing and object code optimization. C
doesn't have exception handling, so you either have to remember to undo
allocations etc.  in failure cases all through the code, or you stick your
undo code at the end of the function and have all failure cases jump to the
relevant label.  It's not pretty, but it's much less error-prone e.g.

func()
{
    error = 0;
    a = alloc_something();
    if (some failure) {
	error = XXX;
	goto out;
    }
    b = alloc_something_else();
    if (some other failure) {
	error = YYY;
	goto out1;
    }
...
out1:
    dealloc(b);
out:
    dealloc(a);
    return(error);
}

This is arguably easier to follow and less likely to get broken than the
alternative of embedding all the unwind code at each error point.

Tim

--
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
