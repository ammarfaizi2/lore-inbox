Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292730AbSELIEB>; Sun, 12 May 2002 04:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310435AbSELIEA>; Sun, 12 May 2002 04:04:00 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:62704 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S292730AbSELID7>;
	Sun, 12 May 2002 04:03:59 -0400
Message-ID: <3CDE21CF.61245C24@mvista.com>
Date: Sun, 12 May 2002 01:03:27 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Russell King <rmk@arm.linux.org.uk>,
        Linus Torvalds <torvalds@transmeta.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: 64-bit jiffies, a better solution take 2 (Fix ARM)
In-Reply-To: <3CDD5570.E7E97205@mvista.com> <Pine.LNX.4.44.0205111034400.2355-100000@home.transmeta.com> <20020511191118.F1574@flint.arm.linux.org.uk> <3CDD6DA1.7B259EF1@mvista.com> <20020511201748.G1574@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
> 
> On Sat, May 11, 2002 at 10:37:39AM -0700, Linus Torvalds wrote:
> > On Sat, 11 May 2002, george anzinger wrote:
> > >
> > > So, what to do?  For ARM and MIPS we could go back to solution 1:
> >
> > Why not just put that knowledge in the ARM/MIPS architecture makefile?
> >
> > ARM already has multiple linker scripts, and it already selects on them
> > based on CONFIG options, so I'd much rather just do that straightforward
> > kind of thing than play any clever games.
> 
> So would I - there will be a config option, so we can just use sed on the
> relevant linker script to do the right thing.
> 
> --
> Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
>              http://www.arm.linux.org.uk/personal/aboutme.html

Ok, here is the change to move ARM to little endian (apply after take 2):

diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.15-kb2/arch/arm/vmlinux-armo.lds.in linux/arch/arm/vmlinux-armo.lds.in
--- linux-2.5.15-kb2/arch/arm/vmlinux-armo.lds.in	Sun May 12 00:54:48 2002
+++ linux/arch/arm/vmlinux-armo.lds.in	Sun May 12 00:57:01 2002
@@ -4,7 +4,7 @@
  */
 OUTPUT_ARCH(arm)
 ENTRY(stext)
-jiffies = jiffies_64 + 4;
+jiffies = jiffies_64;
 SECTIONS
 {
 	. = TEXTADDR;
diff -urP -I \$Id:.*Exp \$ -X /usr/src/patch.exclude linux-2.5.15-kb2/arch/arm/vmlinux-armv.lds.in linux/arch/arm/vmlinux-armv.lds.in
--- linux-2.5.15-kb2/arch/arm/vmlinux-armv.lds.in	Sun May 12 00:54:48 2002
+++ linux/arch/arm/vmlinux-armv.lds.in	Sun May 12 00:57:16 2002
@@ -4,7 +4,7 @@
  */
 OUTPUT_ARCH(arm)
 ENTRY(stext)
-jiffies = jiffies_64 + 4;
+jiffies = jiffies_64;
 SECTIONS
 {
 	. = TEXTADDR;

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Real time sched:  http://sourceforge.net/projects/rtsched/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml
