Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132106AbQLJWZk>; Sun, 10 Dec 2000 17:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135241AbQLJWZ3>; Sun, 10 Dec 2000 17:25:29 -0500
Received: from 62-6-231-238.btconnect.com ([62.6.231.238]:28423 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S132106AbQLJWZ1>;
	Sun, 10 Dec 2000 17:25:27 -0500
Date: Sun, 10 Dec 2000 21:57:05 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.30.0012102346130.5455-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0012102152440.5361-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Szabolcs Szakacsits wrote:
> 
> - this comment from include/linux/fs.h should be deleted
>   #define NR_RESERVED_FILES 10 /* reserved for root */

well, not really -- it is "reserved" right now too, it is just root is
allowed to use up all the reserved entries in the beginning and then when
the normal user uses up all the "non-reserved" ones (from slab
cache) there would be nothing left for the root.

But let us not argue about the above definition of "reserved" -- that is
not productive. Let's do something productive -- namely, take your idea to
the next logical step. Since you have proven that the freelist mechanism
or concept of "reserve file structures" is not 100% satisfactory as is
then how about removing the freelist altogether? I.e. what about serving
each allocation request directly from the slab cache and imposing any
"reserved for root" policy purely by the nr_xxx_files counters?

The only argument against such idea would be "taking elements off the
freelist is probably faster than allocating from slab". But maybe not? Who
measured it? if slab allocator is so fast that the difference is
negligible then applying the same idea all over the kernel (e.g. to
superblocks etc) will remove a lot of code, which is a good thing.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
