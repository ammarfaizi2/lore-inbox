Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318947AbSH1UvX>; Wed, 28 Aug 2002 16:51:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318959AbSH1UvW>; Wed, 28 Aug 2002 16:51:22 -0400
Received: from natwar.webmailer.de ([192.67.198.70]:34288 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S318947AbSH1UvW>; Wed, 28 Aug 2002 16:51:22 -0400
Date: Wed, 28 Aug 2002 22:53:15 +0200
From: Dominik Brodowski <devel@brodo.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
Message-ID: <20020828225315.D816@brodo.de>
References: <20020828221947.A816@brodo.de> <Pine.LNX.4.33.0208281331020.8978-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
In-Reply-To: <Pine.LNX.4.33.0208281331020.8978-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Wed, Aug 28, 2002 at 01:43:08PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2002 at 01:43:08PM -0700, Linus Torvalds wrote:
> 
> On Wed, 28 Aug 2002, Dominik Brodowski wrote:
> >
> > Do these CPUs need kernel support? E.g. do udelay() calls work as
> > expected?
> 
> Crusoe CPU's do not.
Great.

> But Intel CPU's _do_ need this, for example (since they change the TSC
> frequency).
And that's why there is some need for a cpufreq core (which manages
loops_per_jiffy etc.) and the need for the cpufreq drivers (#2 and #3 in my
previous mail).

> Which is why such a CPU needs to be passed in a _policy_. Which is my 
> whole argument.
Which is #1 - the "input" to the cpufreq core. This can be seperated from
the cpufreq core. So basically 

"policy input" --> "frequency input" --> cpufreq core --> cpufreq driver
  user-space    |                 k e r n e l  -  s p a c e

instead of

"policy input" --> "frequency input" --> cpufreq core --> cpufreq driver
     u s e r  -  s p a c e            |     k e r n e l  -  s p a c e


Linus, would you agree to the /proc interface as one of several
frequency "input"/management options? It's good for testing, for some 
workloads (LART), and it's (almost) done (just needs seperating from 
the cpufreq core)...

	Dominik
