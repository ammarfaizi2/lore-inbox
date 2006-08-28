Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751154AbWH1QUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751154AbWH1QUY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 12:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWH1QUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 12:20:24 -0400
Received: from madara.hpl.hp.com ([192.6.19.124]:44269 "EHLO madara.hpl.hp.com")
	by vger.kernel.org with ESMTP id S1751154AbWH1QUX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 12:20:23 -0400
Date: Mon, 28 Aug 2006 09:10:00 -0700
From: Stephane Eranian <eranian@hpl.hp.com>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/18] 2.6.17.9 perfmon2 patch for review: new i386 files
Message-ID: <20060828161000.GF20394@frankl.hpl.hp.com>
Reply-To: eranian@hpl.hp.com
References: <200608230806.k7N8654c000504@frankl.hpl.hp.com> <p733bbn7m6o.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p733bbn7m6o.fsf@verdi.suse.de>
User-Agent: Mutt/1.4.1i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: eranian@hpl.hp.com
X-HPL-MailScanner: Found to be clean
X-HPL-MailScanner-From: eranian@hpl.hp.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi,

On Wed, Aug 23, 2006 at 12:58:55PM +0200, Andi Kleen wrote:
> 
> > +
> > +fastcall void smp_pmu_interrupt(struct pt_regs *regs)
> > +{
> 
> This misses enter/exit_idle on x86-64.
> 
I have been working on adding idle notifier for i386.
I am wondering about this code:

/* Called from interrupts to signify idle end */
void exit_idle(void)
{
        if (current->pid | read_pda(irqcount))
                return;
        __exit_idle();
}

And in particular the irqcount. I am guessing you are trying
to protect against nested interrupts. In fact, I think we only
want to get notified once the interrupt stack is fully unwound.
because we get way more exit_idle() than enter_idle().

Is there an irqcount mechanism on i386?

Thanks

--
-Stephane
