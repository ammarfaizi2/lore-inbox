Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265108AbSLMC5w>; Thu, 12 Dec 2002 21:57:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267349AbSLMC5w>; Thu, 12 Dec 2002 21:57:52 -0500
Received: from fmr01.intel.com ([192.55.52.18]:57031 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265108AbSLMC5u>;
	Thu, 12 Dec 2002 21:57:50 -0500
Message-ID: <F2DBA543B89AD51184B600508B68D40010F1CE54@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: jamesclv@us.ibm.com, Zwane Mwaikambo <zwane@holomorphy.com>
Cc: Martin Bligh <mbligh@us.ibm.com>, John Stultz <johnstul@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
Date: Thu, 12 Dec 2002 19:05:38 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, we are working on a xAPIC patch that supports more than 8 CPUs in a
generic fashion (don't use hardcode OEM checking). We already tested it on
two OEM systems with 16 CPUs. 
- It uses clustered mode. We don't want to use physical mode because it does
not support lowest priority delivery mode.
- We also check the version of the local APIC if it's xAPIC or not. It's
possible that some other x86 architecture (other than P4P) uses xAPIC.

Stay tuned.

Jun
> -----Original Message-----
> From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> Sent: Thursday, December 12, 2002 6:42 PM
> To: Zwane Mwaikambo
> Cc: Martin Bligh; John Stultz; Linux Kernel
> Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
> 
> On Thursday 12 December 2002 06:21 pm, Zwane Mwaikambo wrote:
> > On Thu, 12 Dec 2002, James Cleverdon wrote:
> > > On Thursday 12 December 2002 05:44 pm, Zwane Mwaikambo wrote:
> > > > Hi,
> > > > 	I've got an 32x SMP system which has an xAPIC but utilises
> flat
> > > > addressing. This patch is to rename what was formerly x86_summit to
> > > > x86_xapic (just to avoid confusion) and then select mask depending
> on
> > > > that.
> > > >
> > > > Untested/uncompiled patch
> > >
> > > Hi Zwane,
> > >
> > > How can you have a 32-way SMP system with flat addressing?  There are
> > > only 8 bits in the destination address field.  Even if you work around
> > > that by assigning a set of CPUs to each dest addr bit, there can only
> be
> > > 15 physical APIC IDs in flat mode.  To get to 32 you must switch into
> > > clustered mode.
> > >
> > > Please tell me more.  I'm intrigued how this can be done.
> >
> > Hi James,
> > 	with the xAPIC we can use the 8bit address space everywhere in
> > physical destination mode. For example the ICR now has an 8bit space for
> > destination.
> >
> > "Specifies the target processor or processors. This field is only used
> > when the destination shorthand field is set to 00B. If the destination
> > mode is set to physical, then bits 56 through 59 contain the APIC ID of
> > the target processor for Pentium and P6 family processors and bits 56
> > through 63 contain the APIC ID of the target processor the for Pentium 4
> > and Intel Xeon processors. If the destination mode is set to logical,
> the
> > interpretation of the 8-bit destination field depends on the settings of
> > the DFR and LDR registers of the local APICs in all the processors in
> the
> > system (see Section 8.6.2.,  Determining IPI Destination )."
> > 	- System Developer's Manual vol3 p291
> >
> > Regards,
> > 	Zwane
> 
> Sure you can physically address them, if you assign IDs using Intel's
> official
> xAPIC numbering scheme (which must be clustered for more than 7 CPUs).
> But,
> you still don't have enough destination address bits to go around.  In
> flat
> mode, the kernel assumes you have one bit per CPU and phys IDs will be <
> 0xF.
> 
> Bill tells me that you may be doing this for an emulator.  Why not emulate
> clusered APIC mode, like the real hardware uses?
> 
> I know the name x86_summit doesn't really fit.  The summit patch should
> work
> for any xAPIC box that uses the system bus for interrupt delivery and has
> multiple APIC clusters.  Is that what you're working towards?
> 
> --
> James Cleverdon
> IBM xSeries Linux Solutions
> {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
