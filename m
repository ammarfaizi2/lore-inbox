Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266291AbUI0PDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266291AbUI0PDh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 11:03:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266311AbUI0PDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 11:03:37 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:49614 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266291AbUI0PDf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 11:03:35 -0400
Date: Mon, 27 Sep 2004 08:03:03 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [time] add support for CLOCK_THREAD_CPUTIME_ID and
 CLOCK_PROCESS_CPUTIME_ID
In-Reply-To: <41558C6D.4050305@redhat.com>
Message-ID: <Pine.LNX.4.58.0409270757200.30127@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <Pine.LNX.4.58.0409250743230.15887@schroedinger.engr.sgi.com>
 <41558C6D.4050305@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 25 Sep 2004, Ulrich Drepper wrote:

> > Yes and glibc will have to get through contortions to
> > simulate a clock that returns the actual cpu time used. Why not cleanly
> > do the clock_gettime syscall without doing any redirection of clocks?
>
> First of all, unnecessary kernel code where it is not needed.  And
> second, because with the definition of the CPUTIME clock in use for many
> years now not all variants can be handled in the kernel.  We use this
> clock to provide access to the TSC functionality.  This is nothing the
> kernel does.

The kernel can do the same now in a much more reliable way since it can
produce time with nanosecond accuracy.

> > Any implementation of the CPUTIME clocks is always easier to do in the
> > kernel with just a few lines.
>
> No, you don't know the glibc side.

Yes, I do know that in detail. I have proposed numerous patches for this
issue to glibc-alpha.

> > Ok, I will dig out my old patch and repost it to glibc-alpha.
>
> I haven't gotten an answer to the question "is there really any value in
> this kind of clock?".

My old patches implement what you suggested: fallback to CLOCK_REALTIME in
glibc if the cputimer is not reliable.

I do not really understand your question. The CLOCK_PROCESS_CPUTIME_ID is
a clock mandated by the POSIX standard and it should work reliably. There
is no question that this clock must be provided.

I do not care how it is done as long as it always works reliably. It is IMHO
the best solution to put that into the kernel since glibc does not really
have all the information available to provide this clock (f.e. the
information obtained via TSC is not adjusted properly since the kernel
time adjustments will not be applied to it) but I will respect your
preferred way to solving this issue.
