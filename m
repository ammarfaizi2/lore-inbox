Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268510AbRHAWbU>; Wed, 1 Aug 2001 18:31:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268514AbRHAWbK>; Wed, 1 Aug 2001 18:31:10 -0400
Received: from [63.209.4.196] ([63.209.4.196]:25107 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268510AbRHAWa4>; Wed, 1 Aug 2001 18:30:56 -0400
Date: Wed, 1 Aug 2001 15:29:58 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: <Andries.Brouwer@cwi.nl>
cc: <alan@lxorguk.ukuu.org.uk>, <hch@caldera.de>, <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vxfs fix
In-Reply-To: <200108012103.VAA93890@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.33.0108011522590.21247-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Aug 2001 Andries.Brouwer@cwi.nl wrote:
>
> When mount continues to try all types, it may try V7.
> That always succeeds, there is no test for magic or so,
> and after garbage has been mounted as a V7 filesystem,
> the kernel crashes or hangs or fails in other sad ways.

Even on filesystems that have bad (limited or non-existent) magic numbers,
the read_super() function should really be able to do a fair amount of
sanity-checking. If nothing else, then things like verifying that the root
inode really is a directory with a proper size, for example.

I don't think V7 has a magic number at all. But checking that the size and
nr-of-inodes fields make sense, together with verifying that the root
inode really is a directory with (size % 512) == 0, and possibly verifying
things like "if the root directory is not large enough to have a
doubly/triply indirect block, then that doubly/triply indirect blocknumber
had better be zero"  would catch 99.9% of everything.

Whether those kind of tests are really worth adding, considering the
rather limited number of people who actually enable the FS, I don't know.

		Linus

