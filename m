Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318325AbSHIMoa>; Fri, 9 Aug 2002 08:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318326AbSHIMoa>; Fri, 9 Aug 2002 08:44:30 -0400
Received: from adsl-161-92.barak.net.il ([62.90.161.92]:63496 "EHLO
	hirame.qlusters.com") by vger.kernel.org with ESMTP
	id <S318325AbSHIMo3>; Fri, 9 Aug 2002 08:44:29 -0400
Subject: Re: device driver / char module interrupt vector -> user space code
From: Gilad Ben-Yossef <gilad@benyossef.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: SA <bullet.train@ntlworld.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1028889240.30103.189.camel@irongate.swansea.linux.org.uk>
References: <200208090949.48484.bullet.train@ntlworld.com> 
	<1028889240.30103.189.camel@irongate.swansea.linux.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 09 Aug 2002 15:46:07 +0300
Message-Id: <1028897167.27103.39.camel@sake>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 13:34, Alan Cox wrote:
> On Fri, 2002-08-09 at 09:49, SA wrote:
> > I am writing a char module for a PCI stage controller and want to add the 
> > following functionality; 
> > 
> > The device will generate an interrupt (or software trigger) and I want this to 
> > run a bit of user code with relatively latency.  (<1ms).  I am unclear how to
> > do this while still separating the user from the kernel code and maintaining
> > security - would this usually be handled by issuing a signal to the user space
> > process? if so how and what latency can I expect? 
> 
> You could deliver a signal, or if appropriate you can have a system call
> that blocks until the IRQ. To get good reliable latency, mlockall() the 
> process you need to be real time, and set it to a real time scheduling
> priority.


To get <1ms latencies I suspect you will also need the preemtive kernel
and lock-break patches (http://www.tech9.net/rml/linux/) and if you're
running on an x86, changing the HZ value in linux/asm/param.h from 100
to 1000 will also be a good idea IMHO. 

Of course, this requires re-compiling and replacing the kernel which may
or may not be apropriate. AFAIK both the patches and the HZ value change
are already in the 2.5.x development kernels already, but not everyone
are running *that* version quite yet... :-D

Gilad.

-- 
Gilad Ben-Yossef <gilad@benyossef.com>
Code mangler, senior coffee drinker and VP SIGSEGV
Qlusters ltd.

"You got an EMP device in the server room? That is so cool."
      -- from a hackers-il thread on paranoia



