Return-Path: <linux-kernel-owner+w=401wt.eu-S933200AbWLaQz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933200AbWLaQz3 (ORCPT <rfc822;w@1wt.eu>);
	Sun, 31 Dec 2006 11:55:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933201AbWLaQz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Dec 2006 11:55:29 -0500
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:3277 "EHLO
	mcr-smtp-001.bulldogdsl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933200AbWLaQz2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Dec 2006 11:55:28 -0500
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Oops in 2.6.19.1
Date: Sun, 31 Dec 2006 16:55:51 +0000
User-Agent: KMail/1.9.5
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>
References: <200612201421.03514.s0348365@sms.ed.ac.uk> <200612301659.35982.s0348365@sms.ed.ac.uk> <20061231162731.GK20714@stusta.de>
In-Reply-To: <20061231162731.GK20714@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612311655.51928.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 31 December 2006 16:27, Adrian Bunk wrote:
> On Sat, Dec 30, 2006 at 04:59:35PM +0000, Alistair John Strachan wrote:
> > On Thursday 28 December 2006 04:14, Alistair John Strachan wrote:
> > > On Thursday 28 December 2006 04:02, Alistair John Strachan wrote:
> > > > On Thursday 28 December 2006 02:41, Zhang, Yanmin wrote:
> > > > [snip]
> > > >
> > > > > > Here's a current decompilation of vmlinux/pipe_poll() from the
> > > > > > running kernel, the addresses have changed slightly. There's no
> > > > > > xchg there either:
> > > > >
> > > > > Could you reproduce the bug by the new kernel, so we could get the
> > > > > exact address and instruction of the bug?
> > > >
> > > > It crashed again, but this time with no output (machine locked
> > > > solid). To be honest, the disassembly looks right (it's like Chuck
> > > > said, it's jumping back half way through an instruction):
> > > >
> > > > c0156f5f:       3b 87 68 01 00 00       cmp    0x168(%edi),%eax
> > > >
> > > > So c0156f60 is 87 68 01 00 00..
> > > >
> > > > This is with the GCC recompile, so it's not a distro problem. It
> > > > could still either be GCC 4.x, or a 2.6.19.1 specific bug, but it's
> > > > serious. 2.6.19 with GCC 3.4.3 is 100% stable.
> > >
> > > Looks like a similar crash here:
> > >
> > > http://ubuntuforums.org/showthread.php?p=1803389
> >
> > I've eliminated 2.6.19.1 as the culprit, and also tried toggling
> > "optimize for size", various debug options. 2.6.19 compiled with GCC
> > 4.1.1 on an Via Nehemiah C3-2 seems to crash in pipe_poll reliably,
> > within approximately 12 hours.
> >
> > The machine passes 6 hours of Prime95 (a CPU stability tester), four
> > memtest86 passes, and there are no heat problems.
> >
> > I have compiled GCC 3.4.6 and compiled 2.6.19 with an identical config
> > using this compiler (but the same binutils), and will report back if it
> > crashes. My bet is that it won't, however.
>
> There are occasional reports of problems with kernels compiled with
> gcc 4.1 that vanish when using older versions of gcc.
>
> AFAIK, until now noone has ever debugged whether that's a gcc bug,
> gcc exposing a kernel bug or gcc exposing a hardware bug.
>
> Comparing your report and [1], it seems that if these are the same
> problem, it's not a hardware bug but a gcc or kernel bug.

This bug specifically indicates some kind of miscompilation in a driver, 
causing boot time hangs. My problem is quite different, and more subtle. The 
crash happens in the same place every time, which does suggest determinism 
(even with various options toggled on and off, and a 300K smaller kernel 
image), but it takes 8-12 hours to manifest and only happens with GCC 4.1.1.

Unless we can start narrowing this down, it would be a mammoth task to seek 
out either the kernel or GCC change that first exhibited this bug, due to the 
non-immediate reproducibility of the bug, the lack of clues, and this 
machine's role as a stable, high-availability server.

(If I had another Epia M10000 or another computer I could reproduce the bug 
on, I would be only too happy to boot as many kernels as required to fix it; 
however I cannot spare this machine).

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
