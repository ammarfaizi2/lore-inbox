Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129315AbRBAEWn>; Wed, 31 Jan 2001 23:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129649AbRBAEWe>; Wed, 31 Jan 2001 23:22:34 -0500
Received: from smtp1.kolumbus.fi ([193.229.0.36]:43109 "EHLO smtp1.kolumbus.fi")
	by vger.kernel.org with ESMTP id <S129315AbRBAEW2> convert rfc822-to-8bit;
	Wed, 31 Jan 2001 23:22:28 -0500
Message-Id: <200102010413.GAA26280@smtp1.kolumbus.fi>
Date: Thu, 1 Feb 2001 1:28 +0200
From: jukka.santala@kolumbus.fi
Subject: VAST: Re: 2.4.X inode cache bug
To: Quim K Holland <qkholland@my-deja.com>
Cc: linux-kernel@vger.kernel.org, jukka.santala@kolumbus.fi,
        jukka.santala@kolumbus.fi
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quim K Holland <qkholland@my-deja.com> wrote:
> Then maybe the attached patch is what you want?  This also replaces
> `+' on the next line with `^' to avoid slanted distribution.

Thanks. The use of + in a hash-formula is usually all right, though. It's
XOR with carry propagation; when there's some pattern or cycicity to
the value being hashed, carry propagation is even a desired quality. And
due to being a common operation, it's usually at least as fast as XOR.
Ofcourse, the sum of multiple random values tends to normalize (ie. the
distribution is normal-distribution) but since the upper bits are
discarded, this isn't a big problem.

For a really fast version of this hash-function, I would just sum up the
upper 32 bits of the inode with the lower 32 bits, and then again the
upper 16 bits of he result with lower 16 bits, using carry. Then take as
many lower bits as needed. Usually hash-table sizes should be prime
numbers, but I predict through profiling would show modulo-operation
to take more time than scanning the bucket in typical cases.

If cache-affinity was desired, one should be familiar with the
associativity rules on target platform, however the practical effect is
normally to just reduce the effective hash-taable size.

 -Donwulff




-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
