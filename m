Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269340AbUIYOvv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269340AbUIYOvv (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 10:51:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269344AbUIYOvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 10:51:51 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:58524 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269340AbUIYOvt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 10:51:49 -0400
Date: Sat, 25 Sep 2004 07:51:32 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [time] add support for CLOCK_THREAD_CPUTIME_ID and
 CLOCK_PROCESS_CPUTIME_ID
In-Reply-To: <41550B77.1070604@redhat.com>
Message-ID: <Pine.LNX.4.58.0409250743230.15887@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Ulrich Drepper wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Christoph Lameter wrote:
>
> > Then please sign off on the following patch:
>
> Sorry, I fail to see the point.  The CPUTIME stuff will either way be
> entire implemented at userlevel.  If we use TSC, we compute the
> resolution from the CPU clock speed (no need to comment, I know it's not
> reliable everywhere).  If we fall back on realtime, we will simply in
> glibc map

I thought I heard you asking for CPUTIME returning the actual cputime
used in the last message. I have proposed falling back to realtime in the
past but that was not acceptable.

>
>    clock_getres (CLOCK_PROCESS_CPUTIME_ID, &ts)
>
> to
>
>    clock_getres (CLOCK_REALTIME, &ts)
>
> The kernel knows nothing about this clock.

Yes and glibc will have to get through contortions to
simulate a clock that returns the actual cpu time used. Why not cleanly
do the clock_gettime syscall without doing any redirection of clocks?

Any implementation of the CPUTIME clocks is always easier to do in the
kernel with just a few lines.

> The comment changes are OK, of course.
>
> If there is more to change this is in glibc.  So far I have not heard of
> anybody wanting to use the clocks this way.  This is why we do not have
> the fallback to realtime implemented.  If you say you need it I have no
> problem adding appropriate patches.

Ok, I will dig out my old patch and repost it to glibc-alpha.
