Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265459AbRFVQ0M>; Fri, 22 Jun 2001 12:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265460AbRFVQ0D>; Fri, 22 Jun 2001 12:26:03 -0400
Received: from horsea.3ti.be ([212.204.244.41]:40207 "EHLO horsea.3ti.be")
	by vger.kernel.org with ESMTP id <S265459AbRFVQZu>;
	Fri, 22 Jun 2001 12:25:50 -0400
Date: Fri, 22 Jun 2001 18:25:41 +0200 (CEST)
From: Dag Wieers <dag@wieers.com>
X-X-Sender: <dag@horsea.3ti.be>
To: Chris Wedgwood <cw@f00f.org>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Should __FD_SETSIZE still be set to 1024 ?
In-Reply-To: <20010623034849.A3728@metastasis.f00f.org>
Message-ID: <Pine.LNX.4.33.0106221811020.27761-100000@horsea.3ti.be>
User-Agent: Mutt/1.2.5i
X-Mailer: Evolution 0.10 (Tasmanian Devil)
Organization: IBM Belgium
X-Extra: If you can read this and Linux is your thing. Work for IBM Belgium/Linux !
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 23 Jun 2001, Chris Wedgwood wrote:

> On Fri, Jun 22, 2001 at 04:59:36PM +0200, Dag Wieers wrote:
>
>     Is there a reason for __FD_SETSIZE to be 1024 in
>     linux/posix_types.h and gnu/types.h ?
>     Why can't we increase this number by default ?
>
> It might break stuff, like things that link with code that assumes it
> is only 1024.

So if someone wants to increase it for an application he needs to be sure
that everything that it is linked with is compiled with a similar
__FD_SETSIZE ?

Why can you safely increase the value in Squid then ?


>     Shouldn't it be set to the real limit of the kernel ?
>
> Nah... the kernel limit is 1024^2 --- you don't want to use select
> anywhere near that.

Yes, but still, why 1024 ?


>     (And let applications define their own limit if there is a need
>     for one ?)
>
> Well, squid and friends do this anyhow.

No, squid takes the lowest of both (FD_SETSIZE and SQUID_MAXFD) in main.c.
And the Squid configure gets the FD_SETSIZE value from linux/posix_types.h
;(


> Not only that, using a greatly increased value should be a run-time
> decision, lest you want your code to break on early 2.2.x kernels and
> before.

I'm still not convinced that something might break, since everybody
advices to increase __FD_SETSIZE before compiling Squid.

And if linux/posix_types.h defines the limit of open file descriptors of
the system, 1024 is (IMO) a wrong number. But then again, nobody bothered
to change it...

Thanks for your respons.

--   dag wieers,  dag@wieers.com,  http://dag.wieers.com/   --
«Onder voorbehoud van hetgeen niet uitdrukkelijk wordt erkend»

