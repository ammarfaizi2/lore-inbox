Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277485AbRJJXSz>; Wed, 10 Oct 2001 19:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277529AbRJJXSp>; Wed, 10 Oct 2001 19:18:45 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:7684 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S277528AbRJJXS3>; Wed, 10 Oct 2001 19:18:29 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: [PATCH]Fix bug:rmdir could remove current working directory
Date: Wed, 10 Oct 2001 23:17:45 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9q2kup$31b$1@penguin.transmeta.com>
In-Reply-To: <Pine.GSO.4.21.0110101743140.21168-100000@weyl.math.psu.edu> <3BC4EFFC.42ACE59E@us.ibm.com>
X-Trace: palladium.transmeta.com 1002755924 18449 127.0.0.1 (10 Oct 2001 23:18:44 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 10 Oct 2001 23:18:44 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BC4EFFC.42ACE59E@us.ibm.com>,
Mingming cao  <cmm@us.ibm.com> wrote:
>
>I thought about the case when rmdir() on the cwd of other processes,
>but, as you said, that is implementation dependent. However rmdir() on
>"." does returns EBUSY error.

That's a completely different thing, though - even though the difference
is rather subtle.

You can remove pretty much any empty directory (if the filesystem
permits it - some don't). HOWEVER, you can not use "." as the final
component of your pathname.

It has nothing to do with home directory: you can try just doing

	mkdir /tmp/hello
	rmdir /tmp/hello/.

and you'll get the same error (and it _should_ return EINVAL, not EBUSY.
EBUSY is for the "this filesystem doesn't allow you to remove a
directory that is in use" case).

			Linus
