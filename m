Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129766AbRBSBnq>; Sun, 18 Feb 2001 20:43:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130073AbRBSBng>; Sun, 18 Feb 2001 20:43:36 -0500
Received: from ferret.lmh.ox.ac.uk ([163.1.18.131]:58888 "HELO
	ferret.lmh.ox.ac.uk") by vger.kernel.org with SMTP
	id <S129766AbRBSBnQ>; Sun, 18 Feb 2001 20:43:16 -0500
Date: Mon, 19 Feb 2001 01:43:14 +0000 (GMT)
From: Chris Evans <chris@scary.beasts.org>
To: <linux-kernel@vger.kernel.org>
Subject: sendfile() breakage was Re: SO_SNDTIMEO: 2.4 kernel bugs
In-Reply-To: <Pine.LNX.4.30.0102190025270.19003-100000@ferret.lmh.ox.ac.uk>
Message-ID: <Pine.LNX.4.30.0102190138240.19003-100000@ferret.lmh.ox.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 19 Feb 2001, Chris Evans wrote:

> > BTW, if you have enough fast network, you probably can observe
> > that sendfile() is even not interrupted by signals. 8) But this
> > is possible to fix at least. BTW the same fix will repair SO_*TIMEO
> > partially, i.e. it will timeout after n*timeo, where n is an arbitrary
> > number not exceeding size/sndbuf.
>
> Hi Alexey,
>
> You are right - our sendfile() implementation is broken. I have fixed it
> (patch at end of mail).

Actually the whole mess stems from our broken internal ->write() and
->read() APIs.

The _single_ return value is trying to convery _two_ pieces of information
- always a bad move. They are:
1) Success/failure (and error code if it's a failure)
2) Amount of bytes read or written

This bogon does not allow for the following information to be returned
(assume I asked for 8192 bytes to be written):
"4096 bytes were written, and the operation was aborted due to EINTR"

Cheers
Chris

