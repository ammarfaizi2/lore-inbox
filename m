Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286229AbRLJL1Z>; Mon, 10 Dec 2001 06:27:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286233AbRLJL1F>; Mon, 10 Dec 2001 06:27:05 -0500
Received: from bzq-165-60.dsl.bezeqint.net ([62.219.165.60]:22024 "EHLO
	the.linux-dude.net") by vger.kernel.org with ESMTP
	id <S286229AbRLJL05>; Mon, 10 Dec 2001 06:26:57 -0500
Date: Mon, 10 Dec 2001 13:26:42 +0200 (IST)
From: Ido Diamant <ido@the.linux-dude.net>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: ip_nat_irc bug?
In-Reply-To: <20011210.111434.41640378.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0112101326250.5108-100000@the.linux-dude.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks. I will check it now.


On Mon, 10 Dec 2001, David S. Miller wrote:

>    From: Ido Diamant <ido@the.linux-dude.net>
>    Date: Mon, 10 Dec 2001 12:52:11 +0200 (IST)
>
>     After compiling kernel 2.4.16, I'v seen that I can't dcc chat bots
>    running on my local computer. I tried to see why its happening, and
>    couldn't get into any reasonable idea.
>    Yesterday I remembered that I compiled the 2.4.16 with the ip_nat_irc
>    module, and loaded it by default with my firewall. I rmmod ip_nat_irc and
>    suddenly I could dcc chat my local bots.
>    Q. Why is it happening?
>    Q. Am I using this module correctly? as far as I know, I just need to load
>    the module, and thats it, am I wrong? should I create some kind of rule
>    for it?
>    Q. Is it bug?
>
> This patch fixes the bug:
>
> diff -u --recursive --new-file --exclude=CVS --exclude=.cvsignore ../vanilla/2.4/linux/net/ipv4/netfilter/ip_nat_irc.c linux/net/ipv4/netfilter/ip_nat_irc.c
> --- ../vanilla/2.4/linux/net/ipv4/netfilter/ip_nat_irc.c	Tue Oct 30 15:08:12 2001
> +++ linux/net/ipv4/netfilter/ip_nat_irc.c	Sat Dec  8 19:23:27 2001
> @@ -1,8 +1,8 @@
>  /* IRC extension for TCP NAT alteration.
> - * (C) 2000 by Harald Welte <laforge@gnumonks.org>
> + * (C) 2000-2001 by Harald Welte <laforge@gnumonks.org>
>   * based on a copy of RR's ip_nat_ftp.c
>   *
> - * ip_nat_irc.c,v 1.15 2001/10/22 10:43:53 laforge Exp
> + * ip_nat_irc.c,v 1.16 2001/12/06 07:42:10 laforge Exp
>   *
>   *      This program is free software; you can redistribute it and/or
>   *      modify it under the terms of the GNU General Public License
> @@ -81,7 +81,7 @@
>  	}
>
>  	newdstip = master->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip;
> -	newsrcip = master->tuplehash[IP_CT_DIR_ORIGINAL].tuple.dst.ip;
> +	newsrcip = ct->tuplehash[IP_CT_DIR_ORIGINAL].tuple.src.ip;
>  	DEBUGP("nat_expected: DCC cmd. %u.%u.%u.%u->%u.%u.%u.%u\n",
>  	       NIPQUAD(newsrcip), NIPQUAD(newdstip));
>
>

