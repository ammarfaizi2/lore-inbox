Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262252AbTFZRp0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 13:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbTFZRp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 13:45:26 -0400
Received: from dp.samba.org ([66.70.73.150]:35229 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S262252AbTFZRpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 13:45:25 -0400
Date: Fri, 27 Jun 2003 03:55:54 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RFC] irq handling code consolidation (common part)
Message-ID: <20030626175554.GA22089@krispykreme>
References: <20030626110247.GT9679@pazke>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030626110247.GT9679@pazke>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the irq handling consolidation patch returns from the dead !
> Now with runaway irq detection code included !
> 
> This patch (against 2.5.73) contains common part of it.

Great! Well it wasnt dead, I was also keeping it up to date and sending
it on to akpm :)

I have two suggestions that will help in my crusade to kill NR_IRQS.

1. define irq_desc, irq_valid, for_each_irq in include/linux/irq.h if
HAVE_ARCH_IRQ_DESC isnt defined (instead of in each architecture).
Basically I want to start using these macros in a few places and dont
want to break every architecture that hasnt converted to the new scheme.

On the other hand if we decide to move the irq descriptor definition
into each arch as hch suggested, this wont be necessary as all archs
will break anyway :)

2. define irq_atoi that converts an irq into a printable string. We have
a bunch of #ifdef CONFIG_SPARC stuff we can then get rid of, and other
archs can start using it if wanted (eg on ppc64 I can subtract our
software offset so the irqs printed match the hardware)

Anton
