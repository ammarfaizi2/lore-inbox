Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279313AbRJWHl2>; Tue, 23 Oct 2001 03:41:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279314AbRJWHlS>; Tue, 23 Oct 2001 03:41:18 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:9480 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S279313AbRJWHlE>; Tue, 23 Oct 2001 03:41:04 -0400
Message-ID: <3BD51F02.92B9B7F3@idb.hist.no>
Date: Tue, 23 Oct 2001 09:40:50 +0200
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.4.12 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: safemode <safemode@speakeasy.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: time tells all about kernel VM's
In-Reply-To: <20011023030353Z279218-17408+3723@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

safemode wrote:
[...]
> B.  The VM has this need to redistribute cache and buffer so that an OOM
> situation doesn't take place until all the ram is basically being used.  The
> problem is that currently the VM will swap out stuff it isn't using and
> without buffer it must read from the drive (which is being used to swap)
> which takes more cpu which isn't there because the app is locking the kernel
> up trying to allocate memory (see why dbench causes mp3 skips).  So what
> happens is that the kernel cant swap because the hdd io is being strangled by
> the process that's going out of control (kghostview) which means that the VM
> is stuck doing this redistribution at a snails pace and the OOM situation
> never occurs (or occurs many days later when you've died of starvation).
> Leaving you deadlocked on a kernel with a VM that is supposed to conquer this
> situation and make it a thing of the past.
> 
Any VM with paging _can_ be forced into a trashing situation where
a keypress takes hours to process.  A better VM will take more pressure
before it gets there and performance will degrade more gradually.
But any VM can get into this situation.

Consider a malicious app that uses lots of RAM but deliberately leaves
a _single_ page free.  OOM will never happen, but the machine is
brought to its knees anyway.  (You can also get in trouble by running
a few hundred infinite loops, with some dummy io so they too get the
io boost other processes gets.)

Swapping out whole processes can help this, but it will merely
move the point where you get stuck.  A load control system that
kills processes when response is too slow is possible, but
the problem here is that you can't get people to agree
on how bad is too bad.  It is sometimes ok to leave the machine 
alone crunching a big problem over the weekend.  And sometimes
you _need_ response much faster.

And what app to kill in such a situation?
You had a single memory pig, but it aint necessarily so.

Helge Hafting
