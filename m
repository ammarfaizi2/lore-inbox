Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbVJFNco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbVJFNco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750926AbVJFNco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:32:44 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64425 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1750923AbVJFNcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:32:43 -0400
Message-ID: <20051006173223.A10342@castle.nmd.msu.ru>
Date: Thu, 6 Oct 2005 17:32:23 +0400
From: Andrey Savochkin <saw@sawoct.com>
To: Arjan van de Ven <arjan@infradead.org>, Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, xemul@sw.ru, st@sw.ru
Subject: Re: SMP syncronization on AMD processors (broken?)
References: <434520FF.8050100@sw.ru> <1128604748.2960.40.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <1128604748.2960.40.camel@laptopd505.fenrus.org>; from "Arjan van de Ven" on Thu, Oct 06, 2005 at 03:19:07PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 03:19:07PM +0200, Arjan van de Ven wrote:
> On Thu, 2005-10-06 at 17:05 +0400, Kirill Korotaev wrote:
> > Hello Linus, Andrew and others,
> > 
> > Please help with a not simple question about spin_lock/spin_unlock on 
> > SMP archs. The question is whether concurrent spin_lock()'s should 
> > acquire it in more or less "fair" fashinon or one of CPUs can starve any 
> > arbitrary time while others do reacquire it in a loop.
> 
> spinlocks are designed to not be fair. or rather are allowed to not be.
> If you want them to be fair on x86 you need at minimum to put a
> cpu_relax() in your busy loop...

The question was raised exactly because cpu_relax() doesn't help on these AMD
CPUs.

Some Pentiums do more than expected from them, and the programs works in a
very fair manner even without cpu_relax(), so the question boils down to
whether there are some new AMD rules how to write such loops, is it a defect
of the CPU, or if we are missing something else.

	Andrey
