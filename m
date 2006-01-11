Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWAKJca@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWAKJca (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 04:32:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbWAKJca
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 04:32:30 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:31449 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751395AbWAKJc3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 04:32:29 -0500
Date: Wed, 11 Jan 2006 15:02:12 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Stephen Hemminger <shemminger@osdl.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Crash with SMP on post 2.6.15 -git kernel
Message-ID: <20060111093212.GA15281@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <20060110165457.42ed2087@dxpl.pdx.osdl.net> <200601110227.30461.ak@suse.de> <20060110184903.790d1a2c@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20060110184903.790d1a2c@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 10, 2006 at 06:49:03PM -0800, Stephen Hemminger wrote:
> On Wed, 11 Jan 2006 02:27:30 +0100
> Andi Kleen <ak@suse.de> wrote:
> 
> > On Wednesday 11 January 2006 01:54, Stephen Hemminger wrote:
> > 6
> > > [   37.047264] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)[   37.070722] CPU: L2 Cache: 1024K (64 bytes/line)
> > > [   37.085894] mtrr: v2.0 (20020519)
> > > [   37.350186] Using local APIC timer interrupts.
> > > [   37.414873] Detected 12.464 MHz APIC timer.
> > > [   37.428717] Booting processor 1/2 APIC 0x1
> > > 
> > > Machine then goes blank and reboots...
> > 

I took the latest git and took your config file and it boots fine on
my dual opteron box. cpuinfo & lspci output atached.

> > Don't know what it could be - I didn't merge anything. Maybe revert the kexec patches?
> I built it without kexec and that had no change.  But perhaps it botched something.
>  

Few x86_64 APIC related kexec changes are still in Andi's tree and have not
been pushed to Linus tree. So there are no new x86_64 kexec patches in latest
git repository.

Andrew has pushed x86_64 kdump related patches to Linus tree. And these become
effective only under CONFIG_CRASH_DUMP. These patches are very less likely
to botch with this stuff.

> > Does the -git6 snapshot still work?  Possibly do a binary search to narrow
> > it down.

I tested -git6 also in the same way and this too boots fine.

> > 
> > -Andi
> 

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=cpuinfo

processor	: 0
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 5
model name	: AMD Opteron(tm) Processor 248
stepping	: 8
cpu MHz		: 2193.506
cache size	: 1024 KB
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips	: 4391.72
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts ttp

processor	: 1
vendor_id	: AuthenticAMD
cpu family	: 15
model		: 5
model name	: AMD Opteron(tm) Processor 248
stepping	: 8
cpu MHz		: 2193.506
cache size	: 1024 KB
fpu		: yes
fpu_exception	: yes
cpuid level	: 1
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 syscall nx mmxext lm 3dnowext 3dnow
bogomips	: 4386.31
TLB size	: 1024 4K pages
clflush size	: 64
cache_alignment	: 64
address sizes	: 40 bits physical, 48 bits virtual
power management: ts ttp


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=lspci

0000:00:06.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8111 PCI (rev 07)
0000:00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-8111 LPC (rev 05)
0000:00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-8111 IDE (rev 03)
0000:00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-8111 ACPI (rev 05)
0000:00:0a.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0a.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:0b.0 PCI bridge: Advanced Micro Devices [AMD] AMD-8131 PCI-X Bridge (rev 12)
0000:00:0b.1 PIC: Advanced Micro Devices [AMD] AMD-8131 PCI-X APIC (rev 01)
0000:00:18.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:18.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.0 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.1 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.2 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:00:19.3 Host bridge: Advanced Micro Devices [AMD] K8 NorthBridge
0000:01:00.0 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:01:00.1 USB Controller: Advanced Micro Devices [AMD] AMD-8111 USB (rev 0b)
0000:01:05.0 VGA compatible controller: ATI Technologies Inc Rage XL (rev 27)
0000:02:01.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
0000:02:01.1 Ethernet controller: Broadcom Corporation NetXtreme BCM5704 Gigabit Ethernet (rev 03)
0000:02:02.0 SCSI storage controller: LSI Logic / Symbios Logic 53c1030 PCI-X Fusion-MPT Dual Ultra320 SCSI (rev 07)

--lrZ03NoBR/3+SXJZ--
