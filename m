Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278943AbRKFJQN>; Tue, 6 Nov 2001 04:16:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278709AbRKFJQE>; Tue, 6 Nov 2001 04:16:04 -0500
Received: from celebris.bdk.pl ([212.182.99.100]:40466 "EHLO celebris.bdk.pl")
	by vger.kernel.org with ESMTP id <S278701AbRKFJPz>;
	Tue, 6 Nov 2001 04:15:55 -0500
Date: Tue, 6 Nov 2001 10:16:33 +0100 (CET)
From: Wojtek Pilorz <wpilorz@bdk.pl>
To: Alexander Viro <viro@math.psu.edu>
cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <Pine.GSO.4.21.0111052006040.27086-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.21.0111061000060.16977-100000@celebris.bdk.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Nov 2001, Alexander Viro wrote:

[...]
> 
> find(1).  Stuff that runs every damn night.  We end up doing getdents() +
> bunch of lstat() on the entries we had found.  And that means access to
> inodes refered from them.  Try that on a large directory with child
> inodes spread all over the disk.
> 
[...]

Part of the problem is that, as far as I know, there is no sane way to
request the kernel to execute a number of lstat-s or similar calls
in the order that would be convenient to the system (I do not consider
creating threads for this purpose a sane way).
If a program (say find, or tar, or anything) needs an information from 
5000 lstats of fstats or reads, it has to specify them one-by-one in some
order, without knowledge which order would be best.
If we had a call to execute a vector of lstats, or open, or reads (from
different handles), program which would use such calls would allow kernel
to take decision what is the best order or individual operations.

I remember that using similar 'vector' functions in old days on IBM OS/MVT
gave dramatical performance improvements (maybe for different
reasons; machine memories were often half a megabyte, so opening a file
required the system to read and execute several modules loaded from system
disks; when opening 10 files each of the modules had to be loaded once
rather than 10 times).

Would it be possible and a good idea to add such 'vector' operations to
the Linux kernel?

Best regards,

Wojtek
--------------------
Wojtek Pilorz
Wojtek.Pilorz@bdk.pl


