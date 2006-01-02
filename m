Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWABO7l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWABO7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 09:59:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWABO7l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 09:59:41 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:17357 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750769AbWABO7l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 09:59:41 -0500
Date: Mon, 2 Jan 2006 16:03:56 +0100
To: Dave Jones <davej@redhat.com>, Keith Owens <kaos@ocs.com.au>,
       Matt Mackall <mpm@selenic.com>, linux-kernel@vger.kernel.org
Subject: Re: [POLL] SLAB : Are the 32 and 192 bytes caches really usefull on x86_64 machines ?
Message-ID: <20060102150356.GA28955@aitel.hist.no>
References: <20051229012915.GB3286@redhat.com> <23471.1135821010@ocs3.ocs.com.au> <20051229023906.GC3286@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229023906.GC3286@redhat.com>
User-Agent: Mutt/1.5.11
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 28, 2005 at 09:39:06PM -0500, Dave Jones wrote:
> On Thu, Dec 29, 2005 at 12:50:10PM +1100, Keith Owens wrote:
>  > Dave Jones (on Wed, 28 Dec 2005 20:29:15 -0500) wrote:
>  > >
>  > > > Something like this:
>  > > > 
>  > > > http://lwn.net/Articles/124374/
>  > >
>  > >One thing that really sticks out like a sore thumb is soft_cursor()
>  > >That thing gets called a *lot*, and every time it does a kmalloc/free
>  > >pair that 99.9% of the time is going to be the same size alloc as
>  > >it was the last time.  This patch makes that alloc persistent
>  > >(and does a realloc if the size changes).
>  > >The only time it should change is if the font/resolution changes I think.
>  > 
>  > Can soft_cursor() be called from multiple processes at the same time,
>  > in particular with dual head systems?  If so then a static variable is
>  > not going to work.
> 
> My dual-head system here displays a cloned image on the second
> screen, which seems to dtrt.  I'm not sure how to make it show
> something different on the other head to test further.

Few dualhead drivers actually support two different framebuffers,
but the matrox G550 (and G400) drivers do.  Compile one
of those, make sure to configure dualhead support.
After booting up, use "matroxset" to set the 
framebuffer to vga-connector mapping so that the two 
outputs actually show the different framebuffers.

Another way is to use several graphichs cards (AGP getting
the first framebuffer and each PCI card getting others as
the drivers load.)

Helge Hafting
