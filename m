Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271755AbTGRNvR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 09:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271753AbTGRNu6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 09:50:58 -0400
Received: from gn78-101.ma.emulex.com ([138.239.78.101]:35505 "EHLO
	wintermute.ma.emulex.com") by vger.kernel.org with ESMTP
	id S271724AbTGRNtm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 09:49:42 -0400
Date: Fri, 18 Jul 2003 10:03:42 -0400
From: Jamie Wellnitz <Jamie.Wellnitz@emulex.com>
To: Arjan van de Ven <arjanv@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Andrew Vasquez <andrew.vasquez@qlogic.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>,
       Linux-SCSI <linux-scsi@vger.kernel.org>
Subject: Re: [ANNOUNCE] QLogic qla2xxx driver update available (v8.00.00b4 ).
Message-ID: <20030718140342.GA32615@ma.emulex.com>
References: <1058536002.5950.3.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058536002.5950.3.camel@laptop.fenrus.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 18, 2003 at 09:46:42AM -0400, Arjan van de Ven wrote:
> On Fri, 2003-07-18 at 13:23, Christoph Hellwig wrote:
> >  
> >  - qla2x00_intr_handler should use spin_lock, not spin_lock_irqsave
> 
> possibly correct; on x86 irq handlers run with interrupts enabled for
> example; just too dangerous to do this esp if error recovery and similar
> code calls this from process context as well (iirc a few places do)

Is this true?  Do irq handlers _always_ run with interrupts enabled?
I thought the driver could control this behavior with the SA_INTERRUPT
flag.

This code in handle_IRQ_event seems to turn interrupts back on
(apparently someone has turned them off), but only if SA_INTERRUPT is
not set.

   if (!(action->flags & SA_INTERRUPT))
                 __sti();
 
Thanks,
Jamie Wellnitz
Jamie.Wellnitz@emulex.com
