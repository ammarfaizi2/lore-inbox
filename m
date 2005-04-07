Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVDGURf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVDGURf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 16:17:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbVDGURf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 16:17:35 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:19599 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262586AbVDGUR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 16:17:29 -0400
Subject: Re: 2.6.12-rc2 in_atomic() picks up preempt_disable()
From: Arjan van de Ven <arjan@infradead.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: kaos@sgi.com, linux-kernel@vger.kernel.org, mingo@elte.hu
In-Reply-To: <200504071840.j37Iei25019895@harpo.it.uu.se>
References: <200504071840.j37Iei25019895@harpo.it.uu.se>
Content-Type: text/plain
Date: Thu, 07 Apr 2005 22:17:18 +0200
Message-Id: <1112905038.6290.77.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 3.7 (+++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (3.7 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 20:40 +0200, Mikael Pettersson wrote:
> On Thu, 07 Apr 2005 12:17:37 +0200, Arjan van de Ven wrote:
> >On Thu, 2005-04-07 at 20:10 +1000, Keith Owens wrote:
> >> 2.6.12-rc2, with CONFIG_PREEMPT and CONFIG_PREEMPT_DEBUG.  The
> >> in_atomic() macro thinks that preempt_disable() indicates an atomic
> >> region so calls to __might_sleep() result in a stack trace.
> >
> >but you're not allowed to schedule when preempt is disabled!
> 
> That sounds draconian. Where is that requirement stated?
> 
> A preempt-disabled region ought to have the same semantics
> as in a CONFIG_PREEMPT=n kernel, and since schedule is Ok
> in the latter case it should be Ok in the former too.
> 
> All that preempt_disable() should do is prevent involuntary
> schedules. But the conditional schedules introduced by may-sleep
> functions are _voluntary_, so there's no reason to forbid them.

but that implies you need to remember this after schedule. all in all it
starts to smell more and more like the local irq disable flag, and I at
least thing of it in a very similar way as well.


