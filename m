Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130884AbRAWHY5>; Tue, 23 Jan 2001 02:24:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136254AbRAWHYr>; Tue, 23 Jan 2001 02:24:47 -0500
Received: from [203.36.158.121] ([203.36.158.121]:24193 "EHLO kabuki.eyep.net")
	by vger.kernel.org with ESMTP id <S130320AbRAWHYe>;
	Tue, 23 Jan 2001 02:24:34 -0500
Subject: Re: 2.4 and ipmasq modules
From: Daniel Stone <daniel@kabuki.eyep.net>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Rusty Russell <rusty@linuxcare.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <20010122180158.B24670@vitelus.com>
In-Reply-To: <20010120144616.A16843@vitelus.com> <E14KsZI-0006IU-00@halfway> 
	 <20010122180158.B24670@vitelus.com>
Content-Type: text/plain
X-Mailer: Evolution (0.8 - Preview Release)
Date: 23 Jan 2001 18:29:34 +1100
Mime-Version: 1.0
Message-Id: <E14Kxtc-0000KT-00@kabuki.eyep.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 22 Jan 2001 18:01:58 -0800, Aaron Lehmann wrote:
> On Tue, Jan 23, 2001 at 12:48:20PM +1100, Rusty Russell wrote:
> > Those who berated Aaron for not wanting to upgrade: he is the Debian
> > maintainer for crashme, gtk-theme-switch, koules, pngcrush, and
> > xdaliclock.  By wasting his time making him convert a perfectly
> > working system, you are taking away time from those projects.  I'd
> > rather see him spend time on Cool Stuff(TM) which benefits all of us.

I don't use any of that :P

> Thank you for your support, but it seems clear that they were right.
> I changed the kernel settings to have pure netfilter configuration,
> read the NAT-HOWTO, and followed its instructions. I reccomend that any
> others still trying to use the 2.[02].x style interfaces do the same.

Hallelujiah, brother!

> netfilter seems not only much cleaner than ipchains or ipfwadm, but also
> much more powerful. I read into the HOWTO a bit and was very impressed
> by the capabilities. In particular, it's nice to have port forwarding
> integrated with NAT rather than as a seperate chunk of kernel code using
> different userspace tools.

Among other things. It originally started out having NAT and filtering
controlled by two different userspace tools - iptables and ipnatctl, but
they were eventually merged. 

> I hope that netfilter will last longer than the last two packet
> filtering/mangling/masquerading mechanisms. :)


Looking at something ages ago that I now cannot find, Rusty apparently
realised that ipchains was wrong when he was writing it; no such
admission (at least, that I know about) yet.

> P.S.: The only thing I did not get working successfully was IRC DCC. I

> sent a bug report to the maintainer of the patch from the
> patch-o-matic, but did not recieve an immediate response, so I'll
> include it below in case anyone else has any ideas.
> _______________________________________________________________________________
> 
> >From aaronl@vitelus.com Sun Jan 21 00:44:17 2001
> Date: Sun, 21 Jan 2001 00:44:17 -0800
> From: Aaron Lehmann <aaronl@vitelus.com>
> To: laforge@gnumonks.org
> Subject: irc-conntrack-nat doesn't work for me
> 
> I applied irc-conntrack-nat from iptables-1.2's patch-o-matic onto a
> Linux 2.4.0 kernel with XFS support. I tried several different IRC
> clients on the sending end (which was of course behind this NAT box)
> and different IRC servers (all on port 6667). On the recieving end, I
> would always get:
> 
> -:- DCC GET request from aaronl_[aaronl@vitelus.com
>           [64.81.36.147:33989]] 150 bytes /* That's the NAT box's IP */
> -:- DCC Unable to create connection: Connection refused
> 
> Any idea what's wrong? I have irc-conntrack-nat compiled into the
> kernel.


Well, it's NAT'ing it OK. Are you sure you have a rule like the
following:
iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
?

d

PS: If you're trying to NAT a DCC RESUME, don't even bother.

-- 
Daniel Stone
Linux Kernel Developer
daniel@kabuki.eyep.net

-----BEGIN GEEK CODE BLOCK-----
Version: 3.1
G!>CS d s++:- a---- C++ ULS++++$>B P---- L+++>++++ E+(joe)>+++ W++ N->++ !o
K? w++(--) O---- M- V-- PS+++ PE- Y PGP>++ t--- 5-- X- R- tv-(!) b+++ DI+++ 
D+ G e->++ h!(+) r+(%) y? UF++
------END GEEK CODE BLOCK------



-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
