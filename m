Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264682AbUE0RR3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264682AbUE0RR3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:17:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264625AbUE0RR3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:17:29 -0400
Received: from colin2.muc.de ([193.149.48.15]:22025 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S264902AbUE0RNz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:13:55 -0400
Date: 27 May 2004 19:13:52 +0200
Date: Thu, 27 May 2004 19:13:52 +0200
From: Andi Kleen <ak@muc.de>
To: Arthur Perry <kernel@linuxfarms.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
Subject: Re: GART error 11 (fwd)
Message-ID: <20040527171352.GA36906@colin2.muc.de>
References: <20uGg-17i-23@gated-at.bofh.it> <m3d64pvqlu.fsf@averell.firstfloor.org> <Pine.LNX.4.58.0405271135280.18743@tiamat.perryconsulting.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0405271135280.18743@tiamat.perryconsulting.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 27, 2004 at 12:05:38PM -0400, Arthur Perry wrote:
> And perhaps this may be the case, maybe the hardware should not report
> these errors (which may not actually be gart errors after all) just
> because the GART has been set up.
> However, my failure mode seems to be that I only get these errors when the
> agp driver is loaded on a machine that does not have an agp bus.
> I also have IOMMUs disabled in the BIOS by default.

The kernel will allocate an aperture if there isn't one (over memory
when needed) 

> The BIOS is not enabling the GART at all, so it must be done by the
> kernel. A boot into DOS will show the Gart Aperture Control Register set

Correct. 

> to all zeros, where a boot to Linux 2.4 w/AGP will boot with them enabled.
> Again, the failure mode recognised so far is that the "gart errors" appear
> when this register is set up.
> 
> What the user sees at this point is even though they have the
> "GART error reporting enable" disabled, they still see "GART" errors.

The GART error MCE does not work properly in K8. Normally the BIOS
disables it, but some early kernels managed to still enable
it through a backdoor.

You can rule that out by using an recent 2.4 kernel.org kernel or
the SLES8-SP3 kernel if you want a distribution kernel (no idea
if RH has the fix or not) 

But it's possible that it's really a different MCE.


> 
> If you are suggesting that there may be a real hardware error here that is
> being misinterpreted by the kernel, my next course of action is to collect
> that real error syndrome and decode it.

Yes, that's a good idea. 

> 
> I can volunteer to assist with fixing this decoding function as well,
> since I have a good test case here.

We already have a patch for that, it just needs a bit more work
before it can be merged.

-Andi
