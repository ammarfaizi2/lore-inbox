Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129647AbRBUAXa>; Tue, 20 Feb 2001 19:23:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130035AbRBUAXW>; Tue, 20 Feb 2001 19:23:22 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:41992 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129647AbRBUAXS>; Tue, 20 Feb 2001 19:23:18 -0500
Date: Tue, 20 Feb 2001 16:22:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Daniel Phillips <phillips@innominate.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: [rfc] Near-constant time directory index for Ext2
In-Reply-To: <01022022544707.18944@gimli>
Message-ID: <Pine.LNX.4.10.10102201618520.31530-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 20 Feb 2001, Daniel Phillips wrote:
> 
> You mean full_name_hash?  I will un-static it and try it.  I should have
> some statistics tomorrow.  I have a couple of simple metrics for
> measuring the effectiveness of the hash function: the uniformity of
> the hash space splitting (which in turn affects the average fullness
> of directory leaves) and speed.

I was more thinking about just using "dentry->d_name->hash" directly, and
not worrying about how that hash was computed. Yes, for ext2 it will have
the same value as "full_name_hash" - the difference really being that
d_hash has already been precomputed for you anyway.

> Let the hash races begin.

Note that dentry->d_name->hash is really quick (no extra computation), but
I'm not claiming that it has anything like a CRC quality. And it's
probably a bad idea to use it, because in theory at least the VFS layer
might decide to switch the hash function around. I'm more interested in
hearing whether it's a good hash, and maybe we could improve the VFS hash
enough that there's no reason to use anything else..

		Linus

