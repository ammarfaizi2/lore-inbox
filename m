Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262672AbVGHODZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262672AbVGHODZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 10:03:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261295AbVGHODW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 10:03:22 -0400
Received: from mx1.elte.hu ([157.181.1.137]:56255 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262672AbVGHOCy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 10:02:54 -0400
Date: Fri, 8 Jul 2005 16:02:54 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: Vitaly Wool <vwool@ru.mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: 'sleeping function called from invalid context' bug when mounting an IDE device
Message-ID: <20050708140254.GA5477@elte.hu>
References: <20050708162846.54de783d.vwool@ru.mvista.com> <20050708134346.GA4890@elte.hu> <1120831242.19225.3.camel@c-67-188-6-232.hsd1.ca.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1120831242.19225.3.camel@c-67-188-6-232.hsd1.ca.comcast.net>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> > > So, the problem is in the generic IDE code, namely, in ide_intr() 
> > > taking ide_lock.
> > 
> > which version did you try, and does this happen with the latest patch 
> > too?
> 
> Interrupts should be enabled unconditionally for threaded interrupt 
> handlers. Or at least the generics work that way.

yes, that's why i'm asking about the version and the full backtrace.  
Threaded irq handlers run with irqs enabled:

        /*
         * Unconditionally enable interrupts for threaded
         * IRQ handlers:
         */
        if (!hardirq_count() || !(action->flags & SA_INTERRUPT))
                raw_local_irq_enable();

    Ingo
