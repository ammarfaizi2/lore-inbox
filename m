Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290437AbSAQUWs>; Thu, 17 Jan 2002 15:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290440AbSAQUWj>; Thu, 17 Jan 2002 15:22:39 -0500
Received: from alcove.wittsend.com ([130.205.0.10]:749 "EHLO
	alcove.wittsend.com") by vger.kernel.org with ESMTP
	id <S290437AbSAQUW3>; Thu, 17 Jan 2002 15:22:29 -0500
Date: Thu, 17 Jan 2002 15:22:26 -0500
From: "Michael H. Warfield" <mhw@wittsend.com>
To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>
Cc: lkml <linux-kernel@vger.kernel.org>, Tomasz Torcz <zdzichu@irc.pl>,
        "Michael H. Warfield" <mhw@wittsend.com>,
        Hans-Christian Armingeon <linux.johnny@gmx.net>
Subject: Re: swapper [was OOPS on 2.4.17 ...]
Message-ID: <20020117152226.A26267@alcove.wittsend.com>
Mail-Followup-To: Pierre Rousselet <pierre.rousselet@wanadoo.fr>,
	lkml <linux-kernel@vger.kernel.org>, Tomasz Torcz <zdzichu@irc.pl>,
	Hans-Christian Armingeon <linux.johnny@gmx.net>
In-Reply-To: <20020117182758.GA736@irc.pl> <3C472B64.6000206@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C472B64.6000206@wanadoo.fr>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 08:52:04PM +0100, Pierre Rousselet wrote:
> Tomasz Torcz wrote:
> > Process swapper (pid: 1, stackpage=c1199000)

> Michael H. Warfield wrote:
> > Process swapper (pid: 0,stackpage=c022f000)

> Hans-Christian Armingeon wrote:
> > Process swapper (pid: 1, stackpage=cfe8d00)

> what is this swapper process involved in 2.4.17 oops ? could it be 
> spawned when devfs thinks there is already a root fs mounted at boot 
> time before mounting the root fs given to the boot loader ?

	It's blowing chunks even without devfs.

	But you've pointed out something important.  This is a heavily
upgraded RedHat 6.0 system and maybe there are some things which it
is doing which is inappropriate for the 2.4 kernels.  I vaguely remember
a problem a while back with swapping and the swapper daemon and some
systems blowing chunks.  All my various RedHat systems (6.0, 6.1, 6.2,
and 7.2) are all running kswapd.  No "swapper" process, per se.  And
init always has "1".

	But even if some old application is doing something ill behaved,
that's still a problem since applications should not be capable of causing
such an oops.  So that makes two problems, one in user space and one in
kernel space.

	But...  I've disabled swap on the afflicted system (it's got
enough memory that it damn well should have never swapped anyways).  We
shall see what we shall see over the next couple of days.

	Good point though...

> Pierre
> -- 
> ------------------------------------------------
>  Pierre Rousselet <pierre.rousselet@wanadoo.fr>
> ------------------------------------------------

	Mike
-- 
 Michael H. Warfield    |  (770) 985-6132   |  mhw@WittsEnd.com
  /\/\|=mhw=|\/\/       |  (678) 463-0932   |  http://www.wittsend.com/mhw/
  NIC whois:  MHW9      |  An optimist believes we live in the best of all
 PGP Key: 0xDF1DD471    |  possible worlds.  A pessimist is sure of it!
