Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312696AbSDFSZk>; Sat, 6 Apr 2002 13:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312704AbSDFSZj>; Sat, 6 Apr 2002 13:25:39 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:32273 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312696AbSDFSZj>; Sat, 6 Apr 2002 13:25:39 -0500
Date: Sat, 6 Apr 2002 10:23:10 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
        Dave Hansen <haveblue@us.ibm.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [WTF] ->setattr() locking changes
In-Reply-To: <Pine.GSO.4.21.0204061213490.632-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0204061020140.24305-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




On Sat, 6 Apr 2002, Alexander Viro wrote:
> >
> > Comments?  If you don't see any problems with this variant I'll do it.
>
> OTOH, we might be better off taking ->i_sem in all callers of notify_change().

That was my first reaction on Dave's patch, but on the other hand it then
looked so simple to just let notify_change() do the locking (none of the
places I looked at wanted to do anything else), that it looked better
inside notify_change.

I agree with you that doing the locking outside would clean some stuff up,
since things like write already have the lock for other reasons.

> Hmm...  While we are at it, why don't we remove suid/sgid on truncate(2)?

Are there any standards saying either way? But yes, it sounds logical.

		Linus

