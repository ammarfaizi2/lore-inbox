Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbTHTPlk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 11:41:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262023AbTHTPlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 11:41:40 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:40146 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S262013AbTHTPlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 11:41:35 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 20 Aug 2003 17:41:33 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@colin2.muc.de, dang@fprintf.net, ak@muc.de, lmb@suse.de,
       linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
Message-Id: <20030820174133.5e3f50e5.skraw@ithnet.com>
In-Reply-To: <20030819122847.2d7e2e31.davem@redhat.com>
References: <mdtk.Zy.1@gated-at.bofh.it>
	<mgUv.3Wb.39@gated-at.bofh.it>
	<mgUv.3Wb.37@gated-at.bofh.it>
	<miMw.5yo.31@gated-at.bofh.it>
	<m365ktxz3k.fsf@averell.firstfloor.org>
	<1061320620.3744.16.camel@athena.fprintf.net>
	<20030819192125.GD92576@colin2.muc.de>
	<1061321268.3744.20.camel@athena.fprintf.net>
	<20030819193235.GG92576@colin2.muc.de>
	<20030819122847.2d7e2e31.davem@redhat.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Aug 2003 12:28:47 -0700
"David S. Miller" <davem@redhat.com> wrote:

> On 19 Aug 2003 21:32:35 +0200
> Andi Kleen <ak@colin2.muc.de> wrote:
> 
> > What happens on outgoing active ARPs is a different thing. Reasonable
> > choices would be either the prefered source address of the route or
> > the local interface's address. I must admit I don't have a strong
> > opinion on what the better behaviour of those is, but neither of them would
> > seem particularly wrong to me.
> 
> Andi, we take the source address from the packet we are
> trying to send out that interface.
> 
> Just as it is going to be legal to send out a packet from
> that interface using that source address, it is legal to
> send out an ARP request from that interface using that source
> address.

Aehm, sorry but the logic is bogus. A routed packet will be sent out this
interface with a foreign IP as source, too. Though nobody will want to send an
arp request with a foreign ip as source.
But you say here: Just as I can send out a packet with IP X from that interface
I can send out ARP request with same source.
Obviously you don't want that.
So you cannot step from A to B in your logical chain here.

Again. I'd like to stress I don't want to insult you or anything. The simple
thing is this: there are a lot setups out there that could benefit from your
tolerance in this issue. Can't we simply take the issue to the point: "you are
right, but you show tolerance for boxes that are not completely wrong" ?
I mean the world is full of people that are right and intolerant, so that in
fact doesn't really make them special ...

Please let us keep in mind that joe-average-user cannot handle complex setups
with arpfilter, arp_filter or anything the like. But he can right away enter
IT-superstore XYZ and buy a brand new router box for 20 bucks. If he is unlucky
(and you stay intolerant) he will for sure _not_ blame this box but his desktop
linux if things don't work out as expected.
I think we should at least make a minimum effort to keep things simple (and
explainable to joe-average-user), even if the background is complex.
Everywhere we have a solution for a problem that is overly complex, we will
fail to gain a broad market share, because there may very likely be easier
solutions under <name-some-os> _and_ we attract support problems for all
distributors.

Regards,
Stephan
