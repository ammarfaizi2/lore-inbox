Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312169AbSERKQm>; Sat, 18 May 2002 06:16:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312279AbSERKQl>; Sat, 18 May 2002 06:16:41 -0400
Received: from ns.suse.de ([213.95.15.193]:10252 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S312169AbSERKQl>;
	Sat, 18 May 2002 06:16:41 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au,
        alan@lxorguk.ukuu.org.uk
Subject: Re: AUDIT: copy_from_user is a deathtrap.
In-Reply-To: <E178eMm-0000NO-00@wagner.rustcorp.com.au.suse.lists.linux.kernel> <Pine.LNX.4.44.0205171936220.1524-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 18 May 2002 12:16:40 +0200
Message-ID: <p733cwpzrp3.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> On Fri, 17 May 2002, Rusty Russell wrote:
> >
> > Sorry I wasn't clear: I'm saying *replace*, not add,
> 
> Ok, let _me_ be clear: replacing them with an inferior product that cannot
> tell you partial copies is not going to happen. Not now, not ever. You
> would break all the users who _require_ knowing about a read() that only
> gave you 5 out of 50 bytes.

Are you sure they even exist ? As far as I can see near everybody relies
on zeroing of target on exception instead.

At least for the SSE optimized copy_*_user always would be much better,
because optimizing the miss count is painful from an unrolled loop
and cannot be even done accurately (8 bytes accuracy is best with 8 byte
loads/stored).  With that in mind I think the byte count is broken by 
design because it cannot be correctly implemented unless you do byte copies.

I remember TCP was given as the prime user when this interface was 
introduced in 2.1, but TCP does not use the byte count currently and never has
(in fact the primary memory copy interface of TCP - csum_copy_* - does not 
even support it)

-Andi 
