Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132448AbRCZO1a>; Mon, 26 Mar 2001 09:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132449AbRCZO1U>; Mon, 26 Mar 2001 09:27:20 -0500
Received: from monza.monza.org ([209.102.105.34]:7953 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S132448AbRCZO1J>;
	Mon, 26 Mar 2001 09:27:09 -0500
Date: Mon, 26 Mar 2001 06:25:57 -0800
From: Tim Wright <timw@splhi.com>
To: Stephen Satchell <satch@fluent-access.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings
Message-ID: <20010326062557.A1985@kochanski.internal.splhi.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Stephen Satchell <satch@fluent-access.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20010323235909.C3098@werewolf.able.es> <20010323162956.A27066@ganymede.isdn.uiuc.edu> <Pine.LNX.4.31.0103231433380.766-100000@penguin.transmeta.com> <20010323235909.C3098@werewolf.able.es> <20010323163129.B2534@kochanski.internal.splhi.com> <4.3.2.7.2.20010323170728.00b31100@mail.fluent-access.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <4.3.2.7.2.20010323170728.00b31100@mail.fluent-access.com>; from satch@fluent-access.com on Fri, Mar 23, 2001 at 05:16:26PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 05:16:26PM -0800, Stephen Satchell wrote:
[...]
> Really?  I have a "cleanup" function that can be called during failure 
> cases (and success cases -- but you didn't mention that) so that the cost 
> is very low and I don't have to code ANY labels.
> 
> But then again, I'm a double-pipe abuser, in that I tend to code "atomic" 
> sequences as
> 
> if ((a) || (b) || (c) || (d) || (e) || (f) || (g) || ... ) { something 
> failed}  else {it all worked!}
> 
> and make sure that the failure value is non-zero for each a, b, c, d, and 
> so forth.
> 

Sorry, my example was too simplistic. Replace simple allocations with e.g.
allocate();
grab lock;
set flag;
allocate();

or something similar. Yes it's possible to code a state variable to remember
where you got to, or to e.g. add an extra boolean variable to indicate that
you grabbed the lock, but I'd argue that this obfuscates the code as well as
making it less efficient. It's no good looking to see if the lock has been
grabbed - if you failed at the first stage, it may still be locked by a
different CPU.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
