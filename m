Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751170AbWI0N0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751170AbWI0N0G (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 09:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbWI0N0F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 09:26:05 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:23979 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751181AbWI0N0E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 09:26:04 -0400
Date: Wed, 27 Sep 2006 09:24:20 -0400
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Valdis.Kletnieks@vt.edu
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@osdl.org>,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Stupid kexec/kdump question...
Message-ID: <20060927132420.GB2514@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <200609261525.k8QFP6j4022389@turing-police.cc.vt.edu> <20060926221029.d9e87650.akpm@osdl.org> <20060927052737.GA17214@verge.net.au> <m1u02toi2g.fsf@ebiederm.dsl.xmission.com> <200609271251.k8RCpp6X029724@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200609271251.k8RCpp6X029724@turing-police.cc.vt.edu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2006 at 08:51:50AM -0400, Valdis.Kletnieks@vt.edu wrote:
> On Wed, 27 Sep 2006 02:00:07 MDT, Eric W. Biederman said:
> 
> > I suspect the reason for the matching kernel from the distros is just
> > that everything is quite new so they don't want to wonder if you old
> > kernel has all of the appropriate support, and by that point they can
> > probably assume the shipped kernel works.
> 
> And careful reading of the Fedora scripts shows how to provide your
> own custom kernel/initrd pair. Setting the right variable in the right
> config file will use that - if it's unset, it will go with a kernel
> named ${kernelversion}kdump.
> 
> > >> > 2) I'm presuming that a massively stripped down kernel (no sound support,
> > >> > no netfilter, no etc) that just has what's needed to mount the dump location
> > >> > is sufficient?
> > >
> > > Yes
> 
> I'm definitely submitting a doc patch to explain all this in more detail, as
> soon as I get it figured out enough. ;)
> 
> > >> > 3) The docs recommend 'crashkernel=64M@16M', but that's 8% of my memory.
> > >> > What will happen if I try '16M@16M' instead?  Just slower copying due to
> > >> > a smaller buffer cache space, or something more evil?
> > >
> > > There is a lower bound to how small you can make the space, which
> > > is basically how little memory space your post-crash kernel needs.
> > > 16M is probably pushing it, but 32M should be more than possible.
> > > Experimentation is really the order of the day here.
> > 
> > At that level I would say that below 32M is where you start dealing with
> > custom built programs, instead of slapping a bunch of utilities inside
> > a ramdisk.  I suspect with a little care you could get a few K user
> > space executable and fit everything inside of 4M.  But I don't know if anyone
> > is that ambitious yet.
> 
> Well, the stripped down kernel is right around 2M.  Unfortunately, I need
> to run lvm.static, which is another 1.5M at least.  So unless busybox has
> grown support for LVM, I'm looking at 8M at best.
> 

Distros don't want to build and ship an additional kernel just for dumping
purposes. They want to use production kernel as binary itself as dump
capture kernel. It reduces overheads for them significantly.

Currently we are reserving 64MB of memory for our testing purposes on 
i386 and x86_64. Any thing lesser than that, sometimes either system
hangs or OOM killer pitches in. Now people are working on preparing custom
initrd for dumping purposes so that dumping can be done from early user
space itself. This might lead to reduced memory usage and more reliability.
I think soon it should be available in fedora (busybox based custom initrd
for crashdumping purposes.)

-Vivek
