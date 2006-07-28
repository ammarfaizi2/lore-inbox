Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161119AbWG1Ki3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161119AbWG1Ki3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 06:38:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932627AbWG1Ki2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 06:38:28 -0400
Received: from colin.muc.de ([193.149.48.1]:22791 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S932626AbWG1Ki1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 06:38:27 -0400
Date: 28 Jul 2006 12:38:26 +0200
Date: Fri, 28 Jul 2006 12:38:26 +0200
From: Andi Kleen <ak@muc.de>
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Fw: Re: 2.6.18-rc2-mm1
Message-ID: <20060728103826.GB75067@muc.de>
References: <20060728011938.fc6c2d6e.akpm@osdl.org> <44C9FB60.76E4.0078.0@novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44C9FB60.76E4.0078.0@novell.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2006 at 10:56:16AM +0100, Jan Beulich wrote:
> >>> Andrew Morton <akpm@osdl.org> 28.07.06 10:19 >>>
> >
> >More unwinder problems.  Seems to be specific to -mm.
> >(Followups on-list are preferred, thanks).
> 
> That's another of the lose ends - while Andi and I had decided to put
> a proper stack frame in place for the switch to the irq stack in the
> interrupt macro, we had forgotten about doing something similar for
> call_softirq() - as the code is written currently, there simply is now
> way of annotating the code properly. If Andi is agreeable to this,
> then I'll just change the code so that it'll have a proper stack frame.

Fine by me. I'll just fix it up.

> 
> The recursive traces appear to result from the fact that when we
> did the change to the interrupt macro, we neglected the fact that
> show_trace() expects to find the old stack pointer as the very first
> item on the interrupt stack, which isn't the case anymore. The value
> of where the subsequent stack access fails is a little strange, though.
> Making this assumption be true again would, however, require adding
> a push to both the interrupt macro and call_softirq. I'm afraid Andi's
> not going to be too happy about that, but on the other hand I can't
> see any other possible way that would get away without adding
> some code to these paths.

I can just add the push.

-Andi
