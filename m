Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131705AbQK2QtT>; Wed, 29 Nov 2000 11:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131704AbQK2Qs7>; Wed, 29 Nov 2000 11:48:59 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:64693 "EHLO math.psu.edu")
        by vger.kernel.org with ESMTP id <S131701AbQK2Qsz>;
        Wed, 29 Nov 2000 11:48:55 -0500
Date: Wed, 29 Nov 2000 11:18:26 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Hugh Dickins <hugh@veritas.com>
cc: Andries Brouwer <aeb@veritas.com>, linux-kernel@vger.kernel.org
Subject: Re: access() says EROFS even for device files if /dev is mounted RO
In-Reply-To: <Pine.LNX.4.21.0011291533340.4535-100000@localhost.localdomain>
Message-ID: <Pine.GSO.4.21.0011291051010.14112-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Nov 2000, Hugh Dickins wrote:

> Sorry, I missed the point at issue here, and what changed when.
> Assuming (perhaps wrongly) it's independent of filesystem type,
> 
> Solaris         yes             ok              ok
> HP-UX           yes             EROFS           ok
> 
> I don't have UnixWare or OpenServer at hand to test,
> guess UnixWare as Solaris, can report OpenServer tomorrow.
> But it looks like a Floridan answer.

It looks like

	AT&T versions up to SysIII (at least), all UCB versions, Ultrix,
4.4BSD-derived systems, Solaris, pre-2.2.6 Linux, current 2.4.* Linux:
if access() says EROFS - open() will also fail with EROFS.

HP-UX and 2.2.6-2.2.18-pre*: give false alarm on access() even though they
allow open().

I would say that the latter group is badly outnumbered _and_ broken. It's one
thing when standard sets the bogus historical behaviour in stone, but
here we introduced bogus behaviour due to misreading the vague language
used in standard. Historically, on systems that allow write access to devices
on r/o filesystems access() doesn't return EROFS for devices. Moreover, that's
what one might reasonably expect and there are programs relying on that.
Principle of minimal surprise and all such...

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
