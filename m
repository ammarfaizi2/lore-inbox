Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261480AbTIKRda (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbTIKRbu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:31:50 -0400
Received: from ns.suse.de ([195.135.220.2]:9449 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261454AbTIKRZx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:25:53 -0400
Date: Thu, 11 Sep 2003 19:25:50 +0200
From: Andi Kleen <ak@suse.de>
To: Jamie Lokier <jamie@shareable.org>
Cc: willy@debian.org, linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-Id: <20030911192550.7dfaf08c.ak@suse.de>
In-Reply-To: <20030911171205.GH29532@mail.jlokier.co.uk>
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel>
	<p73oexri9kx.fsf@oldwotan.suse.de>
	<20030911162504.GL21596@parcelfarce.linux.theplanet.co.uk>
	<20030911183136.01dfeb53.ak@suse.de>
	<20030911171205.GH29532@mail.jlokier.co.uk>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Sep 2003 18:12:05 +0100
Jamie Lokier <jamie@shareable.org> wrote:

> Andi Kleen wrote:
> > Even a memory write is tens to hundres of cycles.
> 
> Not from the CPU's perspective.  It is done in parallel with other
> instructions.

Only when there are more instructions to execute. But device
driver code often does a following read e.g. to check if it can submit
another request to the hardware.

My claim is basically:

Change everybody who currently does

#ifdef CONFIG_MMIO
	writel(... )
	readl(...)
#else
	outl( ... ) 
	inl ( ...) 
#endif

to 
	if (dev->mmio) { 
		writel(); 
		real();
	} else { 
		outl();
		inl();
	} 

and you will have a hard time to benchmark the difference on any non ancient system
in actual driver operation.

-Andi

