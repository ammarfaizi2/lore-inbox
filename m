Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278240AbRJMCAu>; Fri, 12 Oct 2001 22:00:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278241AbRJMCAl>; Fri, 12 Oct 2001 22:00:41 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:54285 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278240AbRJMCAb>; Fri, 12 Oct 2001 22:00:31 -0400
Date: Fri, 12 Oct 2001 19:00:41 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Paul Mackerras <paulus@samba.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists
 with insertion
In-Reply-To: <15303.37865.489986.425653@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.33.0110121846030.8148-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Oct 2001, Paul Mackerras wrote:
>
> As for intel x86, is there a architecture spec that talks about things
> like memory ordering?  My impression is that the x86 architecture is
> pretty much defined by its implementations but I could well be wrong.

It is discussed in the multi-procesor management section, under "memory
ordering", and it does say that "reads can be carried out specilatively
and in any order".

HOWEVER, it does have what Intel calles "processor order", and it claims
that "writes by a single processor are observed in the same order by all
processors."

Which implies that if the _same_ CPU wrote *p and p, there is apparently
an ordering constraint there. But I don't think that's the case here. So
the x86 apparently needs a rmb().

(But Intel has redefined the memory ordering so many times that they might
redefine it in the future too and say that dependent loads are ok. I
suspect most of the definitions are of the type "Oh, it used to be ok in
the implementation even though it wasn't defined, and it turns out that
Windows doesn't work if we change it, so we'll define darkness to be the
new standard"..)

> Indeed...  getting the new p but the old *p is quite
> counter-intuitive IMHO.

I disagree. I think the alpha has it right - it says that if you care
about ordering, you have to tell so. No ifs, no buts, no special cases
("Oh, dependent loads are special").

Of course, I used to absolutely _hate_ the x86 ordering rules just because
they are so ad-hoc. But I'm getting more and more used to them, and the
Intel "write ordered with store-buffer forwarding" model ends up being
really nice for locking ;)

		Linus

