Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287234AbSAHLtX>; Tue, 8 Jan 2002 06:49:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287407AbSAHLtN>; Tue, 8 Jan 2002 06:49:13 -0500
Received: from weta.f00f.org ([203.167.249.89]:62149 "EHLO weta.f00f.org")
	by vger.kernel.org with ESMTP id <S287234AbSAHLtI>;
	Tue, 8 Jan 2002 06:49:08 -0500
Date: Wed, 9 Jan 2002 00:52:11 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Martin Rode <Martin.Rode@programmfabrik.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Question about bi-directional pipes.
Message-ID: <20020108115211.GC29782@weta.f00f.org>
In-Reply-To: <3C3AB20A.8B16C23A@programmfabrik.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C3AB20A.8B16C23A@programmfabrik.de>
User-Agent: Mutt/1.3.25i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 08, 2002 at 09:47:06AM +0100, Martin Rode wrote:

    I was just wondering if it is possible under Linux to use popen in
    a bi-directional way?

using pipe(2) --- no

    I want to use popen under php and must write _and_ read from and
    to the pipe. Some guy at the php mailing list stated that this is
    possible to do with BSD, he wasn't sure about linux.

Some (all) of the *BSD's implement pipe(2) using UNIX domain sockets
under the hood and were thus able to do this, however, I don't believe
any other OS ever did this and I certainly wouldn't assume it will
work for compatibility reasons.

    If this is a kernel issue and not a glibc one, is there a way to
    get popen work bi-directionally under linux? Say I want a

    pipe = popen ('somefile', 'w+');

Don't use glibc for this, it can't do what you want.  I have a small
library I wrote that does a popen type thing and gives separate access
to stdin, stdout and stderr of the process --- if that is of use you
are welcome to it (it's C, not php, I have no idea about how to import
C functions into php).

With a (small) amount of effort, I can even make a version that nukes
stderr and wraps the stdin/stdout functions with a a UNIX domain socket
which will do pretty much exactly what you want[1].


  --cw

[1] Oh, it doesn't do command-line parsing as I explicitly didn't want
    this when I wrote it.
