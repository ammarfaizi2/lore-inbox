Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129279AbRBVEDI>; Wed, 21 Feb 2001 23:03:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129323AbRBVEC6>; Wed, 21 Feb 2001 23:02:58 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:7688 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129279AbRBVECt>; Wed, 21 Feb 2001 23:02:49 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [rfc] Near-constant time directory index for Ext2
Date: 21 Feb 2001 20:02:18 -0800
Organization: Transmeta Corporation
Message-ID: <97230a$16k$1@penguin.transmeta.com>
In-Reply-To: <200102220203.f1M237Z20870@webber.adilger.net> <3A947C54.E4750E74@transmeta.com> <3A948ACB.7B55BEAE@innominate.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3A948ACB.7B55BEAE@innominate.de>,
Daniel Phillips  <phillips@innominate.de> wrote:
>
>I mentioned this earlier but it's worth repeating: the desire to use a
>small block size is purely an artifact of the fact that ext2 has no
>handling for tail block fragmentation.  That's a temporary situation -
>once we've dealt with it your 2,000,000 file directory will be happier
>with 4K filesystem blocks.

I'd rather see a whole new filesystem than have ext2 do tail-block
fragmentation. 

Once you do tail fragments, you might as well do the whole filesystem
over and have it do fancier stuff than just handling sub-blocking. 

Another way of saying this: if you go to the complexity of no longer
being a purely block-based filesystem, please go the whole way. Make the
thing be extent-based, and get away from the notion that you have to
allocate blocks one at a time. Make the blocksize something nice and
big, not just 4kB or 8kB or something.

And don't call it ext2. 

		Linus
