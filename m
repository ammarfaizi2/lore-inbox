Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267502AbSLSBZ0>; Wed, 18 Dec 2002 20:25:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267506AbSLSBZ0>; Wed, 18 Dec 2002 20:25:26 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:2038 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267502AbSLSBZP> convert rfc822-to-8bit;
	Wed, 18 Dec 2002 20:25:15 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Date: Wed, 18 Dec 2002 17:32:43 -0800
User-Agent: KMail/1.4.3
Cc: "Martin Bligh" <mbligh@us.ibm.com>, "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E190@fmsmsx405.fm.intel.com>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E190@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212181732.44007.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 December 2002 05:05 pm, Pallipadi, Venkatesh wrote:
> I have started working on a similar patch for 2.5. Other thing in my todo
> list is to split this patch up into chunks.
>
> Other comments inlined below.
>
> > From: Christoph Hellwig [mailto:hch@infradead.org]
> >
> > On Wed, Dec 18, 2002 at 02:36:20PM -0800, Pallipadi, Venkatesh wrote:
> > >   xAPIC support can actually  be determined from the LAPIC version.
> >
> > Are you sure?  IIRC some of the early summit boxens didn't report the
> > right versions..
> > does this really not break anything in the fragile summit setups?
>
> I am not really sure about the local APIC versions in summit. What I
> remember seeing on lkml was summit has older IOAPIC version. Can someone
> clarify this?

Sure, I can verify it.  The I/O APICs in shipped summit chipsets contains a 
version ID of 0x11 instead of 0x14 to 0x1F.  The high performance folks 
claimed that Intel specified 0x14 for the local APICs, but left their orange 
jacket docs saying 0x1X for I/O APICs until after the chips taped out.

Whatever.  In any case, there are boxes in the field that contain those 
version numbers.  We can recognize them using the OEM and product strings in 
the MPS and ACPI tables, so it's only an annoyance.


> > Okay, this was wrong before, but any chance you could use proper
> > style here (i.e. if ()
> > Again.
>
> oops.. I somehow missed these 'if' coding style stuff. changing it
> immediately.
>
> > > +      define_bool CONFIG_X86_CLUSTERED_APIC y
> >
> > Do we really need CONFIG_X86_APIC_CLUSTER _and_
> > CONFIG_X86_CLUSTERED_APIC?
>
> I will also eliminate CONFIG_X86_APIC_CLUSTER and use
> CONFIG_X86_CLUSTERED_APIC directly.
>
> > -	if (clustered_apic_mode == CLUSTERED_APIC_NUMAQ) {
> > +	if (clustered_apic_mode &&
> > +		(configured_platform_type ==
> > CONFIGURED_PLATFORM_NUMA) ) {
> >
> > Doesn;t configured_platform_type == CONFIGURED_PLATFORM_NUMA imply
> > clustered_apic_mode?  and it should be at least
> > CONFIGURED_PLATFORM_NUMAQ,
> > btw.  Probably better something short like SUBARCH_NUMAQ..
>
> Yes, right now CONFIGURED_PLATFORM_NUMA implies clustered_apic_mode, and
> one of the checks in the above 'if' is redundant. Will do a search and
> replace of NUMA by NUMAQ.
>
>
> Thanks,
> Venkatesh

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

