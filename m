Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132862AbQL3EKw>; Fri, 29 Dec 2000 23:10:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132885AbQL3EKm>; Fri, 29 Dec 2000 23:10:42 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:26119 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S132862AbQL3EK0>; Fri, 29 Dec 2000 23:10:26 -0500
Date: Fri, 29 Dec 2000 19:36:21 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Byron Stanoszek <gandalf@winds.org>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, "Marco d'Itri" <md@Linux.IT>,
        Jeff Lightfoot <jeffml@pobox.com>, Dan Aloni <karrde@callisto.yi.org>,
        Anton Blanchard <anton@linuxcare.com.au>
Subject: Re: test13-pre6 (Fork Bug with Athlons? Temporary Fix)
In-Reply-To: <Pine.LNX.4.21.0012292156200.11714-200000@winds.org>
Message-ID: <Pine.LNX.4.10.10012291929250.1722-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 29 Dec 2000, Byron Stanoszek wrote:
> 
> I narrowed the problem down to a subset of patches from the MM set in
> test13-pre2. Reversing the attached 'context.patch' fixes the problem (only for
> i386), but I'm not yet sure why. test13-pre2 and up work without any problems
> on an Intel cpu (Pentium 180 & P3 800 tested).

Cool.

Maybe your libc is different on the different machines? Normal programs
shouldn't use segments at all, so I really do not see how this patch could
matter in the least, even if it was completely and utterly buggy (which is
not obvious at first glance).

I wonder why you seem to have an LDT at all..

> Anyways, I can't seem to find out what really changes with the patch except for
> the obvious 'void *segment' changing into a typedef-struct.

Would you mind trying to hunt this down a bit more? In particular, it
would be good to see if the behaviour is the same if you do the typedef
change but leave the other logic alone. That would also cut down on the
purely syntactic changes of the patch.

I'll take a look at the code here.

	Thanks,

		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
