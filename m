Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132046AbRDJUHY>; Tue, 10 Apr 2001 16:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132056AbRDJUHK>; Tue, 10 Apr 2001 16:07:10 -0400
Received: from ns.suse.de ([213.95.15.193]:39177 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132046AbRDJUFx>;
	Tue, 10 Apr 2001 16:05:53 -0400
Date: Tue, 10 Apr 2001 22:05:51 +0200
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: David Howells <dhowells@cambridge.redhat.com>,
        Andrew Morton <andrewm@uow.edu.au>, Ben LaHaise <bcrl@redhat.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386 rw_semaphores fix
Message-ID: <20010410220551.A24251@gruyere.muc.suse.de>
In-Reply-To: <11851.986925762@warthog.cambridge.redhat.com> <Pine.LNX.4.31.0104101229150.13071-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.31.0104101229150.13071-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Apr 10, 2001 at 12:42:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 12:42:07PM -0700, Linus Torvalds wrote:
> 
> 
> On Tue, 10 Apr 2001, David Howells wrote:
> >
> > Here's a patch that fixes RW semaphores on the i386 architecture. It is very
> > simple in the way it works.
> 
> XADD only works on Pentium+.

My Intel manual says it 486+:

``
XADD-Exchange and Add
[...]
Intel Architecture Compatibility
Intel Architecture processors earlier than the Intel486TM processor do not recognize this instruc-
tion. If this instruction is used, you should provide an equivalent code sequence that runs on
earlier processors.
''

I guess 386 could live with an exception handler that emulates it.

(BTW an generic exception handler for CMPXCHG would also be very useful
for glibc -- currently it has special checking code for 386 in its mutexes) 
The 386 are so slow that nobody would probably notice a bit more slowness
by a few exceptions.

-Andi
