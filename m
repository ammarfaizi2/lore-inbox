Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315611AbSFCWTx>; Mon, 3 Jun 2002 18:19:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315616AbSFCWTw>; Mon, 3 Jun 2002 18:19:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:40975 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315611AbSFCWTv>; Mon, 3 Jun 2002 18:19:51 -0400
Date: Mon, 3 Jun 2002 15:19:44 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Chris Mason <mason@suse.com>
cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 12/16] fix race between writeback and unlink
In-Reply-To: <1023142233.31475.23.camel@tiny>
Message-ID: <Pine.LNX.4.44.0206031514110.868-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 3 Jun 2002, Chris Mason wrote:
>
> Or am I missing something?

No. I think that in the long run we really would want all of the writeback
preallocation should happen in the "struct file", not in "struct inode".
And they should be released at file close ("release()"), not at iput()
time.

I _think_ that right now nfsd doesn't cache file opens (only inodes), so
this could be a performance issue for nfsd, but it might be possible to
change how nfsd acts. And it would be a _lot_ cleaner to do it at the file
level.

		Linus

