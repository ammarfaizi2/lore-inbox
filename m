Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266827AbRHSToi>; Sun, 19 Aug 2001 15:44:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270011AbRHSTo2>; Sun, 19 Aug 2001 15:44:28 -0400
Received: from fep01-0.kolumbus.fi ([193.229.0.41]:11695 "EHLO
	fep01-app.kolumbus.fi") by vger.kernel.org with ESMTP
	id <S266827AbRHSToK>; Sun, 19 Aug 2001 15:44:10 -0400
Date: Sun, 19 Aug 2001 22:44:20 +0300 (EEST)
From: Kai Makisara <Kai.Makisara@kolumbus.fi>
X-X-Sender: <makisara@kai.makisara.local>
To: Albrecht Jacobs <Albrecht.Jacobs@janglednerves.com>
cc: "(Martin Jacobs)" <100.179370@germanynet.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Q: 2.4.[37]-XFS: /dev/nst0m: cannot allocate memory
In-Reply-To: <3B800CA3.AF9E321F@janglednerves.com>
Message-ID: <Pine.LNX.4.33.0108192234500.19318-100000@kai.makisara.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Aug 2001, Albrecht Jacobs wrote:

> Kai Makisara wrote:
> >
...
> > In variable block mode in 2.4, you get ENOMEM if the block on the tape is
> > larger than the byte count in the read(). 2.2 just returned what you asked
> > for and silentlry threw away the rest of the block. If the byte count is
> > larger than the block size, then the block is returned.
> >
> > I.e., the first block on your tape is larger than 32 kB.
> >
> >         Kai
>
> If I understand you right this is a FEATURE, not a bug! I find it quite
> irritating when using a tape device. Shouldn't I get some error message
> about wrong block size?

Yes, it is a feature. The behaviour of the Linux driver was changed in
2.4 to match the behaviour of other Unix tape drivers in this case.

It is legal to read blocks that are smaller than the byte count and so
the non-matching block size is not an error as such. It is an error only if
the block is larger than the requested size and this error is returned to
the user. I admit that the code ENOMEM is not too informative but there is
not an error code for too big block size.

> 	Forgive me but I am some sort of end user (admin) and not a kernel
> hacker.
> BTW, where can I get documentation about this 'feature'?
>
It seems that the st man page only documents the 2.2 behaviour (my fault).

I have not seen a good tutorial for tape operations in Unix. The man pages
document some things. The basic rule is that you must know the block
size(s) on the tape and set the parameters accordingly.

	Kai


