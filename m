Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265887AbUJEUza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265887AbUJEUza (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265900AbUJEUza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:55:30 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:21916 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S265887AbUJEUz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:55:28 -0400
Date: Tue, 5 Oct 2004 13:53:44 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Roland McGrath <roland@redhat.com>
cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ulrich Drepper <drepper@redhat.com>
Subject: Re: [PATCH] CPU time clock support in clock_* syscalls
In-Reply-To: <200410051838.i95IcSgC006889@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0410051350360.28733@schroedinger.engr.sgi.com>
References: <200410051838.i95IcSgC006889@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Oct 2004, Roland McGrath wrote:

> > I just reviewed the code and to my surprise the simple things like
> >
> > clock_gettime(CLOCK_PROCESS_CPUTIME_ID) and
> > clock_gettime(CLOCK_THREAD_CPUTIME_ID) are not supported.
>
> You seem to be confused.  A clockid_t for a CPU clock encodes a PID, which
> can be zero to indicate the current thread or current process.

Is there a standard for that? Or is it an opaque type that you have
defined this way?

> > The thread specific time measurements have nothing to do with the posix
> > standard and may best be kept separate.
>
> Nonsense.  POSIX defines the notion of CPU clocks for these calls, and that
> is what I have implemented.

Posix only defines a process and a thread clock. This is much more.

> Of course glibc is in charge of what the meaning of the POSIX APIs is.
> That is true for every call.

The proper information to realize these clocks is only available on the
kernel level. A clean API for that would remove lots of code that
currently exists in glibc.

I wonder how glibc will realize access to special timer hardware. Will
glibc be able load device drivers for timer chips?

