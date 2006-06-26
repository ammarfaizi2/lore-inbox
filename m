Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933383AbWFZWqV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933383AbWFZWqV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 18:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933354AbWFZWpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 18:45:51 -0400
Received: from ccerelbas03.cce.hp.com ([161.114.21.106]:2778 "EHLO
	ccerelbas03.cce.hp.com") by vger.kernel.org with ESMTP
	id S933341AbWFZWpX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 18:45:23 -0400
Date: Mon, 26 Jun 2006 15:37:17 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: oprofile-list <oprofile-list@lists.sourceforge.net>,
       perfmon <perfmon@napali.hpl.hp.com>,
       linux-ia64 <linux-ia64@vger.kernel.org>,
       perfctr-devel <perfctr-devel@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.17.1 new perfmon code base, libpfm, pfmon available
Message-ID: <20060626223716.GA16082@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200606261336_MC3-1-C384-7981@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200606261336_MC3-1-C384-7981@compuserve.com>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck,

On Mon, Jun 26, 2006 at 01:33:03PM -0400, Chuck Ebbert wrote:
> > Also a new version of pfmon, pfmon-3.2-060621, to take advantage of the update in libpfm:
> > 
> >       - support for 32-bit mode AMD64 processors
> >       - updated event name parsing to prepare for separate
> >         event unit mask management (Kevin Corry)
> >       - fix the detection of unavailable PMC registers. it was causing crashes
> >         when used with sampling.
> > 
> > Note that I have tested 32-bit compiled libpfm,pfmon running on an 64-bit AMD
> > perfmon kernel. I have not tested on a 32-bit AMD linux kernel because I don't
> > have such setup. I would appreciate any feedback on this.
> 
> 32-bit works great.  Unfortunately, pfmon is far too limited for serious kernel
> monitoring AFAICT.  E.g. you can't select edge counting instead of cycle
> counting.  So you can count how many clock cycles were spent with interrupts

I put in an option to enable this mode, do pfmon --help. I think it's called
edge-mask.

> disabled but you can't count how many times they were disabled.  That's too bad
> because using pfmon is so easy compared to writing a program.
> 
Try the option, and let me know if it does not work for you.

> And is someone working on kernel profiling tools that use the perfmon2
> infrastructure on i386?  I'd like to see kernel-based profiling that lets
> you use something like the existing 'readprofile' to retrieve results.  This
> would be a lot better than the current timer-based profiling.
> 
You can do this on your athlon using pfmon already, you need to enable a
different sampling module. Here is an example:

$ pfmon --smpl-module=inst-hist -ecpu_clk_unhalted -k --long-smpl-period=100000 \
     --resolve-addr --system-wide --session-timeout=10

This will sample (period of 100,000 cpu_clk_unhalted) in the kernel ONLY for 10s and print  a flat
profile sorted by #samples/instruction addresses. You can chose any event you want. Note that you can
also use this output format in per-thread mode.

Hope this helps.
-- 
-Stephane
