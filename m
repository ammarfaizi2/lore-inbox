Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281020AbRKLVxD>; Mon, 12 Nov 2001 16:53:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281023AbRKLVwx>; Mon, 12 Nov 2001 16:52:53 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:49679 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S281020AbRKLVwn>; Mon, 12 Nov 2001 16:52:43 -0500
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: File System Performance
Date: Mon, 12 Nov 2001 21:48:28 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <9spg3c$7bb$1@penguin.transmeta.com>
In-Reply-To: <3BF03402.87D44589@zip.com.au> <3BF03402.87D44589@zip.com.au> <1005600431.13303.10.camel@jen.americas.sgi.com> <3BF04289.8FC8B7B7@zip.com.au>
X-Trace: palladium.transmeta.com 1005601937 30730 127.0.0.1 (12 Nov 2001 21:52:17 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 12 Nov 2001 21:52:17 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <3BF04289.8FC8B7B7@zip.com.au>,
Andrew Morton  <akpm@zip.com.au> wrote:
>
>It's tar.  It cheats.  It somehow detects that the
>output is /dev/null, and so it doesn't read the input files.

Probably the kernel.

If you do a mmap()+write(), the write() to /dev/null won't even read the
mmap contents, which in turn will cause the pages to never be brought
in.

Anything which uses mmap+write will show this.

		Linus
