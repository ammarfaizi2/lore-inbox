Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbSKZRQj>; Tue, 26 Nov 2002 12:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266431AbSKZRQj>; Tue, 26 Nov 2002 12:16:39 -0500
Received: from vger.timpanogas.org ([216.250.140.154]:2023 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S266243AbSKZRQh>; Tue, 26 Nov 2002 12:16:37 -0500
Date: Tue, 26 Nov 2002 11:26:48 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Steven Dake <sdake@mvista.com>
Cc: "Joao Alberto M. dos Reis (listas de discucao)" <lista@vudu.ath.cx>,
       lista do kernel <linux-kernel@vger.kernel.org>
Subject: [PROPOSAL] Network Load Balance
Message-ID: <20021126112648.A30916@vger.timpanogas.org>
References: <1038264237.3731.9.camel@goku> <3DE2AB46.70100@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3DE2AB46.70100@mvista.com>; from sdake@mvista.com on Mon, Nov 25, 2002 at 03:59:18PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Here is something we did at Novell many years back that worked very well for 
load balancing across multiple adapters.  This implementation allowed up
to four (4) adapters to function with load balancing.  To pull this off,
you need to spoof at the MAC laer and alter the MAC addresses in the 
header of received frames to spoof the IP stack above.  This method 
requires **NO** changes to any protocol stacks above.

All adapters were permitted to receive frames and there was a memory table 
that held the MAC address of the first adapter in the load balance 
group.  For any packets received by any of the adapters, the MAC frame 
address was replaced for other receiving adapters with the address of 
the primary adapter prior to being pushed up to the protocol stacks.

Any TX packets going outbound to the primary adapter MAC address were 
intercepted and round robined out to each of the load balance cards.
Prior to being transmitted, the MAC address in the outbound packets
was changed to match the card the packet would be sent from.  This 
has the affect of spoofing the remote clients into seeing packets 
originate from that particular adapter, and they would answer to that 
card MAC address.  When the card received the packets, since the MAC address
was being NAT'd, all of the received data would be aliased to appear to 
be originating from the first primary adapter.

This model worked great on IPX, and worked fine with ARP and RARP under 
IP, although it's not intutive as to why.

At any rate, this is a down and dirty model that would support load 
balancing effectively across up to four adapters.  It worked very well
for us.

Jeff





On Mon, Nov 25, 2002 at 03:59:18PM -0700, Steven Dake wrote:
> Joao,
> 
> Your looking for bonding driver, which is in the kernel and also has a 
> seperate sourceforge project where development works.
> 
> Thanks
> -steve
> 
> Joao Alberto M. dos Reis (listas de discucao) wrote:
> 
> >There is any way to make 2 intel ethernet cards working as one, like the
> >Network Load Balance (NLB - Windows) in the Intel Ethernet adapters with
> >the Adaptive Load Balance feature on linux? 
> >
> >I know that in windows it works, but in the linux? Anyone has any
> >ideias? 
> >
> >Joao Reis.
> >
> >
> >
> >-
> >To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> >the body of a message to majordomo@vger.kernel.org
> >More majordomo info at  http://vger.kernel.org/majordomo-info.html
> >Please read the FAQ at  http://www.tux.org/lkml/
> >
> >
> >
> >  
> >
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
