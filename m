Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289018AbSAUDDW>; Sun, 20 Jan 2002 22:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289017AbSAUDDL>; Sun, 20 Jan 2002 22:03:11 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:6928 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289020AbSAUDCw>; Sun, 20 Jan 2002 22:02:52 -0500
Message-ID: <3C4B8362.8B249698@zip.com.au>
Date: Sun, 20 Jan 2002 18:56:34 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: Your message of "Sun, 20 Jan 2002 18:04:00 -0800."
	             <3C4B7710.6C518006@zip.com.au> <324.1011579918@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 20 Jan 2002 18:04:00 -0800,
> Andrew Morton <akpm@zip.com.au> wrote:
> >ksymoops doesn't know what modules were loaded at the time
> >of the crash, and it doesn't know where they were loaded.
> 
> /var/log/ksymoops.  man insmod and look for ksymoops assistance.

Oh I have, extensively, when trying to get kgdb to play with
modules.  I did what any sensible person would do: gave up and went
for a static link.

I'm not aware of anyone getting kgdb working fully with modules.

> >The `klogd -x' problem has been with us for *years* and
> >distributors still persist in turning it on.
> 
> Tell me about it :(.
> 
> >It assumes too much.  Arjan has a kksymoops thingy which does the symbol
> >resolution at crash-time.
> 
> It can only get symbols that are in /proc/ksyms, i.e. the exported
> symbols.  Proper crash analysis needs the full symbol table.

Proper crash analysis needs to know the load address of each module
at the time of the crash.  We should print them out at Oops time.

> >It also
> >handles the common case where the running vmlinux/System.map/etc no longer
> >exist.
> 
> So does ksymoops, with reduced detail because it only has exported
> symbols.
> 
> >I would prefer that all this become easier, simpler and more reliable.
> >We need a damn good reason for deprecating statically linked kernels
> >and certainly none has been presented yet.
> 
> That is a different problem.  Saying that modular kernels cause
> problems for debugging is not a good enough reason to deprecate modular
> kernels, all the problems have been solved.

They are patently *not* solved, because we continue to get a
stream of partially and competely useless oops reports.  It
is my empirical observation that this problem is worse when
modules are involved.  It is my personal experience that
modular code is harder to debug.

It is also my personal experience that the refusal of sbp2.o to
work correctly when statically linked was a complete pain in the
ass when trying to diagnose its deadlock and module refcount
problems.  It was only when I worked out that I could link it
statically and then get it to play via rescan-scsi-bus.sh that
I was able to make reasonably-paced progress in finding the bugs.

We don't want this to happen to every damn driver in the kernel.

-
