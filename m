Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278084AbRJVIDn>; Mon, 22 Oct 2001 04:03:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278080AbRJVIDe>; Mon, 22 Oct 2001 04:03:34 -0400
Received: from zero.tech9.net ([209.61.188.187]:15114 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S278084AbRJVIDW>;
	Mon, 22 Oct 2001 04:03:22 -0400
Subject: Re: Linux 2.4.12-ac5
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Udo A. Steinberg" <reality@delusion.de>, Dave Jones <davej@suse.de>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        laughing@shared-source.org
In-Reply-To: <E15va55-00017E-00@the-village.bc.nu>
In-Reply-To: <E15va55-00017E-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 22 Oct 2001 04:03:47 -0400
Message-Id: <1003737827.1712.39.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2001-10-22 at 04:05, Alan Cox wrote:
> > You aren't crazy, it doesn't build here either.  The problem is that
> > fixmap.h only includes those defines if CONFIG_IO_APIC is defined. 
> > Well, I don't have use IO_APIC (I am UP) but I do define
> > CONFIG_X86_APIC.  So it does not compile.
> 
> Ahah that would make sense.

Looking over the code it just seems like some ifdefs need sprinkling...
for the time being I just disabled CONFIG_X86_UP_APIC here.

> > So, the problem is that acpitable.c assumes you have both CONFIG_IO_APIC
> > and CONFIG_X86_APIC declared.  It shouldn't.  Even more important, why
> > is my system compiling acpitable.c now?  I don't compile anything to do
> > with ACPI.  What needs access to the ACPI tables via Mini-ACPI, now?
> 
> It is needed for a small number of certain newer SMP systems, and
> potentially a lot more stuff in the near future.

Can it be made a config setting? "Use ACPI to determine irq routing or
whatever" ... it can even default to on.  One good thing to note is that
it is all init/initdata, but its still a bloat of the kernel image.

	Robert Love

