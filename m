Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275448AbRJFSZF>; Sat, 6 Oct 2001 14:25:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275470AbRJFSYq>; Sat, 6 Oct 2001 14:24:46 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:52359 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275448AbRJFSYi>;
	Sat, 6 Oct 2001 14:24:38 -0400
Date: Sat, 6 Oct 2001 14:25:06 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Jan Kara <jack@ucw.cz>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Nathan Scott <nathans@wobbly.melbourne.sgi.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Quotactl change
In-Reply-To: <20011006150731.C30450@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.GSO.4.21.0110061417260.6465-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Oct 2001, Jan Kara wrote:

>   Hello,
> 
>   I'm sending you a change for quotactl interface which Nathan Scott proposed
> for XFS. Actually it's his patch with just a few changes from me.
>   It allows quotactl() to be overidden by a filesystem and so XFS can do it's
> tricks with quota without patching dquot.c. Sideeffect of this change is a
> cleanup in quotactl() interface :).

[snip]

	Umm...  So you've just given to each fs driver a syscall with
completely unspecified arguments?  I _really_ doubt that it's a good
idea, especially since each instance will have to copy structures
to/from userland.

	Please, put switch by the first argument and copy_{to,from}_user()
into the syscall itself.  Yes, it means more methods, but it helps to avoid
large PITA couple of years down the road.

