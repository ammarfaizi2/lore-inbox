Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265485AbSJSCoY>; Fri, 18 Oct 2002 22:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265486AbSJSCoY>; Fri, 18 Oct 2002 22:44:24 -0400
Received: from mnh-1-12.mv.com ([207.22.10.44]:7 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S265485AbSJSCoY>;
	Fri, 18 Oct 2002 22:44:24 -0400
Message-Id: <200210190352.WAA05769@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: john stultz <johnstul@us.ibm.com>
cc: Linus Torvalds <torvalds@transmeta.com>, andrea <andrea@suse.de>,
       lkml <linux-kernel@vger.kernel.org>,
       george anzinger <george@mvista.com>,
       Stephen Hemminger <shemminger@osdl.org>, Andi Kleen <ak@muc.de>
Subject: Re: [PATCH] linux-2.5.43_vsyscall_A0 
In-Reply-To: Your message of "18 Oct 2002 15:57:12 MST."
             <1034981832.4042.58.camel@cog> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 18 Oct 2002 22:52:53 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

johnstul@us.ibm.com said:
> Since no one really brought up any issues with the code itself
> (correct me if I'm wrong), here is the i386 vsyscall gettimeofday port
> I sent last night, synced up and ready for integration.

This vsyscall implementation breaks UML.  Any app that's run inside UML
that uses vsyscalls will get the host's vsyscalls rather than the UML
vsyscalls.

This needs to be virtualizable somehow, which means that apps run inside
UML, without being changed, get the UML vsyscalls.  There are a couple of
possiblities that I can think of:
	a get_vsyscall system call which is executed by libc on startup -
UML would return a different calue from the host
	some mechanism for UML to map its own vsyscall area in place of
the host's - it wouldn't necessarily need to be able to unmap it when it's
running its own kernel code because it can probably arrange not to use the
host's vsyscalls.

				Jeff

