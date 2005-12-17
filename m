Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964956AbVLQUwi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964956AbVLQUwi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Dec 2005 15:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964974AbVLQUwi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Dec 2005 15:52:38 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:19725 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964956AbVLQUwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Dec 2005 15:52:37 -0500
Date: Sat, 17 Dec 2005 21:52:38 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andi Kleen <ak@suse.de>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, arjan@infradead.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
Message-ID: <20051217205238.GR23349@stusta.de>
References: <20051215212447.GR23349@stusta.de> <20051215140013.7d4ffd5b.akpm@osdl.org> <20051216141002.2b54e87d.diegocg@gmail.com> <20051216140425.GY23349@stusta.de> <20051216163503.289d491e.diegocg@gmail.com> <632A9CF3-7F07-44D6-BFB4-8EAA272AF3E5@mac.com> <p73slsrehzs.fsf@verdi.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p73slsrehzs.fsf@verdi.suse.de>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 17, 2005 at 06:44:07PM +0100, Andi Kleen wrote:
> Kyle Moffett <mrmacman_g4@mac.com> writes:
> 
> > On Dec 16, 2005, at 10:35, Diego Calleja wrote:
> > > I know, but there's too much resistance to the "pure" 4kb patch.
> > 
> > I have yet to see any resistance to the 4Kb patch this time around
> > that was not "*whine* don't break my ndiswrapper plz".  
> 
> My comment from last time about the missing safety net still applies 100%.
> 
> Kernel code is getting more complex all the time and running with
> very tight stack is just risky.

My patch reduces it from roughly 6kB to 4kB.

I'm with you that we need a safety net, but I don't see a problem with 
this being between 3kB and 4kB. The goal should be to _never_ use more 
than 3kB stack having a 1kB safety net.

And in my experience, many stack problems don't come from code getting 
more complex but from people allocating 1kB structs or arrays of
> 2k chars on the stack. In these cases, the code has to be fixed and 
"make checkstack" makes it easy to find such cases.

And as a data point, my count of bug reports for problems with in-kernel 
code with 4k stacks after Neil's patch went into -mm is still at 0.

> > The point is to force it in -mm so most people can't just disable it
> > because it fixes their problem.  We want 8k stacks to go away, and
> 
> Who is we? And why? 
> 
> About the only half way credible arguments I've seen for it were:  
> 
> - "it might reduce stalls in the VM with order 1". Didn't quite
> convince me because there were no numbers presented and at least on
> x86-64 I've never noticed or got reported significant stalls because
> of this.
> 
> - "it allows more threads for 32bit which might run out of lowmem" - i
> think everybody agrees that the 10k threads case is not really
> something to encourage. And even when you want to add it then only a factor
> two increase (which this patch brings) is not really too helpful.
>...

Unfortunately, "is not really something to encourage" doesn'a make 
"happens in real-life applications" impossible...

Reducing the stack by one third brings a factor two reduction in the 
memory usage of threads - I wouldn't say this sounds too bad.

> -Andi

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

