Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154265AbPKHUYM>; Mon, 8 Nov 1999 15:24:12 -0500
Received: by vger.rutgers.edu id <S154237AbPKHUPW>; Mon, 8 Nov 1999 15:15:22 -0500
Received: from dukat.scot.redhat.com ([195.89.149.246]:1909 "EHLO dukat.scot.redhat.com") by vger.rutgers.edu with ESMTP id <S154428AbPKHUO0>; Mon, 8 Nov 1999 15:14:26 -0500
From: "Stephen C. Tweedie" <sct@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14375.12057.128547.565786@dukat.scot.redhat.com>
Date: Mon, 8 Nov 1999 20:14:17 +0000 (GMT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.rutgers.edu>, Stephen Tweedie <sct@redhat.com>
Subject: Re: map_user_kiobuf question
In-Reply-To: <382355AA.6B6C450C@mandrakesoft.com>
References: <382355AA.6B6C450C@mandrakesoft.com>
Sender: owner-linux-kernel@vger.rutgers.edu

Hi,

In article <382355AA.6B6C450C@mandrakesoft.com>, Jeff Garzik
<jgarzik@mandrakesoft.com> writes:

> What type of address gets passed to the third argument of
> map_user_kiobuf?

> can I do something like

> 	addr = vmalloc (size);
> 	...
> 	map_user_kiobuf (xxx, iobuf, (unsigned long) addr, xxx);
> 	[ ... mess around with iobuf'd pages ... ]
> 	unmap_kiobuf (iobuf);

No --- and you wouldn't want to.

map_user_kiobuf() checks that the user has got permission to access the
requested pages, but vmalloc returns pages which are only visible from
kernel space.

The whole point about kiobufs is that they abstract away the mechanism
used to select the pages concerned.  A consumer of kiobufs doesn't know
where the pages came from originally.  If you want to populate the
kiobuf with kernel pages, you can do so: it's just a different kiobuf
populating function.

Thanks for raising this, though: I'll add virtual and physical page
mapping functions for kiobufs.

--Stephen


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
