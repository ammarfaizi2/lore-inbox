Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267563AbUIPGOF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267563AbUIPGOF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267583AbUIPGOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:14:05 -0400
Received: from cantor.suse.de ([195.135.220.2]:15078 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267563AbUIPGOB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:14:01 -0400
Date: Thu, 16 Sep 2004 08:13:59 +0200
From: Andi Kleen <ak@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Zwane Mwaikambo <zwane@fsmlabs.com>, linux-kernel@vger.kernel.org,
       ak@suse.de, wli@holomorphy.com, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916061359.GA12915@wotan.suse.de>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040915144523.0fec2070.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 02:45:23PM -0700, Andrew Morton wrote:
> Zwane Mwaikambo <zwane@fsmlabs.com> wrote:
> >
> > William spotted this stray bit, LOCK_SECTION isn't used anymore on x86_64. 
> 
> btw, Ingo and I were scratching heads over an x86_64 oops in curent -linus
> trees.
> 
> If you enable profiling and frame pointers, profile_pc() goes splat
> dereferencing the `regs' argument when it decides that the pc refers to a
> lock section.  Ingo said `regs' had a value of 0x2, iirc.  Consider this a
> bug report ;)

Known problem. Interrupts don't save regs->rbp, but the new profile_pc
that was introduced recently uses it.

One quick fix is to just use SAVE_ALL in the interrupt entry code,
but I don't like this because it will affect interrupt latency.

The real fix is to fix profile_pc to not reference it.

-Andi
