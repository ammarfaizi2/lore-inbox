Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261300AbSKGQH4>; Thu, 7 Nov 2002 11:07:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbSKGQH4>; Thu, 7 Nov 2002 11:07:56 -0500
Received: from kim.it.uu.se ([130.238.12.178]:8913 "EHLO kim.it.uu.se")
	by vger.kernel.org with ESMTP id <S261300AbSKGQH4>;
	Thu, 7 Nov 2002 11:07:56 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15818.37221.445746.346901@kim.it.uu.se>
Date: Thu, 7 Nov 2002 17:14:29 +0100
To: Zwane Mwaikambo <zwane@holomorphy.com>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5-AC] Forced enable/disable local APIC
In-Reply-To: <Pine.LNX.4.44.0211052138060.27141-100000@montezuma.mastecende.com>
References: <Pine.LNX.4.44.0211052138060.27141-100000@montezuma.mastecende.com>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:
 > +int enable_local_apic_flag __initdata = 0; /* 0=probe, 1=force, 2=disable e.g. DMI */
...
 > +	if (enable_local_apic_flag == 1)
 > +		goto force_apic;
 >  
 >  	switch (boot_cpu_data.x86_vendor) {
 >  	case X86_VENDOR_AMD:
 > @@ -642,6 +661,7 @@
 >  		goto no_apic;
 >  	}
 >  
 > +force_apic:
 >  	if (!cpu_has_apic) {
 >  		/*
 >  		 * Some BIOSes disable the local APIC in the

Of what use is the force case? If someone boots with "lapic" on a CPU
where the APIC feature bit is off, then the code will rdmsr/wrmsr on
APICBASE, even though we (the kernel) haven't verified that the CPU
actually has that MSR. This is doubleplusungood.

I have no problem with the disable option.

/Mikael
