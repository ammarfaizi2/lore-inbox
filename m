Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131224AbQK2NKi>; Wed, 29 Nov 2000 08:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131397AbQK2NK3>; Wed, 29 Nov 2000 08:10:29 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62688 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131224AbQK2NKS>;
        Wed, 29 Nov 2000 08:10:18 -0500
Date: Wed, 29 Nov 2000 07:39:51 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Hugh Dickins <hugh@veritas.com>
cc: Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.LNX.4.21.0011291147170.4021-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0011290711430.14112-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Hugh Dickins wrote:

> On Tue, 28 Nov 2000, Andries Brouwer wrote:
> > On Tue, Nov 28, 2000 at 03:04:31PM +0100, Rogier Wolff wrote:
> > 
> > > Ok, so if you read the standard carefully you get a bogus result. 
> > 
> > Why bogus? Things could have been otherwise, but the important
> > part is that all Unices do things the same way.
> 
> Yes, and I think you'll have difficulty, Andries, finding
> any other Unices which interpret the standard as you and
> Linux do: Solaris, HP-UX, UnixWare and OpenServer all allow
> writing to a device node (or FIFO) on read-only filesystem.

Hold on. What do they return upon access()? I've looked through the
available kernel sources and results are:
	has r/o filesystems	access()	open()
v3:		no
v5, v6:		yes		N/A		EROFS
v7:		yes		EROFS		EROFS
PDP versions of BSD prior to 2.10, Ultrix 3.1, SysIII, PWB: same as v7
4.4BSD:		yes		ok		ok
{Free,Net,Open}BSD, Linux prior to 2.2.6 and post 2.4.0-test9-pre7: ditto
2.10BSD, 2.10.1BSD, 2.11BSD: ditto
4.3-Tahoe and later: ditto, judging by date of 2.10 release.

What you are saying is that recent SysV variants have
		yes		?		ok
Nice, but what do they do on access()? If they do not return EROFS for
devices - that's it, standard needs to be fixed and 2.2 should drop the
special-casing in sys_access().

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
