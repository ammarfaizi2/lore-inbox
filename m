Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281594AbRKPWfn>; Fri, 16 Nov 2001 17:35:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281599AbRKPWfY>; Fri, 16 Nov 2001 17:35:24 -0500
Received: from domino1.resilience.com ([209.245.157.33]:5838 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S281597AbRKPWfL>; Fri, 16 Nov 2001 17:35:11 -0500
Message-ID: <3BF5952E.E73BB648@resilience.com>
Date: Fri, 16 Nov 2001 14:37:34 -0800
From: Jeff Golds <jgolds@resilience.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.13 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Stefan Smietanowski <stesmi@stesmi.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] AMD SMP capability sanity checking.
In-Reply-To: <Pine.LNX.4.30.0111162302160.22827-100000@Appserv.suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> 
> On Fri, 16 Nov 2001, Stefan Smietanowski wrote:
> 
> > Would you mind writing what each of these actually is?
> > Athlon 661 doesn't tell me much, neither does Duron 671.
> > That's just an example, which is which?
> 
> The numbers translate to the family/model/stepping fields
> of /proc/cpuinfo.
> 
> The only older models certified as safe for SMP are.
> 
>  Athlon model 6, stepping 0 CPUID = 660
>  Athlon model 6, stepping 1 CPUID = 661
>  Duron  model 7, stepping 0 CPUID = 670
> 
> The newer models..
>  model 6 stepping 2 and above 662
>  model 7 stepping 1 and above 671
> 
> have a cpuid flag that must be compared to find out if they
> are capable or not. Note that these id's tally with XP's and MP's.
> The capability bit is the only way to distinguish between these models.
> 

So the MP has the SMP capable bit set and the XP does not?

If so, I'm not convinced this is the correct way to approach this
issue.  My reasoning is based on the fact that AMD is not exactly a
impartial source of information.  AMD wants to sell more MP chips, so
they can say that only MP chips are SMP capable even if XP chips work
just fine.

Now, with your patch, if people successfully use XP chips in an SMP
configuration, you're giving the maintainers of the Linux kernel the
opportunity to ignore oopses reported from these people and I think
that's a bad thing.  If someone can show that XPs are truly not SMP
capable, then, by all means, implement your patch as written.

The way I'd prefer to see this handled is that things are assumed to
work until proven otherwise.  Sort of like the SMP Celeron systems
people have been using: Is there _any_ reason to believe that Celeron's
can't do SMP?  Sure doesn't seem like it except for Intel's statement
that Celerons aren't SMP capable.  And if you decide to taint oopses
from people with such configurations, I think you'll be doing the Linux
community a disservice.

-Jeff

P.S.  BTW, I don't know all the Athlon steppings, but it sure looks like
_a lot_ of older Athlons/Durons are SMP capable.  Does it seem likely
that this suddenly changed when AMD stamped XP or MP on the chip?

-- 
Jeff Golds
Sr. Software Engineer
jgolds@resilience.com
