Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267643AbSLFW1U>; Fri, 6 Dec 2002 17:27:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267644AbSLFW1U>; Fri, 6 Dec 2002 17:27:20 -0500
Received: from [195.223.140.107] ([195.223.140.107]:13186 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S267643AbSLFW1S>;
	Fri, 6 Dec 2002 17:27:18 -0500
Date: Fri, 6 Dec 2002 23:34:59 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>,
       Arjan van de Ven <arjanv@redhat.com>, Andrew Morton <akpm@digeo.com>,
       Norman Gaywood <norm@turing.une.edu.au>, linux-kernel@vger.kernel.org
Subject: Re: Maybe a VM bug in 2.4.18-18 from RH 8.0?
Message-ID: <20021206223459.GG4335@dualathlon.random>
References: <20021206111326.B7232@turing.une.edu.au> <3DEFF69F.481AB823@digeo.com> <20021206011733.GF1567@dualathlon.random> <3DEFFEAA.6B386051@digeo.com> <20021206014429.GI1567@dualathlon.random> <20021206021559.GK9882@holomorphy.com> <1039170975.1432.5.camel@laptop.fenrus.com> <20021206142302.GC11023@holomorphy.com> <20021206151238.GE11023@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021206151238.GE11023@holomorphy.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 06, 2002 at 07:12:38AM -0800, William Lee Irwin III wrote:
> split just to get a bloated mem_map to fit. Many of the smaller apps,
> e.g. /bin/sh etc. are indifferent to the ABI violation.

the problem of the split is that it would reduce the address space
available to userspace that is quite critical on big machines (one of
the big advantages of 64bit that can't be fixed on 32bit) but I wouldn't
classify it as an ABI violation, infact the little I can remember about
the 2.0 kernels [I almost never read that code] is that it had shared
address space and tlb flush while entering/exiting kernel, so I can bet
the user stack in 2.0  was put at 4G, not at 3G. 2.2 had to put it at 3G
because then the address space was shared with the obvious performance
advantages, so while I didn't read any ABI, I deduce you can't say the
ABI got broken if the stack is put at 2G or 1G or 3.5G or 4G again with
x86-64 (of course x86-64 can give the full 4G to userspace because the
kernel runs in the negative part of the [64bit] address space, as 2.0
could too).

Andrea
