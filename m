Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbSLWBQP>; Sun, 22 Dec 2002 20:16:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbSLWBQP>; Sun, 22 Dec 2002 20:16:15 -0500
Received: from petasus.ch.intel.com ([143.182.124.5]:15072 "EHLO
	petasus.ch.intel.com") by vger.kernel.org with ESMTP
	id <S265277AbSLWBQO> convert rfc822-to-8bit; Sun, 22 Dec 2002 20:16:14 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.4]  generic support for systems with more than 8 CPUs (1/2)
Date: Sun, 22 Dec 2002 17:24:15 -0800
Message-ID: <C8C38546F90ABF408A5961FC01FDBF1912E1B6@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-MS-Has-Attach: 
Content-Transfer-Encoding: 7BIT
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.4]  generic support for systems with more than 8 CPUs (1/2)
Thread-Index: AcKp4GkE0rrhnhXPEde/HABQi2jWFgAP4QqQ
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@unisys.com>,
       "William Lee Irwin III" <wli@holomorphy.com>,
       "Christoph Hellwig" <hch@infradead.org>,
       "James Cleverdon" <jamesclv@us.ibm.com>,
       "John Stultz" <johnstul@us.ibm.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
Cc: "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>
X-OriginalArrivalTime: 23 Dec 2002 01:24:15.0545 (UTC) FILETIME=[01CA7290:01C2AA22]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> From: Martin J. Bligh [mailto:mbligh@aracnet.com]
> > 1/2 : checking for xAPIC support in the system
> 
> OK, that looks pretty sane - one question:
> 
> > -		if ((clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&
> > +		if (!xapic_support &&
> > +		    (clustered_apic_mode != CLUSTERED_APIC_XAPIC) &&
> 
> When does xapic_support differ from
> (clustered_apic_mode == CLUSTERED_APIC_XAPIC) ?
>

They are quite different. 
Infact CLUSTERED_APIC_XAPIC just means using physical APIC mode and is kind of a
misnomer as xAPIC doesn't necessariy mean physical APIC mode. 
xapic_support says whether xAPIC support is there or not. Then APICs 
can be configured either in physical or logical modes. I mainly need this as
with xAPIC support, we have:
- LAPIC and IOAPIC have there own name space, 
- max or 255 CPUS with 0xff as broadcast, as opposed to 0xf broadcast in case of no xAPIC

> Do you want to use a physical flat xapic mode for your stuff, or the
> same clustered physical mode as the Summit stuff? If the latter, then
> the new switch seems unnecessary ....

Now I am getting a bit confused here. I am using physical mode with no clustering
whatsoever. Thats what I felt even Summit was doing in 2.4.

Thanks,
-Venkatesh
