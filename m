Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129574AbRBIBV4>; Thu, 8 Feb 2001 20:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129700AbRBIBVr>; Thu, 8 Feb 2001 20:21:47 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:23304 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129574AbRBIBVj>; Thu, 8 Feb 2001 20:21:39 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: dentry cache order 7 is broken
Date: 8 Feb 2001 17:21:20 -0800
Organization: Transmeta Corporation
Message-ID: <95vgmg$i9u$1@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.33.0102072302030.5947-100000@twinlark.arctic.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.33.0102072302030.5947-100000@twinlark.arctic.org>,
dean gaudet  <dean-list-linux-kernel@arctic.org> wrote:
>
>if you've got 512Mb of RAM you end up with a dentry cache of order 7 --
>65536 entries.
>
>this results in a D_HASHBITS of 16.  if you look at d_hash it contains
>this code:
>
>	hash = hash ^ (hash >> D_HASHBITS) ^ (hash >> D_HASHBITS*2);

Cool.

Just remove the third part altogether.  The "hash" is only 32 bits
anyway (even on 64-bit platforms, as we don't want to blow up the dentry
size unnecessarily).  And with most machines with reasonable memory, you
already get fine distribution with just two terms (ie you don't lose any
bits), and it speeds it up and avoids the problem you see.

Thanks..

		Linus
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
