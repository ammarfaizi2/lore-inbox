Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269657AbTGJWpy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 18:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269656AbTGJWpm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 18:45:42 -0400
Received: from adsl-110-19.38-151.net24.it ([151.38.19.110]:47035 "HELO
	develer.com") by vger.kernel.org with SMTP id S269657AbTGJWo0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 18:44:26 -0400
From: Bernardo Innocenti <bernie@develer.com>
Organization: Develer
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: [PATCH] Fix do_div() for all architectures
Date: Fri, 11 Jul 2003 00:58:58 +0200
User-Agent: KMail/1.5.9
Cc: Richard Henderson <rth@twiddle.net>, Linus Torvalds <torvalds@osdl.org>,
       linux-kernel@vger.kernel.org, Peter Chubb <peter@chubb.wattle.id.au>,
       Andrew Morton <akpm@digeo.com>, Ian Molton <spyro@f2s.com>,
       gcc@gcc.gnu.org
References: <200307060133.15312.bernie@develer.com> <200307102131.45474.bernie@develer.com> <20030710201939.GQ16313@dualathlon.random>
In-Reply-To: <20030710201939.GQ16313@dualathlon.random>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200307110058.59212.bernie@develer.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 10 July 2003 22:19, Andrea Arcangeli wrote:

 > >  Without type based alias analysis, the compiler is forced to flush
 > > all registers containing copies of memory objects before function
 > > call and reloading values from memory afterwards.
 >
 > the kernel isn't complaint with the alias analysis, that's why it has
 > to be turned off (-fnostrict-aliasing) or stuff would break.

Yeah, I noticed. Writing low-level code without breaking strict aliasing
rules can be quite difficult if you don't want to give up any of your clever
tricks. I have a set of macros for handling linked lists that I can't get to
compile without those damn alias warnings with the latest GCC versions.

Besides, pushing our philosophycal discussion forward, what the generic
do_div() is doing might be vary bad for performance. After extracting the
address of n, the compiler must conservatively assume that any following
pointer dereference or function call could alter the contents of n.

Since strict aliasing is turned off, access to the divisor will become
slow as hell. Almost as if it was declared volatile.

Ok, as Richard said, it's just the generic version for those who don't
care enough to write their own optimized version.

 > > Boy, that's ugly! It's too bad C can't do it the Perl way:
 > >
 > >     (n,rem) = __div64_32(n, base);
 >
 > or the python way:
 >
 > 	n, rem = __div64_32(n, base)
 >
 > ;)

 You beat me!

-- 
  // Bernardo Innocenti - Develer S.r.l., R&D dept.
\X/  http://www.develer.com/

Please don't send Word attachments - http://www.gnu.org/philosophy/no-word-attachments.html


