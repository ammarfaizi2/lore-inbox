Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267829AbTBEGrX>; Wed, 5 Feb 2003 01:47:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267831AbTBEGrX>; Wed, 5 Feb 2003 01:47:23 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:52746 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S267829AbTBEGrV>; Wed, 5 Feb 2003 01:47:21 -0500
Message-Id: <200302050648.h156mxs16371@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Dave Slicer" <slice1900@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: disabling nagle
Date: Wed, 5 Feb 2003 08:47:18 +0200
X-Mailer: KMail [version 1.3.2]
References: <F137jnt61tqeaVRMPjc00012673@hotmail.com>
In-Reply-To: <F137jnt61tqeaVRMPjc00012673@hotmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 February 2003 02:01, Dave Slicer wrote:
> On Tue, Feb 04, 2003 at 11:39:16AM -0800, Fiona Sou-Yee Wong wrote:
> >I have kernel version 2.4.18 and I was looking for a patch to have
> > the option to disable NAGLE's algorithm.
> >Is there a patch available for kernels 2.4 and greater and if not,
> > what other options do I have?
>
> Others already answered this specific question, but I wonder how hard
> it would be to create a patch to disable TCP's timeout and retransmit
> mechanisms on a given interface?  This would allow those of us who
> have no alternative other than PPP over ssh for VPN to greatly
> improve performance. Over a well behaved connection this works
> acceptably, but given any delays or packet loss it is essentially
> unusable.  I know the real answer is using something other than TCP
> as the transport layer for the tunnel (IPSEC, IP over IP, UDP, etc.)
> but that isn't always possible.  So I'd like a way to treat the ppp
> interface the VPN tunnel creates as a completely reliable transport
> for which normal TCP/IP retransmits and timeouts don't apply. It'd
> just bullheadedly go along transmitting data and assuming it was
> received -- the underlying TCP transport can take care of making the
> link reliable.

I want this too ;) For one, it would be a perfect example of using
good existing tools to achieve the goal instead of inventing
something big and new. Also it does not reduce MTU unlike
packet-encapsulation tunnels.

Now it's an imperfect example due to noted TCP over TCP performance
problem ('internal meltdown').

> Is this even remotely reasonable?  If it would cause performance
> degradation it'd have to be a config option or never make the kernel
> at all (Linus may never accept it regardless I suppose)  But ignoring
> that for a moment, is it just too hairy to contemplate?  I've done a
> few patches here and there for Linux in the past, but nothing like
> this (and nothing involving networking) so it is far beyond my
> capability.  But if something was cooked up that works well enough
> I'd be willing to try polishing it and porting between kernel
> versions where necessary.
>
> But I'd take any suggestions for alterations in /proc/sys/net/ipv4/*
> that might help the current state of things.

I'm looking there for the first time ever, but it seems you
can twiddle TCP parameters in /proc/sys/net/ipv4/tcp_*
(OTOH I don't see retransmit timeout controls there...
maybe they have another name?)

In order to make them per-iface one needs to have an ability to
override them in /proc/sys/net/ipv4/conf/ethX.
Seems like this is not implemented.
--
vda
