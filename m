Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261212AbUKWDFi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261212AbUKWDFi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 22:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262500AbUKWDEI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 22:04:08 -0500
Received: from fmr16.intel.com ([192.55.52.70]:62866 "EHLO
	fmsfmr006.fm.intel.com") by vger.kernel.org with ESMTP
	id S261212AbUKWCtA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 21:49:00 -0500
Subject: Re: why use ACPI (Re: 2.6.10-rc2 doesn't boot (if no floppy
	device))
From: Len Brown <len.brown@intel.com>
To: Adrian Bunk <bunk@stusta.de>, Dave Jones <davej@redhat.com>
Cc: Chris Wright <chrisw@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041123013720.GA4371@stusta.de>
References: <20041115152721.U14339@build.pdx.osdl.net>
	 <1100819685.987.120.camel@d845pe> <20041118230948.W2357@build.pdx.osdl.net>
	 <1100941324.987.238.camel@d845pe> <20041120124001.GA2829@stusta.de>
	 <1101148138.20008.6.camel@d845pe> <20041123004619.GQ19419@stusta.de>
	 <1101172056.20006.153.camel@d845pe>  <20041123013720.GA4371@stusta.de>
Content-Type: text/plain
Organization: 
Message-Id: <1101178052.20007.196.camel@d845pe>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 22 Nov 2004 21:47:32 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-22 at 20:37, Adrian Bunk wrote:
> On Mon, Nov 22, 2004 at 08:07:36PM -0500, Len Brown wrote:
> > On Mon, 2004-11-22 at 19:46, Adrian Bunk wrote:

> 
> My old desktop computer (with a VIA MVP3 chipset and an AMD K6 cpu)
> I bought in 1998 did power off fine under Linux using APM.

I stand corrected.  ACPI wasn't widely deployed until 1998, so I expect
everything at that time was APM.  grepping my logs for more modern
systems, I see APM still in many of the laptops, about half the
desktops, and none of the servers -- YMMV.

> > Enabling IOAPIC is one that a lot of people like, because it results
> in
> > less interrupt sharing and better performance than PIC mode.  But if
> you
> > don't load your system much you may not notice any difference.
> 
> I saw
> 
>   kernel: APIC error on CPU0: 00(02)
> ...
>   kernel: APIC error on CPU0: 02(02)
> 
> on my computer and decided disabling APIC was the easiest way to solve
> them...

yup, this is common on some hardware.

Frankly, I don't know if it is something to be concerned about if you
don't see it that much, but if the hardware loses interrupts when the
IOAPIC is enabled, then disabling it is a reasonable workaround.

> > Next people tend to notice fan speed, because they can hear it.
> > If you load processor and thermal, you'll probably see some
> > /proc/acpi/thermal/thermal_zone/*/temperature and you'll
> > probably find that it stays lower if you keep processor
> > loaded versus when you do not.
> 
> /proc/acpi/thermal/thermal_zone is empty on my computer.
> 
> > This is usually because of power-saving c-csates in idle,
> > which you can observe in /proc/acpi/processor/*/power
> > and the higher the C-state, the more power you save.
> 
> active state:            C1
> default state:           C1
> bus master activity:     00000000
> states:
>    *C1:                  promotion[--] demotion[--] latency[000]
> usage[00000000]
>     C2:                  <not supported>
>     C3:                  <not supported>
> 

You'll get C1 even without ACPI, so ACPI processor driver doesn't give
you any additional power savings c-states on this hardware.

> > Also, CPUFREQ usually often on ACPI, and that can save
> > power even when the system is not idle, and this results
> > in lower temperatures and hopefully slower fan speeds.
> 
> My computer has a desktop Athlon...

maybe Dave can determine if there is a governor that can help you.

cheers,
-Len


