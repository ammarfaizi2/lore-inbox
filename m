Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311577AbSCTFu6>; Wed, 20 Mar 2002 00:50:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311575AbSCTFum>; Wed, 20 Mar 2002 00:50:42 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:21520 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311572AbSCTFuf>; Wed, 20 Mar 2002 00:50:35 -0500
Message-ID: <3C9822CD.47ED9565@zip.com.au>
Date: Tue, 19 Mar 2002 21:49:01 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rahul Karnik <rahul@genebrew.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 3Com 556B Tornado not working
In-Reply-To: <33032.192.168.1.1.1016594386.squirrel@porsche.genebrew.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rahul Karnik wrote:
> 
> I have a HP Omnibook 500 with a 3Com 556B miniPCI ethernet/modem combo. Try
> as I might, I can't seem to get the card to connect to the network. My
> question is, how do I figure out what is the problem here? At this point, I
> do not know if the card or the kernel is at fault. Please CC me as I am not
> subscribed to the list.
> 

Seems that link negotiation didn't go right.

> Mar 19 22:24:30 quicksilver kernel: eth0: Media override to transceiver 8
> (Autonegotiate).

How did you manage to get this message to come out with a modular
driver?  Are there other driver options in modules.conf?

First-up you should avoid using any special negotiation and
transceiver options and just let the card work it out.

> ...
> Transceiver type in use:  Autonegotiate.
>  MAC settings: half-duplex.

Do you expect half-duplex?

> ...
>    Able to perform Auto-negotiation, negotiation not complete.
> ...
>  Link partner capability is 0001:.
>    Negotiation did not complete.

Lots of bad things there.  Remove any special options, then
re-run mii-diag and vortex-diag.  If your cables and peer
are behaving then you should see happy output indicating the
desired duplex, speed and negotiation status.

If it still doesn't work, try statically assigning the IP
address (get rid of DHCP somehow).  There were some workarounds
in later drivers for strange interactions between some hardware
combinations and some DHCP clients.

If it *still* doesn't work then it's time to sniff the connection
and try to see those arp messages.

And try different cables, different link peers.

And try another you-know-which operating system.  If that works OK
then we know the hardware's good.

-
