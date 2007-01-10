Return-Path: <linux-kernel-owner+w=401wt.eu-S932539AbXAJAmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932539AbXAJAmF (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 19:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932548AbXAJAmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 19:42:04 -0500
Received: from koto.vergenet.net ([210.128.90.7]:45919 "EHLO koto.vergenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932539AbXAJAmB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 19:42:01 -0500
Date: Wed, 10 Jan 2007 09:31:11 +0900
From: Horms <horms@verge.net.au>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [PATCH] Kdump documentation update for 2.6.20
Message-ID: <20070110003110.GC28721@verge.net.au>
References: <20070108075803.GB7889@in.ibm.com> <20070109011846.GB7479@verge.net.au> <20070109144708.GA6924@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070109144708.GA6924@in.ibm.com>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2007 at 08:17:08PM +0530, Vivek Goyal wrote:
> On Tue, Jan 09, 2007 at 10:18:47AM +0900, Horms wrote:
> > >  Download and build the system and dump-capture kernels
> > >  ------------------------------------------------------
> > > +There are two possible methods of using Kdump.
> > > +
> > > +	1) Build a separate custom dump-capture kernel for capturing the
> > > +	   kernel core dump.
> > > +
> > > +	2) Use system kernel itself as dump-capture kernel and there is
> > > +	   no need to build a separate dump-capture kernel. (Only for
> > > +	   i386 architecture kernel version 2.6.20 onwards)
> > > +
> > > +For i386, second method is recommended, as it takes away the need to build
> > > +additional kernel.
> > 
> > I think that the above description is a little misleading, and quite
> > i386 centric. The question is not weather or not you are using the
> > system kernel, but rather, what options are needed for the crash kernel.
> > 
> Hi Horms,
> 
> Thanks for going through the update. Actually I never knew that kdump
> IA64 support is mainline now. I thought it is still in Tony's tree. And
> we never had IA64 specific documentation in kdump.txt file and that's another
> reason that discussion became more i386 centric when it came to relocatable
> kernels.

It wasn't that long ago it was merged, but its there now :)

> > In terms of a non-relocatable kernel, then the boot and crash kernels
> > need to be separate.
> > 
> > But in the case of a relocatable kernel, then the boot and crash kernels
> > may be the same, or they may be separate. Depending on just what
> > the end-user wants in each kernel.
> > 
> > On ia64 there is no CONFIG_RELOCATABLE option, but the kernel is always
> > relocatable anyway. That is, you can use the same kernel before and
> > after crash (though I am not sure that I have tested this).
> > 
> 
> I have tried to re-arrange the documentation based on some of your 
> recommendations. I have also left couple of sections empty which are
> ia64 specific. I don't have an IA64 machine and I don't know how exactly
> it is used on IA64. Can you please have a quick look at the patch and
> also fill IA64 specific details where appropriate.

Sure, will do.

> Hopefully, this time documentation is clearer.
> 
> 
> Mohan, Can you please check the correctness of ppc64 specific details.
> 
> > > +   --append="root=<root-dev> init 1 irqpoll maxcpus=1"
> > > +
> > > +If you are using a relocatable kernel (method 2), then use
> > > +following command.
> > >
> > > +   kexec -p <bzImage-of-relocatable-kernel> \
> > > +   --initrd=<initrd-for-relocatable-kernel> \
> > > +   --append="root=<root-dev> init 1 irqpoll maxcpus=1"
> > 
> > --args-linux is not needed on ia64, but its kernel is relocatable.
> > I think the important point is that if you are using a bzImage,
> > then you need --args-linux, and basically at this point that
> > means an i386 (or x86_64) relocatable bzImage.
> > 
> 
> I am hoping it --args-linux will be required while loading vmlinux on
> IA64? Because this is ELF file specific option. And this interface should
> be common across all the architectures.
> 
> > Then again, I could be wrong, I'm not sure that I understand
> > --args-linux, I just know that I'm not using it :)

I will take a look into this.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

