Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUAPCJn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 21:09:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263185AbUAPCJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 21:09:43 -0500
Received: from modemcable178.89-70-69.mc.videotron.ca ([69.70.89.178]:59008
	"EHLO montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S262730AbUAPCJm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 21:09:42 -0500
Date: Thu, 15 Jan 2004 21:08:56 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Gaspar Bakos <gbakos@cfa.harvard.edu>
cc: Linux Kernel <linux-kernel@vger.kernel.org>, peb@mppmu.mpg.de
Subject: Re: SMP kernel, only single processor appears (fwd)
In-Reply-To: <Pine.LNX.4.58.0401152040060.4208@montezuma.fsmlabs.com>
Message-ID: <Pine.LNX.4.58.0401152104020.4208@montezuma.fsmlabs.com>
References: <Pine.SOL.4.58.0401151807310.9382@antu.cfa.harvard.edu>
 <Pine.LNX.4.58.0401152040060.4208@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jan 2004, Zwane Mwaikambo wrote:

> On Thu, 15 Jan 2004, Gaspar Bakos wrote:
> >
> > I have an Intel 7505VB2 dual Xeon motherboard with 2x2.66GHz CPUs, Redhat
> > 9.0 and self-compiled 2.4.23 kernel. Interestingly, I see only one CPU
> > with e.g. "top", or cat /proc/cpuinfo, etc.
> >
> > I have to tell though that I installed this system by cloning the disk of
> > another PC, which is running a single processor; then booting in the dual
> > processor computer from the cloned disk (with a bootfloppy), and then
> > recompiling the kernel (and rebooting to the new SMP enabled kernel).
> > Seems to me that this is not enough, and I might have missed something.
> >
> > Any advice would be welcome.
>
> This looks like you have 2 physical processors. Perhaps you don't have
> hyperthreading enabled, i presume you want 4 logical processors. Try the
> "acpi=ht" kernel parameter.

Sorry i mis-parsed your email in my haste. Could you try the following
patch (Courtesy of Peter Breitenlohner)

--- linux-2.4.23/include/asm-i386/smpboot.h.orig	2003-08-25 13:44:43.000000000 +0200
+++ linux-2.4.23/include/asm-i386/smpboot.h	2003-12-02 16:49:46.000000000 +0100
@@ -73,11 +73,9 @@
  */
 static inline int cpu_present_to_apicid(int mps_cpu)
 {
-	if (clustered_apic_mode == CLUSTERED_APIC_XAPIC)
-		return raw_phys_apicid[mps_cpu];
 	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
 		return (mps_cpu/4)*16 + (1<<(mps_cpu%4));
-	return mps_cpu;
+	return raw_phys_apicid[mps_cpu];
 }

 static inline unsigned long apicid_to_phys_cpu_present(int apicid)
