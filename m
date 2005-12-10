Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751285AbVLJCCk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbVLJCCk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 21:02:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbVLJCCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 21:02:40 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:51927 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1751232AbVLJCCj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 21:02:39 -0500
Subject: Re: i386 -> x86_64 cross compile failure (binutils bug?)
From: Lee Revell <rlrevell@joe-job.com>
To: Jeffrey Hundstad <jeffrey.hundstad@mnsu.edu>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <439A201D.7030103@mnsu.edu>
References: <1134154208.14363.8.camel@mindpipe>  <439A0746.80208@mnsu.edu>
	 <1134173138.18432.41.camel@mindpipe>  <439A201D.7030103@mnsu.edu>
Content-Type: text/plain
Date: Fri, 09 Dec 2005 20:50:10 -0500
Message-Id: <1134179410.18432.66.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-12-09 at 18:23 -0600, Jeffrey Hundstad wrote:
> Lee Revell wrote:
> 
> >On Fri, 2005-12-09 at 16:37 -0600, Jeffrey Hundstad wrote:
> >  
> >
> >>Lee Revell wrote:
> >>
> >>    
> >>
> >>>I'm trying to build an x66-64 kernel on a 32 bit system (Ubuntu 5.10).
> >>>I added -m64 to the CFLAGS as per the gcc docs.  But the build fails
> >>>with:
> >>>
> >>>$ make ARCH=x86_64
> >>> [...]
> >>> CC      init/initramfs.o
> >>>
> >>>
> >>>      
> >>>
> >>I have successfully done this using Debian/Sid.
> >>
> >>    
> >>
> >
> >I added "-m64" to AFLAGS as well and now I get farther:
> >
> >  CC      arch/x86_64/ia32/syscall32.o
> >  AS      arch/x86_64/ia32/vsyscall-sysenter.o
> >arch/x86_64/ia32/vsyscall-sysenter.S: Assembler messages:
> >arch/x86_64/ia32/vsyscall-sysenter.S:14: Error: suffix or operands invalid for `push'
> >arch/x86_64/ia32/vsyscall-sysenter.S:16: Error: suffix or operands invalid for `push'
> >arch/x86_64/ia32/vsyscall-sysenter.S:18: Error: suffix or operands invalid for `push'
> >arch/x86_64/ia32/vsyscall-sysenter.S:25: Error: suffix or operands invalid for `pop'
> >arch/x86_64/ia32/vsyscall-sysenter.S:27: Error: suffix or operands invalid for `pop'
> >arch/x86_64/ia32/vsyscall-sysenter.S:29: Error: suffix or operands invalid for `pop'
> >arch/x86_64/ia32/vsyscall-sigreturn.S:16: Error: suffix or operands invalid for `pop'
> >make[1]: *** [arch/x86_64/ia32/vsyscall-sysenter.o] Error 1
> >make: *** [arch/x86_64/ia32] Error 2
> >
> >Lee
> >
> >  
> >
> 
> Yes, some commands NEED the -m64 and and WILL NOT work with -m64.
> 

Aha!  I disabled CONFIG_IA32_EMULATION and it works perfectly.

So all that's needed to build an x86_64 kernel with the i386 Ubuntu 5.10
toolchain:

 - edit Makefile: add -m64 to CFLAGS and AFLAGS
 - disable CONFIG_IA32_EMULATION
 - make ARCH=x86_64

Lee





