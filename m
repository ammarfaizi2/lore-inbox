Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbSJTNNb>; Sun, 20 Oct 2002 09:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262617AbSJTNNb>; Sun, 20 Oct 2002 09:13:31 -0400
Received: from ns.suse.de ([213.95.15.193]:23050 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S262568AbSJTNNa>;
	Sun, 20 Oct 2002 09:13:30 -0400
Mail-Copies-To: never
To: Andi Kleen <ak@muc.de>
Cc: Jeff Dike <jdike@karaya.com>, john stultz <johnstul@us.ibm.com>,
       Linus Torvalds <torvalds@transmeta.com>, andrea <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, discuss@x86-64.org
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0
References: <20021019031002.GA16404@averell>
	<200210190450.XAA06161@ccure.karaya.com>
	<20021019040238.GA21914@averell>
From: Andreas Jaeger <aj@suse.de>
Date: Sun, 20 Oct 2002 15:19:32 +0200
In-Reply-To: <20021019040238.GA21914@averell> (Andi Kleen's message of "Sat,
 19 Oct 2002 06:02:38 +0200")
Message-ID: <u8lm4tcknv.fsf@gromit.moeb>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> writes:

> [full quote for context]
>
> On Sat, Oct 19, 2002 at 06:49:59AM +0200, Jeff Dike wrote:
>> ak@muc.de said:
>> > Guess you'll have some problems then with UML on x86-64, which always
>> > uses vgettimeofday. But it's only used for gettimeofday() currently,
>> > perhaps it's  not that bad when the UML child runs with the host's
>> > time.
>> 
>> It's not horrible, but it's still broken.  There are people who depend
>> on UML being able to keep its own time separately from the host.
>> 
>> > I guess it would be possible to add some support for UML to map own
>> > code over the vsyscall reserved locations. UML would need to use the
>> > syscalls then. But it'll be likely ugly. 
>> 
>> Yeah, it would be.
>> 
>> My preferred solution would be for libc to ask the kernel where the vsyscall
>> area is.  That's reasonably clean and virtualizable.  Andrea doesn't like it
>> because it adds a few instructions to the vsyscall address calculation.
>
> I would have no problems with adding that to the x86-64 kernel. It could
> be passed in by the ELF environment vector and added to the ABI. 
> Overhead should be negligible, it just needs a single table lookup.  
> Andreas, what do you think ? 

Create a new AT_ constant, and pass it via the auxiliary vector and we
can use it in glibc.

Andreas
-- 
 Andreas Jaeger
  SuSE Labs aj@suse.de
   private aj@arthur.inka.de
    http://www.suse.de/~aj
