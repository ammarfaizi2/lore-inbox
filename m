Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130352AbRAGVFB>; Sun, 7 Jan 2001 16:05:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136487AbRAGVEl>; Sun, 7 Jan 2001 16:04:41 -0500
Received: from piglet.twiddle.net ([207.104.6.26]:17936 "EHLO
	piglet.twiddle.net") by vger.kernel.org with ESMTP
	id <S136466AbRAGVEc>; Sun, 7 Jan 2001 16:04:32 -0500
Date: Sun, 7 Jan 2001 13:03:11 -0800
From: Richard Henderson <rth@twiddle.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Dave <djdave@bigpond.net.au>, linux-kernel@vger.kernel.org
Subject: Re: ftruncate returning EPERM on vfat filesystem
Message-ID: <20010107130311.B26532@twiddle.net>
In-Reply-To: <Pine.LNX.4.30.0101071613130.1132-100000@athlon.internal> <E14FGI2-0002fo-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <E14FGI2-0002fo-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 01:55:15PM +0000, Alan Cox wrote:
> > +                       return -EPERM;
> 
> To stop a case where the fs gets corrupted otherwise. You can change that to
> return 0 which is more correct but most not remove it.

While I suppose "0" is covered under "the result is unspecified", I
would suggest that EINVAL is a better choice: "The filedes argument
does not refer to a file on which this operation is possible".

The reason being that the normal reason for an extending ftruncate
is so that you can mmap it and not get SIGBUS for accessing past the
end of the file.


r~
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
