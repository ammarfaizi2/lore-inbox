Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132139AbRCVSYh>; Thu, 22 Mar 2001 13:24:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132140AbRCVSY2>; Thu, 22 Mar 2001 13:24:28 -0500
Received: from mozart.stat.wisc.edu ([128.105.5.24]:27398 "EHLO
	mozart.stat.wisc.edu") by vger.kernel.org with ESMTP
	id <S132121AbRCVSYS>; Thu, 22 Mar 2001 13:24:18 -0500
To: "David S. Miller" <davem@redhat.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, Serge Orlov <sorlov@con.mcst.ru>,
        <linux-kernel@vger.kernel.org>,
        Jakob Østergaard <jakob@unthought.net>
Subject: Re: Linux 2.4.2 fails to merge mmap areas, 700% slowdown.
In-Reply-To: <Pine.LNX.4.31.0103201042360.1990-100000@penguin.transmeta.com>
	<vba1yrr7w9v.fsf@mozart.stat.wisc.edu>
	<15032.1585.623431.370770@pizda.ninka.net>
	<vbay9ty50zi.fsf@mozart.stat.wisc.edu>
From: buhr@stat.wisc.edu (Kevin Buhr)
In-Reply-To: buhr@cs.wisc.edu's message of "21 Mar 2001 14:19:13 -0600"
Date: 22 Mar 2001 12:23:15 -0600
Message-ID: <vbaelvp3bos.fsf@mozart.stat.wisc.edu>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

buhr@cs.wisc.edu (Kevin Buhr) writes:
> 
> "David S. Miller" <davem@redhat.com> writes:
> > 
> > It is the garbage collector scheme used for memory allocation in gcc
> > >=2.96 that triggers the bad cases seen by Serge.
> 
> Ahhh!  Thanks for the info.
> 
> I'm still happy to help test out the patch, but I guess it's not
> likely to affect my 2.95.2 numbers much at all.  Maybe I can get a
> snapshot of GCC 3.0 up and running, though, and test that out.

I pulled the "gcc-3_0-branch" of GCC from CVS and compiled Mozilla
under a 2.4.2 kernel.  The numbers I saw were:

    real    57m26.850s
    user    96m57.490s
    sys     3m16.780s

which are almost exactly the same as my GCC 2.95.2 numbers.  When I
peeked at "/proc/<cc1plus>/maps" a few times, I counted ~150 lines,
not ~2000.  On another, much smaller block of C++ code, I get similar
results: no dramatic change in kernel time.

Either the Mozilla codebase and my other test case don't tickle the
problem, or something has changed in 3.0's allocation scheme since
RedHat 2.96 was built.

Kevin <buhr@stat.wisc.edu>
