Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276872AbRJKU3y>; Thu, 11 Oct 2001 16:29:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276883AbRJKU3n>; Thu, 11 Oct 2001 16:29:43 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21461 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S276872AbRJKU3b>;
	Thu, 11 Oct 2001 16:29:31 -0400
From: Andries.Brouwer@cwi.nl
Date: Thu, 11 Oct 2001 20:29:29 GMT
Message-Id: <UTC200110112029.UAA31163.aeb@cwi.nl>
To: Andries.Brouwer@cwi.nl, viro@math.psu.edu
Subject: Re: 2.4.11 loses sda9
Cc: adilger@turbolabs.com, arvest@orphansonfire.com,
        linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From viro@math.psu.edu Thu Oct 11 21:19:27 2001

    On Thu, 11 Oct 2001 Andries.Brouwer@cwi.nl wrote:

    > so as to make it easy to switch between compiles where
    > a kdev_t is a number and we use the infamous arrays,
    > and compiles where a kdev_t is a pointer to a device struct,
    > and no arrays exist, I now see that get_hardsect_size(dev)
    > is replaced by
    >         get_hardsect_size(to_kdev_t(bdev->bd_dev))
    > . Yecch.
    > Al, I never understood why you want to introduce a
    > struct block_device * to do precisely what kdev_t
    > was designed to do.]
     
    We had been through that way too many times.  You know what problems
    with unified device struct I've brought before.  You know what
    problems I have with your 64bit dev_t.  And you know _very_ well that
    any patches in that area should be done in small steps.

    Hell, I'd prefer that one to be done _much_ slower - with decent
    debugging between the steps instead of "we've got to close the
    holes opened by bdev-in-pagecache _NOW_" kind of situation we'd got.

    IMO eventually we should have per-disk structure and keep reference to
    it from struct block_device.  Then get_hardsect_size() wiuld turn into
    access to field of that beast (and would take struct block_device *
    as an argument).  But that's 2.5 stuff and I bloody refuse to participate
    in attempts to do everything in one huge leap.  One we'd got is already
    bad enough.

You invent two strawmen to divert attention from the question:

> You know what problems I have with your 64bit dev_t.

Well, in fact I don't know, except that you announced to fork the
source once it got one. But that is an entirely separate discussion
and has nothing to do with kdev_t.  A dev_t is what goes into the kernel
at the mknod system call, and comes out of the kernel at the stat
system call, and roughly speaking has no other significance.
It plays a role in NFS, but NFS already uses a 64bit dev_t.

Kernel patches for a 64bit dev_t are entirely orthogonal to kdev_t work.

> I refuse to participate in attempts to do everything in one huge leap.

Well, it is not me who invents the idea of big changes at once.
It was mostly Linus who did not like intermediate code.

I think I can go to my goal in many small steps avoiding intermediate code,
although life is a bit easier with intermediate stuff like get_hardsect_size(dev).

But the size of the leaps towards the goal has very little to do
with the design of the goal.

So those are your two strawmen. Yes, there is one more sentence:

> You know what problems with unified device struct I've brought before.

I don't mind splitting kdev_t into kbdev_t and kcdev_t.
Keeping the former requires a cast or a union somewhere.
Splitting requires some code duplication.
Altogether there is very little difference between the two setups.

Remains the question, let me repeat:
"Al, I never understood why you want to introduce a struct block_device *
 to do precisely what kdev_t was designed to do."

I see that you are making small steps away from my goal, so I hope
you know very precisely where you want to go and how to get there.

> But that's 2.5 stuff

Yes, precisely. But you do not wait for 2.5 but start walking already.

Andries
