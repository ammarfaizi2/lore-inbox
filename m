Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261462AbREOUls>; Tue, 15 May 2001 16:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261475AbREOUli>; Tue, 15 May 2001 16:41:38 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:57280 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S261462AbREOUlY>;
	Tue, 15 May 2001 16:41:24 -0400
Date: Tue, 15 May 2001 16:41:09 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: James Simmons <jsimmons@transvirtual.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Neil Brown <neilb@cse.unsw.edu.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B0191E5.508CAB9@transmeta.com>
Message-ID: <Pine.GSO.4.21.0105151632380.21081-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 May 2001, H. Peter Anvin wrote:

> Permission management.  The permissions on the subnodes are inherited
> from the main node, which is stored on a persistent medium.

If you want them all to inherit it - inherit from mountpoint. End of story.
Yes, it means that permission(9) will need vfsmount argument. But we
_will_ need that anyway. For per-mountpoint read-only, if nothing else.

Want details? Please. We have the ->getattr() method. Currently not
used, but intended to be used by ...stat family (with the current
behaviour being default). Now, let's pass to permission(9), notify_change(9)
and ->{set,get}attr()  both vfsmount and dentry. See what I mean?

We get (essentially for free)
	* per-mountpoint read-only flag (I've already done nosuid, noexec
and nodev per-mountpoint)
	* ability to have inodes that simply don't have owners - ownership
is determined (and handled) by the functions/methods above. So FAT and
friends can get rid of knowledge of uid=,gid=" crap.
	* ability to inherit ownership from mountpoint and if fs wants it -
update the ownership of mountpoint.

