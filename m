Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLNXEM>; Thu, 14 Dec 2000 18:04:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbQLNXEC>; Thu, 14 Dec 2000 18:04:02 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:260 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129260AbQLNXDw>; Thu, 14 Dec 2000 18:03:52 -0500
Subject: Re: Signal 11
To: torvalds@transmeta.com (Linus Torvalds)
Date: Thu, 14 Dec 2000 22:35:28 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <91b610$biq$1@penguin.transmeta.com> from "Linus Torvalds" at Dec 14, 2000 11:11:28 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E146gyH-00007v-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't know why RH decided to do their idiotic gcc-2.96 release (it
> certainly wasn't approved by any technical gcc people - the gcc people

Every single patch in that release barring I believe 2 was accepted into
the main tree. So they liked the code. The naming did upset people and was
unfortunate, but done talking to the compiler folks at Red Hat with the
best of intentions behind it. If we had called it 'Red Hat cc' I think people
would have been even more offended at the way they had been discredited.

I do understand why they got peeved, I do understand why they feel no urge
to support the 296 codebase (nor would I want them to). I hit 'd' when I 
see 'I have 2.2.18 patched with [reiserfs|ext3|bigmem|lfs]' for the same
reasons.

> They included another (non-broken) compiler, and called it "kgcc". 
> "kgcc" stands for "kernel gcc", apparently because (a) they realised

kgcc is a convention invented a long time ago by Conectiva. Debian also used
to have gcc272. It is done because

gcc272 is useless at C++, has lots of bugs
egcs is no better at C++ and has lots of bugs
gcc295 is a little better at C++ and is _Crawling_ with bugs
gcc296(redhat) is a lot better at C++ and doesn't appear to be any buggier.

In fact gcc296 is the first compiler that can compiled 2.2.16 correctly. All
the previous compilers miscompile the strstr() inline in some cases. Thats
why I had to hack the 2.2 kernel tree to make it work. (And the cases where
you got compile time errors gcc was right to moan about - like using (...)
in traditional

> user applications and (b) gcc-2.96 is so broken that it requires special
> libraries for C++ vtable chunks handling that is different, so the

Wrong - the C++ vtable format change is part of the intended progression of the
compiler and needed to meet standards compliance. gcc 295 also changed the
internal formats. Unfortunately the gcc295 and 296 formats are both probably
not the final format. The compiler folks are not willing to guarantee anything
untill gcc 3.0, which may actually be out by the time 2.4 is stable.

> unusable as a development platform, and I hope RH downgrades their
> compiler to something that works better RSN.  It apparently has problems

Like what - gcc 2.5.8 ? The problem is not in general that the snapshot is any
buggier than before, but that the bugs are in different places. egcs and gcc295
both caused X compile problems too.

I still advise people: Use egcs-1.1.2 for Linux 2.2.x. You can build 2.2.18 with
gcc 2.9.6 but I personally wouldn't be running production systems on a kernel
built that way - but NOT because gcc296 is buggier but because the bugs are
going to be in different places and I firmly believe production system people
should let the loons find them ;)

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
