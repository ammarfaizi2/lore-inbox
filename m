Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262208AbSLQCWj>; Mon, 16 Dec 2002 21:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSLQCWj>; Mon, 16 Dec 2002 21:22:39 -0500
Received: from fmr01.intel.com ([192.55.52.18]:35811 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S262208AbSLQCWf> convert rfc822-to-8bit;
	Mon, 16 Dec 2002 21:22:35 -0500
content-class: urn:content-classes:message
Subject: RE: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
Date: Mon, 16 Dec 2002 18:30:31 -0800
Message-ID: <3014AAAC8E0930438FD38EBF6DCEB564419BE0@fmsmsx407.fm.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
Thread-Index: AcKi35oEokJz7A7SEdeNCQBQi+Bs2ACk+N2A
X-MimeOLE: Produced By Microsoft Exchange V6.0.6334.0
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: <jamesclv@us.ibm.com>, "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Zwane Mwaikambo" <zwane@holomorphy.com>
Cc: "Martin Bligh" <mbligh@us.ibm.com>, "John Stultz" <johnstul@us.ibm.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 17 Dec 2002 02:30:31.0891 (UTC) FILETIME=[45663230:01C2A574]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've never worked on a system that tries to use MSIs.  Do they use lowest
> priority delivery?

They should provide lowest priority delivery as well as direct.

Jun


> -----Original Message-----
> From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> Sent: Friday, December 13, 2002 11:40 AM
> To: Nakajima, Jun; Zwane Mwaikambo
> Cc: Martin Bligh; John Stultz; Linux Kernel
> Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on !Summit
> 
> On Friday 13 December 2002 07:43 am, Nakajima, Jun wrote:
> > I/O APIC? I'm talking about xAPIC, i.e. local APIC which is part of the
> > chip. Also note that I/O subsystem can generate interrupts (e.g. MSI,
> > Message Signaled Interrupt), bypassing I/O APICs.
> >
> > Jun
> 
> Part of the "x" in xAPIC is that it can communicate over the classic 2
> data /
> 1 clock serial bus or send interrupts over the system bus.  If operating
> in
> serial mode, the old priority arbitration protocol works just fine.  It's
> parallel mode where we have problems.  All the I/O interrupts tend to hit
> CPU
> 0, thanks to the XTPR HW's tie-breaker logic.
> 
> Intel has added a new register to I/O APICs that tells whether they're
> operating in serial or parallel mode.  It may be useful to read that bit
> before activating some of the code in my patches.
> 
> I've never worked on a system that tries to use MSIs.  Do they use lowest
> priority delivery?
> 
> (FYI, Summit boxes are hardwired into parallel mode.  There's no provision
> for
> a serial APIC bus connecting the PCI expansion box to the CPUs.)
> 
> > > -----Original Message-----
> > > From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> > > Sent: Thursday, December 12, 2002 7:22 PM
> > > To: Nakajima, Jun; Zwane Mwaikambo
> > > Cc: Martin Bligh; John Stultz; Linux Kernel
> > > Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on
> !Summit
> > >
> > > On Thursday 12 December 2002 07:05 pm, Nakajima, Jun wrote:
> > > > BTW, we are working on a xAPIC patch that supports more than 8 CPUs
> in
> > > > a generic fashion (don't use hardcode OEM checking). We already
> tested
> > > > it
> > >
> > > on
> > >
> > > > two OEM systems with 16 CPUs.
> > > > - It uses clustered mode. We don't want to use physical mode because
> it
> > > > does not support lowest priority delivery mode.
> > > > - We also check the version of the local APIC if it's xAPIC or not.
> > > > It's possible that some other x86 architecture (other than P4P) uses
> > > > xAPIC.
> > > >
> > > > Stay tuned.
> > > >
> > > > Jun
> > >
> > > See my 2.5 summit patch for one that uses logical mode and lowest
> > > priority delivery.  I haven't submitted that for 2.4 because the
> physical
> > > patch has the most run time on it, both in Alan's tree and SuSE 8.0+.
> > >
> > > The hardcoded OEM checking was necessary because the Summit I/O APICs
> > > were still using the older version number.  (The HW folks claim that
> > > Intel didn't
> > > specify the new number soon enough for them.)
> > >
> > > I'm hesitant to key xAPIC vs. flat off the local APIC version number
> > > because
> > > it's possible to build a flat system out of P4 CPUs.  I/O APIC version
> > > numbers combined with the parallel vs. serial bit would be safer
> (except
> > > for
> > > the Summit problem above).  I've also tried checking all the CPU's
> > > physical
> > > APIC IDs to see if they use multiple APIC clusters.
> > >
> > > > > -----Original Message-----
> > > > > From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> > > > > Sent: Thursday, December 12, 2002 6:42 PM
> > > > > To: Zwane Mwaikambo
> > > > > Cc: Martin Bligh; John Stultz; Linux Kernel
> > > > > Subject: Re: [PATCH][2.5][RFC] Using xAPIC apic address space on
> > >
> > > !Summit
> > >
> > > > > On Thursday 12 December 2002 06:21 pm, Zwane Mwaikambo wrote:
> > > > > > On Thu, 12 Dec 2002, James Cleverdon wrote:
> > > > > > > On Thursday 12 December 2002 05:44 pm, Zwane Mwaikambo wrote:
> > > > > > > > Hi,
> > > > > > > > 	I've got an 32x SMP system which has an xAPIC but
> utilises
> > > > >
> > > > > flat
> > > > >
> > > > > > > > addressing. This patch is to rename what was formerly
> > > > > > > > x86_summit
> > >
> > > to
> > >
> > > > > > > > x86_xapic (just to avoid confusion) and then select mask
> > >
> > > depending
> > >
> > > > > on
> > > > >
> > > > > > > > that.
> > > > > > > >
> > > > > > > > Untested/uncompiled patch
> > > > > > >
> > > > > > > Hi Zwane,
> > > > > > >
> > > > > > > How can you have a 32-way SMP system with flat addressing?
> There
> > >
> > > are
> > >
> > > > > > > only 8 bits in the destination address field.  Even if you
> work
> > > > > > > around that by assigning a set of CPUs to each dest addr bit,
> > >
> > > there
> > >
> > > > > > > can only
> > > > >
> > > > > be
> > > > >
> > > > > > > 15 physical APIC IDs in flat mode.  To get to 32 you must
> switch
> > >
> > > into
> > >
> > > > > > > clustered mode.
> > > > > > >
> > > > > > > Please tell me more.  I'm intrigued how this can be done.
> > > > > >
> > > > > > Hi James,
> > > > > > 	with the xAPIC we can use the 8bit address space everywhere
> >
> > in
> >
> > > > > > physical destination mode. For example the ICR now has an 8bit
> > > > > > space for destination.
> > > > > >
> > > > > > "Specifies the target processor or processors. This field is
> only
> > >
> > > used
> > >
> > > > > > when the destination shorthand field is set to 00B. If the
> > >
> > > destination
> > >
> > > > > > mode is set to physical, then bits 56 through 59 contain the
> APIC
> > > > > > ID
> > >
> > > of
> > >
> > > > > > the target processor for Pentium and P6 family processors and
> bits
> > >
> > > 56
> > >
> > > > > > through 63 contain the APIC ID of the target processor the for
> > >
> > > Pentium
> > >
> > > > > > 4 and Intel Xeon processors. If the destination mode is set to
> > >
> > > logical,
> > >
> > > > > the
> > > > >
> > > > > > interpretation of the 8-bit destination field depends on the
> > >
> > > settings
> > >
> > > > > > of the DFR and LDR registers of the local APICs in all the
> > >
> > > processors
> > >
> > > > > > in
> > > > >
> > > > > the
> > > > >
> > > > > > system (see Section 8.6.2.,  Determining IPI Destination )."
> > > > > > 	- System Developer's Manual vol3 p291
> > > > > >
> > > > > > Regards,
> > > > > > 	Zwane
> > > > >
> > > > > Sure you can physically address them, if you assign IDs using
> Intel's
> > > > > official
> > > > > xAPIC numbering scheme (which must be clustered for more than 7
> > > > > CPUs). But,
> > > > > you still don't have enough destination address bits to go around.
> > > > > In flat
> > > > > mode, the kernel assumes you have one bit per CPU and phys IDs
> will
> > > > > be
> > >
> > > <
> > >
> > > > > 0xF.
> > > > >
> > > > > Bill tells me that you may be doing this for an emulator.  Why not
> > > > > emulate clusered APIC mode, like the real hardware uses?
> > > > >
> > > > > I know the name x86_summit doesn't really fit.  The summit patch
> > >
> > > should
> > >
> > > > > work
> > > > > for any xAPIC box that uses the system bus for interrupt delivery
> and
> > >
> > > has
> > >
> > > > > multiple APIC clusters.  Is that what you're working towards?
> > > > >
> > > > > --
> > > > > James Cleverdon
> > > > > IBM xSeries Linux Solutions
> > > > > {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
> > >
> > > --
> > > James Cleverdon
> > > IBM xSeries Linux Solutions
> > > {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
> 
> --
> James Cleverdon
> IBM xSeries Linux Solutions
> {jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com
