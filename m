Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317020AbSFFRG1>; Thu, 6 Jun 2002 13:06:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317021AbSFFRGZ>; Thu, 6 Jun 2002 13:06:25 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:42664
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317020AbSFFRGV>; Thu, 6 Jun 2002 13:06:21 -0400
Date: Thu, 6 Jun 2002 10:05:03 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Robert Love <rml@tech9.net>
Cc: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] CONFIG_NR_CPUS
Message-ID: <20020606170503.GA14252@opus.bloom.county>
In-Reply-To: <3CFF3504.1DCD24E7@zip.com.au> <20020606.031520.08940800.davem@redhat.com> <1023377213.13787.2.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 06, 2002 at 08:26:52AM -0700, Robert Love wrote:

> On Thu, 2002-06-06 at 03:15, David S. Miller wrote:
>  
> > Nice.  While you're at it can you fix the value on 64-bit
> > platforms when CONFIG_NR_CPUS is not specified?  (it should
> > be 64, not 32)
> 
> I agree, this is good.  I often am toying with some debugging aid that
> is an array of NR_CPUS and waste a lot of memory with NR_CPUS stuck at
> 32... no reason my kernels should not be set to 2 or whatever I need.
> 
> I have attached a patch that is Andrew's + your request, Dave.  Since
> what really determines the maximum number of CPUs is the size of
> unsigned long, I used that.  Cool?

Here's a (compile) tested version for PPC.  arch/ppc/kernel/smp.c makes
much less use of max_cpus, so this should be all that's needed. BTW, on
x86 max_cpus could become __initdata if someone cares..

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


===== arch/ppc/config.in 1.36 vs edited =====
--- 1.36/arch/ppc/config.in	Fri May 24 04:15:43 2002
+++ edited/arch/ppc/config.in	Thu Jun  6 09:30:39 2002
@@ -172,6 +172,7 @@
 bool 'Symmetric multi-processing support' CONFIG_SMP
 if [ "$CONFIG_SMP" = "y" ]; then
    bool '  Distribute interrupts on all CPUs by default' CONFIG_IRQ_ALL_CPUS
+   int  '  Maximum number of CPUs (2-32)' CONFIG_NR_CPUS 32
 fi
 if [ "$CONFIG_SMP" != "y" ]; then
    bool 'Preemptible Kernel' CONFIG_PREEMPT
===== arch/ppc/Config.help 1.10 vs edited =====
--- 1.10/arch/ppc/Config.help	Fri May 24 03:38:05 2002
+++ edited/arch/ppc/Config.help	Thu Jun  6 09:31:04 2002
@@ -14,6 +14,14 @@
 
   If you don't know what to do here, say N.
 
+CONFIG_NR_CPUS
+  This allows you to specify the maximum number of CPUs which this
+  kernel will support.  The maximum supported value is 32 and the
+  mimimum value which makes sense is 2.
+
+  This is purely to save memory - each supported CPU adds
+  approximately eight kilobytes to the kernel image.
+
 CONFIG_PREEMPT
   This option reduces the latency of the kernel when reacting to
   real-time or interactive events by allowing a low priority process to
