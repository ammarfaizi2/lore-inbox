Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932227AbWEaFtG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932227AbWEaFtG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 01:49:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932489AbWEaFtG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 01:49:06 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:24714 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932227AbWEaFtF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 01:49:05 -0400
Date: Wed, 31 May 2006 07:49:27 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: genirq handle helper
Message-ID: <20060531054927.GA18703@elte.hu>
References: <1149046728.766.17.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1149046728.766.17.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> Hi Ingo, Thomas !
> 
> This simple pach makes the transition easier. By making 
> generic_handle_irq() call the old __do_IRQ if no new-style handler 
> exist for a given irq, the transition from old style to new style is 
> made easier for me. That is, I can have some PICs use the new handler 
> mecanism while old ones still get __do_IRQ without having the common 
> powerpc code caring about the type of PIC (it just does 
> generic_handle_irq()).
> 
> Might be useful to others as well, at least until everybody is ported 
> over.

yeah, good idea - this will also make the MSI fix simpler.

Acked-by: Ingo Molnar <mingo@elte.hu>

Andrew, if you add Ben's patch, you can drop the 
arch/x86_64/kernel/irq.c bits of genirq-msi-fixes.patch. [if they stay 
they wont hurt, they'll only be redundant.]

	Ingo
