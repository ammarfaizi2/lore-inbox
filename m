Return-Path: <linux-kernel-owner+w=401wt.eu-S1161281AbXAMEGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161281AbXAMEGw (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 23:06:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbXAMEGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 23:06:49 -0500
Received: from koto.vergenet.net ([210.128.90.7]:55994 "EHLO koto.vergenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161269AbXAMEGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 23:06:47 -0500
Date: Sat, 13 Jan 2007 13:03:45 +0900
From: Horms <horms@verge.net.au>
To: Jay Lan <jlan@sgi.com>
Cc: "Zou, Nanhai" <nanhai.zou@intel.com>, Andrew Morton <akpm@osdl.org>,
       linux-ia64@vger.kernel.org, "Luck, Tony" <tony.luck@intel.com>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] Kdump documentation update for 2.6.20: ia64 portion
Message-ID: <20070113040343.GA6227@verge.net.au>
References: <20070112060724.GC17379@verge.net.au> <10EA09EFD8728347A513008B6B0DA77A086BAA@pdsmsx411.ccr.corp.intel.com> <20070112090043.GA27340@verge.net.au> <45A7E59F.7020207@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45A7E59F.7020207@sgi.com>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 12, 2007 at 11:46:39AM -0800, Jay Lan wrote:
> Horms wrote:
> > Hi,
> > 
> > this patch fills in the portions for ia64 kexec.
> > 
> > I'm actually not sure what options are required for the dump-capture
> > kernel, but "init 1 irqpoll maxcpus=1" has been working fine for me.
> > Or more to the point, I'm not sure if irqpoll is needed or not.
> > 
> > This patch requires the documentation patch update that Vivek Goyal has
> > been circulating, and I believe is currently in mm. Feel free to fold it
> > into that change if it makes things easier for anyone.
> > 
> > Take II
> > 
> > Nanhai,
> > 
> > I have noted that vmlinux.gz may also be used. And added a note about the
> > kernel being able to automatically place the crashkernel region.
> > Furthermore, I added a note that if manually specified, the region should
> > be 64Mb aligned to avoid wastage. I notice that the auto placement code
> > uses 64Mb. But is this strictly neccessary for all page sizes?
> > 
> > Signed-off-by: Simon Horman <horms@verge.net.au>
> > 
> > Index: linux-2.6/Documentation/kdump/kdump.txt
> > ===================================================================
> > --- linux-2.6.orig/Documentation/kdump/kdump.txt	2007-01-12 17:45:19.000000000 +0900
> > +++ linux-2.6/Documentation/kdump/kdump.txt	2007-01-12 17:59:42.000000000 +0900
> > @@ -17,7 +17,7 @@
> >  memory image to a dump file on the local disk, or across the network to
> >  a remote system.
> >  
> > -Kdump and kexec are currently supported on the x86, x86_64, ppc64 and IA64
> > +Kdump and kexec are currently supported on the x86, x86_64, ppc64 and ia64
> >  architectures.
> >  
> >  When the system kernel boots, it reserves a small section of memory for
> > @@ -229,7 +229,23 @@
> >  
> >  Dump-capture kernel config options (Arch Dependent, ia64)
> >  ----------------------------------------------------------
> > -(To be filled)
> > +
> > +- No specific options are required to create a dump-capture kernel
> > +  for ia64, other than those specified in the arch idependent section
> > +  above. This means that it is possible to use the system kernel
> > +  as a dump-capture kernel if desired.
> > +  
> > +  The crashkernel region can be automatically placed by the system
> > +  kernel at run time. This is done by specifying the base address as 0,
> > +  or omitting it all together.
> 
> In my testing, i found the base address was ignored. Whatever value
> specified was fine. Not necessary to be 0. But i guess it is fine to
> give people a guideline telling them to specify 0.

I submitted a patch to honour non-zero base addresses,
I'm pretty sure it is in there now.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

