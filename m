Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKQMww>; Fri, 17 Nov 2000 07:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129720AbQKQMwl>; Fri, 17 Nov 2000 07:52:41 -0500
Received: from Cantor.suse.de ([194.112.123.193]:519 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S129132AbQKQMwj>;
	Fri, 17 Nov 2000 07:52:39 -0500
Date: Fri, 17 Nov 2000 13:22:37 +0100
From: Andi Kleen <ak@suse.de>
To: Jan Niehusmann <jan@gondor.com>
Cc: Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Error in x86 CPU capabilities starting with test5/6
Message-ID: <20001117132237.A4525@gruyere.muc.suse.de>
In-Reply-To: <3A14FF48.E554BE1B@home.com> <14869.6415.500026.432150@harpo.it.uu.se> <20001117130418.B3572@gruyere.muc.suse.de> <20001117131430.B29836@gondor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20001117131430.B29836@gondor.com>; from jan@gondor.com on Fri, Nov 17, 2000 at 01:14:30PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2000 at 01:14:30PM +0100, Jan Niehusmann wrote:
> On Fri, Nov 17, 2000 at 01:04:18PM +0100, Andi Kleen wrote:
> > The program would be broken if it executed CPUID itself, because it has no way to guarantee
> > that the CPUID is executed on all CPUs the scheduler may later move the task too.
> 
> I wonder what's the right way for an app to ask the kernel if, for example,
> tsc is available. As you stated above, executing CPUID is probably wrong.
> But if the process parses /proc/cpuinfo, it has to make sure tsc is available
> on all cpus it may run on, doesn't it? 

Just check all the flags and fall back to the code not using the feature 
if any doesn't support it.

> 
> What about some system call stating 'I want to use feature XYZ'. If all CPUs
> implement XYZ, the system call simply returns some ACK, and NACK if no CPU 
> implements it (and no emulation is available). 

That would strike me as overkill. 

> 
> If only some CPUs implement the feature, the kernel may return NACK,
> or it may make sure the process will only run on CPUs implementing the
> feature and return ACK. Is this usefull? It's just an idea ;-) I wonder
> if there are many features that may be available only on some CPUs in an
> 'SMP' system.

Generally it is probably a rare case, otherwise there would be more bug reports
on it (because e.g. for the FXSR case a lot of SSE supporting kernels panic
on boot) 



-Andi


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
