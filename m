Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288051AbSA3CRz>; Tue, 29 Jan 2002 21:17:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288040AbSA3CRq>; Tue, 29 Jan 2002 21:17:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:38668 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288051AbSA3CRg>; Tue, 29 Jan 2002 21:17:36 -0500
Date: Tue, 29 Jan 2002 18:16:37 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Robert Love <rml@tech9.net>, <viro@math.psu.edu>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5: push BKL out of llseek
In-Reply-To: <3C574BD1.E5343312@zip.com.au>
Message-ID: <Pine.LNX.4.33.0201291813420.1996-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jan 2002, Andrew Morton wrote:
>
> And llseek is *fast*.  If we're seeing significant
> lock contention in there then adding a schedule() is
> likely to turn Anton into one unhappy dbencher.

I'd agree, except I doubt there is every much contention on the _same_
file.

The reason llseek() ends up being so clear on the profiles is that it's a
very common system call under certain loads _and_ it uses a shared lock
for everything.

Also note the correctness issue (ie serialization on i_size), although
that is only an issue for SEEK_END (and maybe the lock should only be
gotten for that case. I'd love to hear what Al thinks..

		Linus

