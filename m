Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268752AbUILRGn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268752AbUILRGn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 13:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268751AbUILRGn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 13:06:43 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:33733 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S268752AbUILRFx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 13:05:53 -0400
Date: Sun, 12 Sep 2004 13:10:26 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Andi Kleen <ak@suse.de>
Cc: Tejun Heo <tj@home-tj.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Interrupt entry CONFIG_FRAME_POINTER fix
In-Reply-To: <20040912132454.6cf1d60c.ak@suse.de>
Message-ID: <Pine.LNX.4.53.0409121257320.2297@montezuma.fsmlabs.com>
References: <20040912091628.GB13359@home-tj.org> <20040912132454.6cf1d60c.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Sep 2004, Andi Kleen wrote:

> On Sun, 12 Sep 2004 18:16:28 +0900
> Tejun Heo <tj@home-tj.org> wrote:
> 
> >  On x86_64, rbp isn't saved on entering interrupt handler even when
> > CONFIG_FRAME_POINTER is turned on.  This breaks profile_pc()
> > (resulting in oops) which uses regs->rbp to track back to the original
> > stack.  Save full stack when CONFIG_FRAME_POINTER is specified.
> 
> 
> I don't think your patch is correct, you don't restore rbp ever and it gets corrupted.
> 
> I think the correct change is to fix profile_pc() to not reference rbp, but just hardcode
> the rsp offset for the FP and non FP cases (8 and 0) 

Yep, i botched up the patch, after looking at the disassembly on 
x86_64 without CONFIG_FRAME_POINTER again it's definitely incorrect. In 
fact there are still a few users such as _spin_lock_irqsave which push 
flags onto the stack and the stack pointer isn't consistent across all 
functions in that text section. I'm going to have to try Andi's previous 
suggestions.

Thanks,
	Zwane
