Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265517AbSLWB2q>; Sun, 22 Dec 2002 20:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265543AbSLWB2q>; Sun, 22 Dec 2002 20:28:46 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:26338 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S265517AbSLWB2p> convert rfc822-to-8bit; Sun, 22 Dec 2002 20:28:45 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic support for systems with more than 8 CPUs (2/2)
Date: Sun, 22 Dec 2002 17:36:46 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E1B7@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-MS-Has-Attach: 
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic support for systems with more than 8 CPUs (2/2)
Thread-Index: AcKptC2gVKvIWhWnEdeo8gBQi2jWzAAbt54Q
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "William Lee Irwin III" <wli@holomorphy.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
X-OriginalArrivalTime: 23 Dec 2002 01:36:47.0363 (UTC) FILETIME=[C1E8C530:01C2AA23]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: William Lee Irwin III [mailto:wli@holomorphy.com]
> 
> On Sat, Dec 21, 2002 at 10:59:10PM -0800, Pallipadi, Venkatesh wrote:
> > 2/2 : switching to physical mode APIC setup in case of more 
> than 8 CPU system
> [...]
> > -	printk("Enabling APIC mode: ");
> > -	if(clustered_apic_mode == CLUSTERED_APIC_NUMAQ)
> > -		printk("Clustered Logical.	");
> > -	else if(clustered_apic_mode == CLUSTERED_APIC_XAPIC)
> > -		printk("Physical.	");
> > -	else
> > -		printk("Flat.	");
> > -	printk("Using %d I/O APICs\n",nr_ioapics);
> 
> IIRC NUMA-Q can be dynamically detected at boot by means of an MP OEM
> table's presence, in particular if there's a matching string in the 8B
> OEM record in the OEM table, with a value of "IBM NUMA" IIRC. This is
> probably a line or two's worth of change to mpparse.c and declaring a
> variable for clustered_apic_mode. If it were difficult to detect, I
> wouldn't have suggested implementing it (though do so at your 
> leisure). =)

Yes. There is already some code in base that does this. For NUMAQ specifically
this check happens and clustered mode is selected for APIC. My patch has this 
additinal check (after the initial IBM OEM check), for non-NUMAQ systems with 
more than 8 CPUs and xAPIC support. These systems can not work with the 
default flat addressing mode. So, this patch sets up such systems in physical 
mode.

Thanks,
-Venkatesh
