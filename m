Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313733AbSDPQAn>; Tue, 16 Apr 2002 12:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313732AbSDPQAm>; Tue, 16 Apr 2002 12:00:42 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:37136 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313733AbSDPP7k>; Tue, 16 Apr 2002 11:59:40 -0400
Date: Tue, 16 Apr 2002 08:56:59 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Lang <david.lang@digitalinsight.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Vojtech Pavlik <vojtech@suse.cz>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 36
In-Reply-To: <E16xVSi-0000FN-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204160849540.1244-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Apr 2002, Alan Cox wrote:
>
> We need to support partitioning on loopback devices in that case.

No, you just need to do the loopback over nbd - you need something to do
the byte swapping anyway (ie you can't really use the normal "loop"
device: I really just meant the more generic "loop the data back"
approach).

nbd devices already do partitioning, I'm fairly certain.

(But no, I've never tested it, obviously).

Btw, while I'm at it - who out there actually uses the new "enbd"
(Enhanced NBD)? I have this feeling that that would be the better choice,
since unlike plain nbd it should be deadlock-free on localhost (ie you
don't need a remote machine).

> > The only reason byteswapping exists is a rather historical one: Linux did
> > the wrong thing for "insw/outsw" on big-endian architectures at one point
> > (it byteswapped the data).
>
> A small number of other setups people wired the IDE the quick and easy
> way and their native format is indeed ass backwards - some M68K disks and
> the Tivo are examples of that. Interworking requires byteswapping and the
> ability to handle byteswapped partition tables.

Note that THAT case is an architecture issue, and should probably be
handled by just making the IDE "insw" macro do the byteswapping natively.
That way you don't get the current "it can actually corrupt your
filesystem on SMP" behaviour.

(Although I suspect that none of the architectures in question have ever
even jokingly considered SMP support ;)

			Linus

