Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262865AbVDHQo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262865AbVDHQo5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbVDHQo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:44:57 -0400
Received: from grendel.digitalservice.pl ([217.67.200.140]:49344 "HELO
	mail.digitalservice.pl") by vger.kernel.org with SMTP
	id S262865AbVDHQoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:44:44 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.12-rc2-mm2
Date: Fri, 8 Apr 2005 18:44:57 +0200
User-Agent: KMail/1.7.1
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
References: <20050408030835.4941cd98.akpm@osdl.org> <200504081346.59282.rjw@sisk.pl>
In-Reply-To: <200504081346.59282.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504081844.58200.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 8 of April 2005 13:46, Rafael J. Wysocki wrote:
> On Friday, 8 of April 2005 12:08, Andrew Morton wrote:
> > 
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc2/2.6.12-rc2-mm2/
> > 
> > 
> > - Although small, bk-audit.patch was causing conflits with a couple of
> >   other projects.  Dropped for now.
> > 
> > - Greg is not using bk now, so bk-pci.patch, bk-i2c.patch,
> >   bk-driver-core.patch and bk-usb.patch have been replaced with gregkh-*.patch
> >   in -mm.
> > 
> > - Largeish x86_64 update
> 
> It does not compile on a uniprocessor x86-64:
> 
>   CC      arch/x86_64/kernel/process.o
>   CC      arch/x86_64/kernel/semaphore.o
>   CC      arch/x86_64/kernel/signal.o
>   AS      arch/x86_64/kernel/entry.o
>   CC      arch/x86_64/kernel/traps.o
>   CC      arch/x86_64/kernel/irq.o
>   CC      arch/x86_64/kernel/ptrace.o
>   CC      arch/x86_64/kernel/time.o
>   CC      arch/x86_64/kernel/ioport.o
>   CC      arch/x86_64/kernel/ldt.o
>   CC      arch/x86_64/kernel/setup.o
> arch/x86_64/kernel/setup.c: In function `amd_detect_cmp':
> arch/x86_64/kernel/setup.c:759: error: `cpu_core_id' undeclared (first use in this function)
> arch/x86_64/kernel/setup.c:759: error: (Each undeclared identifier is reported only once
> arch/x86_64/kernel/setup.c:759: error: for each function it appears in.)
> make[1]: *** [arch/x86_64/kernel/setup.o] Error 1
> make: *** [arch/x86_64/kernel] Error 2

A fix follows (I hope it's correct).

Greets,
Rafael


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

--- linux-2.6.12-rc2-mm2-orig/arch/x86_64/kernel/setup.c	2005-04-08 18:38:03.000000000 +0200
+++ linux-2.6.12-rc2-mm2/arch/x86_64/kernel/setup.c	2005-04-08 18:32:41.000000000 +0200
@@ -746,6 +746,7 @@ static void __init display_cacheinfo(str
 	}
 }
 
+#ifdef CONFIG_SMP
 /*
  * On a AMD dual core setup the lower bits of the APIC id distingush the cores.
  * Assumes number of cores is a power of two.
@@ -773,6 +774,11 @@ static void __init amd_detect_cmp(struct
 	printk(KERN_INFO "CPU %d(%d) -> Node %d -> Core %d\n",
 			cpu, c->x86_num_cores, node, cpu_core_id[cpu]);
 }
+#else
+static void __init amd_detect_cmp(struct cpuinfo_x86 *c)
+{
+}
+#endif
 
 static int __init init_amd(struct cpuinfo_x86 *c)
 {

-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"
