Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266522AbUBEUQg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 15:16:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266408AbUBEUQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 15:16:36 -0500
Received: from fmr09.intel.com ([192.52.57.35]:30659 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S266522AbUBEUQ3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 15:16:29 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Date: Thu, 5 Feb 2004 12:16:17 -0800
Message-ID: <F595A0622682C44DBBE0BBA91E56A5ED1C3682@orsmsx410.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [Infiniband-general] Getting an Infiniband access layer in the linux kernel
Thread-Index: AcPsGZjROImzXgQCRJWTJFQhgl26twABc3+gAAEPX2A=
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "King, Steven R" <steven.r.king@intel.com>, "Greg KH" <greg@kroah.com>,
       <linux-kernel@vger.kernel.org>
Cc: <infiniband-general@lists.sourceforge.net>
X-OriginalArrivalTime: 05 Feb 2004 20:16:18.0139 (UTC) FILETIME=[E9C38AB0:01C3EC24]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think that we tried to isolate a lot of these kernel calls into
one library, the component library, so that when the kernel APIs change,
which seems to happen every release, we only have to change the code 
in one spot. 

This actually helps porting to new kernels. For example, I think that
it only took a week to get the IBAL code to compile on 2.6 since all or
most 
of the kernel dependencies were isolated to one module. 

It also then allows most of the code to remain very readable, since we
don't have to put #ifdefs all over the place when an API or kernel data
structure changes. 

Are there any other examples of drivers that isolate kernel specific
calls
to one module or file of their code to ease portability between
different revisions
of the kernel ? If not, maybe they should look at what we have done,
it might save them some headaches in the future. 



-----Original Message-----
From: infiniband-general-admin@lists.sourceforge.net
[mailto:infiniband-general-admin@lists.sourceforge.net] On Behalf Of
King, Steven R
Sent: Thursday, February 05, 2004 11:39 AM
To: Greg KH; linux-kernel@vger.kernel.org
Cc: infiniband-general@lists.sourceforge.net
Subject: RE: [Infiniband-general] Getting an Infiniband access layer in
the linux kernel


We just use the kernel's spin_lock_irqsave(), so I don't know what
you're talking about.

-----Original Message-----
From: Greg KH [mailto:greg@kroah.com] 
Sent: Thursday, February 05, 2004 10:55 AM
To: King, Steven R; linux-kernel@vger.kernel.org
Cc: infiniband-general@lists.sourceforge.net
Subject: Re: [Infiniband-general] Getting an Infiniband access layer in
the linux kernel


On Thu, Feb 05, 2004 at 10:27:54AM -0800, King, Steven R wrote:
> Hi Greg,
> What exactly is wrong with spinlock?  Far as I know, it's been working

> bug-free on a variety of platforms for quite some time now.  The other

> abstractions such as atomic_t are for platform portability.

Again, compare them to the current kernel spinlocks and try to realize
why your implementation of spinlock_irqsave() will not work on all
platforms.

Come on, just use the kernel versions, there is no need to reinvent the
wheel all of the time, it just wastes everyones time (including mine...)

thanks,

greg k-h


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration See the
breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
Infiniband-general mailing list Infiniband-general@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/infiniband-general
