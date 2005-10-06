Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750949AbVJFNqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750949AbVJFNqJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 09:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750951AbVJFNqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 09:46:09 -0400
Received: from castle.nmd.msu.ru ([193.232.112.53]:55304 "HELO
	castle.nmd.msu.ru") by vger.kernel.org with SMTP id S1750949AbVJFNqI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 09:46:08 -0400
Message-ID: <20051006174604.B10342@castle.nmd.msu.ru>
Date: Thu, 6 Oct 2005 17:46:04 +0400
From: Andrey Savochkin <saw@sawoct.com>
To: Andi Kleen <ak@suse.de>
Cc: Kirill Korotaev <dev@sw.ru>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       xemul@sw.ru, st@sw.ru, discuss@x86-64.org
Subject: Re: SMP syncronization on AMD processors (broken?)
References: <434520FF.8050100@sw.ru> <p73hdbuzs7l.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2i
In-Reply-To: <p73hdbuzs7l.fsf@verdi.suse.de>; from "Andi Kleen" on Thu, Oct 06, 2005 at 03:32:30PM
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 06, 2005 at 03:32:30PM +0200, Andi Kleen wrote:
> Kirill Korotaev <dev@sw.ru> writes:
> 
> > Please help with a not simple question about spin_lock/spin_unlock on
> > SMP archs. The question is whether concurrent spin_lock()'s should
> > acquire it in more or less "fair" fashinon or one of CPUs can starve
> > any arbitrary time while others do reacquire it in a loop.
> 
> They are not fully fair because of the NUMAness of the system.
> Same on many other NUMA systems.
> 
> We considered long ago to use queued locks to avoid this, but 
> they are quite costly for the uncongested case and never seemed worth it.
> 
> So live with it.

Well, it's hard to swallow...
It's not about being not fully fair, it's about deadlocks that started
to appear after code changes inside retry loops...

A practical question is whether there is an "official" way to tell the CPU
that it should synchronize with memory, or if you have ideas how to make it
less costly than queued locks.

A theoretical question is how many places in the kernel use such retry loops
that may start to fail some day (or on some machines)...

	Andrey
