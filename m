Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288779AbSADVPe>; Fri, 4 Jan 2002 16:15:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288774AbSADVPZ>; Fri, 4 Jan 2002 16:15:25 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:52498 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288782AbSADVPV>; Fri, 4 Jan 2002 16:15:21 -0500
Date: Fri, 4 Jan 2002 13:14:47 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <Andries.Brouwer@cwi.nl>, <Nikita@Namesys.COM>,
        <alessandro.suardi@oracle.com>, <jgarzik@mandrakesoft.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.2-pre7 still missing bits of kdev_t
In-Reply-To: <Pine.GSO.4.21.0201041601510.27334-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0201041311240.8047-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Alexander Viro wrote:
>
> Reasons:
> 	a) foo_mknod() - why the hell would we take dev_t, pass it into
> ->mknod() only to split it into major:minor there and immediately
> rebuild dev_t from them?  And that - for _all_ instances of ->mknod()

No, if you make init_special_inode() take minor/major, then you have to
make mknod do the same.

At that point it becomes a ABI issue how the mknod _system_call_ argument
is split up into major/minor, and the rest of the kernel wouldn't really
care.

However, looking more at this, we clearly need to have the same ABI for
stat() as for mknod(), so it probably makes sense to just continue to have
"dev_t is a standard mix of minor/major" numbers approach, and just
continue passing "dev_t" around exactly as such a combination (and then
let people do the proper MKNOD/MAJOR/MINOR macros on it).

So you may be right - there are no real advantage from splitting the two,
as long as dev_t and kdev_t cannot be mixed up by mistake (which is
largely true already now).

		Linus

