Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbWI0IBf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbWI0IBf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 04:01:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbWI0IBf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 04:01:35 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51137 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932208AbWI0IBe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 04:01:34 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Horms <horms@verge.net.au>
Cc: Andrew Morton <akpm@osdl.org>, fastboot@lists.osdl.org,
       Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] Stupid kexec/kdump question...
References: <200609261525.k8QFP6j4022389@turing-police.cc.vt.edu>
	<20060926221029.d9e87650.akpm@osdl.org>
	<20060927052737.GA17214@verge.net.au>
Date: Wed, 27 Sep 2006 02:00:07 -0600
In-Reply-To: <20060927052737.GA17214@verge.net.au> (horms@verge.net.au's
	message of "Wed, 27 Sep 2006 14:27:38 +0900")
Message-ID: <m1u02toi2g.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horms <horms@verge.net.au> writes:

> On Tue, Sep 26, 2006 at 10:10:29PM -0700, Andrew Morton wrote:
>> On Tue, 26 Sep 2006 11:25:06 -0400
>> Valdis.Kletnieks@vt.edu wrote:
>> 
>> > OK, I'm running a Fedora Core 6 (rawhide actually) box with -18-mm1 kernel.
>> > I've installed kexec-tools and similar, and am trying to get the kernels
>> > built following the hints in Documentation/kdump/kdump.txt, but a few
>> > questions arise:
>> > 
>> > 1) Other than the fact that the Fedora userspace looks for a
>> > ${kernelvers}kdump kernel, is there any reason the kdump kernel has
>> > to match the running one, or can an older kernel be used?
>
> The post-crash kernel is not realy dependant on the pre-crash kernel.
> What is important is that either the kernel is relocatable
> (which is being worked on for x86 and i386), or it is compiled to
> run at a non-default address and that address corresponds
> to the region reserved by the crashkernel command line parameter
> passed to the pre-crash kernel.
>
> The post-crash kernel will also need CONFIG_CRASH_DUMP 
> and likely CONFIG_PROC_VMCORE

hip hip horray!  Getting mismatched kernels to be supported was a long
discussion.

I suspect the reason for the matching kernel from the distros is just
that everything is quite new so they don't want to wonder if you old
kernel has all of the appropriate support, and by that point they can
probably assume the shipped kernel works.

>> > 2) I'm presuming that a massively stripped down kernel (no sound support,
>> > no netfilter, no etc) that just has what's needed to mount the dump location
>> > is sufficient?
>
> Yes
>
>> > 3) The docs recommend 'crashkernel=64M@16M', but that's 8% of my memory.
>> > What will happen if I try '16M@16M' instead?  Just slower copying due to
>> > a smaller buffer cache space, or something more evil?
>
> There is a lower bound to how small you can make the space, which
> is basically how little memory space your post-crash kernel needs.
> 16M is probably pushing it, but 32M should be more than possible.
> Experimentation is really the order of the day here.

At that level I would say that below 32M is where you start dealing with
custom built programs, instead of slapping a bunch of utilities inside
a ramdisk.  I suspect with a little care you could get a few K user
space executable and fit everything inside of 4M.  But I don't know if anyone
is that ambitious yet.

Eric
