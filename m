Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263159AbUDAUsW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Apr 2004 15:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263156AbUDAUsW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Apr 2004 15:48:22 -0500
Received: from fmr02.intel.com ([192.55.52.25]:4543 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id S263159AbUDAUry (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Apr 2004 15:47:54 -0500
Subject: Re: [ACPI] Re: Linux 2.4.26-rc1 (cmpxchg vs 80386 build)
From: Len Brown <len.brown@intel.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Jamie Lokier <jamie@shareable.org>, Bill Davidsen <davidsen@tmr.com>,
       Chris Friesen <cfriesen@nortelnetworks.com>,
       Willy Tarreau <willy@w.ods.org>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Arkadiusz Miskiewicz <arekm@pld-linux.org>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ACPI Developers <acpi-devel@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.55.0404011423070.3675@jurand.ds.pg.gda.pl>
References: <4069A359.7040908@nortelnetworks.com>
	 <1080668673.989.106.camel@dhcppc4> <4069D3D2.2020402@tmr.com>
	 <Pine.LNX.4.55.0403311305000.24584@jurand.ds.pg.gda.pl>
	 <20040331150219.GC18990@mail.shareable.org>
	 <Pine.LNX.4.55.0404011423070.3675@jurand.ds.pg.gda.pl>
Content-Type: text/plain
Organization: 
Message-Id: <1080852371.30349.19.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 01 Apr 2004 15:46:11 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-01 at 07:29, Maciej W. Rozycki wrote:
> On Wed, 31 Mar 2004, Jamie Lokier wrote:
> 
> > >  Well, "cmpxchg", "xadd", etc. can be easily emulated with an aid of a
> > > spinlock.  With SMP operation included.
> > 
> > Nope.  Len Brown wrote:
> > 
> > > Linux uses this locking mechanism to coordinate shared access
> > > to hardware registers with embedded controllers,
> > > which is true also on uniprocessors too.
> > 
> > You can't do that with a spinlock.  The embedded controllers would
> > need to know about the spinlock.
> 
>  Hmm, does it mean we support x86 systems where an iomem resource has to
> be atomically accessible by a CPU and a peripheral controller?

ACPI specifies a location in regular memory that is used to contain the
lock.  The lock is used both by the CPU and by the embedded controller
to cover access to shared registers.  We don't spin on this lock because
we don't know how long the embedded controller might hold it.  Instead
when we fail to acquire it we schedule an event to trigger when the lock
is free.

cheers,
-Len



