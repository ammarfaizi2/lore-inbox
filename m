Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265414AbSLVV2v>; Sun, 22 Dec 2002 16:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265437AbSLVV2u>; Sun, 22 Dec 2002 16:28:50 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:51374 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S265414AbSLVV2u>; Sun, 22 Dec 2002 16:28:50 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C1AEC76@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'Martin J. Bligh'" <mbligh@aracnet.com>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.4]  generic support for systems with more than 8 CP
		Us (2/2)
Date: Sun, 22 Dec 2002 15:36:36 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The format for the OEM table is pretty much freelance. ES7000 uses it in
> the most informal way. However, we need information from this table to
> switch to APIC mode, start CPUs, etc. To have the hook for OEM tables in
> MP parsing (and in ACPI, for that matter) seems pretty natural. Or if
> reading of the OEM table could also be done in more generic way so other
> platforms had chance to read their tables seamlessly...

>Support for parsing the mps oem tables is already there - I use it for
>NUMA-Q ... see if smp_read_mpc_oem will do what you want ... if not,
>maybe we can generalise it out.

Never mind: I just looked closer into the patch - magic - mpc_oem_check()
does just this! 
I apologize for missing this on the first read. Was in a hurry to get to
Christmas shopping :-)

I have to say that the mechanism developed in the patch looks perfect for
ES7000 case. 
I just need to catch up and digest it ASAP so I won't go again down the road
you already went...

>In the last patch from Venkatesh there was a > 8CPUs option ... that
>seems like a direct correlation to clustered apic support to me ...
>maybe we could just switch on CONFIG_X86_CLUSTERED_APIC directly and
>bypass CONFIG_X86_MANY_CPU? The menu text could stay the same (less
>confusing for users than asking them about apic modes) ...

Maybe, for other systems MANY_CPU criteria would make sense, but it won't
work for us: on ES7000s with Fosters/Gallatins, we can run 1 to 32 CPUs and
have to be in flat clustered mode in any case - whether we run 2 do 32 of
them... This is also true for Cascades running on hierarchical cluster
(logical). Our APIC ID's are hard-coded topologically in the BIOS, so we
could run 2 processors on the high end of topology, with high APIC IDs. We
couldn't get around using just ID's (not the EID's), because hardware needs
the full CPU ID address to deliver IPIs.

>M.

