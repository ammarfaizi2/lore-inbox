Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbULNWSa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbULNWSa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 17:18:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbULNWPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 17:15:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:9675 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261705AbULNWPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 17:15:12 -0500
Date: Tue, 14 Dec 2004 14:14:57 -0800
Message-Id: <200412142214.iBEMEvEI011636@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH 1/7] cpu-timers: high-resolution CPU clocks for POSIX
 clock_* syscalls
In-Reply-To: Christoph Lameter's message of  Tuesday, 14 December 2004 10:36:01 -0800 <Pine.LNX.4.58.0412140939010.1546@schroedinger.engr.sgi.com>
X-Shopping-List: (1) Classical socks
   (2) Satanic absorbers
   (3) Impudent bride polluters
   (4) Buoyant beef
   (5) Despondent frantic imports
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Sounds good.

I'm glad you like it.  Your prior interest and work in this area stimulated
general interest and active discussion, and I think that has contributed to
the likelihood of getting useful functionality available to users ASAP.

> This yields some additional functionality and is an improvement to the
> ABI. Why is CLOCK_*_CPUTIME_ID etc not directly supporting using
> the kernel API? Otherwise the API will take only some of the posix
> clocks defined in the kernel which may surprise authors of other c
> libraries.

It's mainly just to simplify the code.  The CPU clocks did not quite fit
into the k_clock function-table model, though I think that was really the
case more before some k_clock interface cleanups happened.  Now I think it
might be possible to write k_clock hook functions that call into the
posix_cpu_* functions for those small-integer constant clockid_t cases,
though off hand what I would be more confident of would be to handle them
in the existing special case calls.  i.e., if they are supported at all it
might best be by having every call translate CLOCK_*_CPUTIME_ID to
MAKE_*_CPUCLOCK(SCHED, 0) before the < 0 check.  I really don't see the
need to support those values in the kernel interface, which never did
before (though having them in linux/time.h).  But I would not object to it.
I just strongly doubt anyone would ever use it.

> It seems that this code does now support extra clocks like
> CLOCK_REALTIME_HR, CLOCK_MONOTONIC_HR and CLOCK_SGI_CYCLE right?

Here I think you are talking about glibc, not kernel code.  If you mean
this about the kernel code, then please clarify (and I'm not sure what the
question means in that context).  If you are asking about the glibc code,
please take that to the libc mailing list and we won't bother the kernel
folks with that discussion.


Thanks,
Roland
