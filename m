Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264643AbSLGSVa>; Sat, 7 Dec 2002 13:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264646AbSLGSVa>; Sat, 7 Dec 2002 13:21:30 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:50290 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S264643AbSLGSVM>; Sat, 7 Dec 2002 13:21:12 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
References: <20021206111326.B7232@turing.une.edu.au>
	<3DEFF69F.481AB823@digeo.com>
	<20021206011733.GF1567@dualathlon.random>
	<3DEFFEAA.6B386051@digeo.com>
	<20021206014429.GI1567@dualathlon.random>
	<20021206021559.GK9882@holomorphy.com>
	<1039170975.1432.5.camel@laptop.fenrus.com>
	<20021206142302.GC11023@holomorphy.com>
	<20021206151238.GE11023@holomorphy.com>
	<20021206223459.GG4335@dualathlon.random>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 07 Dec 2002 11:27:23 -0700
In-Reply-To: <20021206223459.GG4335@dualathlon.random>
Message-ID: <m17kelwupg.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> On Fri, Dec 06, 2002 at 07:12:38AM -0800, William Lee Irwin III wrote:
> > split just to get a bloated mem_map to fit. Many of the smaller apps,
> > e.g. /bin/sh etc. are indifferent to the ABI violation.
> 
> the problem of the split is that it would reduce the address space
> available to userspace that is quite critical on big machines (one of
> the big advantages of 64bit that can't be fixed on 32bit) but I wouldn't
> classify it as an ABI violation, infact the little I can remember about
> the 2.0 kernels [I almost never read that code] is that it had shared
> address space and tlb flush while entering/exiting kernel, so I can bet
> the user stack in 2.0  was put at 4G, not at 3G. 2.2 had to put it at 3G
> because then the address space was shared with the obvious performance
> advantages, so while I didn't read any ABI, I deduce you can't say the
> ABI got broken if the stack is put at 2G or 1G or 3.5G or 4G again with
> x86-64 (of course x86-64 can give the full 4G to userspace because the
> kernel runs in the negative part of the [64bit] address space, as 2.0
> could too).

As I remember it 2.0 used the 3/1 split the difference was that
segments had different base register values.  So the kernel though it
was running at 0.  %fs which retained a base address of 0 was used
when access to user space was desired.

Eric
