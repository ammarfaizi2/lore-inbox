Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbRLXLJW>; Mon, 24 Dec 2001 06:09:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284727AbRLXLJM>; Mon, 24 Dec 2001 06:09:12 -0500
Received: from hal.grips.com ([62.144.214.40]:39913 "EHLO hal.grips.com")
	by vger.kernel.org with ESMTP id <S284717AbRLXLJC>;
	Mon, 24 Dec 2001 06:09:02 -0500
Message-Id: <200112241108.fBOB8oi28275@hal.grips.com>
Content-Type: text/plain; charset=US-ASCII
From: Gerold Jury <gjury@hal.grips.com>
To: <mingo@elte.hu>
Subject: Re: aio
Date: Mon, 24 Dec 2001 12:08:49 +0100
X-Mailer: KMail [version 1.3.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112211446370.5098-100000@localhost.localdomain> <200112211527.fBLFR6X07357@hal.grips.com>
In-Reply-To: <200112211527.fBLFR6X07357@hal.grips.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Friday 21 December 2001 14:48, Ingo Molnar wrote:
> > is this a fundamental limitation expressed in the interface, or just an
> > implementational limitation? On sockets this is indeed a big problem,
> > HTTP pipelining wants completely separate receive/send queues.
> >
> > 	Ingo
>

I got the _POSIX_SYNCHRONIZED_IO completely wrong.
It has nothing to do with the ordering of the aio read/write requests.

Aio_read and aio_write work with absolute positions inside the file size.
The order of requests is unspecified in SUSV V2.
SUSV V2 does neither prevent nor force the desired behaviour.

It seems like it is up to the implementation how to deal with the request 
order.
As mentioned earlier, SGI-kaio does the right thing with the same interface.

I want to add, that a combination of sigwaitinfo / sigtimedwait and aio is a 
very efficient way to deal with sockets. The accept may be handled with real 
time signals as well by using fcntl F_SETSIG and F_SETFL FASYNC.


Gerold

