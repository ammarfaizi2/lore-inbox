Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315469AbSEZAHE>; Sat, 25 May 2002 20:07:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315471AbSEZAHE>; Sat, 25 May 2002 20:07:04 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:47370 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315469AbSEZAHD> convert rfc822-to-8bit; Sat, 25 May 2002 20:07:03 -0400
Date: Sat, 25 May 2002 17:07:03 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Schwebel <robert@schwebel.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <20020526003359.Z598@schwebel.de>
Message-ID: <Pine.LNX.4.44.0205251651460.4120-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g4Q06aj25184
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 26 May 2002, Robert Schwebel wrote:
>
> Show me how you will implement a closed loop controller where the
> application is _not_ implemented as a kernel module. I would really love to
> do it this way, but unfortunately no one of the realtime programmers has
> found a way how it can be achieved so far.

The thing is, if your whole app is really RT, then neither RTAI nor
RTLinux will help you all that much.

The "user space" in RTAI ends up being equally limited as any kernel
module in RTLinux. No dynamic memory allocation, no deep recursion, no
regular system calls. That's just fundamental to hard realtime, and has
nothing to do with any of the environments themselves.

The "advantage" of RTAI is a copyright license issue at that point,
nothing more (well, you get your own address space, but since you mustn't
fault anything anyway, the advantage is dubious, _and_ it certainly eats
into your performance). And as explained elsewhere, I don't find that to
be an advantage at all (and as pointed out by Larry, there seems to be
some dubious issues about the RTAI copyright itself).

Don't get me wrong - I'd love to say that it could be easily fixed by
doing xxxx, but the fact is that since the linux kernel itself isn't hard
realtime, the lack of kernel services really is unavoidable.

And once you lack kernel services, from a programming standpoint it
shouldn't really matter whether it's a kernel module or not. You've got
basically the same amount of (or rather, "lack of") support. A lot of
things are a lot easier in kernel mode (interrupts, IO etc), while you
might find loading the app etc easier in the RTAI model, for example. You
win some, you lose some.

Can we make the whole kernel truly hard-RT? Sure, possible in theory. In
practice? No way, José. It's just not mainline enough.

So I'm agreeing with you: for true hard RT, you need a kernel module. I
can't come up with a way to avoid any of the fundamental problems either..

			Linus

