Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264041AbRFMTcM>; Wed, 13 Jun 2001 15:32:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263999AbRFMTcC>; Wed, 13 Jun 2001 15:32:02 -0400
Received: from dsl-64-192-150-245.telocity.com ([64.192.150.245]:15628 "EHLO
	mail.communicationsboard.net") by vger.kernel.org with ESMTP
	id <S264041AbRFMTbt>; Wed, 13 Jun 2001 15:31:49 -0400
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.6-pre2, pre3 VM Behavior
Message-ID: <992460707.3b27bfa31aa98@eargle.com>
Date: Wed, 13 Jun 2001 15:31:47 -0400 (EDT)
From: Tom Sightler <ttsig@tuxyturvy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: IMP/PHP IMAP webmail program 2.2.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

I have been using the 2.4.x kernels since the 2.4.0-test days on my Dell 5000e
laptop with 320MB of RAM and have experienced first hand many of the problems
other users have reported with the VM system in 2.4.  Most of these problems
have been only minor anoyances and I have continued testing kernels as the 2.4
series has continued, mostly without noticing much change.

With 2.4.6-pre2, and -pre3 I can say that I have seen a marked improvement on my
machine, especially in interactive response, for my day to day workstation uses.
 However, I do have one observation that seems rather strange, or at least wrong.

I, on occasion, have the need to transfer relatively large files (750MB-1GB)
from our larger Linux servers to my machine.  I usually use ftp to transfer
these files and this is where I notice the following:

1.  Transfer of the first 100-150MB is very fast (9.8MB/sec via 100Mb Ethernet,
close to wire speed).  At this point Linux has yet to write the first byte to
disk.  OK, this might be an exaggerated, but very little disk activity has
occured on my laptop.

2.  Suddenly it's as if Linux says, "Damn, I've got a lot of data to flush,
maybe I should do that" then the hard drive light comes on solid for several
seconds.  During this time the ftp transfer drops to about 1/5 of the original
speed.

3.  After the initial burst of data is written things seem much more reasonable,
and data streams to the disk almost continually while the rest of the transfer
completes at near full speed again.

Basically, it seems the kernel buffers all of the incoming file up to nearly
available memory before it begins to panic and starts flushing the file to disk.
 It seems it should start to lazy write somewhat ealier.  Perhaps some of this
is tuneable from userland and I just don't know how.

This was much less noticeable on a server with a much faster SCSI hard disk
subsystem as it took significantly less time to flush the information to the
disk once it finally starterd, but laptop hard drives are traditionally poor
performers and at 15MB/s it take 10-15 seconds before things stable out, just
from transferring a file.

Anyway, things are still much better, with older kernels things would almost
seem locked up during those 10-15 seconds but now my apps stay fairly responsive
(I can still type in AbiWord, browse in Mozilla, etc).

Later,
Tom
