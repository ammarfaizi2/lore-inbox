Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261354AbTAMPGD>; Mon, 13 Jan 2003 10:06:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261356AbTAMPGD>; Mon, 13 Jan 2003 10:06:03 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:5505 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S261354AbTAMPGC>; Mon, 13 Jan 2003 10:06:02 -0500
Date: Mon, 13 Jan 2003 16:11:59 +0100
From: Dominik Brodowski <linux@brodo.de>
To: Alessandro Suardi <ALESSANDRO.SUARDI@oracle.com>
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.5.55 failed to boot with ACPI support
Message-ID: <20030113151159.GA10921@brodo.de>
References: <7071726.1042419087751.JavaMail.nobody@web55.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7071726.1042419087751.JavaMail.nobody@web55.us.oracle.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Sun, Jan 12, 2003 at 04:51:27PM -0800, Alessandro Suardi wrote:
> Dominik Brodowski wrote:
> 
> > On Mon, Jan 13, 2003 at 12:04:02AM +0100, Alessandro Suardi wrote:
> > > Andrew Grover wrote:
> > > 
> > > > > From: Ole J. Hagen [mailto:olehag_2001@yahoo.no] 
> > > > > I just wanted to inform that kernel-2.5.55 failes to boot 
> > > > > when ACPI support is 
> > > > > compiled in the kernel. 
> > > > > 
> > > > > I have following configuration; Dell Optiplex GX-240, Pentium 
> > > > > 4 (1.5 GHz), ATI RAGE 128.
> > > >
> > > > How exactly does it fail?
> > > 
> > > My brand new Dell Latitude C640 oopses on boot in 2.5.56 if I
> > >  have CPU_FREQ config'd in. ACPI without CPU_FREQ is okay - well,
> > >  it screws my framebuffer screen (what 2.4.21-pre3 doesn't) when
> > >  the ACPI code does its bootup printk's, but after that the
> > >  screen recovers.
> > >
> > > ...
> > >
> > > Back on topic, if you're interested I can rebuild my 2.5.56 with
> > >  CPU_FREQ and write down the backtrace of the oops.
> > Would be great if you could do that - and tell what oops it is (NULL pointer
> > dereference etc.), in case you still see that on your screen.
> 
> Sigh :(
> 
> Rebuilt with CPU_FREQ, doesn't oops.

:)

> It says
> 
> cpufreq: Intel(R) SpeedStep(TM) for this processor not (yet) available
> 
> Is the above message expected ? The CPU is a 1.8Ghz mobile P4.

2.5.56, you say... let me check... yep, then this patch is missing (it's in
2.5.56-bk). Could you send me a /proc/cpuinfo, please? Especially if this
patch doesn't work :)

	Dominik

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-10 21:55:28.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-10 22:13:33.000000000 +0100
@@ -447,7 +447,7 @@
 		if (c->x86_model != 2)
 			return 0;
 
-		if (c->x86_mask != 4)
+		if ((c->x86_mask != 4) && (c->x86_mask != 7))
 			return 0;
 
 		ebx = cpuid_ebx(0x00000001);



