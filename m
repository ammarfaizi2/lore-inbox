Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318300AbSHEFk7>; Mon, 5 Aug 2002 01:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSHEFk7>; Mon, 5 Aug 2002 01:40:59 -0400
Received: from angband.namesys.com ([212.16.7.85]:46281 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S318300AbSHEFk6>; Mon, 5 Aug 2002 01:40:58 -0400
Date: Mon, 5 Aug 2002 09:44:29 +0400
From: Oleg Drokin <green@namesys.com>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: reiserfs blocks long on getdents64() during concurrent write
Message-ID: <20020805094429.A5897@namesys.com>
References: <Pine.LNX.4.44.0208041506480.31879-100000@pc40.e18.physik.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0208041506480.31879-100000@pc40.e18.physik.tu-muenchen.de>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Aug 04, 2002 at 06:09:34PM +0200, Roland Kuhn wrote:

> The first call to getdents64 takes 4.7s! I captured the task status and 
> got this:

[call traces skipped]

> writer is a shell script calling dd with a blocksize of 1M. The problem of 
> course vanishes when using noatime, but it still makes me wonder why a 
> single write request is delayed so long. The other possibility to avoid 

It seems that your kernel performs writes slowly.

> this is to use a sync mount, and there I discovered something really 
> strange: 2.4.19 gives me about 17MB/s while 2.4.18-3 (RedHat) was creeping 
> slow with 10kB/s!

2.4.18-3 is particularly bad know for this exact problem (slow write speed),
you should consider upgrading to at least 2.4.18-5 kernel from redhat updates.

For me on plain 2.4.18 the problem is not visible that bad as for you.
I.e. ls on a directory where I write this big file finishes in under
half a second.

> If you have any thoughts on the cause of this behaviour and/or on how to 
> fix it, I would be glad to hear them. If it's not too complicated I could 
> even code something up myself, and I for sure can do any testing needed.

You said 2.4.19 writes stuff faster for you, how about testing ls on that
kernel?

Bye,
    Oleg
