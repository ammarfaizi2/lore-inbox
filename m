Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262931AbUCRUhg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 15:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262926AbUCRUhg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 15:37:36 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:19455 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262942AbUCRUh1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 15:37:27 -0500
Date: Thu, 18 Mar 2004 21:37:19 +0100 (MET)
From: Armin Schindler <armin@melware.de>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 2.6] serialization of kernelcapi work
In-Reply-To: <20040318121826.61c9f145.akpm@osdl.org>
Message-ID: <Pine.LNX.4.31.0403182126360.13676-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004, Andrew Morton wrote:
> Armin Schindler <armin@melware.de> wrote:
> >
> > Hi all,
> >
> > the ISDN kernelcapi function recv_handler() is triggered by
> > schedule_work() and dispatches the CAPI messages to the applications.
> >
> > Since a workqueue function may run on another CPU at the same time,
> > reordering of CAPI messages may occur.
>
> TCP has the same problem.
>
> > For serialization I suggest a mutex semaphore in recv_handler(),
> > patch is appended (yet untested).
>
> It will work OK.  It isn't very scalable of course, but I assume you're
> dealing with relatively low bandwidths.

Right, compared with network, I guess it is low bandwith.

> I would suggest that you look at avoiding the global semaphore.  Suppose
> someone has 64 interfaces or something.  Is that possible?  It might be
> better to put the semaphore into struct capi_ctr so you can at least
> process frames from separate cards in parallel.

This was just mentioned on the i4l-developer list too.
But not on capi_ctr basis, a semaphore per application (struct capi20_appl)
should be better.

The reason for the serialization is a possible re-ordering of messages
per application, so only the application needs the semaphore.

Thanks Andrew, I will prepare a new patch.

Armin


