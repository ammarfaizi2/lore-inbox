Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130296AbQKAQHh>; Wed, 1 Nov 2000 11:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131434AbQKAQH1>; Wed, 1 Nov 2000 11:07:27 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:8701 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S130296AbQKAQHM>; Wed, 1 Nov 2000 11:07:12 -0500
Date: Wed, 1 Nov 2000 14:05:37 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Jonathan George <Jonathan.George@trcinc.com>
cc: "'matthew@mattshouse.com'" <matthew@mattshouse.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: 2.4.0-test10 Sluggish After Load
In-Reply-To: <790BC7A85246D41195770000D11C56F21C847A@trc-tpaexc01.trcinc.com>
Message-ID: <Pine.LNX.4.21.0011011402010.11112-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Nov 2000, Jonathan George wrote:

> It might be helpful to show the current (post crippled) results
> of top. Futhermore, a list of allocated ipc resources (share
> memory, etc.) and open files (lsof) would be nice.

The problem may well be that Oracle wants to clean up
all memory at once, accessing much more memory than
it did while under stress with more tricky access
patterns.

The 2.4 VM is basically pretty good when you're not
thrashing and has efficient management of the VM until
your working set reaches the size of physical memory.

But once you hit the thrashing point, the VM falls
flat on its face. This is a nasty surprise to many
people and I am working on (trivial) thrashing control,
but it's not there yet (and not all that important).

If this looks bad to you, compare the points where 2.2
starts thrashing and where 2.4 starts thrashing. You'll
most likely (there must be a few corner cases where 2.2
does better ;)) see that 2.4 still runs fine where 2.2
performance has already "degraded heavily" and that 2.2
has "hit the wall" before 2.4 does so ... the difference
just is that 2.4 hits the wall more suddenly ;)

regards,

Rik
--
"What you're running that piece of shit Gnome?!?!"
       -- Miguel de Icaza, UKUUG 2000

http://www.conectiva.com/		http://www.surriel.com/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
