Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312896AbSDKUVO>; Thu, 11 Apr 2002 16:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312901AbSDKUVN>; Thu, 11 Apr 2002 16:21:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22544 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S312896AbSDKUVN>; Thu, 11 Apr 2002 16:21:13 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [prepatch] address_space-based writeback
Date: Thu, 11 Apr 2002 20:20:04 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <a94r5k$m23$1@penguin.transmeta.com>
In-Reply-To: <3CB4203D.C3BE7298@zip.com.au> <3CB48F8A.DF534834@zip.com.au> <20020410221211.GA6076@ravel.coda.cs.cmu.edu> <5.1.0.14.2.20020410235415.03d41d00@pop.cus.cam.ac.uk>
X-Trace: palladium.transmeta.com 1018556454 19227 127.0.0.1 (11 Apr 2002 20:20:54 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 11 Apr 2002 20:20:54 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <5.1.0.14.2.20020410235415.03d41d00@pop.cus.cam.ac.uk>,
Anton Altaparmakov  <aia21@cam.ac.uk> wrote:
>
>Um, NTFS uses address spaces for things where ->host is not an inode at all 
>so doing host->i_sb will give you god knows what but certainly not a super 
>block!

Then that should be fixed in NTFS.

The original meaning of "->host" was that it could be anything (and it
was a "void *", but the fact is that all the generic VM code etc needed
to know about host things like size, locking etc, so for over a year now
"host" has been a "struct inode", and if you need to have something
else, then that something else has to embed a proper inode.

>As long as your patches don't break that is possible to have I am happy... 
>But from what you are saying above I have a bad feeling you are somehow 
>assuming that a mapping's host is an inode...

It's not Andrew who is assuming anything: it _is_. Look at <linux/fs.h>,
and notice the

	struct inode            *host;

part.

		Linus
