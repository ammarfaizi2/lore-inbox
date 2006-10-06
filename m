Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWJFPSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWJFPSK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 11:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751445AbWJFPSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 11:18:10 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:47519 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751447AbWJFPSI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 11:18:08 -0400
Message-ID: <452673AC.1080602@garzik.org>
Date: Fri, 06 Oct 2006 11:18:04 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       linux-arch@vger.kernel.org
CC: Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Andrew Morton <akpm@osdl.org>, Thomas Gleixner <tglx@linutronix.de>,
       torvalds@osdl.org, Dmitry Torokhov <dtor@mail.ru>,
       Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH, RAW] IRQ: Maintain irq number globally rather than passing
 to IRQ handlers
References: <20061002132116.2663d7a3.akpm@osdl.org> <20061002162049.17763.39576.stgit@warthog.cambridge.redhat.com> <20061002162053.17763.26032.stgit@warthog.cambridge.redhat.com> <18975.1160058127@warthog.cambridge.redhat.com> <4525A8D8.9050504@garzik.org> <1160133932.1607.68.camel@localhost.localdomain> <45263ABC.4050604@garzik.org> <20061006111156.GA19678@elte.hu> <45263D9C.9030200@garzik.org>
In-Reply-To: <45263D9C.9030200@garzik.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the raw, un-split-up first pass of the irq argument removal 
patch (500K):	http://gtf.org/garzik/misc/patch.irq-remove

Notes:

* raw first pass, DO NOT APPLY.

* this was useful work:  it turned up several minor bugs

* Do we mark irq handlers FASTCALL?  If not, we probably can now.

* I also turned up a few obvious places that dhowells missed in his 
pt_regs patch, inevitably in non-x86 arches that probably were not built.

* I need to fix up ~10 or so drivers that called their interrupt 
handlers directly, then used a 'irq == 0' test to determine whether the 
interrupt handler was called internally, or by the system.

* not sure yet if I want to mark the parport "irq handler" functions as 
truly irqreturn_t

* Hopefully I will have this polished by the end of the day.


