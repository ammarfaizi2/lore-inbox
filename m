Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278522AbRJaPph>; Wed, 31 Oct 2001 10:45:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280187AbRJaPpS>; Wed, 31 Oct 2001 10:45:18 -0500
Received: from ns.ithnet.com ([217.64.64.10]:35340 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S278522AbRJaPpP>;
	Wed, 31 Oct 2001 10:45:15 -0500
Date: Wed, 31 Oct 2001 16:45:39 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: The good, the bad & the ugly (or VM, block devices, and SCSI :-)
Message-Id: <20011031164539.29c04ee0.skraw@ithnet.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,

this is a message especially for:

Gerard Roudier <groudier@club-internet.fr>, symbios driver
Justin T. Gibbs, adaptec driver
Andrea and Rik, VM
Linus, the man with the big picture :-)

Everything started with a note from a friend who tried some small all-in-one
box with a sym53c1010 onboard. He (an all-time adaptec user like me) told me
the small box feels like flying, compared to his at-home box (with adaptec).
This made me curious for trying myself. I bought a Tekram DC390 U3W (which is
in fact a relabeled U3D) with symbios chipset. I simply replaced the controller
in my box (compiled a kernel with both drivers of course) and gave it a try
with bonnie. It did not look impressing. Effectively adaptec A29160 and DC390
had the same read and write speeds, only noticeable was that tekram performed
twice as many seeks as adaptec. This was reproducable in all bonnie-tests. Hm,
that should not make the big difference. Anyway I was too lazy to put the
adaptec back in and continued working (for several days). Today it hit me:
As Linus said something about testing pre6 I gave it a try and did the usual
nfs-copy, cd read test. I was pretty astonished to see the tekram perform very
well under heavy I/O load, here are the numbers:

A29160:                                     symbios:

cd read without nfs-load:                   cd read without nfs-load
2998,9 kB                                   3619,3 kB
3168,2 kB                                   3611,1 kB
2968,4 kB                                   3620,2 kB

cd read with nfs load:                      cd read with nfs load
1926,2 kB                                   3408,1 kB
2123,4 kB                                   3395,2 kB
2539,4 kB                                   3605,1 kB
2631,9 kB                                   3605,8 kB

The rest of the hardware involved is completely the same, only the controller
boards got exchanged. Another thing quite remarkable: during symbios tests the
network throughput derived from nfs load is _higher_ and looks more stable.
Whereas during adaptec the whole picture looks like having hiccup. More to say:
starting an application  during the tests results in waiting a bit (some 10-20
seconds) with tekram, but waiting pretty long (or even forever, "the ugly" ;-)
while using adaptec. This is particularly interesting for the vm guys since all
the scene is in high vm load with around 3-5 MB of free mem and a damn lot of
page cache. So if you try something around vm I can only urge you to perform
tests that do _no_ I/O at all, because you may be greatly bitten by your
controller (or its driver).
Another thing to mention: during the last cd-read tests with tekram setup I
already have been deeply impressed by the driver, so I decided to stress it
some more and start applications (like mozilla) in the background. And in the
end I was even more impressed, because it turned out (you can see in the last
two figures), that it got even _faster_. Obviously I cannot explain why.
If anybody wants me to test anything, feel free to ask.

My personal opinion: Justin has work to do.

Regards,
Stephan




