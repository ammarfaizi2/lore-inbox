Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261165AbVBDMFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261165AbVBDMFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 07:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVBDMFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 07:05:12 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49286 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261153AbVBDME7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 07:04:59 -0500
To: Hirokazu Takahashi <taka@valinux.co.jp>, akpm@osdl.org, suparna@in.ibm.com,
       fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] Reserving backup region for kexec based crashdumps.
References: <m1zmym6m6z.fsf@ebiederm.dsl.xmission.com>
	<20050203.191039.39155205.taka@valinux.co.jp>
	<m18y666i6u.fsf@ebiederm.dsl.xmission.com>
	<20050204.190509.112624049.taka@valinux.co.jp>
	<m1hdks60cr.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 04 Feb 2005 05:02:42 -0700
In-Reply-To: <m1hdks60cr.fsf@ebiederm.dsl.xmission.com>
Message-ID: <m13bwc5y8t.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Hirokazu Takahashi <taka@valinux.co.jp> writes:
> > > Most of this just results in easier management between the pieces.
> > > Which is a good thing.  However at the moment I don't think it
> > > simplifies any of the core problems.  I still need to reserve
> > > a large hunk of physical address space early on before any
> > > DMA transactions are setup to hold the new kernel.
> > 
> > I agree that my idea is not essential at the moment.
> > 
> > > So while I am happy to see patches that improve this I don't
> > > actually care right now.
> > 
> > ok.

Thinking about this some more this does have a significant aspect
on the design.  For architectures that support this, on the
primary kernel the command line option becomes:
crashkernel=size instead of crashkernel=size@location.
Which means the kernel needs to call alloc_bootmem instead
of reserve_bootmem.  So it results in a primary kernel implementation
difference.

In addition if we really can push all of the dump specific
functionality into user space as it appears we can, this allows a
generic kernel to be used for the crash dump process.  It will
probably still be a special hardened build where reliability is
more important than performance.  So that any micro hit we take in
performance by modifying __pa() and __va() will be irrelevant.

I like it.

I have already demonstrated that there is a general technique that
any architecture can use to build a kernel that runs at a non-default
address.  So for the architectures that cannot build a PIC kernel
there is still a proven solution available, it simply will not
be as nice to manage.

x86_64 should pretty straight forward.  i386 will be a little more
difficult but doable.

Patches are still welcome.

Eric
