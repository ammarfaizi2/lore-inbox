Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261446AbSKGQge>; Thu, 7 Nov 2002 11:36:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261447AbSKGQge>; Thu, 7 Nov 2002 11:36:34 -0500
Received: from modemcable191.130-200-24.mtl.mc.videotron.ca ([24.200.130.191]:33801
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S261446AbSKGQgc>; Thu, 7 Nov 2002 11:36:32 -0500
Date: Thu, 7 Nov 2002 11:41:23 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5-AC] Forced enable/disable local APIC
In-Reply-To: <15818.37221.445746.346901@kim.it.uu.se>
Message-ID: <Pine.LNX.4.44.0211071140310.27141-100000@montezuma.mastecende.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Nov 2002, Mikael Pettersson wrote:

> Zwane Mwaikambo writes:
>  > +int enable_local_apic_flag __initdata = 0; /* 0=probe, 1=force, 2=disable e.g. DMI */
> ...
>  > +	if (enable_local_apic_flag == 1)
>  > +		goto force_apic;
>  >  
>  >  	switch (boot_cpu_data.x86_vendor) {
>  >  	case X86_VENDOR_AMD:
>  > @@ -642,6 +661,7 @@
>  >  		goto no_apic;
>  >  	}
>  >  
>  > +force_apic:
>  >  	if (!cpu_has_apic) {
>  >  		/*
>  >  		 * Some BIOSes disable the local APIC in the
> 
> Of what use is the force case? If someone boots with "lapic" on a CPU
> where the APIC feature bit is off, then the code will rdmsr/wrmsr on
> APICBASE, even though we (the kernel) haven't verified that the CPU
> actually has that MSR. This is doubleplusungood.

We still honour the APIC feature bit, its just that we bypass the cpuid 
checks. Looks sane no?

	Zwane
-- 
function.linuxpower.ca

