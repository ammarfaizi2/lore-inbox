Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131156AbQLILnx>; Sat, 9 Dec 2000 06:43:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131401AbQLILnm>; Sat, 9 Dec 2000 06:43:42 -0500
Received: from front4.grolier.fr ([194.158.96.54]:29437 "EHLO
	front4.grolier.fr") by vger.kernel.org with ESMTP
	id <S131156AbQLILnd> convert rfc822-to-8bit; Sat, 9 Dec 2000 06:43:33 -0500
Date: Sat, 9 Dec 2000 11:12:57 +0100 (CET)
From: Gérard Roudier <groudier@club-internet.fr>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2*PATCH] alpha I/O access and mb()
In-Reply-To: <3A31F094.480AAAFB@alsa-project.org>
Message-ID: <Pine.LNX.4.10.10012091050550.819-100000@linux.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 9 Dec 2000, Abramo Bagnara wrote:

> 
> Here you are two patches:
> 
> alpha-mb-2.2.diff add the missing mb() to the cores that still lack it
> (against 2.2.18pre25)
> 
> alpha-mb-2.4.diff add missing defines from core_t2.h for non generic
> kernel (against 2.4.0test11)
> 
> Please apply on your trees.
> 
> I've also noted that 2.4 uses mb() after read[bwlq] while 2.2 don't.
> Who's right?

Let me howl for a minute. :-)

The actual issue regarding ordering is generally to ensure something to
happen (i.e. to be seen to happen by other agents) _before_ something
else. As a result, what we have in mind is to insert a barrier _before_
this `something else'.

However, everything I seem to see about this issue on our planet and that
applies to IO subsystems is blindly inserting barriers _after_ the
'something'.

Is software getting sci. fi. ? ;-)

Based on that, let me claim that most of blind barriers inserted this way
are useless (thus sob-optimal) and may band-aid useful barriers that are
missing. The result is subtle bugs, hidden most of the time, that we will
have to suffer for decades.

The only way to do things right regarding ordering it to have device
drivers _aware_ of such issues. Now, if we are happy with broken portable
or platform-independant drivers that rely on broken hidden ordering
alchemy rather than on correctness, then it is another story.

  Gérard.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
