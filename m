Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265622AbTIFHI4 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Sep 2003 03:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265633AbTIFHI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Sep 2003 03:08:56 -0400
Received: from nikam.ms.mff.cuni.cz ([195.113.18.106]:61895 "EHLO
	nikam.ms.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S265622AbTIFHIy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Sep 2003 03:08:54 -0400
Date: Sat, 6 Sep 2003 09:08:54 +0200
From: Jan Hubicka <jh@suse.cz>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Jan Hubicka <jh@suse.cz>, Andi Kleen <ak@muc.de>, torvalds@osdl.org,
       akpm@osdl.org, rth@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030906070854.GF9989@kam.mff.cuni.cz>
References: <20030905004710.GA31000@averell> <20030905053730.GB24509@kam.mff.cuni.cz> <20030905172715.GA80302@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905172715.GA80302@colin2.muc.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > How much work would be to fix kernel in this regard?
> 
> The big problem is that -funit-at-a-time is not widely used yet,
> so even if we fix the kernel at some point it would likely 
> get broken again all the time by people who use older kernels
> (= most kernel developers currently)
> 
> > Are there some cases where this is esential?  Kernel would be nice
> > target to whole program optimization and GCC is not that far from it
> > right now.
> 
> I'm not sure that is that good an idea. When I was still hacking 
> TCP I especially moved some stuff out-of-line in the fast path to avoid 
> register pressure. Otherwise gcc would inline rarely used sub functions 
> and completely mess up the register allocation in the fast path.
> Of course just a call alone messes up the registers somewhat because
> of its clobbers, but a full inlining is usually worse.

You can use -O2 and rely on inline done by hand.  I can add option
-fno-inline-functions-called-once.  That should avoid such a problems.
Anyway it would be nice to mark functions that exist for this reason by
noinline attribute so compiler knows about it, but that is different
story.
> 
> Also I fear cross module inlining would expose a lot of latent bugs
> (missing barriers etc.) when the optimizer becomes more aggressive. 
> I'm not saying this would be a bad thing, just that it may be a lot 
> of work to fix (both for compiler and kernel people)

Some of this should be already tested by folks using Intel compiler I
would hope.

Honza
> 
> -Andi
> 
