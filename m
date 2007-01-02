Return-Path: <linux-kernel-owner+w=401wt.eu-S964921AbXABVKo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbXABVKo (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:10:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964986AbXABVKo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:10:44 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:2630 "HELO
	mailout.stusta.mhn.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964921AbXABVKn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:10:43 -0500
Date: Tue, 2 Jan 2007 22:10:45 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Cc: "Zhang, Yanmin" <yanmin_zhang@linux.intel.com>,
       LKML <linux-kernel@vger.kernel.org>, Greg KH <greg@kroah.com>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: kernel + gcc 4.1 = several problems
Message-ID: <20070102211045.GY20714@stusta.de>
References: <200612201421.03514.s0348365@sms.ed.ac.uk> <200612301659.35982.s0348365@sms.ed.ac.uk> <20061231162731.GK20714@stusta.de> <200612311655.51928.s0348365@sms.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200612311655.51928.s0348365@sms.ed.ac.uk>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2006 at 04:55:51PM +0000, Alistair John Strachan wrote:
> On Sunday 31 December 2006 16:27, Adrian Bunk wrote:
> > On Sat, Dec 30, 2006 at 04:59:35PM +0000, Alistair John Strachan wrote:
> > > On Thursday 28 December 2006 04:14, Alistair John Strachan wrote:
> > > > On Thursday 28 December 2006 04:02, Alistair John Strachan wrote:
> > > > > On Thursday 28 December 2006 02:41, Zhang, Yanmin wrote:
> > > > > [snip]
> > > > >
> > > > > > > Here's a current decompilation of vmlinux/pipe_poll() from the
> > > > > > > running kernel, the addresses have changed slightly. There's no
> > > > > > > xchg there either:
> > > > > >
> > > > > > Could you reproduce the bug by the new kernel, so we could get the
> > > > > > exact address and instruction of the bug?
> > > > >
> > > > > It crashed again, but this time with no output (machine locked
> > > > > solid). To be honest, the disassembly looks right (it's like Chuck
> > > > > said, it's jumping back half way through an instruction):
> > > > >
> > > > > c0156f5f:       3b 87 68 01 00 00       cmp    0x168(%edi),%eax
> > > > >
> > > > > So c0156f60 is 87 68 01 00 00..
> > > > >
> > > > > This is with the GCC recompile, so it's not a distro problem. It
> > > > > could still either be GCC 4.x, or a 2.6.19.1 specific bug, but it's
> > > > > serious. 2.6.19 with GCC 3.4.3 is 100% stable.
> > > >
> > > > Looks like a similar crash here:
> > > >
> > > > http://ubuntuforums.org/showthread.php?p=1803389
> > >
> > > I've eliminated 2.6.19.1 as the culprit, and also tried toggling
> > > "optimize for size", various debug options. 2.6.19 compiled with GCC
> > > 4.1.1 on an Via Nehemiah C3-2 seems to crash in pipe_poll reliably,
> > > within approximately 12 hours.
> > >
> > > The machine passes 6 hours of Prime95 (a CPU stability tester), four
> > > memtest86 passes, and there are no heat problems.
> > >
> > > I have compiled GCC 3.4.6 and compiled 2.6.19 with an identical config
> > > using this compiler (but the same binutils), and will report back if it
> > > crashes. My bet is that it won't, however.
> >
> > There are occasional reports of problems with kernels compiled with
> > gcc 4.1 that vanish when using older versions of gcc.
> >
> > AFAIK, until now noone has ever debugged whether that's a gcc bug,
> > gcc exposing a kernel bug or gcc exposing a hardware bug.
> >
> > Comparing your report and [1], it seems that if these are the same
> > problem, it's not a hardware bug but a gcc or kernel bug.
> 
> This bug specifically indicates some kind of miscompilation in a driver, 
> causing boot time hangs. My problem is quite different, and more subtle. The 
> crash happens in the same place every time, which does suggest determinism 
> (even with various options toggled on and off, and a 300K smaller kernel 
> image), but it takes 8-12 hours to manifest and only happens with GCC 4.1.1.
>...

Sorry if my point goes a bit away from your problem:

My point is that we have several reported problems only visible
with gcc 4.1.

Other bug reports are e.g. [2] and [3], but they are only present with
using gcc 4.1 _and_ using -Os.

There's simply a bunch of bugs only present with gcc 4.1, and what 
worries me most is that the estimated number of unknown cases is most 
likely very high since most people won't check different compiler 
versions when running into a problem.

> Cheers,
> Alistair.

cu
Adrian

[1] http://bugzilla.kernel.org/show_bug.cgi?id=7176
[2] http://bugzilla.kernel.org/show_bug.cgi?id=7106
[3] https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=186852

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

