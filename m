Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751106AbWGPSx3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751106AbWGPSx3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 14:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751163AbWGPSx3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 14:53:29 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12046 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751106AbWGPSx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 14:53:28 -0400
Date: Sun, 16 Jul 2006 19:53:14 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Albert Cahalan <acahalan@gmail.com>
Cc: Kyle Moffett <mrmacman_g4@mac.com>, dwmw2@infradead.org,
       arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
       linux-kernel@vger.kernel.org, davem@davemloft.net
Subject: Re: 2.6.18 Headers - Long
Message-ID: <20060716185314.GA17172@flint.arm.linux.org.uk>
Mail-Followup-To: Albert Cahalan <acahalan@gmail.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, dwmw2@infradead.org,
	arjan@infradead.org, maillist@jg555.com, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net
References: <787b0d920607151409q4d0dfcc1wc787d9dfe7b0a897@mail.gmail.com> <6C943713-549B-453C-A0B2-1286764FFE13@mac.com> <787b0d920607161138l4b6dc25dycaeaaea5e948c769@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <787b0d920607161138l4b6dc25dycaeaaea5e948c769@mail.gmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 16, 2006 at 02:38:45PM -0400, Albert Cahalan wrote:
> On 7/16/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> >On Jul 15, 2006, at 17:09:28, Albert Cahalan wrote:
> 
> >You realize that on a couple architectures it's fundamentally
> >impossible to get atomic ops completely in userspace, right?
> 
> Sure. Those architectures don't need to drag down the rest.
> Plenty of headers are only exported for some architectures.

Wrong perspective.  The problem is that they may _appear_ to work as
described, but not actually work in the intended way.  That's a bug,
and it's a _hard_ bug to locate.

> (Well actually, such architectures could just give apps a
> writable flag to disable the scheduler -- this is acceptable
> for the embedded things these architectures are used for.

Cloud cuckoo land.  In the embedded world, there are folk still want
to have the security aspects as well.  Moreover, there are far more
folk who do _NOT_ want to have things like "disable the scheduler" -
think the realtime folk.

> It's not as if the app developers would care to support
> those architectures anyway.

That's actually more of a reason to take away the toys they shouldn't
be playing with in the first place - the only reason these (wrong)
interfaces are being used is because they're easily accessible.  Had
they _never_ been visible to userspace, no one would've attempted to
use them in the first place.

So, take away the "easily accessible" bit on the common architectures
and they'll find different ways to meet their needs.  Hopefully, that
will be some portable solution instead of one where racy code goes by
unnoticed.  If it isn't, at least there will be build errors to tell
you something needs to be fixed (probably from the assembler!)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
