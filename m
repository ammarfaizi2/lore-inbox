Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbRE1Xay>; Mon, 28 May 2001 19:30:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261771AbRE1Xao>; Mon, 28 May 2001 19:30:44 -0400
Received: from yoda.planetinternet.be ([195.95.30.146]:6411 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S261719AbRE1Xai>; Mon, 28 May 2001 19:30:38 -0400
Date: Tue, 29 May 2001 01:30:30 +0200
From: Kurt Roeckx <Q@ping.be>
To: Russell King <rmk@arm.linux.org.uk>
Cc: Vadim Lebedev <vlebedev@aplio.fr>, linux-kernel@vger.kernel.org
Subject: Re: Potenitial security hole in the kernel
Message-ID: <20010529013030.A3381@ping.be>
In-Reply-To: <003601c0e7bf$41953080$0101a8c0@LAP> <20010529001256.F9203@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <20010529001256.F9203@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2001 at 12:12:56AM +0100, Russell King wrote:
> On Mon, May 28, 2001 at 11:43:38PM +0200, Vadim Lebedev wrote:
> > Please correct me if i'm wrong but it seems to me that i've stumbled on
> > really BIG security hole in the signal handling code.
> 
> I don't think there's problem, unless I'm missing something.
> 
> > The problem IMO is that the signal handling code stores a processor context
> > on the user-mode stack frame which is active while
> > the signal handler is running.
> 
> User context (defined by 'regs') is stored onto the user stack.
> However, when context is restored, certain checks are done, including
> making sure that the segment registers cs and ss are their user mode
> versions (or'd with 3), and the processor flags are non-privileged.

If that's what's happening, I have to agree with him that there
is a problem.

Why would he need to go back to kernel space at all?  He can make
it point wherever he wants.

You should never "return" from userspace to kernelspace.  The
only way to go from user space to kernel space should be by using
a system call.


Kurt

