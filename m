Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129098AbQKEEX5>; Sat, 4 Nov 2000 23:23:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129109AbQKEEXr>; Sat, 4 Nov 2000 23:23:47 -0500
Received: from thig.blarg.net ([206.124.128.18]:34566 "EHLO thig.blarg.net")
	by vger.kernel.org with ESMTP id <S129098AbQKEEXh>;
	Sat, 4 Nov 2000 23:23:37 -0500
From: "Dave Wagner" <wagner@blarg.net>
To: <torvalds@transmeta.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Re: Negative scalability by removal of  lock_kernel()?(Was:Strange performance behavior of 2.4.0-test9)
Date: Sat, 4 Nov 2000 20:19:28 -0800
Message-ID: <001601c046df$96956b80$0400a8c0@berlin>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook 8.5, Build 4.71.2173.0
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
>
> No.
>
> Please use unserialized accept() _always_, because we can fix that.
>
> Even 2.2.x can be fixed to do the wake-one for accept(), if required.
> It's not going to be any worse than the current apache config, and
> basically the less games apache plays, the better the kernel can try to
> accomodate what apache _really_ wants done.  When playing games, you
> hide what you really want done, and suddenly kernel profiles etc end up
> being completely useless, because they no longer give the data we needed
> to fix the problem.
>
> Basically, the whole serialization crap is all about the Apache people
> saying the equivalent of "the OS does a bad job on something we consider
> to be incredibly important, so we do something else instead to hide it".
>
> And regardless of _what_ workaround Apache does, whether it is the sucky
> fcntl() thing or using SysV semaphores, it's going to hide the real
> issue and mean that it never gets fixed properly.
>
> And in the end it will result in really really bad performance.
>
> Instead, if apache had just done the thing it wanted to do in the first
> place, the wake-one accept() semantics would have happened a hell of a
> lot earlier.
>
> Now it's there in 2.4.x. Please use it. PLEASE PLEASE PLEASE don't play
> games trying to outsmart the OS, it will just hurt Apache in the long run.
>

But how would you suggest people using 2.2 configure their
Apache?  Will flock/fcntl or semaphores perform better (albeit
"uglier") than unserialized accept()'s in 2.2.  I'm willing
and expecting to rebuild apache when 2.4 is released.  I do
not, though, want to leave performance on the table today,
just so I can say that my apache binary is 2.4-ready.

Do any of the apache serialization methods (flock/fcntl/semops)
have any performance improvement over unserialized accept() with
Apache running on a 2.2 kernel?

Dave Wagner

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
