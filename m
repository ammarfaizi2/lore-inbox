Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265275AbSLVUNc>; Sun, 22 Dec 2002 15:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbSLVUNc>; Sun, 22 Dec 2002 15:13:32 -0500
Received: from eamail1-out.unisys.com ([192.61.61.99]:13980 "EHLO
	eamail1-out.unisys.com") by vger.kernel.org with ESMTP
	id <S265275AbSLVUNa>; Sun, 22 Dec 2002 15:13:30 -0500
Message-ID: <3FAD1088D4556046AEC48D80B47B478C1AEC74@usslc-exch-4.slc.unisys.com>
From: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
To: "'William Lee Irwin III'" <wli@holomorphy.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>,
       Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       John Stultz <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>
Subject: RE: [PATCH][2.4]  generic support for systems with more than 8 CP
	Us (2/2)
Date: Sun, 22 Dec 2002 14:21:15 -0600
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 2/2 : switching to physical mode APIC setup in case of more than 8 CPU
system
[...]
>> -	printk("Enabling APIC mode: ");
>> -	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
>> -		printk("Clustered Logical.	");
>> -	else if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
>> -		printk("Physical.	");
>> -	else
>> -		printk("Flat.	");
>> -	printk("Using %d I/O APICs\n",nr_ioapics);

>IIRC NUMA-Q can be dynamically detected at boot by means of an MP OEM
>table's presence, in particular if there's a matching string in the 8B
>OEM record in the OEM table, with a value of "IBM NUMA" IIRC. This is
>probably a line or two's worth of change to mpparse.c and declaring a
>variable for clustered_apic_mode. If it were difficult to detect, I
>wouldn't have suggested implementing it (though do so at your leisure). =)

The format for the OEM table is pretty much freelance. ES7000 uses it in the
most informal way. However, we need information from this table to switch to
APIC mode, start CPUs, etc. To have the hook for OEM tables in MP parsing
(and in ACPI, for that matter) seems pretty natural. Or if reading of the
OEM table could also be done in more generic way so other platforms had
chance to read their tables seamlessly...

Also, could the clustered_logical and clustered_physical modes be
implemented as a primary item, with NUMA being a secondary with the set of
its unique features on top of the certain APIC mode? This way, a clustered
mode for the APIC could be selectable without NUMA. CLUSTERED_APIC_NUMAQ
could be still an option with an appropriate clustered mode defined. 

--Natalie

>I still think this is 2.5 material + backport once it gets testing there.


>Bill
