Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264535AbTFVQn6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 12:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264638AbTFVQn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 12:43:58 -0400
Received: from netix1.demon.co.uk ([212.228.80.161]:57604 "EHLO netunix.com")
	by vger.kernel.org with ESMTP id S264535AbTFVQn4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 12:43:56 -0400
Date: Sun, 22 Jun 2003 18:00:30 +0100 (BST)
From: "C.Newport" <crn@netunix.com>
To: <linux-kernel@vger.kernel.org>
Subject: More Re: Bug - nfsroot fails with 2 NICs (fwd)
Message-ID: <Pine.LNX.4.33.0306221758280.5233-100000@hek.netunix.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



---------- Forwarded message ----------
Date: Sun, 22 Jun 2003 17:53:47 +0100 (BST)
From: C.Newport <crn@hek.netunix.com>
To: sparclinux@vger.kernel.org
Cc: lkml@vger.kernel.org    -----<<<<< oops re-copied to linux-kernel
Subject: More Re: Bug - nfsroot fails with 2 NICs


[ Cc to lkml, please include sparclinux in replies ]

I have done some more tests on this one.
The failure occurs whenever there are 2 NICs which use the same
driver. The appears to be a problem in the NIC initialisation
which ends up with part of the initialisation happening on the
wrong NIC, most likely a race of some kind.

A quick search reveals that this is a generic issue rather than
being specific to Sparc. Others in alt.os.linux.slackware have
noted that (on intel where each NIC has its own MAC) each NIC gets
initialised with the MAC of the other NIC which is WIERD.

Until this gets fixed it will be necessary to remove additional
NICs by removing boards before booting from the network. This will
not be possible on some machines with 2 on-board NICs such as
the V100 and V150.

This bug appears to have crept into recent kernels within the last
year or so, between 2.2.20 and 2.2.25. Both 2.4.20 and 2.4.21 are
affected.

On Fri, 20 Jun 2003, C.Newport wrote:

>
> Something appears to be broken in the network initialisation code
> when booting a machine which has more than one NIC from the network.
>
>  =============
> Test case 1 :-
>
> Ultra1 Creater 3D with onboard hme plus second hme on fastwideSE+FE card
> 501-2739  512MB memory.
> boot net ip=rarp root=nfs
>  Loops continually with IP-Config: Incomplete network configuration.
>                         IP-Config: Reopening network devices...
>  This fault occurs on both the 10Mb hub and the 10/100 switched network.
>
> After removing fastwideSE+FE card this machine boots correctly
> with kernel 2.4.20 and mounts the NFS root.
>
>  =============
>
> Test case 2 :-
>
> SS1000E with 2 x SM81, 512MB, 1 x sunlance on each of 2 boards.
>  ( = 4 x SM81, 1G, 2 x sunlance total)
> boot net ip=rarp root=nfs
>  Looking up port of RPC 100003/2 on 192.168.192.24
>  neighbour table overflow
>  neighbour table overflow ........
>
> boot net ip=rarp root=/dev/sda1
>  boots kernel 2.2.25
>
> After removing the 2nd system board
> boot net ip=rarp root=nfs
>  boots kernel 2.2.25 correctly.
>
> This fault does not happen with kernel 2.2.20
>
>  =========
>
> Test case 3 :-
>
> SS20 with 1 x SM71 256Mb sunlance onboard +  hme on fastwideSE+FE card
>
> boot net ip=rarp root=nfs
>  boots correctly to kernel 2.2.25
>  boots correctly to kernel 2.2.20pre2
>
> It seems that sunlance+hme works OK  (at least with 2.2.25)
> If it would help I will build a 2.4.20 tftp image for this machine
> in the morning - it is 0 dark 30 here.

The fault does not occur in this case ( with 2.4.20) because we
have different NICs, sunlance and sunhme.


