Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265508AbTBFGeW>; Thu, 6 Feb 2003 01:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265517AbTBFGeV>; Thu, 6 Feb 2003 01:34:21 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:3347 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S265508AbTBFGeV>; Thu, 6 Feb 2003 01:34:21 -0500
Message-Id: <200302060637.h166bEs22224@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Mika Liljeberg <mika.liljeberg@welho.com>
Subject: Re: disabling nagle
Date: Thu, 6 Feb 2003 08:35:29 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Dave Slicer <slice1900@hotmail.com>, linux-kernel@vger.kernel.org
References: <F137jnt61tqeaVRMPjc00012673@hotmail.com> <200302050648.h156mxs16371@Port.imtp.ilyichevsk.odessa.ua> <1044465519.1516.23.camel@devil>
In-Reply-To: <1044465519.1516.23.camel@devil>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > loss it is essentially unusable.  I know the real answer is using
> > > something other than TCP as the transport layer for the tunnel
> > > (IPSEC, IP over IP, UDP, etc.) but that isn't always possible. 
> > > So I'd like a way to treat the ppp interface the VPN tunnel
> > > creates as a completely reliable transport for which normal
> > > TCP/IP retransmits and timeouts don't apply. It'd just
> > > bullheadedly go along transmitting data and assuming it was
> > > received -- the underlying TCP transport can take care of making
> > > the link reliable.
> >
> > I want this too ;) For one, it would be a perfect example of using
> > good existing tools to achieve the goal instead of inventing
> > something big and new. Also it does not reduce MTU unlike
> > packet-encapsulation tunnels.
> >
> > Now it's an imperfect example due to noted TCP over TCP performance
> > problem ('internal meltdown').
>
> I doubt a hack like disabling RTO would make it into the kernel.
> However, try enabling F-RTO at both ends (echo 1 >
> /proc/sys/net/ipv4/tcp_frto). This should improve things quite a bit.
>
> You need at least linux 2.4.21-pre3, or linux 2.5.x.

Wow, thanks! I'll look into it! (Found the draft. Google is cool ;)

What is really needed is raising RTO to large fixed value so that TCP
connection times out before RTs are triggered. And it have to be done only
on pppd-over-ssh iface. Am I right that currently kernel TCP options
are global, not per-if?
--
vda
