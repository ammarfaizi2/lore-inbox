Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269207AbRHGRJp>; Tue, 7 Aug 2001 13:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269202AbRHGRJf>; Tue, 7 Aug 2001 13:09:35 -0400
Received: from vindaloo.ras.ucalgary.ca ([136.159.55.21]:35462 "EHLO
	vindaloo.ras.ucalgary.ca") by vger.kernel.org with ESMTP
	id <S269198AbRHGRJ2>; Tue, 7 Aug 2001 13:09:28 -0400
Date: Tue, 7 Aug 2001 11:09:16 -0600
Message-Id: <200108071709.f77H9GD05198@vindaloo.ras.ucalgary.ca>
From: Richard Gooch <rgooch@ras.ucalgary.ca>
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: Alexander Viro <viro@math.psu.edu>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] one of $BIGNUM devfs races
In-Reply-To: <Pine.SOL.3.96.1010807111835.6737A-100000@draco.cus.cam.ac.uk>
In-Reply-To: <200108070517.f775HEw30547@vindaloo.ras.ucalgary.ca>
	<Pine.SOL.3.96.1010807111835.6737A-100000@draco.cus.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov writes:
> If you are introducing a spinlock for the sole purpose of protecting
> a counter, I would suggest to drop the spinlock, make the counter an
> atomic_t and just use atomic operations on it. That should be both
> faster and generate shorter code.

Firstly, I don't see an atomic_get_and_inc(). Sure, I can atomically
increment, and I can atomically read. But I can't read and increment
atomically.

Secondly, the range is 24 bits. While 24 bits is "probably enough",
I'd prefer not to waste bits.

Finally, a spinlock is less code (0) and faster on UP.

				Regards,

					Richard....
Permanent: rgooch@atnf.csiro.au
Current:   rgooch@ras.ucalgary.ca
