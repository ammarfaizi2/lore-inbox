Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278432AbRJMWvt>; Sat, 13 Oct 2001 18:51:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278435AbRJMWvj>; Sat, 13 Oct 2001 18:51:39 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22288 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S278432AbRJMWvb>; Sat, 13 Oct 2001 18:51:31 -0400
Date: Sat, 13 Oct 2001 15:19:16 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "Eric W. Biederman" <ebiederm@xmission.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Security question: "Text file busy" overwriting executables but
 not shared libraries?
In-Reply-To: <20011013214603.A1144@kushida.jlokier.co.uk>
Message-ID: <Pine.LNX.4.33.0110131516350.8983-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 13 Oct 2001, Jamie Lokier wrote:
>
> There are applications (GCC comes to mind) which are using mmap() to
> read files now because it is measurably faster than read(), for
> sufficiently large source files.
>
> I don't know where the optimal costs lie.

The gcc people tested it, and their cut-off point is at 30kB or so.
Anything smaller than that is faster to just "read()".

Now, that's a traditional mmap(), though, which has more overhead than a
"read-with-PAGE_COPY" would have. The pure mmap() approach has the actual
page fault overhead too, along with having to do "fstat()" and "munmap()".

		Linus

