Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265881AbUBJOBC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Feb 2004 09:01:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265895AbUBJOBB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Feb 2004 09:01:01 -0500
Received: from mx13.sac.fedex.com ([199.81.197.53]:6921 "EHLO
	mx13.sac.fedex.com") by vger.kernel.org with ESMTP id S265881AbUBJOAs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Feb 2004 09:00:48 -0500
Date: Tue, 10 Feb 2004 21:59:15 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: jchua@silk.corp.fedex.com
To: Andrew Morton <akpm@osdl.org>
cc: Jeff Chua <jeffchua@silk.corp.fedex.com>, torvalds@osdl.org,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] warning: `__attribute_used__' redefined
In-Reply-To: <20040209225336.1f9bc8a8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402102150150.17289@silk.corp.fedex.com>
References: <Pine.LNX.4.58.0402101434260.27213@boston.corp.fedex.com>
 <20040209225336.1f9bc8a8.akpm@osdl.org>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/10/2004
 10:00:39 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 02/10/2004
 10:00:42 PM,
	Serialize complete at 02/10/2004 10:00:42 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Feb 2004, Andrew Morton wrote:

> It is more likely that we need to extend the __KERNEL__ coverage somewhere.
>
> Can you please do a `gcc -H' of that application and show us the inclusion
> route by which it is hitting compiler.h?

Andrew,

Here's the sample "sig.c". Just compile with "cc sig.c"



#include <signal.h>	/* signal */
#include <stdio.h>	/* printf */

void action(int signum);

int main(int argc, char *argv[])
{
	int i;
	for(i = 1; i < 31; i++) {
		if(i == 9 || i == 19)
			continue;

		signal(i, action);
	}
}

void action(int signum)
{
	printf("%d\n", signum);
}




Here's output of "gcc -H sig.c" gcc 2.95.3  glibc 2.2.5  linux 2.6.3-rc2


/usr/include/signal.h
 /usr/include/features.h
  /usr/include/sys/cdefs.h
  /usr/include/gnu/stubs.h
 /usr/include/bits/sigset.h
 /usr/include/bits/types.h
  /usr/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include/stddef.h
  /usr/include/bits/pthreadtypes.h
   /usr/include/bits/sched.h
 /usr/include/bits/signum.h
 /usr/include/time.h
 /usr/include/bits/siginfo.h
  /usr/include/bits/wordsize.h
 /usr/include/bits/sigaction.h
 /usr/include/bits/sigcontext.h
  /usr/include/asm/sigcontext.h
   /usr/include/linux/compiler.h
    /usr/include/linux/compiler-gcc2.h
     /usr/include/linux/compiler-gcc.h
In file included from /usr/include/linux/compiler.h:18,
                 from /usr/include/asm/sigcontext.h:4,
                 from /usr/include/bits/sigcontext.h:28,
                 from /usr/include/signal.h:307,
                 from sig.c:1:
/usr/include/linux/compiler-gcc2.h:21: warning: `__attribute_used__' redefined
/usr/include/sys/cdefs.h:170: warning: this is the location of the previous definition
 /usr/include/bits/sigstack.h
 /usr/include/bits/sigthread.h
/usr/include/stdio.h
 /usr/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include/stddef.h
 /usr/include/libio.h
  /usr/include/_G_config.h
   /usr/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include/stddef.h
   /usr/include/wchar.h
    /usr/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include/stddef.h
    /usr/include/bits/wchar.h
   /usr/include/gconv.h
    /usr/include/wchar.h
     /usr/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include/stddef.h
    /usr/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include/stddef.h
  /usr/lib/gcc-lib/i586-pc-linux-gnu/2.95.3/include/stdarg.h
 /usr/include/bits/stdio_lim.h


Thanks,
Jeff


