Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130406AbRAPL1A>; Tue, 16 Jan 2001 06:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130548AbRAPL0u>; Tue, 16 Jan 2001 06:26:50 -0500
Received: from chiara.elte.hu ([157.181.150.200]:15121 "HELO chiara.elte.hu")
	by vger.kernel.org with SMTP id <S130406AbRAPL0j>;
	Tue, 16 Jan 2001 06:26:39 -0500
Date: Tue, 16 Jan 2001 12:26:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andi Kleen <ak@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        dean gaudet <dean-list-linux-kernel@arctic.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Jonathan Thackray <jthackray@zeus.com>
Subject: Re: 'native files', 'object fingerprints' [was: sendpath()]
In-Reply-To: <20010116121323.A31583@gruyere.muc.suse.de>
Message-ID: <Pine.LNX.4.30.0101161217001.2352-100000@elte.hu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 16 Jan 2001, Andi Kleen wrote:

> On Tue, Jan 16, 2001 at 10:48:34AM +0100, Ingo Molnar wrote:
> > this is a safe, very fast [ O(1) ] object-permission model. (it's a
> > variation of a former idea of yours.) A process can pass object
> > fingerprints and kernel pointers to other processes too - thus the other
> > process can access the object too. Threads will 'naturally' share objects,
> >...
>
> Just setuid etc. doesn't work with that because access cannot be
> easily revoked without disturbing other clients.

well, you cannot easily close() an already shared file descriptor in
another process's context either. Is revocation so important? Why is
setuid() a problem? A native file is just like a normal file, with the
difference that not an integer but a fingerprint identifies it, and that
access and usage counts are not automatically inherited across some
explicit sharing interface.

perhaps we could get most of the advantages by allowing the relaxation of
the 'allocate first free file descriptor number' rule for normal Unix
files?

> Also the model depends on good secure random numbers, which is
> questionable in many environments (e.g. a diskless box where the
> random device effectively gets no new input)

true, although newer chipsets include hardware random generators. But
indeed, object fingerprints (tokens? ids?) make the random generator a
much more central thing.

	Ingo

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
