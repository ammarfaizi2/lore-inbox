Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317073AbSGVNSB>; Mon, 22 Jul 2002 09:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317078AbSGVNSB>; Mon, 22 Jul 2002 09:18:01 -0400
Received: from verein.lst.de ([212.34.181.86]:57867 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S317073AbSGVNR7>;
	Mon, 22 Jul 2002 09:17:59 -0400
Date: Mon, 22 Jul 2002 15:20:56 +0200
From: Christoph Hellwig <hch@lst.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Russell King <rmk@arm.linux.org.uk>,
       Linus Torvalds <torvalds@transmeta.com>, Christoph Hellwig <hch@lst.de>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
Subject: Re: [patch] cli()/sti() cleanup, 2.5.27-A2
Message-ID: <20020722152056.A18619@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Ingo Molnar <mingo@elte.hu>, Russell King <rmk@arm.linux.org.uk>,
	Linus Torvalds <torvalds@transmeta.com>,
	Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
References: <20020722014018.A31813@flint.arm.linux.org.uk> <Pine.LNX.4.44.0207221248250.4519-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.44.0207221248250.4519-100000@localhost.localdomain>; from mingo@elte.hu on Mon, Jul 22, 2002 at 03:01:48PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 22, 2002 at 03:01:48PM +0200, Ingo Molnar wrote:
> So what i did in my tree was to introduce the following 5 core means of
> manipulating the local interrupt flags:
> 
> 	irq_off()
> 	irq_on()
> 	irq_save(flags)
> 	irq_save_off(flags)
> 	irq_restore(flags)

I'd prefer the following:

void irq_off(void);
void irq_on(void);

flags_t irq_save();		/* the old irq_save_off() */
void irq_restore(flags_t);

void __irq_save(void);		/* without saveing */

rational:  proper function-like API (should be inlines), irq save
without disableing is very uncommon, better make the API symmetric.


