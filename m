Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262985AbVCXCLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262985AbVCXCLP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 21:11:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262986AbVCXCLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 21:11:14 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:28519 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262985AbVCXCJq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 21:09:46 -0500
Message-ID: <42422165.20505@yahoo.com.au>
Date: Thu, 24 Mar 2005 13:09:41 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: user-mode-linux-devel@lists.sourceforge.net,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>, akpm@osdl.org,
       jdike@addtoit.com, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [patch 02/12] uml: cpu_relax fix
References: <20050322162121.4295D2125C@zion> <4241A2C0.2050206@fujitsu-siemens.com> <200503240250.38153.blaisorblade@yahoo.it>
In-Reply-To: <200503240250.38153.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
> On Wednesday 23 March 2005 18:09, Bodo Stroesser wrote:
> 
>>blaisorblade@yahoo.it wrote:
>>
>>>Use rep_nop instead of barrier for cpu_relax, following $(SUBARCH)'s
>>>doing that (i.e. i386 and x86_64).
>>
>>IIRC, Jeff had the idea, to use sched_yield() for this (from a discussion
>>on #uml).
> 
> Hmm, makes sense, but this is to benchmark well... I remember from early 
> discussions on 2.6 scheduler that using sched_yield might decrease 
> performance (IIRC starve the calling application).
> 

Typically, for places where cpu_relax is used, sched_yield would be
a poor fit. So yes it could easily reduce performance.

> Also, that call should be put inside the idle loop, not for cpu_relax, which 
> is very different, since it is used (for instance) in kernel/spinlock.c for 
> spinlocks, and in such things. The "Pause" opcode is explicitly recommended 
> (by Intel manuals, I don't recall why) for things like spinlock loops, and 
> using yield there would be bad.
> 

The other thing is that sched_yield won't relax at all if you are the
only thing running, it will be a busy wait. So again, maybe not a great
fit for the idle loop either.


