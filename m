Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTKPIqh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Nov 2003 03:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262575AbTKPIqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Nov 2003 03:46:37 -0500
Received: from coffee.creativecontingencies.com ([210.8.121.66]:20973 "EHLO
	coffee.cc.com.au") by vger.kernel.org with ESMTP id S262491AbTKPIqe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Nov 2003 03:46:34 -0500
Message-Id: <6.0.0.22.2.20031116184701.01b54ae0@caffeine.cc.com.au>
X-Mailer: QUALCOMM Windows Eudora Version 6.0.0.22
Date: Sun, 16 Nov 2003 19:46:08 +1100
To: Linus Torvalds <torvalds@osdl.org>
From: Peter Lieverdink <cafuego@cafuego.net>
Subject: Re: loopback device + crypto = crash on 2.6.0-test7 ? 
Cc: Valdis.Kletnieks@vt.edu,
       Jindrich Makovicka <makovick@kmlinux.fjfi.cvut.cz>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0311110847120.30657-100000@home.osdl.org>
References: <6.0.0.22.2.20031111202757.01af5f50@caffeine.cc.com.au>
 <Pine.LNX.4.44.0311110847120.30657-100000@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 03:49 12/11/2003, you wrote:

>On Tue, 11 Nov 2003, Peter Lieverdink wrote:
> > >At 13:50 11/11/2003, you wrote:
> > >Could we see a 'gcc -V' from *both* machines, please? (and an 'as -v'
> > >and 'ld -v' as well, just to be thorough?)
> >
> > They're the same. Both boxes use Debian Sid with gcc-3.3.2.
>
>[ Taa-daa-taa-daa.. Theme from "The Twilight Zone" ]
>
>And yet the kenrel works when built on one machine?
>
>I'd love to see what the differences are. If the .config etc are all 100%
>the same, I'd like to see what "diff" reports on the generated vmlinux
>files (well, to be honest, I'd need either both files on some web-site, or
>you to actually run diff and find _where_ the differences are).
>
>                 Linus

Well, due to [insert long explanation] the -test8 kernel wasn't available. 
The "good" machine built a -test9, which crashed as well. *sigh* Mind you, 
there are differences between the kernel _it_ builds and the one built by 
the "bad" machine. I've uploaded a alien -t'd debian kernel packages to the 
fastest web space I have for you to have a peek, if you have some time. 
(what with lawsuits and whatnot ;-)

2.6.0-test9 built on the "good" box:
http://monolith.dnsalias.org/~cafuego/kernel-image-2.6.0-test9-kahlua.1.tgz

2.6.0-test9 built on the "bad" box:
http://monolith.dnsalias.org/~cafuego/kernel-image-2.6.0-test9-kahlua.2.tgz

More importantly though, the post from Jindrich:

At 00:13 16/11/2003, you wrote:
>I can confirm, having similar problem. I am using Debian Sid & 
>2.6.0-test9, with 4Gig highmem support (1.5G physical RAM). When reading 
>from cryptoloop (dd if=/dev/loop0 of=testoutput), it seems to produce only 
>noise. Each run of dd produces completely different heap of garbage. When 
>I disable highmem, getting rid of about 512 Megs, cryptoloop seems to work 
>as expected - I can do losetup & mke2fs & mount & read/write files & 
>unmount & losetup -d & again.. ad nauseam.
>
>Jindrich Makovicka

When I compiled on the "bad" machine with disabled HIGHMEM, the resultant 
kernel has NO problems with cryptoloop. I can make a cryptoloop fs, mount, 
copy, unmount, remount etc. That kernel is at:
http://monolith.dnsalias.org/~cafuego/kernel-image-2.6.0-test9-kahlua.3.tgz

So I guess HIGHMEM breaks cryptoloop somehow.

- Peter.




