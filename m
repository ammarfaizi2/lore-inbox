Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276511AbRJaBTU>; Tue, 30 Oct 2001 20:19:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278828AbRJaBTL>; Tue, 30 Oct 2001 20:19:11 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3333 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276511AbRJaBTI>; Tue, 30 Oct 2001 20:19:08 -0500
Date: Tue, 30 Oct 2001 17:17:34 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Alexander Viro <viro@math.psu.edu>
cc: <airlied@csn.ul.ie>, <linux-kernel@vger.kernel.org>
Subject: Re: oops on 2.4.13-pre5 in prune_dcache
In-Reply-To: <Pine.GSO.4.21.0110302009430.3707-100000@weyl.math.psu.edu>
Message-ID: <Pine.LNX.4.33.0110301713130.19263-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 30 Oct 2001, Alexander Viro wrote:
>
> Frankly, it looks like adding magic to struct dentry and struct inode
> might be a good idea.  Both icache and dcache lists tend to be long,
> so any memory corruption is very likely to show up in the code that
> walks them.

I don't like magic numbers. They showed that somebody corrupted something,
but little else. There's nothing sane you can do except warn about magic
mismatch (and ignore it or exit early), and quite frankly, an oops dump
tends to be as useful as the warning.

We used to have magic numbers for tty's and some other things, and they
never helped anybody.

Now, doing _poisoning_ etc of dynamical memory allocation, _that_ is a
magic number use I heartily agree with (if your oops dump has pointers
that look like the poison pattern, that's a useful piece of information)

If you only want to use magic numbers for memory sanity testing, you're
better off doing things like poisoning, and checking that the poison
pattern is there when you re-allocate etc.

		Linus

