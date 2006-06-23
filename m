Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWFWPJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWFWPJs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 11:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751438AbWFWPJr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 11:09:47 -0400
Received: from [198.99.130.12] ([198.99.130.12]:43665 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751450AbWFWPJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 11:09:47 -0400
Date: Fri, 23 Jun 2006 11:08:08 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andrew Morton <akpm@osdl.org>, a.p.zijlstra@chello.nl, hugh@veritas.com,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org, dhowells@redhat.com,
       christoph@lameter.com, mbligh@google.com, npiggin@suse.de,
       torvalds@osdl.org
Subject: Re: [PATCH] mm: tracking shared dirty pages -v10
Message-ID: <20060623150808.GA4427@ccure.user-mode-linux.org>
References: <20060619175243.24655.76005.sendpatchset@lappy> <20060619175253.24655.96323.sendpatchset@lappy> <Pine.LNX.4.64.0606222126310.26805@blonde.wat.veritas.com> <1151019590.15744.144.camel@lappy> <20060623031012.GA8395@ccure.user-mode-linux.org> <20060622203123.affde061.akpm@osdl.org> <449B6790.9010806@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <449B6790.9010806@zytor.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 22, 2006 at 09:01:20PM -0700, H. Peter Anvin wrote:
> No, it's not.  It's a problem with O=, apparently; this patch fixes it:
> 
> http://www.kernel.org/git/?p=linux/kernel/git/hpa/linux-2.6-klibc.git;a=commitdiff;h=4e51186fb663b57ac7c53517947510d2e1e9de01;hp=79317ba49e3f83d40f37b59fcdd5bd7c7635ee32

That works, thanks!

Back to the original problem - 2.6.17-mm1 UML not booting.  If you add
stderr=1 to the command line, you'll see this:

	timer_init : request_irq failed - errno = 38
	NET: Registered protocol family 2
	irq 0, desc: 081debe0, depth: 0, count: 0, unhandled: 0
	->handle_irq():  0808af80, handle_bad_irq+0x0/0x1b7
	->chip(): 081d9320, 0x81d9320
	->action(): 00000000
	   IRQ_NOPROBE set
	unexpected IRQ 00
	BUG: failure at include2/asm/hardirq.h:22/ack_bad_irq()!
	Kernel panic - not syncing: BUG!

which means that the genirq stuff needs UML work, which I was working
on anyway because UML could already be made to crash like this.
Except now, it always does.

				Jeff
