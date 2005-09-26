Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932489AbVIZW2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932489AbVIZW2b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 18:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbVIZW2b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 18:28:31 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:55459 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932489AbVIZW2b
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 18:28:31 -0400
Subject: Re: [PATCH] x86-64: Fix bad assumption that dualcore cpus have
	synced TSCs (resend)
From: john stultz <johnstul@us.ibm.com>
To: Stefan Smietanowski <stesmi@stesmi.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4338731B.4020301@stesmi.com>
References: <1127764012.8195.138.camel@cog.beaverton.ibm.com>
	 <4338731B.4020301@stesmi.com>
Content-Type: text/plain
Date: Mon, 26 Sep 2005 15:28:26 -0700
Message-Id: <1127773707.8195.145.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-09-27 at 00:15 +0200, Stefan Smietanowski wrote:

> Wouldn't it be a good idea to change the comment following
> the code you removed as well?
> 
> Why have a comment saying "multi socket systems" if there is no
> distinction anymore?
> 
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
>        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> >   	return num_online_cpus() > 1;

Yea, good point, that should probably be "SMP systems". 

Do you want to send the patch to Andrew? :)

thanks
-john

