Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282413AbRLKR1W>; Tue, 11 Dec 2001 12:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282481AbRLKR1D>; Tue, 11 Dec 2001 12:27:03 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50183 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S282413AbRLKR0m>; Tue, 11 Dec 2001 12:26:42 -0500
Date: Tue, 11 Dec 2001 09:26:09 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: GOTO Masanori <gotom@debian.org>
cc: <marcelo@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <andrea@suse.de>
Subject: Re: [PATCH] direct IO breaks root filesystem
In-Reply-To: <w534rmynn77.wl@megaela.fe.dis.titech.ac.jp>
Message-ID: <Pine.LNX.4.33.0112110923290.8613-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 11 Dec 2001, GOTO Masanori wrote:
> I, however, found another problem.
> Accessing with inode size unit (== 4096 byte) is ok, but if I accessed
> with block size unit, generic_direct_IO() returns error.  The reason
> is that blocksize is designated as inode->i_blkbits, and its value is
> not disk minimal block size (512), but inode's unit size (4096).

That is not a bug, but a feature.

We _always_ have to do the IO in "inode size" chunks, and if you want to
change it, you have to change it at a higher level (ie you should set the
blocksize with the "BLKBSZSET" ioctl.)

		Linus

