Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267504AbSLSA5H>; Wed, 18 Dec 2002 19:57:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbSLSA5H>; Wed, 18 Dec 2002 19:57:07 -0500
Received: from fmr02.intel.com ([192.55.52.25]:39626 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S267504AbSLSA5E> convert rfc822-to-8bit; Wed, 18 Dec 2002 19:57:04 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Date: Wed, 18 Dec 2002 17:05:01 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E190@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
Thread-Index: AcKm7PHZc68YWRLfEdes/wBQi+Bv6wAAomUg
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Christoph Hellwig" <hch@infradead.org>
Cc: "Martin Bligh" <mbligh@us.ibm.com>, "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>, <jamesclv@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
X-OriginalArrivalTime: 19 Dec 2002 01:05:02.0715 (UTC) FILETIME=[A8FF8CB0:01C2A6FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have started working on a similar patch for 2.5. Other thing in my todo list is to
split this patch up into chunks.

Other comments inlined below.

> From: Christoph Hellwig [mailto:hch@infradead.org]
> On Wed, Dec 18, 2002 at 02:36:20PM -0800, Pallipadi, Venkatesh wrote:
> >   xAPIC support can actually  be determined from the LAPIC version.
> 
> Are you sure?  IIRC some of the early summit boxens didn't report the
> right versions..
> does this really not break anything in the fragile summit setups?

I am not really sure about the local APIC versions in summit. What I remember seeing on
lkml was summit has older IOAPIC version. Can someone clarify this?

> Okay, this was wrong before, but any chance you could use proper
> style here (i.e. if () 
> Again.

oops.. I somehow missed these 'if' coding style stuff. changing it immediately.

> > +      define_bool CONFIG_X86_CLUSTERED_APIC y
> Do we really need CONFIG_X86_APIC_CLUSTER _and_ CONFIG_X86_CLUSTERED_APIC?

I will also eliminate CONFIG_X86_APIC_CLUSTER and use CONFIG_X86_CLUSTERED_APIC directly.

> 
> -	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
> +	if (clustered_apic_mode &&
> +		(configured_platform_type == 
> CONFIGURED_PLATFORM_NUMA) ) {
> 
> Doesn;t configured_platform_type == CONFIGURED_PLATFORM_NUMA imply
> clustered_apic_mode?  and it should be at least 
> CONFIGURED_PLATFORM_NUMAQ,
> btw.  Probably better something short like SUBARCH_NUMAQ..

Yes, right now CONFIGURED_PLATFORM_NUMA implies clustered_apic_mode, and one of the 
checks in the above 'if' is redundant. Will do a search and replace of NUMA by NUMAQ.


Thanks,
Venkatesh
