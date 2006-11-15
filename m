Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966731AbWKOKBV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966731AbWKOKBV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:01:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966732AbWKOKBV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:01:21 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:6577 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S966731AbWKOKBU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:01:20 -0500
Date: Wed, 15 Nov 2006 11:00:30 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, patches@x86-64.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH for 2.6.19] [3/9] x86_64: shorten the x86_64 boot setup GDT to what the comment says
Message-ID: <20061115100030.GA5753@elte.hu>
References: <20061114508.445749000@suse.de> <20061114160853.9F16213C98@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061114160853.9F16213C98@wotan.suse.de>
User-Agent: Mutt/1.4.2.2i
X-ELTE-SpamScore: -2.8
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.8 required=5.9 tests=ALL_TRUSTED,AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.5 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.4998]
	-0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> From: Steven Rostedt <rostedt@goodmis.org>
> 
> Stephen Tweedie, Herbert Xu, and myself have been struggling with a very
> nasty bug in Xen.  But it also pointed out a small bug in the x86_64
> kernel boot setup.
> 
> The GDT limit being setup by the initial bzImage code when entering into
> protected mode is way too big.  The comment by the code states that the
> size of the GDT is 2048, but the actual size being set up is much bigger
> (32768). This happens simply because of one extra '0'.
> 
> Instead of setting up a 0x800 size, 0x8000 is set up.  On bare metal this
> is fine because the CPU wont load any segments unless  they are
> explicitly used.  But unfortunately, this breaks Xen on vmx FV, since it
> (for now) blindly loads all the segments into the VMCS if they are less
> than the gdt limit. Since the real mode segments are around 0x3000, we are
> getting junk into the VMCS and that later causes an exception.
> 
> Stephen Tweedie has written up a patch to fix the Xen side and will be
> submitting that to those folks. But that doesn't excuse the GDT limit
> being a magnitude too big.
> 
> AK: changed to compute true gdt size in assembler, fixed comment
> 
> Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
> Signed-off-by: Andi Kleen <ak@suse.de>

Acked-by: Ingo Molnar <mingo@elte.hu>

note, it seems to me that i386 had this fix years ago already.

	Ingo
