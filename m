Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286165AbRLJGCN>; Mon, 10 Dec 2001 01:02:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286166AbRLJGCE>; Mon, 10 Dec 2001 01:02:04 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8715 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S286165AbRLJGBx>; Mon, 10 Dec 2001 01:01:53 -0500
Date: Sun, 9 Dec 2001 21:55:57 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: GOTO Masanori <gotom@debian.org>
cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <andrea@suse.de>
Subject: Re: [PATCH] direct IO breaks root filesystem
In-Reply-To: <w534rmzendn.wl@megaela.fe.dis.titech.ac.jp>
Message-ID: <Pine.LNX.4.33.0112092154060.13692-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 10 Dec 2001, GOTO Masanori wrote:
>
> The reason is that when kernel accesses /dev/sda with O_DIRECT,
> blkdev_direct_IO() is called. But, it calls generic_direct_IO(),
> and generic_direct_IO() calls brw_kiovec(..., inode->i_dev, ...).

That's a bad bug, yes.

However, the bug is really in "generic_direct_IO()", and you should fix it
there, instead of avoiding to use it altogether.

"generic_direct_IO()" should just get the device from "bh->b_dev (which is
filled in correctly by "get_block()".

		Linus

