Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132541AbRAJMDl>; Wed, 10 Jan 2001 07:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135270AbRAJMDb>; Wed, 10 Jan 2001 07:03:31 -0500
Received: from colorfullife.com ([216.156.138.34]:8973 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S132541AbRAJMDL>;
	Wed, 10 Jan 2001 07:03:11 -0500
Message-ID: <3A5C4FAC.CA6E46A9@colorfullife.com>
Date: Wed, 10 Jan 2001 13:03:56 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
In-Reply-To: <Pine.LNX.4.30.0101101222540.833-100000@e2>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> 
> On Wed, 10 Jan 2001, Manfred Spraul wrote:
> 
> > That means sendmsg() changes the page tables? I measures
> > smp_call_function on my Dual Pentium 350, and it took around 1950 cpu
> > ticks.
> 
> well, this is a performance problem if you are using threads. For normal
> processes there is no need for a SMP cross-call, there TLB flushes are
> local only.
> 
But that would be ugly as hell:
so apache 2.0 would become slower with MSG_NOCOPY, whereas samba 2.2
would become faster.

Is is possible to move the responsibility for maitaining the copy to the
caller?

e.g. use msg_control, and then the caller can request either that a
signal is sent when that data is transfered, or that a variable is set
to 0.

--
	Manfred
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
