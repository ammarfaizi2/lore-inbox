Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265543AbSJSDlD>; Fri, 18 Oct 2002 23:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265544AbSJSDlD>; Fri, 18 Oct 2002 23:41:03 -0400
Received: from mnh-1-10.mv.com ([207.22.10.42]:6919 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265543AbSJSDlD>;
	Fri, 18 Oct 2002 23:41:03 -0400
Message-Id: <200210190450.XAA06161@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andi Kleen <ak@muc.de>
Cc: john stultz <johnstul@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       andrea <andrea@suse.de>, lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0 
In-Reply-To: Your message of "Sat, 19 Oct 2002 05:10:02 +0200."
             <20021019031002.GA16404@averell> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 Oct 2002 23:49:59 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ak@muc.de said:
> Guess you'll have some problems then with UML on x86-64, which always
> uses vgettimeofday. But it's only used for gettimeofday() currently,
> perhaps it's  not that bad when the UML child runs with the host's
> time.

It's not horrible, but it's still broken.  There are people who depend
on UML being able to keep its own time separately from the host.

> I guess it would be possible to add some support for UML to map own
> code over the vsyscall reserved locations. UML would need to use the
> syscalls then. But it'll be likely ugly. 

Yeah, it would be.

My preferred solution would be for libc to ask the kernel where the vsyscall
area is.  That's reasonably clean and virtualizable.  Andrea doesn't like it
because it adds a few instructions to the vsyscall address calculation.

				Jeff

