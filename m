Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUILSLp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUILSLp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 14:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268764AbUILSLo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 14:11:44 -0400
Received: from [211.58.254.17] ([211.58.254.17]:43433 "EHLO hemosu.com")
	by vger.kernel.org with ESMTP id S268237AbUILSLg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 14:11:36 -0400
Date: Mon, 13 Sep 2004 03:11:29 +0900
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andi Kleen <ak@suse.de>, Tejun Heo <tj@home-tj.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Interrupt entry CONFIG_FRAME_POINTER fix
Message-ID: <20040912181129.GA21093@home-tj.org>
References: <20040912091628.GB13359@home-tj.org> <20040912132454.6cf1d60c.ak@suse.de> <Pine.LNX.4.53.0409121257320.2297@montezuma.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0409121257320.2297@montezuma.fsmlabs.com>
User-Agent: Mutt/1.5.6+20040818i
From: Tejun Heo <tj@home-tj.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 01:10:26PM -0400, Zwane Mwaikambo wrote:
> On Sun, 12 Sep 2004, Andi Kleen wrote:
> > On Sun, 12 Sep 2004 18:16:28 +0900
> > Tejun Heo <tj@home-tj.org> wrote:
> > 
> > >  On x86_64, rbp isn't saved on entering interrupt handler even when
> > > CONFIG_FRAME_POINTER is turned on.  This breaks profile_pc()
> > > (resulting in oops) which uses regs->rbp to track back to the original
> > > stack.  Save full stack when CONFIG_FRAME_POINTER is specified.
> > 
> > 
> > I don't think your patch is correct, you don't restore rbp ever and it gets corrupted.
> > 
> > I think the correct change is to fix profile_pc() to not reference rbp, but just hardcode
> > the rsp offset for the FP and non FP cases (8 and 0) 
> 
> Yep, i botched up the patch, after looking at the disassembly on 
> x86_64 without CONFIG_FRAME_POINTER again it's definitely incorrect. In 
> fact there are still a few users such as _spin_lock_irqsave which push 
> flags onto the stack and the stack pointer isn't consistent across all 
> functions in that text section. I'm going to have to try Andi's previous 
> suggestions.

 I'm sorry but I guess I'm slow today. :-( Can you please be kind
enough to lighten me up on how things get corrupted?  I've read the
assembly source and disassembly of the output but I don't really see
how it'll get corrupted.

-- 
tejun

