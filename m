Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280383AbRJaSVm>; Wed, 31 Oct 2001 13:21:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280384AbRJaSVX>; Wed, 31 Oct 2001 13:21:23 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24590 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S280383AbRJaSVO>; Wed, 31 Oct 2001 13:21:14 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: pre6 BUG oops
Date: Wed, 31 Oct 2001 18:19:31 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9rpfbj$vrn$1@penguin.transmeta.com>
In-Reply-To: <3BE03401.406B8585@mandrakesoft.com> <20011031.094112.125896630.davem@redhat.com>
X-Trace: palladium.transmeta.com 1004552502 13847 127.0.0.1 (31 Oct 2001 18:21:42 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 31 Oct 2001 18:21:42 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20011031.094112.125896630.davem@redhat.com>,
David S. Miller <davem@redhat.com> wrote:
>   From: Jeff Garzik <jgarzik@mandrakesoft.com>
>   Date: Wed, 31 Oct 2001 12:25:21 -0500
>
>   2.4.14-pre6 on UP alpha, newly reformatted and reinstalled :)
>   
>   Machine was nowhere near OOM, and no other adverse messages appeared in
>   dmesg.  An rpm build and an rpm install were running in parallel.
>   
>Hmmm... the oops suggests that truncate_complete_page() gets a page
>not in the page cache.  The page count should be at least 2 when
>it gets passed there.

Indeed.  Looks like somebody removed the page from the page cache
without removing it from the inode queue. 

Which sounds rather impossible, as the two are always done together.

Maybe it's just the page count that is buggered, and we free it too
early as a result.  Is this the same machine that had interesting
trouble before?

		Linus
