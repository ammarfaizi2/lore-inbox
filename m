Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965170AbWI0F2S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965170AbWI0F2S (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 01:28:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965340AbWI0F2S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 01:28:18 -0400
Received: from sv1.valinux.co.jp ([210.128.90.2]:9098 "EHLO sv1.valinux.co.jp")
	by vger.kernel.org with ESMTP id S965170AbWI0F2R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 01:28:17 -0400
Date: Wed, 27 Sep 2006 14:27:38 +0900
From: Horms <horms@verge.net.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Valdis.Kletnieks@vt.edu, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Stupid kexec/kdump question...
Message-ID: <20060927052737.GA17214@verge.net.au>
References: <200609261525.k8QFP6j4022389@turing-police.cc.vt.edu> <20060926221029.d9e87650.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060926221029.d9e87650.akpm@osdl.org>
User-Agent: mutt-ng/devel-r804 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2006 at 10:10:29PM -0700, Andrew Morton wrote:
> On Tue, 26 Sep 2006 11:25:06 -0400
> Valdis.Kletnieks@vt.edu wrote:
> 
> > OK, I'm running a Fedora Core 6 (rawhide actually) box with -18-mm1 kernel.
> > I've installed kexec-tools and similar, and am trying to get the kernels
> > built following the hints in Documentation/kdump/kdump.txt, but a few
> > questions arise:
> > 
> > 1) Other than the fact that the Fedora userspace looks for a
> > ${kernelvers}kdump kernel, is there any reason the kdump kernel has
> > to match the running one, or can an older kernel be used?

The post-crash kernel is not realy dependant on the pre-crash kernel.
What is important is that either the kernel is relocatable
(which is being worked on for x86 and i386), or it is compiled to
run at a non-default address and that address corresponds
to the region reserved by the crashkernel command line parameter
passed to the pre-crash kernel.

The post-crash kernel will also need CONFIG_CRASH_DUMP 
and likely CONFIG_PROC_VMCORE

> > 2) I'm presuming that a massively stripped down kernel (no sound support,
> > no netfilter, no etc) that just has what's needed to mount the dump location
> > is sufficient?

Yes

> > 3) The docs recommend 'crashkernel=64M@16M', but that's 8% of my memory.
> > What will happen if I try '16M@16M' instead?  Just slower copying due to
> > a smaller buffer cache space, or something more evil?

There is a lower bound to how small you can make the space, which
is basically how little memory space your post-crash kernel needs.
16M is probably pushing it, but 32M should be more than possible.
Experimentation is really the order of the day here.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

