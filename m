Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132974AbQLJV6z>; Sun, 10 Dec 2000 16:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133003AbQLJV6p>; Sun, 10 Dec 2000 16:58:45 -0500
Received: from 62-6-231-238.btconnect.com ([62.6.231.238]:17415 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S132974AbQLJV6h>;
	Sun, 10 Dec 2000 16:58:37 -0500
Date: Sun, 10 Dec 2000 21:30:14 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.21.0012102105190.1601-100000@penguin.homenet>
Message-ID: <Pine.LNX.4.21.0012102122170.1601-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Tigran Aivazian wrote:
> Ok, let's slowly understand each other. The scenario you suggest is:
> 
> a) measure nr_free_files and let root exhaust all freelist entries. Now
> the freelist is empty and nr_free_files = 0.
> 
> b) now let the user app allocate (from the slab cache) lots of new file
> structures. He can keep doing so until nr_files hits max_files.
> 
> Now what? Now root tries to allocate some and obviously he can't because
> the freelist is empty
.
... and neither can he allocate from the slab cache since nr_files ==
max_files now.

Now, if I understand your proposal correctly -- you would like to redefine
NR_RESERVED_FILES to be _guaranteed_ for root at any time regardless of
the allocation pattern instead of their current definition as guaranteed
number of elements on the _freelist_? Right?

So you would like to deny normal users some requests from the slab cache
if otherwise root's new NR_RESERVED_FILES wouldn't be honoured?

Did I understand your idea correctly? Such policy sounds sensible but is
certainly a redesign of file allocator and should be carefully checked if
it's ok in all cases...

If you agree with the above then we never disagreed to begin with -- I
just insisted (and still insist) that it is the expected behaviour,
perhaps not 100% satisfactory.

Also, I agree with your suggestion to increase NR_RESERVED_FILES -- with
both policies (the current and your new one) the current value of 10 is
way too small.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
