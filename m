Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318208AbSHIJKA>; Fri, 9 Aug 2002 05:10:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318209AbSHIJKA>; Fri, 9 Aug 2002 05:10:00 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:17659 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318208AbSHIJJ7>; Fri, 9 Aug 2002 05:09:59 -0400
Subject: Re: device driver / char module interrupt vector -> user space code
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: SA <bullet.train@ntlworld.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200208090949.48484.bullet.train@ntlworld.com>
References: <200208090949.48484.bullet.train@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 09 Aug 2002 11:34:00 +0100
Message-Id: <1028889240.30103.189.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-08-09 at 09:49, SA wrote:
> I am writing a char module for a PCI stage controller and want to add the 
> following functionality; 
> 
> The device will generate an interrupt (or software trigger) and I want this to 
> run a bit of user code with relatively latency.  (<1ms).  I am unclear how to
> do this while still separating the user from the kernel code and maintaining
> security - would this usually be handled by issuing a signal to the user space
> process? if so how and what latency can I expect? 

You could deliver a signal, or if appropriate you can have a system call
that blocks until the IRQ. To get good reliable latency, mlockall() the 
process you need to be real time, and set it to a real time scheduling
priority.


