Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751656AbWDBDBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751656AbWDBDBx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 22:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751655AbWDBDBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 22:01:53 -0500
Received: from morbo.e-centre.net ([66.154.82.3]:11753 "EHLO
	cubert.e-centre.net") by vger.kernel.org with ESMTP
	id S1751215AbWDBDBw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 22:01:52 -0500
X-ASG-Debug-ID: 1143946892-22384-23-0
X-Barracuda-URL: http://10.3.1.19:8000/cgi-bin/mark.cgi
X-ASG-Orig-Subj: Re: [RFC][PATCH 1/2] Create initial kernel ABI header
	infrastructure
Subject: Re: [RFC][PATCH 1/2] Create initial kernel ABI header
	infrastructure
From: Arjan van de Ven <arjan@infradead.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: "Randy.Dunlap" <rdunlap@xenotime.net>, Pavel Machek <pavel@ucw.cz>,
       linux-kernel@vger.kernel.org, nix@esperi.org.uk, rob@landley.net,
       mmazur@kernel.pl, llh-discuss@lists.pld-linux.org
In-Reply-To: <EB70C0D0-4961-4F78-B245-69C962F8B52E@mac.com>
References: <200603141619.36609.mmazur@kernel.pl>
	 <200603231811.26546.mmazur@kernel.pl>
	 <DE01BAD3-692D-4171-B386-5A5F92B0C09E@mac.com>
	 <200603241623.49861.rob@landley.net> <878xqzpl8g.fsf@hades.wkstn.nix>
	 <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com>
	 <20060326065205.d691539c.mrmacman_g4@mac.com>
	 <20060326065416.93d5ce68.mrmacman_g4@mac.com>
	 <1143376351.3064.9.camel@laptopd505.fenrus.org>
	 <A6491D09-3BCF-4742-A367-DCE717898446@mac.com>
	 <20060329222640.GA2755@ucw.cz>
	 <20060401162213.dc68d120.rdunlap@xenotime.net>
	 <EB70C0D0-4961-4F78-B245-69C962F8B52E@mac.com>
Content-Type: text/plain
Date: Sun, 02 Apr 2006 05:01:06 +0200
Message-Id: <1143946866.3056.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=4.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.10367
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-04-01 at 21:42 -0500, Kyle Moffett wrote:

> (1)  The various C standards state that the implementation should  
> restrict itself to symbols prefixed with "__", everything else is  
> reserved for user code (Including symbols prefixed with a single  
> underscore).

user code in this context includes, in my interpretation, headers for
specific ioctl structures and such (eg direct included headers; headers
that those headers include are a different matter) that the user wants.

Which is the vast majority of the kernel abi.
Exceptions are things like __u64 which are almost always "indirectly"
included. Eg the app wants "struct foo_ioctl" and foo_ioctl happens to
contain an __u64 which needs types.h


> (2)  GCC predefines a large collection of symbols, macros, and  
> functions for its own use, and this set is not constant (just look at  
> the number of new __-prefixed symbols added between GCC 3 and 4.  In  
> addition, we're not just compiling this code under GCC, but people  
> will also be using it (hopefully unmodified) under tiny-cc, intel-cc,  
> PGI, PathScale, Lahey, ARM Ltd, lcc, and possibly others.  It  
> probably does not need to be stated that for something as userspace- 
> sensitive as the KABI headers we should not risk colliding with  
> predefined builtins in any of those compilers.

the good news is that as kernel we have SOME power ;)
people who make compilers like that stay away from symbols the kernel
defines. Especially gcc is very careful in its namespace use and tends
to be very different from what linux kernel uses

> So my question to the list is this:
> Can you come up with any way other than using a "__kabi_" prefix to  
> reasonably avoid namespace collisions with that large list of  
> compilers?

First of all be realistic. Don't do silly things for places where it
doesn't matter. Again the ioctl structs come to mind.
Second, names the kernel ALREADY claims are of course free to use as
well; all those compilers ALREADY stay away from those.

What is left if you take those two big ones out of the picture?


> Of course, if the general consensus is that supporting non-GCC is not  
> important, then that's ok with me.  Judging from the number of  
> negative responses my earlier "[OT] Non-GCC compilers used for linux  
> userspace" got, however, that doesn't seem to be the case.

there is another dynamic; those other compilers in general try to
emulate gcc to a large degree, usually a very large degree. So the
"problem" you see is a lot smaller than you think.


