Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932624AbWG1Kf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932624AbWG1Kf2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932625AbWG1Kf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:35:28 -0400
Received: from colin.muc.de ([193.149.48.1]:55305 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932624AbWG1Kf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:35:28 -0400
Date: 28 Jul 2006 12:35:25 +0200
Date: Fri, 28 Jul 2006 12:35:25 +0200
From: Andi Kleen <ak@muc.de>
To: Jan Beulich <jbeulich@novell.com>
Cc: michal.k.k.piotrowski@gmail.com, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: Re: 2.6.18-rc2-mm1
Message-ID: <20060728103525.GA75067@muc.de>
References: <20060727224233.7fe3724a.akpm@osdl.org> <44C9ED37.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C9ED37.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 09:55:51AM +0100, Jan Beulich wrote:
> >>> Andrew Morton <akpm@osdl.org> 28.07.06 07:42 >>>
> >
> >fyi, Michael's dwarf unwinder seems to have broken.
> >(please follow up on lkml).
> 
> Hmm, not being able to unwind through sysenter_entry is no surprise
> (this simply cannot be properly annotated, as the return address is not
> explicit), but it'd end up in user mode anyway (and the inexact backtrace
> doesn't go past it either). The fallback message is a little mis-leading as
> what is shown is not the left-over backtrace, but the full one (Andi
> probably knows better if/when/why this is supposed to be that way).

Hmm, normally it should dump only the left over entries. On my testing
it did that.

> 
> Likewise for the more puzzling case of not being able to unwind through
> error_code - the left-over trace is again more like a full one. I'm not clear
> why it can't unwind through error_code here; a sufficiently large piece
> of the raw stack dump would be needed to check what's going on here,
> and I just again (don't know how many times I already did this) verified
> that in a similar scenario I get a proper unwind through that point.

Yes I've also seen valid stack traces through error_code

> 
> The third one, getting stuck at __down_failed, is due to the still
> unresolved issue of improper (from the perspective of stack unwinding)
> instruction ordering include/asm-i386/semaphore.h.

I'll fix that. Guess we'll just drop the lock sections.

-Andi

