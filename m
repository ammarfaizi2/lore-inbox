Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSJYR4X>; Fri, 25 Oct 2002 13:56:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261520AbSJYR4X>; Fri, 25 Oct 2002 13:56:23 -0400
Received: from harpo.it.uu.se ([130.238.12.34]:28880 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S261518AbSJYR4W>;
	Fri, 25 Oct 2002 13:56:22 -0400
Date: Fri, 25 Oct 2002 20:02:36 +0200 (MET DST)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200210251802.UAA18166@harpo.it.uu.se>
To: linux-kernel@vger.kernel.org, minyard@acm.org
Subject: Re: NMI watchdog not ticking at the right intervals
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 Oct 2002 09:09:10 -0500, Corey Minyard wrote:
>As I have been working on my NMI patch, I have noticed that the NMI 
>watchdog does not seem to be ticking correctly.  I've tried 2.4 and 2.5 
>kernels, and I get the same results.  From my reading of the code, it 
>should tick once a second.  However, I have had the time between ticks 
>vary from around 33 to over 100 seconds.  Tbe time between ticks is 
>different on every boot, but is consistent once booted.  Is there some 
>divider register that's not getting initialized?
>
>Here's my cpuinfo:
>
>processor    : 0
>cpu_package    : 0
>vendor_id    : GenuineIntel
>cpu family    : 6
>model        : 11
>model name    : Intel(R) Pentium(R) III Mobile CPU      1066MHz

(Me thinks "speedstep?")

Do you boot with nmi_watchdog=1 or 2?
The perfctr + local-APIC driven NMI watchdog is dependent
on the CPU's clock frequency. If this changes, the NMI rate
will change accordingly.

The NMI rate may also be affected by APM/ACPI and how often
the kernel executes HLT.

/Mikael
