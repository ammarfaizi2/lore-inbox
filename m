Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVJGMaF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVJGMaF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Oct 2005 08:30:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbVJGMaF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Oct 2005 08:30:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:52673 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932420AbVJGMaC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Oct 2005 08:30:02 -0400
From: Andi Kleen <ak@suse.de>
To: "Vladimir B. Savkin" <master@sectorb.msk.ru>
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have synced TSCs
Date: Fri, 7 Oct 2005 14:31:46 +0200
User-Agent: KMail/1.8
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       john stultz <johnstul@us.ibm.com>, discuss@x86-64.org
References: <1127157404.3455.209.camel@cog.beaverton.ibm.com> <20051007122624.GA23606@tentacle.sectorb.msk.ru>
In-Reply-To: <20051007122624.GA23606@tentacle.sectorb.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510071431.47245.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 October 2005 14:26, Vladimir B. Savkin wrote:
> On Mon, Sep 19, 2005 at 12:16:43PM -0700, john stultz wrote:
> > Andrew,
> > 	This patch should resolve the issue seen in bugme bug #5105, where it
> > is assumed that dualcore x86_64 systems have synced TSCs. This is not
> > the case, and alternate timesources should be used instead.
> >
> > For more details, see:
> > http://bugzilla.kernel.org/show_bug.cgi?id=5105
>
> I too have a box that shows the symptoms from bugzilla entry above.
> The system is Asus A8V Deluxe MB with
> "AMD Athlon(tm) 64 X2 Dual Core Processor 3800+".
>
> The patch below did not fix the problem, while "idle=poll" did.
> Hope this helps, dmesg attached.

Are you running the latest BIOS?

-Andi

>
> > Please consider for inclusion in your tree.
> >
> > thanks
> > -john
> >
> > diff --git a/arch/x86_64/kernel/time.c b/arch/x86_64/kernel/time.c
> > --- a/arch/x86_64/kernel/time.c
> > +++ b/arch/x86_64/kernel/time.c
> > @@ -959,9 +959,6 @@ static __init int unsynchronized_tsc(voi
> >   	   are handled in the OEM check above. */
> >   	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
> >   		return 0;
> > - 	/* All in a single socket - should be synchronized */
> > - 	if (cpus_weight(cpu_core_map[0]) == num_online_cpus())
> > - 		return 0;
> >  #endif
> >   	/* Assume multi socket systems are not synchronized */
> >   	return num_online_cpus() > 1;
>
> ~
>
> :wq
>
>                                         With best regards,
>                                            Vladimir Savkin.
