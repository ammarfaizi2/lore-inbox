Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266783AbUBGExg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 23:53:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266793AbUBGExe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 23:53:34 -0500
Received: from mail.shareable.org ([81.29.64.88]:38864 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266783AbUBGExc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 23:53:32 -0500
Date: Sat, 7 Feb 2004 04:53:27 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Ulrich Drepper <drepper@redhat.com>, Rik van Riel <riel@redhat.com>,
       Andi Kleen <ak@suse.de>, johnstul@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
Message-ID: <20040207045327.GB14597@mail.shareable.org>
References: <20040205214348.GK31926@dualathlon.random> <Pine.LNX.4.44.0402052314360.5933-100000@chimarrao.boston.redhat.com> <20040206042815.GO31926@dualathlon.random> <40235D0B.5090008@redhat.com> <20040206154906.GS31926@dualathlon.random> <4024333B.6020805@redhat.com> <20040207021954.GD31926@dualathlon.random> <20040207033759.GA8384@nevyn.them.org> <20040207043655.GE31926@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207043655.GE31926@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> (changing three times is worthless in terms of security, all computers
> runs the same bzImage so it's not changing, anyways as Ulrich said this
> can be fixed transparently in "their" kernel)

Andrea, please stop mixing the different arguments.  The three changes
were for technical reasons, not security.

> The bit I care about is that glibc should know about the vsyscall to
> be efficient,

This I agree with,

> and that the offsets should be fixed.

If the vdso position can vary between kernels, there is no real
technical reason why the offsets have to be fixed.  At the simplest,
just like there is AT_SYSINFO to get the generic syscall entry point,
pass an AT_SYSINFO_GTOD for the gettimeofday syscall.  Glibc can use
that with no significant changes to its existing mechanism.

(Although I prefer to use symbols in the vdso because it's cleaner,
AT_SYSINFO_GTOD works.  Another alternative is to have a table of
offsets in the vsyscall page which Glibc can read - future extensible
without the overhead of symbol lookups which Ulrich doesn't like).

-- Jamie

