Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261398AbSKGQV7>; Thu, 7 Nov 2002 11:21:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261399AbSKGQV7>; Thu, 7 Nov 2002 11:21:59 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:29361 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S261398AbSKGQV6>; Thu, 7 Nov 2002 11:21:58 -0500
Date: Thu, 7 Nov 2002 17:25:45 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: Zwane Mwaikambo <zwane@holomorphy.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH][2.5-AC] Forced enable/disable local APIC
In-Reply-To: <15818.37221.445746.346901@kim.it.uu.se>
Message-ID: <Pine.GSO.3.96.1021107171944.5894F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
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

 The assumption is a user knows better what he wants to achieve.  But I'm
not sure we really need it here.  A DMI override with the APICBASE
availability test in place should suffice -- I'd remove the "goto". 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

