Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266062AbRGIAcN>; Sun, 8 Jul 2001 20:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266981AbRGIAcD>; Sun, 8 Jul 2001 20:32:03 -0400
Received: from hq2.fsmlabs.com ([209.155.42.199]:49926 "HELO hq2.fsmlabs.com")
	by vger.kernel.org with SMTP id <S266062AbRGIAbt>;
	Sun, 8 Jul 2001 20:31:49 -0400
Date: Sun, 8 Jul 2001 18:28:40 -0600
From: Victor Yodaiken <yodaiken@fsmlabs.com>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: yodaiken@fsmlabs.com, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Why Plan 9 C compilers don't have asm("")
Message-ID: <20010708182840.A24031@hq2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107090008.f6908Op07251@devserv.devel.redhat.com>
User-Agent: Mutt/1.3.18i
Organization: FSM Labs
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 08, 2001 at 08:08:24PM -0400, Pete Zaitcev wrote:
> Register windows do help some, in that sense ia64 is a big
> step forward ofver x86.

It seems to me that x86 instruction set has lived long enough to
become efficient again. Register windows I think are bad. I'd rather
see a couple of hundred K of 1 cycle memory that the compiler/programmer
could use. But then I don't like the property "test for 1 year
and still don't uncover the production case where there is a window
spill that comes at just the wrong time when the write cache is 
full, ... - and timing changes by hundreds of microseconds."

>As I read what Linus wrote, he talked
> about a different thing: inside a procedure you do not
> know whence you are called, therefore you must start scheduling
> anew from the first instruction of the procedure; before your

This is a hard part for any vliw type machine - if the compiler
can't figure it out or  if the processor requires a sync point, then
performance will be terrible.  My understanding is that this is
just a merced problem, not a ia64 fundamental, but it seems hard.
As Alan points out, the PIV tries to do better with a trace cache
so
    code;call x; code
is essentially, dynamically inlined by caching
    code;code of x; code
if I understand it right and that's pretty cool
- maybe mckinley will use the same technique if
the compiler can't figure it out. 


Anyway, any processor that does badly on calls is going to be 
a disaster, the real question is when it's good to use assembler
escapes.

> You must take into account that early riscs had miniscule dies,
> for example the first Fujitsu made SPARC had 10,000 gates
> all told. An alignment to the next instruction wastes hardware,
> and, perhaps, a clock cycle.

PowerPC has no excuse.

> 
> -- Pete
