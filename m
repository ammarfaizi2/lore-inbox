Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317530AbSFKULE>; Tue, 11 Jun 2002 16:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317531AbSFKULD>; Tue, 11 Jun 2002 16:11:03 -0400
Received: from ool-182d14cd.dyn.optonline.net ([24.45.20.205]:525 "HELO
	osinvestor.com") by vger.kernel.org with SMTP id <S317530AbSFKULB>;
	Tue, 11 Jun 2002 16:11:01 -0400
Date: Tue, 11 Jun 2002 16:10:59 -0400
From: Rob Radez <rob@osinvestor.com>
To: Robert Love <rml@tech9.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CONFIG_NR_CPUS, redux
Message-ID: <20020611161059.N30977@osinvestor.com>
In-Reply-To: <1023817936.21176.232.camel@sinai>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 11, 2002 at 10:52:16AM -0700, Robert Love wrote:
> Andrew has pointed out some architectures may need minor tweaks to work
> with NR_CPUS < 32.  He discovered and fixed a minor issue on i386...
> other architectures, please verify non-standard options work.  Also make

On sparc, setting NR_CPUS to anything other than 32 with CONFIG_SMP set
breaks.  Simple, stupid patch is attached, but there's a more elegant fix to
the actual functions abusing NR_CPUS that just seems much nicer ;-).

And yes, I know, sparc on 2.5 is badly broken, but this just might help keep
the broken-ness down a little bit.

Regards,
Rob Radez

diff -Nru a/include/asm-sparc/smp.h b/include/asm-sparc/smp.h
--- a/include/asm-sparc/smp.h	Tue Jun 11 16:09:48 2002
+++ b/include/asm-sparc/smp.h	Tue Jun 11 16:09:48 2002
@@ -31,7 +31,7 @@
 #include <asm/ptrace.h>
 #include <asm/asi.h>
 
-extern struct prom_cpuinfo linux_cpus[NR_CPUS];
+extern struct prom_cpuinfo linux_cpus[32];
 
 /* Per processor Sparc parameters we need. */
 
