Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129136AbQKPJYC>; Thu, 16 Nov 2000 04:24:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129585AbQKPJXw>; Thu, 16 Nov 2000 04:23:52 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:55821 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129136AbQKPJXf>; Thu, 16 Nov 2000 04:23:35 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: [PATCH] Re: test11-pre5
Date: 16 Nov 2000 08:51:33 -0000
Organization: Alfie's Internet Node
Message-ID: <8v076l$4ir$1@alfie.demon.co.uk>
In-Reply-To: <3A11C1B6.E61FF9F6@mandrakesoft.com> <Pine.LNX.4.21.0011150104250.26856-100000@callisto.yi.org>
X-Newsreader: NN version 6.5.0 CURRENT #119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

karrde@callisto.yi.org (Dan Aloni) writes:
> Is there a special reason why dev->name is not a pointer?

One of the changes in 2.3 was to change dev->name from a pointer to the
char array.  A little bit painful (in terms of the number of changes,
rather than the complexity).

The reason for this is that dev->name needs to be writeable, each instance
of dev->name must not be shared, and there needs to be at least IFNAMSIZ
bytes allocated.

The problem that first triggered the change was that gcc was sharing
all instances of "eth%d", so there was a problem with multiple adaptors
referenced from the same source file.

It just happens that the kernel does not implement read-only strings
(as userspace does), but it could do in the future.  This would cause
problem if dev->name is a pointer.

Finally, looking through the many net drivers, many failed to reserve
IFNAMSIZ (currently 16) bytes.  Some allocated 8, some 9, some 17.

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
