Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130180AbQLLOrz>; Tue, 12 Dec 2000 09:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130401AbQLLOrp>; Tue, 12 Dec 2000 09:47:45 -0500
Received: from www.wen-online.de ([212.223.88.39]:7952 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130180AbQLLOrg>;
	Tue, 12 Dec 2000 09:47:36 -0500
Date: Tue, 12 Dec 2000 15:15:48 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Rik van Riel <riel@conectiva.com.br>
cc: Steven Cole <elenstev@mesatop.com>, linux-kernel@vger.kernel.org,
        vii@penguinpowered.com, mojomofo@mojomofo.com
Subject: Re: UP 2.2.18 makes kernels 3% faster than UP 2.4.0-test12
In-Reply-To: <Pine.LNX.4.21.0012120817130.13641-100000@duckman.distro.conectiva>
Message-ID: <Pine.Linu.4.10.10012121410390.1746-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Dec 2000, Rik van Riel wrote:

> On Mon, 11 Dec 2000, Steven Cole wrote:
> 
> > Building kernels is something we do so frequently and this test
> > is so easy to reproduce is why I performed it in the first
> > place.  I think it may be as good a test of real performance as
> > some of the more formal benchmarks. Comments anyone?
> 
> Just one comment.  You cannot use a kernel build to measure
> other things than those subsystems which the kernel build
> excercises.

One comment back ;-)

Of course.

> Things you could measure with a kernel build:  scheduling (L2
> cache efficiency), fork, readahead, cpu speed, framebuffer
> speed (in the make dep phase) and maybe hard disk speed.

Yes, among others.  RealHardLife hard disk speed.. kinda sorta.

> Things you cannot measure with a kernel build: networking,
> swapping (unless you do a very big parallel build, and even
> then it's questionable), raw IO speed (the kernel build is
> latency sensitive, but doesn't need much throughput), ...

I believe you are wrong wrt parallel kernel builds as swap test..
it's not questionable at all. :)  Or, if it is, please explain why.

My view:

The kernel build is above and beyond all other considerations a CPU
bound job which has a cachable component which is not negligable,
and has an I/O component, but not a dominating one.  That makes it
an ideal generic test candidate for vm throughput.. in any box not
blessed with unlimited I/O capability.

I think that a parallel kernel build is the perfect basic VM functional
test _because_ of it's simple requirements. Limit the I/O to what your
box can deliver (must know before testing), and it's fine.

I agree if you say that it's nothing beyond a basic functionality test.

I test this way because my box doesn't have the hardware to do serious
I/O.. and neither do at least 99.9% of other boxen out there.

What else can you suggest to test basic VM throughput in an I/O starved
environment?  It has to be multi-task, and has to be CPU bound to be
meaningful.

	-Mike

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
