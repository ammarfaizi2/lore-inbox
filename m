Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265331AbUJEVXG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265331AbUJEVXG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 17:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266009AbUJEVXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 17:23:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:57227 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265331AbUJEVXC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 17:23:02 -0400
Date: Tue, 5 Oct 2004 14:22:49 -0700
Message-Id: <200410052122.i95LMntn007340@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Christoph Lameter <clameter@sgi.com>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: Christoph Lameter's message of  Tuesday, 5 October 2004 13:53:44 -0700 <Pine.LNX.4.58.0410051350360.28733@schroedinger.engr.sgi.com>
Emacs: the prosecution rests its case.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a standard for that? Or is it an opaque type that you have
> defined this way?

Of course there is no standard for the bits used in a clockid_t.  This is
an implementation detail in POSIX terms.  POSIX defines function interfaces
to return clockid_t values (clock_getcpuclockid, pthread_getcpuclockid).  
I have chosen the kernel-user ABI for Linux clockid_t's here, but that is
only of concern to the kernel and glibc.

> Posix only defines a process and a thread clock. This is much more.

Like I said the first time, it's three kinds of clocks.  One is what we
will in future use to define POSIX's CPUTIME clocks in our POSIX
implementation, and the other two are what we already use to define
ITIMER_REAL/ITIMER_VIRTUAL in our existing POSIX implementation.

> I wonder how glibc will realize access to special timer hardware. Will
> glibc be able load device drivers for timer chips?

glibc has zero interest in doing any of that.  It will use the single new
"best information" kernel interface when that is available, and it's the
kernel's concern what the best information available from the hardware is.



Thanks,
Roland
