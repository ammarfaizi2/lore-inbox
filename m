Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262238AbUFSAlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262238AbUFSAlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262045AbUFRUkA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 16:40:00 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:64858 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S263154AbUFRUgV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 16:36:21 -0400
Date: Fri, 18 Jun 2004 22:46:55 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: 4Front Technologies <dev@opensound.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: Stop the Linux kernel madness
Message-ID: <20040618204655.GA4441@mars.ravnborg.org>
Mail-Followup-To: 4Front Technologies <dev@opensound.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@osdl.org>
References: <40D232AD.4020708@opensound.com> <3217460000.1087518092@flay> <40D23701.1030302@opensound.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40D23701.1030302@opensound.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 17, 2004 at 05:27:45PM -0700, 4Front Technologies wrote:
> 
> Our commercial OSS drivers work perfectly with Linux 2.6.5, 2.6.6, 2.6.7
> and they are failing to install with SuSE's 2.6.5 kernel. The reason is that
> they have gone and changed the kernel headers which mean that nothing works.
> 
> For instance our kernel interface module doesn't compile anymore we see the 
> following
> errors:
> 
> >make -C /lib/modules/`uname -r`/build scripts scripts_basic 
> >include/linux/version.h
> >make[1]: Entering directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
> >make[1]: Nothing to be done for `scripts'.
> >make[1]: *** No rule to make target `scripts_basic'.  Stop.
> >make[1]: Leaving directory `/usr/src/linux-2.6.5-7.75-obj/i386/bigsmp'
> >make: *** [ossbuild] Error 2
> > 
> >Trying to compile using 
> >INCLUDE=/lib/modules/2.6.5-7.75-bigsmp/build/include
> >In file included from /usr/include/asm/smp.h:18,
> >                 from /usr/include/linux/smp.h:17,
> >                 from /usr/include/linux/sched.h:23,
> >                 from /usr/include/linux/module.h:10,
> >                 from src/sndshield.c:49:
> >/usr/include/asm/mpspec.h:6:25: mach_mpspec.h: No such file or directory
> >In file included from /usr/include/asm/smp.h:18,
> >                 from /usr/include/linux/smp.h:17,
> >                 from /usr/include/linux/sched.h:23,
> >                 from /usr/include/linux/module.h:10,
> 
> 
> 
> Why is this happening?. It's working fine with Linux 2.6.5 and also worked 
> with
> Linux 2.6.4 kernels from SuSE 9.1

It looks like SuSE as the first distribution took the sane approach to
seperate source and output files.
I presume they have documented this somewhere - and I have a patch
from Andreas G. that should actually solve this if a module is
compiled in the usual way like you do.

So you seems to be bitten by a distributor starting to use a new
facility in kbuild.

Why did you not post the error in your first mail btw?

	Sam
