Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265102AbSLQQXR>; Tue, 17 Dec 2002 11:23:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265108AbSLQQXQ>; Tue, 17 Dec 2002 11:23:16 -0500
Received: from chaos.analogic.com ([204.178.40.224]:46986 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S265102AbSLQQXP>; Tue, 17 Dec 2002 11:23:15 -0500
Date: Tue, 17 Dec 2002 11:33:10 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Hugh Dickins <hugh@veritas.com>
cc: Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Ulrich Drepper <drepper@redhat.com>, linux-kernel@vger.kernel.org,
       hpa@transmeta.com
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212171556110.1460-100000@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1021217112402.25749A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Dec 2002, Hugh Dickins wrote:

> On Mon, 16 Dec 2002, Linus Torvalds wrote:
> > 
> > Ok, I did the vsyscall page too, and tried to make it do the right thing
> > (but I didn't bother to test it on a non-SEP machine).
> > 
> > I'm pushing the changes out right now, but basically it boils down to the
> > fact that with these changes, user space can instead of doing an
> > 
> > 	int $0x80
> > 
> > instruction for a system call just do a
> > 
> > 	call 0xfffff000
> 

So you are going to do a system-call off a trap instead of an interrupt.
The difference in performance should be practically nothing. There is
also going to be additional overhead in returning from the trap since
the IP and caller's segment was not saved by the initial trap. I don't
see how you can possibly claim any improvement in performance. Further,
it doesn't make any sense. We don't call physical addresses from a
virtual address anyway, so there will be additional translation that
must take some time. With the current page-table translation you
would need to put your system-call entry point at 0xfffff000 - 0xc0000000
= 0x3ffff000 and there might not even be any RAM there. This guarantees
that you are going to have to set up a special PTE, resulting in
additional overhead.


Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


