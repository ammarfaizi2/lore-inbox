Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263039AbTB0KX1>; Thu, 27 Feb 2003 05:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263137AbTB0KX0>; Thu, 27 Feb 2003 05:23:26 -0500
Received: from meryl.it.uu.se ([130.238.12.42]:58506 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id <S263039AbTB0KX0>;
	Thu, 27 Feb 2003 05:23:26 -0500
From: Mikael Pettersson <mikpe@user.it.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15965.59765.899035.587763@gargle.gargle.HOWL>
Date: Thu, 27 Feb 2003 11:33:25 +0100
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Ion Badulescu <ionut@badula.org>,
       Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: [BUG] 2.5.63: ESR killed my box!
In-Reply-To: <10510000.1046306748@[10.10.2.4]>
References: <Pine.LNX.4.44.0302261559170.3527-100000@home.transmeta.com>
	<10510000.1046306748@[10.10.2.4]>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin J. Bligh writes:
 > maybe change this bit in trap_init:
 > 
 > @@ -665,7 +665,6 @@
 >  	}
 >  	set_bit(X86_FEATURE_APIC, boot_cpu_data.x86_capability);
 >  	mp_lapic_addr = APIC_DEFAULT_PHYS_BASE;
 > -	boot_cpu_physical_apicid = 0;
 >  	if (nmi_watchdog != NMI_NONE)
 >  		nmi_watchdog = NMI_LOCAL_APIC;
 >  
 > to do:
 > 
 > boot_cpu_physical_apicid = hard_smp_processor_id();
 > phys_cpu_present_map = 1 << boot_cpu_physical_apicid;

I assume you meant detect_init_APIC().
No, you can't do any apic reads (which is what hard_smp_processor_id() does)
at this point since the local APIC isn't mapped yet. That happens shortly
after this, in init_apic_mappings()' set_fixmap_nocache() call.

/Mikael
