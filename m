Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271216AbUJVLXn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271216AbUJVLXn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 07:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271235AbUJVLXm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 07:23:42 -0400
Received: from host-212-158-219-180.bulldogdsl.com ([212.158.219.180]:63937
	"EHLO aeryn.fluff.org.uk") by vger.kernel.org with ESMTP
	id S271216AbUJVLVW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 07:21:22 -0400
Date: Fri, 22 Oct 2004 12:21:17 +0100
From: Ben Dooks <ben-linux@fluff.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Interrupts & total mess
Message-ID: <20041022112117.GB17957@home.fluff.org>
References: <1098338878.3941.25.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1098338878.3941.25.camel@gaston>
X-Disclaimer: I speak for me, myself, and the other one of me.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 04:07:58PM +1000, Benjamin Herrenschmidt wrote:
> Ok so my simple project of adding NO_IRQ definitions all over the place
> is turning into a nightmare for various reasons (the probe_irq_* stuff
> beeing one of them, as it currently prevents using -1, so I'm leaning
> toward defining NO_IRQ as beeing INT_MIN, nothing against that ?)
> 
> However, while trying to do that in a simple way, that is with a
>  #ifndef NO_IRQ
>  #define NO_IRQ		(INT_MIN)
>  #endif
> 
> Somewhere in some generic piece of include after we has some asm/* stuff
> included to let the arch a chance to override it, I figured that, first,
> there are a number of places where "irq" is defined as beeing unsigned
> long... So neither INT_MIN nor -1 are appropriate. Then I noticed while
> looking for the right files to add this stuff that we have, at least:
> 
> include/linux/interrupts.h
> include/linux/irq.h
> include/linux/hardirq.h
> include/asm-*/irq.h
> include/asm-*/hw_irq.h
> include/asm-*/hardirq.h

also see the drivers/base/platform.c for the definition of
platform_get_irq() which also should be considered for this
(see earlier posting about the return code).

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'
