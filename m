Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129909AbQLEXVv>; Tue, 5 Dec 2000 18:21:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129912AbQLEXVm>; Tue, 5 Dec 2000 18:21:42 -0500
Received: from wire.cadcamlab.org ([156.26.20.181]:6662 "EHLO
	wire.cadcamlab.org") by vger.kernel.org with ESMTP
	id <S129909AbQLEXVe>; Tue, 5 Dec 2000 18:21:34 -0500
From: Peter Samuelson <peter@cadcamlab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14893.28991.629652.495045@wire.cadcamlab.org>
Date: Tue, 5 Dec 2000 16:50:39 -0600 (CST)
To: Tigran Aivazian <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch-2.4.0-test12-pre5] optimized get_empty_filp()
In-Reply-To: <20001205160014.G6567@cadcamlab.org>
	<Pine.LNX.4.21.0012052229190.1683-100000@penguin.homenet>
X-Mailer: VM 6.75 under 21.1 (patch 12) "Channel Islands" XEmacs Lucid
X-Face: ?*2Jm8R'OlE|+C~V>u$CARJyKMOpJ"^kNhLusXnPTFBF!#8,jH/#=Iy(?ehN$jH
        }x;J6B@[z.Ad\Be5RfNB*1>Eh.'R%u2gRj)M4blT]vu%^Qq<t}^(BOmgzRrz$[5
        -%a(sjX_"!'1WmD:^$(;$Q8~qz\;5NYji]}f.H*tZ-u1}4kJzsa@id?4rIa3^4A$
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  [Peter Samuelson]
> > Whether a memset of 92 bytes (on 32-bit arch), plus an
> > atomic_set(), are worth deserializing, I do not know.

[Tigran Aivazian]
> Of course, they are worth it. Actually, I don't understand how can
> you even doubt it?

Clearly we are talking at cross-purposes here.  I do realize that
spin_lock+spin_unlock have a non-zero cost.

The question is whether or not it is worth taking a lock again (with
that non-zero cost) to achieve the gain of doing the 92-byte memset and
the atomic_set in parallel with other CPUs.  In other words, by locking
and unlocking twice, you reduce the contention on the lock.  Is this,
however, worth the extra cycles and bus traffic?  I don't know.

> Even a single cycle of code executed for _no reason_ must be removed,
> if for no other reason than to make the code easier to understand and
> prevent people from asking questions like "why does X do Y for no
> reason?"

Taken to its logical conclusion, you are arguing for Linux 2.0.x SMP.
Nobody takes any locks at all, except the BKL at kernel entry points.
Clearly that is suboptimal for contention.

Peter
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
