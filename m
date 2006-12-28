Return-Path: <linux-kernel-owner+w=401wt.eu-S1753891AbWL1Xwq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbWL1Xwq (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 18:52:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753900AbWL1Xwq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 18:52:46 -0500
Received: from smtp.osdl.org ([65.172.181.25]:43304 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891AbWL1Xwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 18:52:45 -0500
Date: Thu, 28 Dec 2006 15:51:59 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, Neil Brown <neilb@suse.de>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       virtualization <virtualization@lists.osdl.org>
Subject: Re: [PATCH] Use correct macros in raid code, not raw asm
In-Reply-To: <1167348861.30506.46.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0612281549080.4473@woody.osdl.org>
References: <1167348861.30506.46.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2006, Rusty Russell wrote:
>
> This make sure it's paravirtualized correctly when CONFIG_PARAVIRT=y.

Why doesn't this code use "kernel_fpu_begin()" and "kernel_fpu_end()"?

The raid6 code is crap, and slower. It does "fsave/frstor" or movaps or 
other crud, and the thing is, it shouldn't. It should just do 
kernel_fpu_begin/end(), which does it all right, and avoids saving any 
state at all unless it's being used by the user RIGHT NOW.

		Linus
