Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130436AbQLGPd7>; Thu, 7 Dec 2000 10:33:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130456AbQLGPdt>; Thu, 7 Dec 2000 10:33:49 -0500
Received: from 212-140-94-250.btopenworld.com ([212.140.94.250]:23046 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130436AbQLGPdj>;
	Thu, 7 Dec 2000 10:33:39 -0500
Date: Thu, 7 Dec 2000 15:03:54 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, Andries Brouwer <aeb@veritas.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: [patch-2.4.0-test12-pre6] truncate(2) permissions
In-Reply-To: <Pine.GSO.4.21.0012070709400.20144-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0012071500110.970-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Dec 2000, Alexander Viro wrote:
> On Thu, 7 Dec 2000, Tigran Aivazian wrote:
> 
> > The rationale for being compatible with 4.4BSD on append-only but not on
> > immutable is -- for immutable we can do the test by means of permission()
> > fast but for append-only we would need an extra if() above permission so
> > let's just be BSD-compatible.  Alternatively, one could ignore BSD
> > altogether and return EACCES in both. Or, one could ignore SuS altogether
> > and return EPERM for both immutable and append-only. It is a matter of
> > taste so... I chose something in the middle , perhaps non-intuitive but
> > optimized for speed and the size of code.
> 
> So correct solution may very well be to change the return value of
> permission(9). FWIW, MAY_TRUNCATE might be a good idea - notice that
> knfsd already has something like that. It makes sense for directories,
> BTW - having may_delete() drop the IS_APPEND() test and pass MAY_TRUNCATE
> to permission() instead.
> 

Ok, so you agree with me (I ignore your comment on "BS" because it would
imply that your own suggestion is BS too and that is not nice) that one of
the three alternatives must be chosen. Which one? You have not specified
yet. So far you only said that a different implementation, i.e. a
different place to put the checks, is preferrable.

Which of these three you think is a good idea:

a) be 4.4BSD-compatible and return EPERM for both immutable and
append-only

b) be SuSv2-compatible and return EACCES for both immutable and
append-only

c) be half-compatible with BSD and half-compatible with SuS but with
minimum changes to current code

I understand and agree that c) is not a very good idea. Then, a) or b)?

Regards,
Tigran


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
