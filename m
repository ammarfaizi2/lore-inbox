Return-Path: <linux-kernel-owner+w=401wt.eu-S932633AbXAJBgI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbXAJBgI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 20:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbXAJBgI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 20:36:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:19282 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932633AbXAJBgH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 20:36:07 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.13,165,1167638400"; 
   d="scan'208"; a="186400934:sNHT22900717"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] Kdump documentation update for 2.6.20
Date: Wed, 10 Jan 2007 09:34:12 +0800
Message-ID: <10EA09EFD8728347A513008B6B0DA77A086BA1@pdsmsx411.ccr.corp.intel.com>
In-Reply-To: <20070110003110.GC28721@verge.net.au>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] Kdump documentation update for 2.6.20
thread-index: Acc0UJqfKMknoJMQTtmwvs1xeRtvSwABoTeQ
From: "Zou, Nanhai" <nanhai.zou@intel.com>
To: "Horms" <horms@verge.net.au>, "Vivek Goyal" <vgoyal@in.ibm.com>
Cc: "linux kernel mailing list" <linux-kernel@vger.kernel.org>,
       "Fastboot mailing list" <fastboot@lists.osdl.org>,
       "Morton Andrew Morton" <akpm@osdl.org>,
       "Mohan Kumar M" <mohan@in.ibm.com>
X-OriginalArrivalTime: 10 Jan 2007 01:35:10.0977 (UTC) FILETIME=[9169AF10:01C73457]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Horms
> Sent: 2007Äê1ÔÂ10ÈÕ 8:31
> To: Vivek Goyal
> Cc: linux kernel mailing list; Fastboot mailing list; Morton Andrew Morton;
> Mohan Kumar M
> Subject: Re: [PATCH] Kdump documentation update for 2.6.20
> 
> On Tue, Jan 09, 2007 at 08:17:08PM +0530, Vivek Goyal wrote:
> > On Tue, Jan 09, 2007 at 10:18:47AM +0900, Horms wrote:
> > > >  Download and build the system and dump-capture kernels
> > > >  ------------------------------------------------------
> > > > +There are two possible methods of using Kdump.
> > > > +
> > > > +	1) Build a separate custom dump-capture kernel for capturing the
> > > > +	   kernel core dump.
> > > > +
> > > > +	2) Use system kernel itself as dump-capture kernel and there is
> > > > +	   no need to build a separate dump-capture kernel. (Only for
> > > > +	   i386 architecture kernel version 2.6.20 onwards)
> > > > +
> > > > +For i386, second method is recommended, as it takes away the need to
> build
> > > > +additional kernel.
> > >
> > > I think that the above description is a little misleading, and quite
> > > i386 centric. The question is not weather or not you are using the
> > > system kernel, but rather, what options are needed for the crash kernel.
> > >
> > Hi Horms,
> >
> > Thanks for going through the update. Actually I never knew that kdump
> > IA64 support is mainline now. I thought it is still in Tony's tree. And
> > we never had IA64 specific documentation in kdump.txt file and that's another
> > reason that discussion became more i386 centric when it came to relocatable
> > kernels.
> 
> It wasn't that long ago it was merged, but its there now :)
> 
> > > In terms of a non-relocatable kernel, then the boot and crash kernels
> > > need to be separate.
> > >
> > > But in the case of a relocatable kernel, then the boot and crash kernels
> > > may be the same, or they may be separate. Depending on just what
> > > the end-user wants in each kernel.
> > >
> > > On ia64 there is no CONFIG_RELOCATABLE option, but the kernel is always
> > > relocatable anyway. That is, you can use the same kernel before and
> > > after crash (though I am not sure that I have tested this).
> > >
> >
> > I have tried to re-arrange the documentation based on some of your
> > recommendations. I have also left couple of sections empty which are
> > ia64 specific. I don't have an IA64 machine and I don't know how exactly
> > it is used on IA64. Can you please have a quick look at the patch and
> > also fill IA64 specific details where appropriate.
> 
> Sure, will do.
> 
> > Hopefully, this time documentation is clearer.
> >
> >
> > Mohan, Can you please check the correctness of ppc64 specific details.
> >
> > > > +   --append="root=<root-dev> init 1 irqpoll maxcpus=1"
> > > > +
> > > > +If you are using a relocatable kernel (method 2), then use
> > > > +following command.
> > > >
> > > > +   kexec -p <bzImage-of-relocatable-kernel> \
> > > > +   --initrd=<initrd-for-relocatable-kernel> \
> > > > +   --append="root=<root-dev> init 1 irqpoll maxcpus=1"
> > >
> > > --args-linux is not needed on ia64, but its kernel is relocatable.
> > > I think the important point is that if you are using a bzImage,
> > > then you need --args-linux, and basically at this point that
> > > means an i386 (or x86_64) relocatable bzImage.
> > >
> >
> > I am hoping it --args-linux will be required while loading vmlinux on
> > IA64? Because this is ELF file specific option. And this interface should
> > be common across all the architectures.
> >
> > > Then again, I could be wrong, I'm not sure that I understand
> > > --args-linux, I just know that I'm not using it :)
> 
> I will take a look into this.
> 
 args-linux is not support by IA64 kdump. 
To have common interface, maybe we should support it by ignore this arg like ppc does.

Zou Nan hai
> --
