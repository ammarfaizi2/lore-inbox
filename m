Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317681AbSGRJo1>; Thu, 18 Jul 2002 05:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317685AbSGRJo0>; Thu, 18 Jul 2002 05:44:26 -0400
Received: from [213.225.90.118] ([213.225.90.118]:28174 "HELO
	lexx.infeline.org") by vger.kernel.org with SMTP id <S317681AbSGRJoZ>;
	Thu, 18 Jul 2002 05:44:25 -0400
Date: Thu, 18 Jul 2002 11:48:27 +0200 (CEST)
From: Ketil Froyn <ketil-kernel@froyn.net>
X-X-Sender: ketil@ketil.np
To: Linus Torvalds <torvalds@transmeta.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: close return value (was Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks)
In-Reply-To: <ah4act$1n5$1@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.40L0.0207181137190.10269-100000@ketil.np>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Jul 2002, Linus Torvalds wrote:

> >int ret;
> >do {
> >	ret = close(fd);
> >} while(ret == -1 && errno != EBADF);
>
> NO.
>
> The above is
>  (a) not portable
>  (b) not current practice
>
> The "not portable" part comes from the fact that (as somebody pointed
> out), a threaded environment in which the kernel _does_ close the FD on
> errors, the FD may have been validly re-used (by the kernel) for some
> other thread, and closing the FD a second time is a BUG.
>
> The "not practice" comes from the fact that applications do not do what
> you suggest.
>
> The fact is, what Linux does and has always done is the only reasonable
> thing to do: the close _will_ tear down the FD, and the error value is
> nothing but a warning to the application that there may still be IO
> pending (or there may have been failed IO) on the file that the (now
> closed) descriptor pointed to.

Is this what happens when EINTR is received as well? If so, is there any
point to EINTR? Ie. close() was interrupted, but finished anyway. Would
any application care?

If there is any pending IO when this happens, is it possible to find out
when this is finished? If not, an MTA getting this would have to
temporarily defer the mail it received and hope it doesn't get an EINTR on
close() next time, I guess.

Ketil


