Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTILBjQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 21:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261647AbTILBjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 21:39:16 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:22542 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S261645AbTILBjO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 21:39:14 -0400
Date: Thu, 11 Sep 2003 18:39:09 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: Memory mapped IO vs Port IO
Message-ID: <20030912013909.GG15833@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030911160116.GI21596@parcelfarce.linux.theplanet.co.uk.suse.lists.linux.kernel> <p73oexri9kx.fsf@oldwotan.suse.de> <20030911162504.GL21596@parcelfarce.linux.theplanet.co.uk> <20030911183136.01dfeb53.ak@suse.de> <20030911171205.GH29532@mail.jlokier.co.uk> <20030911192550.7dfaf08c.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030911192550.7dfaf08c.ak@suse.de>
User-Agent: Mutt/1.3.27i
X-Message-Flag: Reading this message may result in the loss of plausible deniability. Consult a lawyer to determine the extent of your liability
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 11, 2003 at 07:25:50PM +0200, Andi Kleen wrote:
> On Thu, 11 Sep 2003 18:12:05 +0100
> Jamie Lokier <jamie@shareable.org> wrote:
> 
> > Andi Kleen wrote:
> > > Even a memory write is tens to hundres of cycles.
> > 
> > Not from the CPU's perspective.  It is done in parallel with other
> > instructions.
> 
> Only when there are more instructions to execute. But device
> driver code often does a following read e.g. to check if it can submit
> another request to the hardware.
> 
> My claim is basically:
> 
> Change everybody who currently does
> 
> #ifdef CONFIG_MMIO
> 	writel(... )
> 	readl(...)
> #else
> 	outl( ... ) 
> 	inl ( ...) 
> #endif
> 
> to 
> 	if (dev->mmio) { 
> 		writel(); 
> 		real();
> 	} else { 
> 		outl();
> 		inl();
> 	} 
> 
> and you will have a hard time to benchmark the difference on any non ancient system
> in actual driver operation.

Shouldn't that be

 	dev->dev_ops->writel(...); 
 	dev->dev_ops->readl(...);

with no conditionals?

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
