Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129535AbRB0C67>; Mon, 26 Feb 2001 21:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129540AbRB0C6l>; Mon, 26 Feb 2001 21:58:41 -0500
Received: from tomts8.bellnexxia.net ([209.226.175.52]:51154 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S129535AbRB0C6T>; Mon, 26 Feb 2001 21:58:19 -0500
Message-ID: <3A9B16AC.707D6091@coplanar.net>
Date: Mon, 26 Feb 2001 21:53:33 -0500
From: Jeremy Jackson <jerj@coplanar.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: Andi Kleen <ak@suse.de>, Jeff Garzik <jgarzik@mandrakesoft.com>,
        linux-kernel@vger.kernel.org
Subject: Re: New net features for added performance
In-Reply-To: <3A9842DC.B42ECD7A@mandrakesoft.com>
		<oupsnl3k5gs.fsf@pigdrop.muc.suse.de>
		<15002.60239.486243.682681@pizda.ninka.net>
		<20010227010336.A25816@gruyere.muc.suse.de> <15002.61448.626860.33433@pizda.ninka.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:

> Andi Kleen writes:
>  > Or did I misunderstand you?
>
> What is wrong with making methods, keyed off of the ethernet protocol
> ID, that can do the "I know where/how-long headers are" stuff for that
> protocol?  Only cards with the problem call into this function vector
> or however we arrange it, and then for those that don't have these
> problems at all we can make NULL a special value for this
> "post-header" pointer.
>

I had a dream about a NIC that would do exactly the above by itsself.
The dumb cards would use the above code, and the smart ones' drivers
would overload the functions and allow the NIC to do it.

"Tell me of the waters of your homeworld, Usul" :)

Except the driver interacts differently than netif_rx... knowing the
protocol it DMA's the header  only(it knows the length then too)

(SMC's epic100's descriptors can do this, but the card can't
do the de-mux on proto id, forcing the network core to run
in the ISR so the card can finish DMA and not exhaust it's
tiny memory.) The network code can
then do all the routing/netfilter/QoS stuff, and tell the card to DMA
the payload into the TX queue of another NIC (or queue the header
with a pointer to the payload in the PCI address space of the incoming
NIC heh heh) OR into the process' mmap'ed TCP receive buffer
ala SGI's STP.



