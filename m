Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbUKDW64@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbUKDW64 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 17:58:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262481AbUKDWzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 17:55:42 -0500
Received: from fw.osdl.org ([65.172.181.6]:63720 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262460AbUKDWwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 17:52:31 -0500
Date: Thu, 4 Nov 2004 14:52:29 -0800
From: Chris Wright <chrisw@osdl.org>
To: Serge Hallyn <serue@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] [PATCH] [0/6] LSM Stacking
Message-ID: <20041104145229.D2357@build.pdx.osdl.net>
References: <1099609471.2096.10.camel@serge.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>; from serue@us.ibm.com on Thu, Nov 04, 2004 at 05:04:31PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Serge Hallyn (serue@us.ibm.com) wrote:
> The following set of patches add support required to stack most
> LSMs.  The most important patch is the first, which provides a
> method for more than one LSM to annotate information to kernel
> objects.  LSM's known to use the LSM fields include selinux, bsdjail,
> seclvl, and digsig.  Without this patch (or something like it),
> none of these modules can be used together.

I think, all in all, this needs more work and more justification (esp.
w.r.t. overhead and impact on the current common use of a single
module).

> 2. A 2.6.10-rc1-bk10 system with the stacking patches, and capabilities
> and SELinux compiled into the kernel under the stacker LSM.  Other
> than stacker being compiled in and the size of the LSM void* array
> being set to 4, the exact same .config was used.

How many CPU's?

> 3. The same kernel as in (2), but with bsdjail and seclvl also stacked.
> 
> On each of these configurations, I ran unixbench twice, and compiled
> a kernel twice (with the same .config, and all files in the cached
> each time).
> 
> The kernel compilation results are as follows:
> 
>          No stacking (1)           Stacking (2)      More Stacking (3)
> Run 1    real 9m51.647s           real 9m48.045s      real 9m53.292s
>          user 8m28.637s           user 8m29.108s      user 8m33.319s
>           sys 1m13.900s            sys 1m14.993s       sys 1m15.377s
> 
> Run 2    real 9m48.154s           real 9m53.369s      real 9m53.292s
>          user 8m28.983s           user 8m29.101s      user 8m34.407s
>           sys 1m13.981s            sys 1m15.307s       sys 1m15.611s
> 
> Run 3    real 9m51.105s           real 9m51.840s      real 9m58.840s
>          user 8m28.894s           user 8m29.192s      user 8m33.538s
>           sys 1m14.183s            sys 1m15.345s       sys 1m16.146s
> 
> Unixbench summaries are as follows.  (I can send the full output if
> anyone asks)

Sorry, I forget what the Unixbench scores mean....

>          No stacking (1)           Stacking (2)      More Stacking (3)
> Run 1         651.5                    647.1                634.3
> Run 2         648.2                    642.8                632.7

How did lmbench numbers look?  And other workloads, like network?

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
