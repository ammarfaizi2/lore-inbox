Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277231AbRJ0WGA>; Sat, 27 Oct 2001 18:06:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277244AbRJ0WFu>; Sat, 27 Oct 2001 18:05:50 -0400
Received: from imladris.infradead.org ([194.205.184.45]:8463 "EHLO
	infradead.org") by vger.kernel.org with ESMTP id <S277231AbRJ0WFo>;
	Sat, 27 Oct 2001 18:05:44 -0400
Date: Sat, 27 Oct 2001 23:05:41 +0100 (BST)
From: Riley Williams <rhw@MemAlpha.CX>
X-X-Sender: <rhw@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.4.13 default config
In-Reply-To: <Pine.LNX.4.33.0110271205560.3528-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.33.0110272218020.16340-100000@infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

My reason for submitting this patch was that the default configuration 
SHOULD meet the following criteria:

 1. It's a sane configuration.

    As part of maintaining the Linux Kernel Version History web pages,
    I've gone through the various kernel tarballs and checked them 
    out. Amongst the ix86 defaults I've seen are the following:

    a.	Only MSDOS file system enabled, with no networking support
	of any kind.

    b.	SLIP enabled with no serial support.

    The above is as per the arch/i386/defconfig file distributed in 
    the kernel release tarball. I would presume at least some of the 
    above would be corrected by `make oldconfig` if that was run.

 2. It's a compilable configuration.

    In theory, any configurable configuration will compile, but even 
    if we can't guarantee that, we should be able to guarantee that
    the default configuration will compile.

As far as I could tell, there was no simple means to test whether 
these criteria were satisfied, and this patch adds such a means.

 >>> The enclosed patch (against the raw 2.4.13 tree) adds a `make
 >>> defconfig` option that configures Linux with the default options
 >>> obtained by simply pressing ENTER to every prompt that comes up.

 >> If someone wishes they can simply
 >>
 >>	cp arch/$arch/defconfig .config
 >>	make oldconfig

Curiously enough, some of the kernel releases have a DIFFERENT config
in defconfig to what's created by the routine I added. With 2.4.13
they're the same, and I don't have any of the other kernel tarballs on
any of my systems at the moment, so can't look up one that's different
right now, but I will if you wish.

 > Why not just
 > 
 >	rm .config (if you have an old one at all)
 >	make oldconfig

Is that guaranteed to produce the default configuration? It certainly 
isn't obvious that such is the case.

 > That's what I always do (or you can copy the ".config" from
 > somewhere else, or you can edit your old ".config" in your
 > favourite editor and re-doing "make oldconfig").

 > I never _ever_ use any "real" configurator myself. The _only_
 > config maker I ever use is "make oldconfig", after having
 > possibly edited the .config file by hand or done something else..

I have to admit that the various interactions between the options are 
beyond what I can follow with a text editor, and I generally use `make 
menuconfig` to configure the kernel for precicely this reason.

I will also add that in my experience, most users are in exactly the 
same situation, and will either...

 A. Run one of the configurators to configure the kernel, then compile 
    it, or

 B. Try to compile it without configuring it first.

If they do the former, we want them to get a compiled kernel. If they 
do the latter, do we want to present a "This kernel needs to be 
configured before it can be compiled" error, or to compile using the 
default configuration?

Personally, I'd opt for the latter, and set the kernel up such that if
the .config file didn't exist when `make *Image` is run, then we
simply run `make defconfig` to create it, and then regard it as being
configured as the user desired.

Another possibility would be to run `make *config` in this situation, 
but the question then is which one do we run?

Best wishes from Riley.

