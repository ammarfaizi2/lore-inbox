Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129854AbRCAUGe>; Thu, 1 Mar 2001 15:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129858AbRCAUGQ>; Thu, 1 Mar 2001 15:06:16 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:63755 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129854AbRCAUF5>; Thu, 1 Mar 2001 15:05:57 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [CFT][PATCH] Re: fat problem in 2.4.2
Date: 1 Mar 2001 12:05:50 -0800
Organization: Transmeta Corporation
Message-ID: <97ma2u$840$1@penguin.transmeta.com>
In-Reply-To: <E14YXft-0008GK-00@the-village.bc.nu> <Pine.GSO.4.21.0103011345110.11577-100000@weyl.math.psu.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.GSO.4.21.0103011345110.11577-100000@weyl.math.psu.edu>,
Alexander Viro  <viro@math.psu.edu> wrote:
>
>Alan, fix is really quite simple. Especially if you have vmtruncate()
>returning int (ac1 used to do it, I didn't check later ones). Actually
>just a generic_cont_expand() done on expanding path in vmtruncate()
>will be enough - it should be OK for all cases, including normal
>filesystems. <grabbing -ac7>
>
>OK, any brave soul to test that? All I can promise that it builds.

This looks like it would create a dummy block even for non-broken
filesystems (ie truncating a file to be larger on ext2 would create a
block, no?). While that would work, it would also waste disk-space.

		Linus
