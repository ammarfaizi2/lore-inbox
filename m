Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132606AbRDXAVZ>; Mon, 23 Apr 2001 20:21:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132607AbRDXAVP>; Mon, 23 Apr 2001 20:21:15 -0400
Received: from abraham.CS.Berkeley.EDU ([128.32.37.121]:52752 "EHLO paip.net")
	by vger.kernel.org with ESMTP id <S132606AbRDXAU5>;
	Mon, 23 Apr 2001 20:20:57 -0400
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: daw@mozart.cs.berkeley.edu (David Wagner)
Newsgroups: isaac.lists.linux-kernel
Subject: Re: light weight user level semaphores
Date: 24 Apr 2001 00:19:46 GMT
Organization: University of California, Berkeley
Distribution: isaac
Message-ID: <9c2gr2$u7s$1@abraham.cs.berkeley.edu>
In-Reply-To: <E14qHRp-0007Yc-00@the-village.bc.nu> <Pine.LNX.4.31.0104190944090.4074-100000@penguin.transmeta.com>
NNTP-Posting-Host: mozart.cs.berkeley.edu
X-Trace: abraham.cs.berkeley.edu 988071586 30972 128.32.45.153 (24 Apr 2001 00:19:46 GMT)
X-Complaints-To: news@abraham.cs.berkeley.edu
NNTP-Posting-Date: 24 Apr 2001 00:19:46 GMT
X-Newsreader: trn 4.0-test74 (May 26, 2000)
Originator: daw@mozart.cs.berkeley.edu (David Wagner)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds  wrote:
>Ehh.. I will bet you $10 USD that if libc allocates the next file
>descriptor on the first "malloc()" in user space (in order to use the
>semaphores for mm protection), programs _will_ break.
>
>You want to take the bet?

Good point.  Speaking of which:
  ioctl(fd, UIOCATTACHSEMA, ...);
seems to act like dup(fd) if fd was opened on "/dev/usemaclone"
(see drivers/sgi/char/usema.c).  According to usema(7), this is
intended to help libraries implement semaphores.

Is this a bad coding?  Should the kernel really support an ioctl()
that can silently allocate the next file descriptor?  This seems
like asking for trouble.  Or, maybe I just misunderstood something.
