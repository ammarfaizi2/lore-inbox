Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129810AbRABV1S>; Tue, 2 Jan 2001 16:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129983AbRABV1J>; Tue, 2 Jan 2001 16:27:09 -0500
Received: from baldur.fh-brandenburg.de ([195.37.0.5]:48775 "HELO
	baldur.fh-brandenburg.de") by vger.kernel.org with SMTP
	id <S129810AbRABV07>; Tue, 2 Jan 2001 16:26:59 -0500
Date: Tue, 2 Jan 2001 21:44:42 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: "David S. Miller" <davem@redhat.com>
cc: matthew@wil.cx, grundler@cup.hp.com, linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk, parisc-linux@thepuffingroup.com
Subject: Re: [PATCH] move xchg/cmpxchg to atomic.h
In-Reply-To: <200101021121.DAA14657@pizda.ninka.net>
Message-ID: <Pine.GSO.4.10.10101022125570.20383-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2 Jan 2001, David S. Miller wrote:

>    We really can't.  We _only_ have load-and-zero.  And it has to be
>    16-byte aligned.  xchg() is just not something the CPU implements.
> 
> Oh bugger... you do have real problems.

For 2.5 we could move all the atomic functions from atomic.h, bitops.h,
system.h and give them a common interface. We could also give them a new
argument atomic_spinlock_t, which is a normal spinlock, but only used on
architectures which need it, everyone else can "optimize" it away. I think
one such lock per major subsystem should be enough, as the lock is only
held for a very short time, so contentation should be no problem.
Anyway, this had the huge advantage that we could use the complete 32/64
bit of the atomic value, e.g. for pointer operations.

bye, Roman


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
