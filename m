Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282978AbRLHR1q>; Sat, 8 Dec 2001 12:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282966AbRLHR1g>; Sat, 8 Dec 2001 12:27:36 -0500
Received: from hera.cwi.nl ([192.16.191.8]:9696 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S282978AbRLHR1c>;
	Sat, 8 Dec 2001 12:27:32 -0500
From: Andries.Brouwer@cwi.nl
Date: Sat, 8 Dec 2001 17:26:55 GMT
Message-Id: <UTC200112081726.RAA247456.aeb@cwi.nl>
To: alan@lxorguk.ukuu.org.uk, torvalds@transmeta.com
Subject: Re: Linux/Pro  -- clusters
Cc: linux-kernel@vger.kernel.org, viro@math.psu.edu
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    From: Linus Torvalds <torvalds@transmeta.com>

    The sad thing is that along the whole path, we actually end
    up needing the structure pointer in different places, so the IO code
    (which is supposed to be timing-critical) ends up doing various lookups on
    the kdev_t several times (both at a higher level and deep down in the IO
    submit layer).

    So now we have to do "bdfind()" *kdev_t -> block_device", and
    "get_gendisk()" for "kdev_t -> struct gendisk" and about 5 different
    "index various arrays using the MAJOR number" on the way to actually doing
    the IO.

    Even though the filesystems that want to _do_ the IO actually already have
    the structure pointer available, and all the indexing off major would
    actually fairly trivially just be about reading off the fields off that
    structure.

    Oh, well. It _is_ going to be quite painful to switch things around.

I don't understand at all. It is not painful at all.
Things are completely straightforward.

A kdev_t is a pointer to all information needed, nowhere a lookup,
except at open time.

You make it kbdev_t, and then call it struct block_device *.
OK, the name doesnt matter as long as the struct it points to has all
information needed. In my version that is the case, and I would
be rather surprised if it were otherwise in Al's version.

The changes are only of the easy, provably correct, mechanical kind.
Boring work, and a bit slow - each step requires a grep over the
kernel source and there are about a hundred steps.

I am sure also Al will tell you that there is no problem.

Andries
