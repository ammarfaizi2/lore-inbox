Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266681AbUF3OXK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266681AbUF3OXK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 10:23:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266680AbUF3OXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 10:23:09 -0400
Received: from mail.shareable.org ([81.29.64.88]:12205 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266681AbUF3OWM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 10:22:12 -0400
Date: Wed, 30 Jun 2004 15:21:16 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Do x86 NX and AMD prefetch check cause page fault infinite loop?
Message-ID: <20040630142116.GC29285@mail.shareable.org>
References: <20040630013824.GA24665@mail.shareable.org> <20040630055041.GA16320@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630055041.GA16320@elte.hu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> i understand what you mean, but for this to trigger one would have to
> trigger the prefetch erratum _and_ then turn off executability in
> parallel, right? So the question is, is there a reliable way to trigger
> the pagefault situation, and if yes, how do you turn on NX - because
> right before the fault the instruction had to be executable.

No need for anything in parallel.

I think you can trigger it by jumping to a non-PROT_EXEC page where
the target address is a prefetch -- or by falling through from the end
of a PROT_EXEC page to a non-PROT_EXEC one.

To be sure both cases are obscure, but the resulting loop is still wrong.

Who knows, perhaps internal conditions of the chip prevent these
particular prefetches from triggering the fault.  After all, we're
told that on returning from the fault handler, the prefetch won't
fault again, and it's not obvious why that should be.  It'd be very
subtle though, and deserve a comment.

-- Jamie

