Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265942AbTIER7y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 13:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265944AbTIER7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 13:59:54 -0400
Received: from havoc.gtf.org ([63.247.75.124]:35987 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S265942AbTIER7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 13:59:53 -0400
Date: Fri, 5 Sep 2003 13:59:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
To: Andi Kleen <ak@colin2.muc.de>
Cc: Jan Hubicka <jh@suse.cz>, Andi Kleen <ak@muc.de>, torvalds@osdl.org,
       akpm@osdl.org, rth@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Use -fno-unit-at-a-time if gcc supports it
Message-ID: <20030905175938.GA29353@gtf.org>
References: <20030905004710.GA31000@averell> <20030905053730.GB24509@kam.mff.cuni.cz> <20030905172715.GA80302@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030905172715.GA80302@colin2.muc.de>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 05, 2003 at 07:27:15PM +0200, Andi Kleen wrote:
> I'm not sure that is that good an idea. When I was still hacking 
> TCP I especially moved some stuff out-of-line in the fast path to avoid 
> register pressure. Otherwise gcc would inline rarely used sub functions 
> and completely mess up the register allocation in the fast path.
> Of course just a call alone messes up the registers somewhat because
> of its clobbers, but a full inlining is usually worse.
[...]
> I suspect that is true for a lot of core kernel code - everything
> that is worth inlining is already inlined and for the rest it doesn't matter.

Definitely , agreed.  In fact, we are moving in the opposite direction:
looking into what we can un-inline...


> On the other hand a lot of driver code seems to be written without
> manual consideration for inline. For that it may be worth it. But then
> I would consider core kernel code to be more important than driver
> code.

Modern network drivers seem fairly aware of it ;-)

> Also I fear cross module inlining would expose a lot of latent bugs
> (missing barriers etc.) when the optimizer becomes more aggressive. 
> I'm not saying this would be a bad thing, just that it may be a lot 
> of work to fix (both for compiler and kernel people)

Agreed.

	Jeff



