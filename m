Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261814AbTDBUUZ>; Wed, 2 Apr 2003 15:20:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261822AbTDBUUZ>; Wed, 2 Apr 2003 15:20:25 -0500
Received: from main.gmane.org ([80.91.224.249]:40685 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261814AbTDBUUX>;
	Wed, 2 Apr 2003 15:20:23 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Dennis Cook" <cook@sandgate.com>
Subject: Re: Deactivating TCP checksumming
Date: Wed, 2 Apr 2003 14:22:59 -0500
Organization: Sandgate Technologies
Message-ID: <b6fda2$oec$1@main.gmane.org>
References: <F91mkXMUIhAumscmKC00000f517@hotmail.com> <20030401122824.GY29167@mea-ext.zmailer.org>
X-Complaints-To: usenet@main.gmane.org
X-MSMail-Priority: Normal
X-Newsreader: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Cc: kernelnewbies@nl.linux.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using RH Linux kernel 2.4.18, setting "features" bit NETIF_F_IP_CSUM does
not appear
to keep a valid IP checksum from being computed in packets presented to my
driver
for transmission. So having HW compute outgoing checksum buys nothing.
Checked this
by suppressing HW checksum computation. Packets are still accepted by peer.

Dennis Cook
Sandgate Technologies

"Matti Aarnio" <matti.aarnio@zmailer.org> wrote in message
news:20030401122824.GY29167@mea-ext.zmailer.org...
> On Tue, Apr 01, 2003 at 12:12:04PM +0000, shesha bhushan wrote:
> > I get that. I can talk with the driver vendor. But to gain the
usefulness
> > of caculation of CSUM in HW we need to disable the software CSUM
> > calculation in TCP layer in the kernel. Am I correct? I am trying to
find
> > that and I ma stuck there. How to disble the software TCP CSUM
calculation?
> > and later I can talk with driver vendor to enable it in hardware. I
wanted
> > help from linux gurus in disabling TCP csum calculation in the kernel.
>
> The kernel code is already smart enough of detect that the outbound
> device will handle the checksum calculations all by itself, and not
> do it in that case.
>
> Testing of  dev->features   is done in files:
>    net/core/dev.c
>    net/ipv4/tcp.c
> (depending what protocol is in question.)
> in the latter case, actually in common tcp path with route-cached
> route_caps flags.
>
> I did
>    egrep 'NETIF_F_.._CSUM' net/*/*.c
> to find those.
> (and a number of other subset searches finding nothing)
>
> Grep is your friend.
>
> This whole "zero-copy" infastructure was implemented during
> development in 2.3 series.
>
> > Thanking You
> > Shesha
>
> /Matti Aarnio



