Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751214AbWBQMBn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751214AbWBQMBn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 07:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWBQMBn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 07:01:43 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:39580 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751214AbWBQMBm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 07:01:42 -0500
Date: Fri, 17 Feb 2006 12:59:58 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, tglx@linutronix.de,
       arjan@infradead.org, akpm@osdl.org
Subject: Re: [patch 0/6] lightweight robust futexes: -V3
Message-ID: <20060217115958.GA14938@elte.hu>
References: <20060216094130.GA29716@elte.hu> <20060216132309.fd4e4723.pj@sgi.com> <20060216215036.GD25738@elte.hu> <20060216205618.d4d97d9d.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060216205618.d4d97d9d.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> [ ... nice writeup of the robust-futex ABI ... ]

can i put this into Documentation/robust-futex-ABI.txt?

> Other details ...
> 
> Nit ...
> 
>     +If a futex is found to be held at exit time, the kernel sets the highest
>     +bit of the futex word:
>     +
>     +	#define FUTEX_OWNER_DIED        0x40000000
> 
>     Contrary to the comment, that doesn't look like the "highest bit."

ok, i fixed this in the text.

> Confusion ...
> 
>     +The list is guaranteed to be private and per-thread, so it's lockless.
> 
>     This statement seems like it is stretching the truth a bit.
>     As best as I can tell, the 'head' is private per-thread, but the
>     elements on the list are shared by all contending threads, and so
>     adding and removing these elements from a given threads list requires
>     some sort of contention handling mechanism, which the code provides.

well, from the kernel's perspective, the list _as it exists_ is private 
and per-thread, so it can be accessed in a lockless way.

from the userspace perspective you are right, it's only private if the 
list entry is manipulated after acquiring the lock.

i fixed up the text to reflect this.

	Ingo
