Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129830AbRAXNrD>; Wed, 24 Jan 2001 08:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129884AbRAXNqy>; Wed, 24 Jan 2001 08:46:54 -0500
Received: from tomcat.admin.navo.hpc.mil ([204.222.179.33]:29567 "EHLO
	tomcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S129830AbRAXNqr>; Wed, 24 Jan 2001 08:46:47 -0500
Date: Wed, 24 Jan 2001 07:46:20 -0600 (CST)
From: Jesse Pollard <pollard@tomcat.admin.navo.hpc.mil>
Message-Id: <200101241346.HAA51300@tomcat.admin.navo.hpc.mil>
To: andrea@suse.de, Richard Henderson <rth@twiddle.net>
Subject: Re: Compatibility issue with 2.2.19pre7
Cc: Russell King <rmk@arm.linux.org.uk>, Hubert Mantel <mantel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
X-Mailer: [XMailTool v3.1.2b]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de>:
> On Tue, Jan 23, 2001 at 11:51:15PM -0800, Richard Henderson wrote:
> > On Thu, Jan 11, 2001 at 12:59:24AM +0100, Andrea Arcangeli wrote:
> > > What I said is that I can write this C code:
> > > 
> > > 	int x[2], * p = (int *) (((char *) &x)+1);
> > > 	main()
> > > 	{
> > > 		*p = 0;
> > > 	}
> > > 
> > > This is legal C code.
> > 
> > Err, no.  This is not "legal" by any stretch of the imagination.
> > This code has undefined behaviour.
> 
> I know this code has undefined behaviour at _runtime_. But I thought
> you were obliged to allow it to compile. That was my only point.
> 
> > We aren't even obliged to allow this to compile.
> 
> I'd love if you could forbid it to compile.

It would have to be implementation dependant/architecture dependant-
The only way to know is to realize that *p initializer value is invalid
is to know:

1. integer addresses MUST be aligned (say 4 or 8 byte boundaries)
2. the computation of (int *) (((char *) &x)+1) is a constant at
   compile time, and not link time (some linkers can do address offset
   calculations if "x" happens to be an external - ie. x +/- offset and
   offset is a constant)

Other systems would have to allow it to compile (and link). It still has
undefined behaviour, and is non-portable.

-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
