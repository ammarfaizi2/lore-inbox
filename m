Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932209AbWFFPdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932209AbWFFPdD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 11:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWFFPdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 11:33:03 -0400
Received: from ms-smtp-04.nyroc.rr.com ([24.24.2.58]:22498 "EHLO
	ms-smtp-04.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751306AbWFFPdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 11:33:01 -0400
Subject: Re: [patch, -rc5-mm3] fix irqpoll some more
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       arjan@linux.intel.com, linux-kernel@vger.kernel.org
In-Reply-To: <20060606145915.GA627@elte.hu>
References: <200606050600.k5560GdU002338@shell0.pdx.osdl.net>
	 <1149497459.23209.39.camel@localhost.localdomain>
	 <20060605084938.GA31915@elte.hu>
	 <1149600355.16247.49.camel@localhost.localdomain>
	 <20060606135353.GA25609@elte.hu>
	 <1149604828.16247.64.camel@localhost.localdomain>
	 <20060606145915.GA627@elte.hu>
Content-Type: text/plain
Date: Tue, 06 Jun 2006 11:32:45 -0400
Message-Id: <1149607965.4558.4.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-06-06 at 16:59 +0200, Ingo Molnar wrote:
> *
> 
> ouch. Then this problem is more urgent than i thought. We definitely 
> need the disable_irq_handler(irq, handler) infrastructure and it should 
> be used in the most common drivers affected (vortex/3c59x, forcedeth and 
> IDE basically).
> 

Ingo, did you take a look at my alternative?  It postpones the unmasking
of the interrupt till the enable_irq is done.  It also doesn't have the
need to update 300+ calls to disable/enable_irq.

Also, the disable_irq_handler doesn't solve the case if the misrouted
irq came from the device that its driver called the disable_irq_handler.
This doesn't affect irqpoll, but for those cases that have broken irq
setups needing irqfixup this can still allow an irq storm.

-- Steve


