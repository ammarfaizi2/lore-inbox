Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbQLMXUw>; Wed, 13 Dec 2000 18:20:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129541AbQLMXUm>; Wed, 13 Dec 2000 18:20:42 -0500
Received: from smtp1.jp.psi.net ([154.33.63.111]:56336 "EHLO smtp1.jp.psi.net")
	by vger.kernel.org with ESMTP id <S129429AbQLMXU3>;
	Wed, 13 Dec 2000 18:20:29 -0500
From: "Rainer Mager" <rmager@vgkk.com>
To: "Linus Torvalds" <torvalds@transmeta.com>
Cc: "Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: Signal 11 - the continuing saga
Date: Thu, 14 Dec 2000 07:48:54 +0900
Message-ID: <NEBBJBCAFMMNIHGDLFKGGEDECJAA.rmager@vgkk.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
In-Reply-To: <Pine.LNX.4.10.10012131213160.802-100000@penguin.transmeta.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Err, for those of us who aren't up to our elbows in the kernel code, is
there a patch for this? Presumeably this will be rolled into 2.4.0test13 but
I'd like to try it out? Also, can someone summarize the fix in English along
with the expected, improved behavior (e.g. Linux will never have a signal 11
again and will never, ever crash ;-)

Finally, as soon as there is a patch, can other people who have seen this
problem test it. My problem is so random that I'd need at least a few days
to gain some confidence this is fixed.


Thanks all.

--Rainer

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Linus Torvalds
> Sent: Thursday, December 14, 2000 5:19 AM
> To: Mike Galbraith
> Cc: Kernel Mailing List
> Subject: Re: Signal 11 - the continuing saga
>
>
> On Wed, 13 Dec 2000, Linus Torvalds wrote:
> >
> > Hint: "ptep_mkdirty()".
>
> In case you wonder why the bug was so insidious, what this caused was two
> separate problems, both of them able to cause SIGSGV's.
>
> One: we didn't mark the page table entry dirty like we were supposed to.
>
> Two: by making it writable, we also made the page shared, even if it
> wasn't supposed to be shared (so when the next process wrote to the page,
> if the swap page was shared with somebody else, the changes would show up
> even in the process that _didn't_ write to it).
>
> And "ptep_mkdirty()" is only used by swapoff, so nothing else would show
> this. Which was why it hadn't been immediately obvious that anything was
> broken.
>
> 		Linus

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
