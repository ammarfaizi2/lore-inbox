Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289003AbSAUCKg>; Sun, 20 Jan 2002 21:10:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289004AbSAUCK0>; Sun, 20 Jan 2002 21:10:26 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:31500 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S289003AbSAUCKS>; Sun, 20 Jan 2002 21:10:18 -0500
Message-ID: <3C4B7710.6C518006@zip.com.au>
Date: Sun, 20 Jan 2002 18:04:00 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: Linux Kernel Maillist <linux-kernel@vger.kernel.org>
Subject: Re: Hardwired drivers are going away?
In-Reply-To: Your message of "Sun, 20 Jan 2002 17:30:12 -0800."
	             <3C4B6F24.C2750F51@zip.com.au> <32505.1011578008@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On Sun, 20 Jan 2002 17:30:12 -0800,
> Andrew Morton <akpm@zip.com.au> wrote:
> >I suspect none of these "Heads" spend much time in protracted
> >email debug sessions.  Because the *first* thing you do is
> >ask the tester to compile the relevant driver into the
> >kernel.
> >
> >The problems which the removal of this option will cause include:
> >
> >1: Inability to look up symbols in the kernel elf image.
> >2: Breaks the kernel profiler
> >3: breaks kgdb
> >4: breaks ksymoops.
> >
> >How often have we seen nonsensical backtraces here because
> >modules were involved?   Possibly we can include a table
> >of module base addresses in the Oops output and teach ksymoops
> >about it.
> 
> You see nonsensical backtraces because people persist in using the oops
> decode option of klogd which is broken when faced with modules.  Turn
> off klogd oops (klogd -x) and you get a raw backtrace which ksymoops
> can handle.

ksymoops doesn't know what modules were loaded at the time
of the crash, and it doesn't know where they were loaded.

The `klogd -x' problem has been with us for *years* and
distributors still persist in turning it on.


>  Guess why these entries are in /proc/ksyms?
> 
> c48a2300 __insmod_3c589_cs_S.bss_L4     [3c589_cs]
> c48a0000 __insmod_3c589_cs_O/lib/modules/2.4.17-xfs/kernel/drivers/net/pcmcia/3c589_cs.o_M3C332CFF_V132113      [3c589_cs]
> c48a22a0 __insmod_3c589_cs_S.data_L96   [3c589_cs]
> c48a1820 __insmod_3c589_cs_S.rodata_L1152       [3c589_cs]
> c48a0060 __insmod_3c589_cs_S.text_L6064 [3c589_cs]
> 
> ksymoops uses the __insmod entries to work out exactly where each
> module is, it gives an accurate backtrace with modules.  man insmod for
> details.

It assumes too much.  Arjan has a kksymoops thingy which does the symbol
resolution at crash-time.  This seems much more reliable to me.  It also
handles the common case where the running vmlinux/System.map/etc no longer
exist.

> Kernel debuggers like kgdb and kdb use kallsyms which has full support
> for modules.  kgdb can also use the __insmod entries in /proc/ksyms to
> tell gdb where each module was loaded.
> 
> ksymoops has a save map option (-s) which writes out the combined
> system map, including the kernel and all symbols from all modules.
> 
> Sure, a dynamic system requires a little more work, but it has all been
> done.  Just kill the broken klogd code so it stops corrupting log data.

Keith, I have spent a *lot* of time working weird kernel bugs
with people via email.  Usually, things peter out simply because
the other party lacks the expertise or time to keep on doing
things.  So the bug doesn't get fixed.

I would prefer that all this become easier, simpler and more reliable.
We need a damn good reason for deprecating statically linked kernels
and certainly none has been presented yet.

-
