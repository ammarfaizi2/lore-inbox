Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289055AbSBSATf>; Mon, 18 Feb 2002 19:19:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289056AbSBSATQ>; Mon, 18 Feb 2002 19:19:16 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:65291 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S289055AbSBSATL>; Mon, 18 Feb 2002 19:19:11 -0500
Date: Mon, 18 Feb 2002 19:17:33 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Ben Greear <greearb@candelatech.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: jiffies rollover, uptime etc.
In-Reply-To: <3C717DEA.7090309@candelatech.com>
Message-ID: <Pine.LNX.3.96.1020218191149.14047A-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Feb 2002, Ben Greear wrote:

> I wonder, is it more expensive to write all drivers to handle the
> wraps than to take the long long increment hit?  The increment is
> once every 10 miliseconds, right?  That is not too often, all things
> considered...

  If you are willing to code in assembler instead of C you can do better,
at least on x86. You just need to do a 32 bit increment on the LS word,
and if you get a carry you can incr the MS word.
 
> Maybe the non-atomicity of the long long increment is the problem?

  I doubt it, the problem is that the software which expects jiffies is
not all going to work well 64 bit. I think that's more the issue, and why
Alan et al are fixing it piecemeal, I don't think there's some magic fix
they're missing.
 
> Does this problem still exist on 64-bit machines?

Absolutely. But not as often ;-)

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

