Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315439AbSINMVJ>; Sat, 14 Sep 2002 08:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315449AbSINMVJ>; Sat, 14 Sep 2002 08:21:09 -0400
Received: from c16598.thoms1.vic.optusnet.com.au ([210.49.243.217]:17832 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S315439AbSINMVI>;
	Sat, 14 Sep 2002 08:21:08 -0400
Message-ID: <1032006359.3d832ad704793@kolivas.net>
Date: Sat, 14 Sep 2002 22:25:59 +1000
From: Con Kolivas <conman@kolivas.net>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: System response benchmarks in performance patches
References: <1031933335.3d820d97a13c6@kolivas.net> <3D824634.480EFA32@digeo.com>
In-Reply-To: <3D824634.480EFA32@digeo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton <akpm@digeo.com>:

> Con Kolivas wrote:
> > I came up with a very simple way of measuring responsiveness that gives
> me
> > numbers that are meaningful to me. What I've done is the old faithful
> kernel
> > compile and measured it under different loads to simulate the pc's ability
> to
> > perform under various loads. I have so far benchmarked 2.4.19 versus
> 2.4.19-ck7,...
> Yes, this is a wonderful test.  Very real-world, easy to do and it
> tickles a few fairly serious performance problems which we have.

Thank you. I've been thinking hard about this for some time. I hope it becomes 
useful

> > The loads were taken from BMatthew's iman found here:
> > http://people.redhat.com/bmatthews/irman/
> I have issues with irman (I think - didn't read the code really
> closely).

irman isn't really the key to this benchmark, it was only the source of a
constant load in each different area. The actual irman app isn't used, only the
child load apps.

> It appears to always perform file overwrites - seeking over files,
> rewriting them.
> 
> This tends to cause best-case behaviour in the VM.  The affected pages
> are tucked up out of the way on the active list and we do quite well.
> 
> If instead the background application is writing _new_ files then
> everything falls apart.
> 
> I'd suggest that you stick with the kernel compile as the workload,
> and vary the background activity a bit.  Try tiobench.

I've had a look at tiobench and it looks like a serious IO load. However the
load varies quite a bit and I'd like something that remains relatively constant
throughout. I'd have to strip the guts out of it and do it as numerous different
IO tests. It does start taking away from the simplicity of it at the moment, and
as you can see from the numbers, it is still very revealing in it's current
incarnation.

> (oh, and try turning on everything in the `input' menu; that might
> get the keyboard working again in 2.5)

Thanks for that. I've managed to get the keyboard working but haven't been up to
speed with development of 2.5.x so I haven't figured out what to do about the
changing IDE partitions. All of that is moot at the moment, though, as my
benchmark won't yet work on 2.5.x because of changes to the /proc filesystem.
Rik Van Riel is helping me sort out this problem.

In the meantime I have created a tarball of this benchmark in a usable form.
I've called it contest (thanks Rik for the name idea) and it's basically a
script and the relevant workload tasks. I've posted it on my kernel page at
http://kernel.kolivas.net under the FAQ. A final reminder note: it won't work on
2.5.x

Con.
