Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030745AbWKUVwp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030745AbWKUVwp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:52:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031064AbWKUVwp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:52:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:47263 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1030745AbWKUVwp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:52:45 -0500
From: Andi Kleen <ak@suse.de>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] i386-pda UP optimization
Date: Tue, 21 Nov 2006 22:52:28 +0100
User-Agent: KMail/1.9.5
Cc: Eric Dumazet <dada1@cosmosbay.com>, Ingo Molnar <mingo@elte.hu>,
       akpm@osdl.org, Arjan van de Ven <arjan@infradead.org>,
       linux-kernel@vger.kernel.org
References: <1158046540.2992.5.camel@laptopd505.fenrus.org> <200611211238.20419.dada1@cosmosbay.com> <456372AD.5080807@goop.org>
In-Reply-To: <456372AD.5080807@goop.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611212252.28493.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> For umask/getppid, assuming you're just running 1e7 iterations, you're
> seeing a difference of 25 and 35ns per iteration difference.  I wonder
> why it would be different for different syscalls; I would expect it to
> be a constant overhead either way.

They got different numbers of current references? 

> Certainly these numbers are much 
> larger than I saw when I benchmarked pda-vs-nopda using lmbench's null
> syscall (getppid) test; I saw an overall 9ns difference in null syscall
> time on my Core Duo run at 1GHz.  What's your CPU and speed?
> 
> One possibility is a cache miss on the gdt while reloading %gs.  I've

On such micro benchmarks everything should be cache hot in theory
(unless it's a system with really small cache)

> been planning on a patch to rearrange the gdt in order to pack all the
> commonly used segment descriptors into one or two cache lines so that
> all the segment register reloads can be done with a minimum of cache
> misses.  It would be interesting for you to replace the:
> 
>     movl $(__KERNEL_PDA), %edx; movl %edx, %gs
> 
> with an appropriate read of the gdt entry, hm, which is a bit complex to
> find.

On UP it could be hardcoded. And oprofile can be used to profile for cache misses.

-Andi
