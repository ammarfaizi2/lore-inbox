Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136160AbRDVObx>; Sun, 22 Apr 2001 10:31:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136161AbRDVObn>; Sun, 22 Apr 2001 10:31:43 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:26341 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S136157AbRDVObW>;
	Sun, 22 Apr 2001 10:31:22 -0400
Date: Sun, 22 Apr 2001 10:31:10 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alon Ziv <alonz@nolaviz.org>
cc: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: light weight user level semaphores
In-Reply-To: <001301c0cb3f$a550d490$910201c0@zapper>
Message-ID: <Pine.GSO.4.21.0104221026360.28681-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 22 Apr 2001, Alon Ziv wrote:

> Well, that's the reason for my small-negative-integer semaphore-FD idea...
> (It won't support select() easily, but poll() is prob'ly good enough)
> Still, there is the problem of read()/write()/etc. semantics; sure, we can
> declare that 'negative FDs' have their own semantics which just happen to
> include poll(), but it sure looks like a kludge...

You _still_ don't get it. The question is not "how to add magic kernel
objects that would look like descriptors and support a binch of
ioctls, allowing to do semaphores", it's "do we need semaphores
to be kernel-level objects". Implementation with pipes allows to avoid
the magic crap - they are real, normal pipes - nothing special from
the kernel POV. read(), write(), etc. are nothing but reading and writing
for pipes.

