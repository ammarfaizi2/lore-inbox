Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131205AbRDSQNN>; Thu, 19 Apr 2001 12:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131246AbRDSQM4>; Thu, 19 Apr 2001 12:12:56 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:54537 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S131205AbRDSQMh>; Thu, 19 Apr 2001 12:12:37 -0400
Date: Thu, 19 Apr 2001 09:11:56 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Abramo Bagnara <abramo@alsa-project.org>
cc: Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>,
        Ulrich Drepper <drepper@cygnus.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <3ADEA746.D3A44511@alsa-project.org>
Message-ID: <Pine.LNX.4.31.0104190903560.3842-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 19 Apr 2001, Abramo Bagnara wrote:
>
> > [ Using file descriptors ]
>
> This would also permit:
> - to have poll()
> - to use mmap() to obtain the userspace area
>
> It would become something very near to sacred Unix dogmas ;-)

No, this is NOT what the UNIX dogmas are all about.

When UNIX says "everything is a file", it really means that "everything is
a stream of bytes". Things like magic operations on file desciptors are
_anathema_ to UNIX. ioctl() is the worst wart of UNIX. Having magic
semantics of file descriptors is NOT Unix dogma at all, it is a horrible
corruption of the original UNIX cleanlyness.

Please don't excuse "semaphore file descriptors" with the "everything is a
file" mantra. It is not at ALL applicable.

The "everything is a file" mantra is to make pipe etc meaningful -
processes don't have to worry about whether the fd they have is from a
file open, a pipe() system call, opening a special block device, or a
socket()+connect() thing. They can just read and write. THAT is what UNIX
is all about.

And this is obviously NOT true of a "magic file descriptors for
semaphores". You can't pass it off as stdin to another process and expect
anything useful from it unless the other process _knows_ it is a special
semaphore thing and does mmap magic or something.

The greatness of UNIX comes from "everything is a stream of bytes". That's
something that almost nobody got right before UNIX. Remember VMS
structured files? Did anybody ever realize what an absolutely _idiotic_
crock the NT "CopyFile()" thing is for the same reason?

Don't confuse that with "everything should be a file descriptor". The two
have nothing to do with each other.

		Linus

