Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269388AbRHGTkt>; Tue, 7 Aug 2001 15:40:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269380AbRHGTkj>; Tue, 7 Aug 2001 15:40:39 -0400
Received: from scfdns01.sc.intel.com ([143.183.152.25]:29434 "EHLO
	clio.sc.intel.com") by vger.kernel.org with ESMTP
	id <S269375AbRHGTkW>; Tue, 7 Aug 2001 15:40:22 -0400
Message-ID: <4148FEAAD879D311AC5700A0C969E89006CDE025@orsmsx35.jf.intel.com>
From: "Grover, Andrew" <andrew.grover@intel.com>
To: "'Dave Jones'" <davej@suse.de>, Nico Schottelius <nicos@pcsystems.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: cpu not detected(x86)
Date: Tue, 7 Aug 2001 12:40:01 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dave Jones [mailto:davej@suse.de]
> Speedstep is voodoo. No-one other than Intel have knowledge of
> how it works. On my P3-700 I've seen speeds range from as low
> as 2MHz[1] -> 266MHz (using an ACPI kernel), and the 550/700 on APM.
> I've also seen other laptops do speed scaling between 2MHz->full clock
> speed whilst on APM.

SpeedStep only drops it to 550 MHz. Any further drops are because of ACPI
processor power or thermal management throwing off your program, because the
current Linux gettimeofday code doesn't think the TSC is ever halted. But,
it is, when the processor is put into C2 or C3. Any benchmark which 1) uses
the TSC and 2) does a sleep() will be wrong.

So, you might try a couple things:

1) Config out the ACPI CPU code. Without it, the system will only exec
"hlt", and the TSC keeps running.

2) Keep the CPU 100% busy throughout the duration of your benchmark.

Longer-term, we need to change the kernel to not use the TSC for udelay, but
to use the PM Timer, if ACPI is going to be monkeying with CPU power states.

Regards -- Andy

PS Your system may also be throttling. It throttles in 12.5% increments, so
that should be borne out in the MHz number if that's what it is doing.


> 
> Run the MHz tester (URL below), and put the box under some load.
> It should increase the MHz accordingly.  How high it goes seems
> to depend on how good your BIOS support for it is.
> 
> Also try switching between ACPI & APM kernels, to see what
> difference it makes.
> 
> regards,
> 
> Dave.
> 
> [1] Actually slower than this, the MHz calculation code takes some
> cycles, so it's an estimate only. http://www.codemonkey.org.uk/MHz.c
> 
> -- 
> | Dave Jones.        http://www.suse.de/~davej
> | SuSE Labs
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
