Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132811AbQLJVlb>; Sun, 10 Dec 2000 16:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132684AbQLJVlL>; Sun, 10 Dec 2000 16:41:11 -0500
Received: from 62-6-231-238.btconnect.com ([62.6.231.238]:8967 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S130895AbQLJVlJ>;
	Sun, 10 Dec 2000 16:41:09 -0500
Date: Sun, 10 Dec 2000 21:12:45 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Szabolcs Szakacsits <szaka@f-secure.com>
cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] NR_RESERVED_FILES broken in 2.4 too
In-Reply-To: <Pine.LNX.4.30.0012102227070.5455-100000@fs129-190.f-secure.com>
Message-ID: <Pine.LNX.4.21.0012102105190.1601-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2000, Szabolcs Szakacsits wrote:
> Or 0 shouldn't be between 0 and NR_RESERVED_FILES. Right? Wrong. I saw
> it happens, you can reproduce it if you lookup the nr_free_files
> value, allocate that much by root, don't release them and
> immediately after this start to allocate fd's by user app. 

Ok, let's slowly understand each other. The scenario you suggest is:

a) measure nr_free_files and let root exhaust all freelist entries. Now
the freelist is empty and nr_free_files = 0.

b) now let the user app allocate (from the slab cache) lots of new file
structures. He can keep doing so until nr_files hits max_files.

Now what? Now root tries to allocate some and obviously he can't because
the freelist is empty. So what? Where is the bug? This is an expected
behaviour to me -- since the freelist is empty there are no more reserved
file structures for root. Which part of this do you believe is wrong? Or
do you believe that this is not the case at all? I.e. something else
happens in the above scenario which I am still missing? If so, please
explain.

If, however, you believe that the above _is_ the case but it should _not_
happen then you are proposing a completely new policy of file structure
allocation which you believe is superior. It is quite possible so let's
all understand your new policy and let Linus decide whether it's better
than the existing one. But if so, don't tell me you are fixing a bug
because it is not a bug -- it's a redesign of file structure allocator.

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
