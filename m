Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314392AbSEFLde>; Mon, 6 May 2002 07:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314393AbSEFLdd>; Mon, 6 May 2002 07:33:33 -0400
Received: from fungus.teststation.com ([212.32.186.211]:28943 "EHLO
	fungus.teststation.com") by vger.kernel.org with ESMTP
	id <S314392AbSEFLdb>; Mon, 6 May 2002 07:33:31 -0400
Date: Mon, 6 May 2002 13:33:18 +0200 (CEST)
From: Urban Widmark <urban@teststation.com>
X-X-Sender: <puw@cola.enlightnet.local>
To: Keith Owens <kaos@ocs.com.au>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: kbuild 2.5 is ready for inclusion in the 2.5 kernel 
In-Reply-To: <8322.1020641767@ocs3.intra.ocs.com.au>
Message-ID: <Pine.LNX.4.33.0205061129440.19054-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 May 2002, Keith Owens wrote:

> >being able to build over NFS or having stricter integrity checks. I just
> >don't get the faster bit, but maybe that's just me.
> 
> You are not comparing like with like.  Much of your speed difference
> from kbuild 2.4 to 2.5 is because you have omitted the make dep time.
> kbuild 2.5 does not have a seperate make dep pass.  Instead it checks
> the dependencies every time, during phase4.

make dep isn't part of a module rebuild given the constriants I work
under, the changes are local to the module (which they are).

In my world make dep is only relevant for the first build, and the
times I mentioned for the full build includes a dependency build.
(I know the presentation of that part was crap ... but so was the
 measurements :)


> Checking the dependencies only once in kbuild 2.4 is a very common
> source of build error.  Users change their code, forget to rerun make
> dep then wonder why their kernel and module build is broken.  In your
> case, you "know" that your change does not affect the dependencies so
> you omit the make dep run.  That is the equivalent of bypassing the
> integrity checks in kbuild 2.5, i.e. it is the equivalent of
> NO_MAKEFILE_GEN=1.

NO_MAKEFILE_GEN is still slower for me than the way I use make modules.

What you are saying is that I should never do:
make modules

but always:
make dep && make bzImage modules

Ok, then I see what you meant by kbuild-2.5 being faster.

Documentation/kbuild/commands.txt (2.4.18 kernel, don't have anything more
recent at hand) has a section on make dep that says I only have to run it
once after the first time I configure the kernel. Maybe that is where I
picked up that habit.


> the kernel.  BTW, if you have a lot of modules you will find that your
> make modules time in 2.4 is significantly higher than the times you
> quoted.

Sure. I was talking about me, my .config (~30 modules) and my builds
specifically.

Btw, I can see other benefits from kbuild-2.5 (and I can bypass the things
I don't want to run all the time more easily than in "2.4" :) and I'm not
against it, but it didn't live up to the faster claim at anything I
normally do. So I had to ask.

/Urban

