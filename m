Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030348AbVKCPoV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030348AbVKCPoV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 10:44:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030353AbVKCPoV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 10:44:21 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:33219 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1030348AbVKCPoU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 10:44:20 -0500
Date: Thu, 3 Nov 2005 16:44:39 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: First steps towards making NO_IRQ a generic concept
Message-ID: <20051103154439.GA28190@elte.hu>
References: <20051103144926.GV23749@parisc-linux.org> <20051103145118.GW23749@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051103145118.GW23749@parisc-linux.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Matthew Wilcox <matthew@wil.cx> wrote:

> [PATCH] Check the irq number is within bounds in the functions which 
> weren't already checking.

> +	if (irq >= NR_IRQS)
> +		return;

hm, why not start with the -1 value for PCI_NO_IRQ, instead of 0:

> +#define PCI_NO_IRQ             0

and be done with it.

also:

> - Move the definition of NO_IRQ from asm directories to 
>   <linux/hardirq.h>. Individual architectures can still override it if 
>   they want to, but all existing definitions were -1.

we shouldnt make it overridable just for the sake of it. If all arches 
were fine with -1, it should be the generic value and there's no 
override.

plus, shouldnt this go into -mm first, since it clearly affects some 
drivers? Why into Linus' tree immediately?

the patch series looks good to me otherwise.

	Ingo
