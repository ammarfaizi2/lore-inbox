Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133005AbRDST2C>; Thu, 19 Apr 2001 15:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133009AbRDST1I>; Thu, 19 Apr 2001 15:27:08 -0400
Received: from runyon.cygnus.com ([205.180.230.5]:49290 "EHLO cygnus.com")
	by vger.kernel.org with ESMTP id <S133005AbRDST1G>;
	Thu, 19 Apr 2001 15:27:06 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Abramo Bagnara <abramo@alsa-project.org>, Alon Ziv <alonz@nolaviz.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mkravetz@sequent.com>
Subject: Re: light weight user level semaphores
In-Reply-To: <Pine.LNX.4.31.0104191036220.5052-100000@penguin.transmeta.com>
Reply-To: drepper@cygnus.com (Ulrich Drepper)
X-fingerprint: BE 3B 21 04 BC 77 AC F0  61 92 E4 CB AC DD B9 5A
X-fingerprint: e6:49:07:36:9a:0d:b7:ba:b5:e9:06:f3:e7:e7:08:4a
From: Ulrich Drepper <drepper@redhat.com>
Date: 19 Apr 2001 12:26:03 -0700
In-Reply-To: Linus Torvalds's message of "Thu, 19 Apr 2001 10:38:34 -0700 (PDT)"
Message-ID: <m3ofts3d4k.fsf@otr.mynet.cygnus.com>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.2 (Thelxepeia)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:

> Looks good to me. Anybody want to try this out and test some benchmarks?

I fail to see how this works across processes.  How can you generate a
file descriptor for this pipe in a second process which simply shares
some memory with the first one?  The first process is passive: no file
descriptor passing must be necessary.

How these things are working elsewhere is that a memory address
(probably a physical address) is used as a token.  The semaphore
object is placed in the memory shared by the processes and the virtual
address is passed in the syscall.

Note that semaphores need not always be shared between processes.
This is a property the user has to choose.  So the implementation can
be easier in the normal intra-process case.

In any case all kinds of user-level operations are possible as well
and all the schemes suggested for dealing with the common case without
syscalls can be applied here as well.

-- 
---------------.                          ,-.   1325 Chesapeake Terrace
Ulrich Drepper  \    ,-------------------'   \  Sunnyvale, CA 94089 USA
Red Hat          `--' drepper at redhat.com   `------------------------
