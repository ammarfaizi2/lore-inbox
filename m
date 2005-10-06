Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750961AbVJFOWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbVJFOWe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750992AbVJFOWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:22:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:47537 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750958AbVJFOWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:22:34 -0400
Subject: Re: SMP syncronization on AMD processors (broken?)
From: Arjan van de Ven <arjan@infradead.org>
To: Andrey Savochkin <saw@sawoct.com>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, st@sw.ru
In-Reply-To: <20051006173223.A10342@castle.nmd.msu.ru>
References: <434520FF.8050100@sw.ru>
	 <1128604748.2960.40.camel@laptopd505.fenrus.org>
	 <20051006173223.A10342@castle.nmd.msu.ru>
Content-Type: text/plain
Date: Thu, 06 Oct 2005 16:22:18 +0200
Message-Id: <1128608538.2960.45.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.9 (++)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (2.9 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	2.8 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-10-06 at 17:32 +0400, Andrey Savochkin wrote:
> On Thu, Oct 06, 2005 at 03:19:07PM +0200, Arjan van de Ven wrote:
> > On Thu, 2005-10-06 at 17:05 +0400, Kirill Korotaev wrote:
> > > Hello Linus, Andrew and others,
> > > 
> > > Please help with a not simple question about spin_lock/spin_unlock on 
> > > SMP archs. The question is whether concurrent spin_lock()'s should 
> > > acquire it in more or less "fair" fashinon or one of CPUs can starve any 
> > > arbitrary time while others do reacquire it in a loop.
> > 
> > spinlocks are designed to not be fair. or rather are allowed to not be.
> > If you want them to be fair on x86 you need at minimum to put a
> > cpu_relax() in your busy loop...
> 
> The question was raised exactly because cpu_relax() doesn't help on these AMD
> CPUs.
> 
> Some Pentiums do more than expected from them, and the programs works in a
> very fair manner even without cpu_relax(), so the question boils down to
> whether there are some new AMD rules how to write such loops, is it a defect
> of the CPU, or if we are missing something else.

the rule basically is "don't write such a loop" though; this is only the
beginning; because if you have two such things on separate cores of a
dual core cpu you for sure starve anything outside of that core just the
same. Eg it goes one level up as well.

There is no spin_lock_yield() currently and until there is this is just
a code pattern you should avoid.


