Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318209AbSHIJcP>; Fri, 9 Aug 2002 05:32:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318212AbSHIJcP>; Fri, 9 Aug 2002 05:32:15 -0400
Received: from [62.40.73.125] ([62.40.73.125]:60545 "HELO Router")
	by vger.kernel.org with SMTP id <S318209AbSHIJcN>;
	Fri, 9 Aug 2002 05:32:13 -0400
Date: Fri, 9 Aug 2002 11:35:49 +0200
From: Jan Hudec <bulb@ucw.cz>
To: SA <bullet.train@ntlworld.com>, linux-kernel@vger.kernel.org
Subject: Re: device driver / char module interrupt vector -> user space code
Message-ID: <20020809093549.GF13165@vagabond>
Mail-Followup-To: Jan Hudec <bulb@ucw.cz>, SA <bullet.train@ntlworld.com>,
	linux-kernel@vger.kernel.org
References: <200208090949.48484.bullet.train@ntlworld.com> <1028889240.30103.189.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1028889240.30103.189.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 11:34:00AM +0100, Alan Cox wrote:
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

If you noticed the discussion about signal delivery and context switch
latency, a syscall (can be ioctl on special device) waiting for the
event would be faster than signal.

-------------------------------------------------------------------------------
						 Jan 'Bulb' Hudec <bulb@ucw.cz>
