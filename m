Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261457AbSKGQnq>; Thu, 7 Nov 2002 11:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261460AbSKGQnq>; Thu, 7 Nov 2002 11:43:46 -0500
Received: from kim.it.uu.se ([130.238.12.178]:9937 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261457AbSKGQno>;
	Thu, 7 Nov 2002 11:43:44 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15818.39371.311141.742866@kim.it.uu.se>
Date: Thu, 7 Nov 2002 17:50:19 +0100
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Mikael Pettersson <mikpe@csd.uu.se>,
       "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5-AC] Forced enable/disable local APIC
In-Reply-To: <Pine.LNX.4.44.0211071140310.27141-100000@montezuma.mastecende.com>
References: <15818.37221.445746.346901@kim.it.uu.se>
	<Pine.LNX.4.44.0211071140310.27141-100000@montezuma.mastecende.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:
 > On Thu, 7 Nov 2002, Mikael Pettersson wrote:
 > 
 > > Zwane Mwaikambo writes:
 > >  > +int enable_local_apic_flag __initdata = 0; /* 0=probe, 1=force, 2=disable e.g. DMI */
 > > ...
 > >  > +	if (enable_local_apic_flag == 1)
 > >  > +		goto force_apic;
 > >  >  
 > >  >  	switch (boot_cpu_data.x86_vendor) {
 > >  >  	case X86_VENDOR_AMD:
 > >  > @@ -642,6 +661,7 @@
 > >  >  		goto no_apic;
 > >  >  	}
 > >  >  
 > >  > +force_apic:
 > >  >  	if (!cpu_has_apic) {
 > >  >  		/*
 > >  >  		 * Some BIOSes disable the local APIC in the
 > > 
 > > Of what use is the force case? If someone boots with "lapic" on a CPU
 > > where the APIC feature bit is off, then the code will rdmsr/wrmsr on
 > > APICBASE, even though we (the kernel) haven't verified that the CPU
 > > actually has that MSR. This is doubleplusungood.
 > 
 > We still honour the APIC feature bit, its just that we bypass the cpuid 
 > checks. Looks sane no?

No. Read what I wrote: if cpu_has_apic is false, the code drops into
the "try the hard way by messing with the APICBASE MSR". Your "force"
goto bypasses the CPU checks, which are there to ensure that the CPU
actually _has_ an APICBASE MSR.

I still see no reason at all for the force.

/Mikael
