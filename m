Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313032AbSC0PYa>; Wed, 27 Mar 2002 10:24:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313036AbSC0PYU>; Wed, 27 Mar 2002 10:24:20 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:53409 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S313033AbSC0PYL>; Wed, 27 Mar 2002 10:24:11 -0500
Date: Wed, 27 Mar 2002 16:24:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
cc: Dave Jones <davej@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] P4/Xeon Thermal LVT support
In-Reply-To: <Pine.LNX.4.44.0203271631400.5751-100000@netfinity.realnet.co.sz>
Message-ID: <Pine.GSO.3.96.1020327161054.8602D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Zwane Mwaikambo wrote:

> > >  #define FIRST_DEVICE_VECTOR	0x31
> > > +#define THERMAL_APIC_VECTOR	0x32	/* Thermal monitor local vector */
> > >  #define FIRST_SYSTEM_VECTOR	0xef
> > 
> >  You certainly want to select a different vector.
> 
> Whats wrong with that vector? I tried to follow the guidelines as 
> specified in hw_irq.h and opted to go for the lower priority ones, or 
> is the vector not serviceable due to its range?

 You can't use a vector that is in the range assigned to I/O APIC
interrupts (i.e.  0x31 - 0xee).  Otherwise you'll get an overlap when the
vector gets assigned to an ordinary IRQ line.  Also you probably want a
high-priority interrupt as the condition is serious, if not critical --
system failures, such as bus exceptions, machine check faults, parity
errors, power failures, etc. demand a high priority service. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

