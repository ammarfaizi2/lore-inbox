Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031038AbWK3ScB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031038AbWK3ScB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 13:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031039AbWK3ScB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 13:32:01 -0500
Received: from mail.keyvoice.com ([12.153.69.53]:47298 "EHLO
	outbound.comdial.com") by vger.kernel.org with ESMTP
	id S1031038AbWK3ScA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 13:32:00 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: Reserving a fixed physical address page of RAM.
Date: Thu, 30 Nov 2006 13:31:58 -0500
Message-ID: <22170ADB26112F478A4E293FF9D449F44D1066@secure.comdial.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Reserving a fixed physical address page of RAM.
Thread-Index: AccUpXLJ2/Z4a+SAQzSzq0FEfkXeogAANb1wAAGhkSA=
From: "Jon Ringle" <JRingle@vertical.com>
To: "Jon Ringle" <JRingle@vertical.com>,
       "Fawad Lateef" <fawadlateef@gmail.com>
Cc: "Dave Airlie" <airlied@gmail.com>, "Robert Hancock" <hancockr@shaw.ca>,
       <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jon Ringle wrote:
> Fawad Lateef wrote:
> > On 11/30/06, Jon Ringle <JRingle@vertical.com> wrote:
> > > Do you think that the following would work to properly 
> reserve the 
> > > memory. If it does, then I think I can just do a 
> ioremap(0x0ffff000,
> > > 0x1000) to obtain a virtual address. (Ofcourse I would 
> actually use 
> > > symbolic names rather than the hardcoded addesses shown here).
> > >
> > > Index: linux/arch/arm/mm/init.c
> > > 
> ===================================================================
> > > --- linux.orig/arch/arm/mm/init.c       2006-11-30 
> > 11:03:00.000000000
> > > -0500
> > > +++ linux/arch/arm/mm/init.c    2006-11-30 
> 11:09:09.000000000 -0500
> > > @@ -429,6 +429,10 @@
> > >         unsigned long addr;
> > >         void *vectors;
> > >
> > > +#ifdef CONFIG_MACH_VERTICAL_RSC4
> > > +       reserve_bootmem (0x0ffff000, 0x1000); #endif
> > > +
> > >         /*
> > >          * Allocate the vector page early.
> > >          */
> > >
> > >
> > 
> > I think you can do like this but can't say accurately 
> because I havn't 
> > worked on arm architecture and also you havn't mentioned your 
> > kernel-version or function (in file
> > arch/arm/mm/init.c) which you are going to do call reserve_bootmem !
> 
> Kernel version is 2.6.16.29 and the reserve_bootmem() call 
> above is at the top of the function devicemaps_init().

Is there some way I can verify that the above works? I've tried the
following to try to get info on the reservation:
	# cat /proc/iomem
	# cat /proc/meminfo
	# cat /proc/slabinfo
	# echo m > /proc/sysrq-trigger

The only one that hints that this might have worked is the `echo m >
/proc/sysrq-trigger` in that I see the reserved pages count one larger
than using a kernel without this patch. Does this mean that the page I
reserved won't get used by Linux for any purpose?

Jon
