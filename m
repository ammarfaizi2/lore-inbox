Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263554AbUCTWUY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Mar 2004 17:20:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUCTWUY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Mar 2004 17:20:24 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:49351 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S263554AbUCTWUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Mar 2004 17:20:23 -0500
Date: Sat, 20 Mar 2004 23:20:15 +0100 (MET)
From: Armin Schindler <armin@melware.de>
To: Andrew Morton <akpm@osdl.org>
cc: <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>
Subject: Re: [PATCH 2.6] serialization of kernelcapi work
In-Reply-To: <20040320130509.660c350e.akpm@osdl.org>
Message-ID: <Pine.LNX.4.31.0403202311030.27784-100000@phoenix.one.melware.de>
Organization: Cytronics & Melware
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:4f0aeee4703bc17a8237042c4702a75a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 Mar 2004, Andrew Morton wrote:
> Armin Schindler <armin@melware.de> wrote:
> >
> > > However you are limiting things so only a single CPU can run `work to do'
> >  > at any time, same as with a semaphore.
> >
> >  Well, limiting the 'work to do' to one CPU is exactly what I need to do,
> >  the code must not run on another CPU at the same time.
>
> Across the entire kernel?  For *all* ISDN connections and interfaces?

Actually yes, for incoming messages.

> Surely there must be some finer-grained level at which the serialisation is
> needed - per-inteface, per-connection, per-session, whatever?

All incoming CAPI messages are queued in one global list and then the work
is scheduled. The recv_handler() is just a dispatcher, which dequeues all
new messages and puts them into the right queue for the application to read.

"the code must not run on another CPU at the same time" is not quite
correct. The code itself may run more than once of course, just the
dequeue-from-global-queue and put into application-queue sequence may
not run twice for the same application.

Armin

