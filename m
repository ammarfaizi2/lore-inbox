Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbTIKDnm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 23:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbTIKDnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 23:43:42 -0400
Received: from fmr09.intel.com ([192.52.57.35]:27135 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S265974AbTIKDnk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 23:43:40 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Wed, 10 Sep 2003 20:43:34 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017304AF3A@scsmsx402.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Thread-Index: AcN4B1lFaSofFlHcRS+FH14vNEZDnAADdk8w
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>
Cc: <richard.brunner@amd.com>, <linux-kernel@vger.kernel.org>,
       <torvalds@osdl.org>, "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 11 Sep 2003 03:43:35.0494 (UTC) FILETIME=[E0EFEE60:01C37816]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I would hate to break this again just to save a few hundred bytes in
> this function. Also the overhead is very low so it is also not
> interesting to make it conditional for speed reasons.

For maintenance and testing purposes, I think it's still better to make
it conditional. If the errata are fixed, you might want to kill the
condition depending on the stepping, for example. During the transition
time, you need to support both the steppings until old ones go away
(then remove the workaround).

Thanks,
Jun

> -----Original Message-----
> From: Andi Kleen [mailto:ak@suse.de]
> Sent: Wednesday, September 10, 2003 6:47 PM
> To: Andrew Morton
> Cc: Andi Kleen; richard.brunner@amd.com; linux-kernel@vger.kernel.org;
> torvalds@osdl.org
> Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
> 
> On Wed, Sep 10, 2003 at 06:44:14PM -0700, Andrew Morton wrote:
> > Andi Kleen <ak@suse.de> wrote:
> > >
> > >  +static int is_prefetch(struct pt_regs *regs, unsigned long addr)
> >
> > Can we make this code go away if the configured CPU is, say, Intel?
> > (I couldn't find a sane CONFIG_ setting to use for this).
> 
> It could be done but ... we are moving more and more to generic
kernels
> (e.g. see the alternative patch code which is enabled unconditionally)
> So that when you have a kernel it will boot on near all modern CPUs.
> Currently Athlon and P4 kernels run on each other for example.
> 
> I would hate to break this again just to save a few hundred bytes in
> this function. Also the overhead is very low so it is also not
> interesting to make it conditional for speed reasons.
> 
> >
> > It might be vaguely interesting to add a user-visible counter for
this
> > event? If someone somehow comes up with an application which hits
the
> fault
> > frequently they will take a big performance hit.
> 
> In that case they can just profile the kernel. is_prefetch should
> show it then.
> 
> Of course someone can still add the counter if they want, I'm not
> opposed to it.
> 
> -Andi
> 
> -
> To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
