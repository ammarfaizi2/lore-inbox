Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267525AbSLSEGv>; Wed, 18 Dec 2002 23:06:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267528AbSLSEGv>; Wed, 18 Dec 2002 23:06:51 -0500
Received: from e32.co.us.ibm.com ([32.97.110.130]:49620 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267525AbSLSEGu> convert rfc822-to-8bit; Wed, 18 Dec 2002 23:06:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>,
       "Christoph Hellwig" <hch@infradead.org>
Subject: Re: [PATCH][2.4]  generic cluster APIC support for systems with more than 8 CPUs
Date: Wed, 18 Dec 2002 20:14:19 -0800
User-Agent: KMail/1.4.3
Cc: "Martin Bligh" <mbligh@us.ibm.com>, "John Stultz" <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
References: <C8C38546F90ABF408A5961FC01FDBF1912E193@fmsmsx405.fm.intel.com>
In-Reply-To: <C8C38546F90ABF408A5961FC01FDBF1912E193@fmsmsx405.fm.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212182014.19439.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 18 December 2002 06:45 pm, Pallipadi, Venkatesh wrote:
> > From: James Cleverdon [mailto:jamesclv@us.ibm.com]
> >
> > > On Wednesday 18 December 2002 05:05 pm, Pallipadi, Venkatesh wrote:
> > > I am not really sure about the local APIC versions in summit. What I
> > > remember seeing on lkml was summit has older IOAPIC
> >
> > version. Can someone
> >
> > > clarify this?
> >
> > Sure, I can verify it.  The I/O APICs in shipped summit
> > chipsets contains a
> > version ID of 0x11 instead of 0x14 to 0x1F.  The high
> > performance folks
> > claimed that Intel specified 0x14 for the local APICs, but
> > left their orange
> > jacket docs saying 0x1X for I/O APICs until after the chips taped out.
> >
> > Whatever.  In any case, there are boxes in the field that
> > contain those
> > version numbers.  We can recognize them using the OEM and
> > product strings in
> > the MPS and ACPI tables, so it's only an annoyance.
>
> OK. In my patch I am looking at local APIC version > 0x14, to check xAPIC
> support. This should work on all systems irrespective of IOAPIC version.
> And even if there are problems here for summit, we can workaround it, by
> simply forcing xAPIC support at already existing OEM string check.
>
>
> Thanks,
> -Venkatesh

Yes, such a scheme should work fine.  (Had something like that in my patch, 
but it was cut out to avoid any chance of breaking flat P4 boxen.)

Once you've determined that you have a system with xAPICs, how do you intend 
to distinguish between those delivering interrupts through the serial bus vs. 
the system bus?  (Correct me if I'm wrong, but your patch didn't define the 
new I/O APIC register that contains the serial/parallel status bit.)

How will you decide between a box that always must use clustered APIC mode, 
like the x440, vs. one which can be operated in flat mode, like the x360?  (I 
only include the x360 in my summit patch to avoid having all the interrupts 
hit CPU 0.  Otherwise, it is a flat box that delivers interrupts through the 
system bus.)  What about other flat P4 systems?

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

