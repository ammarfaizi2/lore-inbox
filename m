Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317262AbSFCKLw>; Mon, 3 Jun 2002 06:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317348AbSFCKLu>; Mon, 3 Jun 2002 06:11:50 -0400
Received: from relay01.valueweb.net ([216.219.253.235]:519 "EHLO
	relay01.valueweb.net") by vger.kernel.org with ESMTP
	id <S317262AbSFCKLr>; Mon, 3 Jun 2002 06:11:47 -0400
Message-ID: <3CFB40FB.E997F3E6@opersys.com>
Date: Mon, 03 Jun 2002 06:12:11 -0400
From: Karim Yaghmour <karim@opersys.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en, French/Canada, French/France, fr-FR, fr-CA
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel <linux-kernel@vger.kernel.org>,
        Philippe Gerum <rpm@idealx.com>
Subject: Re: [ANNOUNCE] Adeos nanokernel for Linux kernel
In-Reply-To: <3CFB2A38.60242CBA@opersys.com> <20020603084606.GA15986@codepoet.org> <3CFB3378.5EB7420@opersys.com> <20020603095202.GA16392@codepoet.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Erik Andersen wrote:
> So will we soon be seeing a port of RTAI to a linux kernel module
> which is implemented as a separate Adeos domain, allowing RTAI
> apps to bypass US patent 5995745?  A quick glance over that
> patent leaves me uncertain whether this indeed bypasses the
> fundamental "invention" of a "process for running a general
> purpose computer operating system using a real time operating
> system".   It still looks to me like a real time operating system
> (Adeos) running real time and non-real time tasks with a general
> purpose operating system as one of the non-real time tasks...
> Could you summarize (for non-lawyers such as myself) how this
> bypasses the claims in the patent?

The problem here is the "quick glance" (no offense intended). The
most important part of a patent is its claims. In the case of the
rtlinux patent, there are 11 claims. There are 2 sorts of claims,
independent claims and dependent claims. In this patent, there are
2 independent claims and 9 claims that depend on these 2 root
claims. If you can show that a method is not an implementation of
those 2 root claims, you're clear.

The 2 root claims in this patent are claim 1 & 7. Both of these
contain the following statements [1]:
> A process for running a general purpose computer operating system
> using a real time operating system, including the steps of: 
> 
> a) providing a real time operating system for running real time
> tasks and components and non-real time tasks; 
> 
> b) providing a general purpose operating system as one of the
> non-real time tasks; 
> 
> c) preempting the general purpose operating system as needed for
> the real time tasks; and 
> 
> d) preventing the general purpose operating system from blocking
> preemption of the non-real time tasks. 

First, the introductory phrase doesn't match. Any RTOS above Adeos
does not run Linux. The RTOS does not catch all interrupts and
decide which ones go to Linux and which don't. In fact, it is
very possible that the RTOS isn't even aware of Linux's existence.
All it sees is Adeos with which it interacts to get everything it
needs. Furthermore, the RTOS has no idea if someone else is
before him in the ipipe.

As for the claims, we just need to take a look at "a" and "b" to
see that it doesn't match:
a) Adeos is certainly not an RTOS and it certainly doesn't have any
"tasks". It doesn't even have a scheduler. All it does is distribute
hardware resources to whoever asks for them. Note that "Exokernel"
for instance, did have a "round-robin" scheduler. So even if Adeos
had a scheduler, it would still be considered a nanokernel.
b) This one doesn't apply to Adeos for the same reasons as "a".
Also this phrase doesn't apply to any RTOS above Adeos because
any such RTOS need not even know Linux is there. All it needs to
know is that it has to call on adeos_suspend_domain() to go into
a dormant state when it doesn't have any more "ready" tasks. In
no way does it have a "Linux" task, as RTLinux and RTAI clearly
do.

Karim

[1]
http://patft.uspto.gov/netacgi/nph-Parser?Sect1=PTO1&Sect2=HITOFF&d=PALL&p=1&u=/netahtml/srchnum.htm&r=1&f=G&l=50&s1=%275,995,745%27.WKU.&OS=PN/5,995,745&RS=PN/5,995,745

===================================================
                 Karim Yaghmour
               karim@opersys.com
      Embedded and Real-Time Linux Expert
===================================================
