Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262027AbREVQXO>; Tue, 22 May 2001 12:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262580AbREVQXE>; Tue, 22 May 2001 12:23:04 -0400
Received: from RAVEL.CODA.CS.CMU.EDU ([128.2.222.215]:17813 "EHLO
	ravel.coda.cs.cmu.edu") by vger.kernel.org with ESMTP
	id <S262576AbREVQWu>; Tue, 22 May 2001 12:22:50 -0400
Date: Tue, 22 May 2001 12:22:39 -0400
To: David Woodhouse <dwmw2@infradead.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Me <bodnar42@bodnar42.dhs.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] include/linux/coda.h
Message-ID: <20010522122239.A32535@cs.cmu.edu>
Mail-Followup-To: David Woodhouse <dwmw2@infradead.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, Me <bodnar42@bodnar42.dhs.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E152DEZ-0001y7-00@the-village.bc.nu> <26524.990547044@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <26524.990547044@redhat.com>; from dwmw2@infradead.org on Tue, May 22, 2001 at 04:57:24PM +0100
From: Jan Harkes <jaharkes@cs.cmu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2001 at 04:57:24PM +0100, David Woodhouse wrote:
> The kernel compiles quite happily with compilers which aren't targetted 
> specifically at Linux -- the CODA compatibility cruft being the one 
> exception. I often just comment out the CODA includes from <linux/fs.h> to 
> get round the same problem.

Well, the original idea for having all that compatibility cruft in
coda.h was that the identical header could be used both by userspace,
and as part of the kernel code of all Coda ports.

But with problems like these popping up and the silly thing is just
turning into an unmaintainable mess of #ifdef bloat.

#include <linux/coda.h> can be taken out of linux/fs.h when I change a
few lines of code. In fact with those changes all Coda related headers
can be moved from include/linux/ to fs/coda/, although coda.h contains
the 'exported interface' and should probably remain in include/linux.

At least this will solve your problem as long as Coda isn't compiled
into the kernel, but not the reported problem of compiling a Linux
kernel on a different (Coda supported) OS without using a properly
configured cross-compiler.

I will try cleaning things up by having a common 'coda.h' for all
platforms (and userspace) and platform specific 'coda_types.h' files
which define missing types and such. It would definitely get rid of a
lot of the bloat, and probably make things somewhat easier to maintain.

Jan

btw. Coda is not an acronym, no need to capitalize it.

