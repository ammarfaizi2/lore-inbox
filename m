Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262281AbVAUGfX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262281AbVAUGfX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 01:35:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262282AbVAUGfX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 01:35:23 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:39511
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262281AbVAUGfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 01:35:17 -0500
Date: Fri, 21 Jan 2005 07:35:17 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, npiggin@novell.com
Subject: Re: OOM fixes 2/5
Message-ID: <20050121063517.GB17050@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050120222056.61b8b1c3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120222056.61b8b1c3.akpm@osdl.org>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 3812 CD76 E482 94AF 020C  0FFA E1FF 559D 9B4F A59B
X-Cpushare-SSL-MD5-Cert: EDA5 F2DA 1D32 7560  5E07 6C91 BFFC B885
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 10:20:56PM -0800, Andrew Morton wrote:
> Andrea Arcangeli <andrea@suse.de> wrote:
> >
> >  This is the forward port to 2.6 of the lowmem_reserved algorithm I
> >  invented in 2.4.1*, merged in 2.4.2x already and needed to fix workloads
> >  like google (especially without swap) on x86 with >1G of ram, but it's
> >  needed in all sort of workloads with lots of ram on x86, it's also
> >  needed on x86-64 for dma allocations. This brings 2.6 in sync with
> >  latest 2.4.2x.
> 
> But this patch doesn't change anything at all in the page allocation path
> apart from renaming lots of things, does it?

In the allocation path not, but it rewrites the setting algorithm, so
from somebody watching it from userspace it's a completely different
thing, usable for the first time ever in 2.6. Otherwise userspace would
be required to have knowledge about the kernel internals to be able to
set it to a sane value. Plus the new init code is much cleaner too.

> AFAICT all it does is to change the default values in the protection map. 
> It does it via a simplification, which is nice, but I can't see how it
> fixes anything.

Having this patch applied is a major fix. See again the google fix
thread in 2.4.1x.  2.6 is vulnerable to it again. This patch makes the
feature usable and enables the feature as well, which is definitely a
fix as far as an end user is concerned (google was the user in this case).
