Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315599AbSGNDUP>; Sat, 13 Jul 2002 23:20:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315607AbSGNDUO>; Sat, 13 Jul 2002 23:20:14 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:22278 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S315599AbSGNDUO>; Sat, 13 Jul 2002 23:20:14 -0400
Date: Sat, 13 Jul 2002 23:17:09 -0400 (EDT)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
In-Reply-To: <1026584920.13885.29.camel@irongate.swansea.linux.org.uk>
Message-ID: <Pine.LNX.3.96.1020713230703.16934B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Jul 2002, Alan Cox wrote:

> On Sat, 2002-07-13 at 17:21, Bill Davidsen wrote:
> > In the absense of the proxy_arp flag, I would not expect that reply,
> > the IP is not on that NIC. Before I "fix" that, is this intended
> > behaviour for some reason? Will I break something if I add check logic?
> > Is there something in /proc/sys/net/ipv4 I missed which will avoid this
> > response?
> 
> Your suspicion and the reality don't match. The RFC's leave the
> situation unclear and some OS's do either. Newer 2.4 has arpfilter which
> can be used to control what actually occurs

I tried setting conf/arp_filter, proxy_arp, and looked at rp_filter but
didn't try anything with it. I'm using tcpdump on the machine sending
who-has and getting two packets back. I tried the obvious setting eth0 and
1, setting default, and setting 'all." The current settings, just the NICs
in question, are producing two arp-replies with settings:

newsmst01:conf# for n in */arp_filter;do echo $n; cat $n; done
all/arp_filter
0
default/arp_filter
0
eth0/arp_filter
1
eth1/arp_filter
1
lo/arp_filter
0
newsmst01:conf# 

This was with 2.4.19-pre10ac2+one smp locking patch.

Oh well, thanks anyway, if it's intended to work that way I'll look at
making it so.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

