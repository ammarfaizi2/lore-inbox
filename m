Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135890AbRAJPTs>; Wed, 10 Jan 2001 10:19:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135892AbRAJPTm>; Wed, 10 Jan 2001 10:19:42 -0500
Received: from srv01s4.cas.org ([134.243.50.9]:57305 "EHLO srv01.cas.org")
	by vger.kernel.org with ESMTP id <S135890AbRAJPT2>;
	Wed, 10 Jan 2001 10:19:28 -0500
From: Mike Harrold <mharrold@cas.org>
Message-Id: <200101101518.KAA11519@mah21awu.cas.org>
Subject: Re: * 4 converted to << 2 for networking code
To: jakob@unthought.net (Jakob Østergaard)
Date: Wed, 10 Jan 2001 10:18:38 -0500 (EST)
Cc: antirez@invece.org (antirez), bgerst@didntduck.org (Brian Gerst),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010110161146.A3252@unthought.net> from "Jakob Østergaard" at Jan 10, 2001 04:11:46 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Wed, Jan 10, 2001 at 06:03:22PM +0100, antirez wrote:
> > On Wed, Jan 10, 2001 at 09:54:04AM -0500, Brian Gerst wrote:
> > > This patch isn't really necessary, because GCC will automatically
> > > convert multiplications and divisions by powers of two to use shifts.
> > 
> > Sure, but since many << 2 already exists in the net kernel code
> > I feel it's better to use just a format, and it seems more appropriate
> > to write << 2, just to reflect what we want.
> > Also some piece of kernel code may be used with compilers that does not
> > optimize power of two.
> 
> On most processors <<2 is slower than *4.   It's outright stupid to 
> write <<2 when we mean *4 in order to optimize for one out of a
> gazillion supported architectures - even more so when the compiler
> for the one CPU where <<2 is faster, will actually generate a shift
> instead of a multiply as a part of the standard optimization.
> 
> One question for the GCC people:  Will gcc change <<2 to *4 on other 
> architectures ?    If so, then my case is not quite as strong of course.

Be careful. *4 is not a simple <<2 substitution (by the compiler) if
the variable is signed. *4 translates to 3 instructions (on x86) if
it's an int.

My feeling is that it shouldn't matter if you use <<2 or *4 even if the
compiler optimises - one would hope that the compiler would optimise to
the fastest in both directions.

Regards,

/Mike
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
