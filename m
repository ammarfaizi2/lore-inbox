Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136334AbRAGS16>; Sun, 7 Jan 2001 13:27:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136376AbRAGS1s>; Sun, 7 Jan 2001 13:27:48 -0500
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:48653 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S136334AbRAGS1d>;
	Sun, 7 Jan 2001 13:27:33 -0500
Message-ID: <3A58C3E8.FF5FF68E@candelatech.com>
Date: Sun, 07 Jan 2001 12:30:48 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.16 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [PATCH] hashed device lookup (Does NOT meet Linus' sumission
In-Reply-To: <E14FKDI-00033e-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Um, what about people running their box as just a VLAN router/firewall?
> > That seems to be one of the principle uses so far.  Actually, in that case
> > both VLAN and IP traffic would come through, so it would be a tie if VLAN
> > came first, but non-vlan traffic would suffer worse.
> 
> Why would someone filter between vlans when any node on each vlan can happily
> ignore the vlan partitioning

Suppose you have a 100bt link upstream, and want to re-sell that as 10 10Mb
links to all the customers in one building.  With VLANs, you can
haul all the data over one wire to a Linux box with 11 interfaces: 1 running
VLAN (100bt), and 10 others running 10bt ethernet.  Now, your uses are
segregated, and you only have 1 100bt wire running to the basement, instead
of 10.

Alternately, if you have a VLAN ethernet switch, your linux box just feeds
100bt into it, and acts as a router with 10 (vlan) interfaces.

In either of these cases, assuming the etherswitch and/or Linux box is secure,
the customers will not be able to be on other peoples VLAN.  This enables
all kinds of routing/billing possibilities...

> > So, how can I make sure that it is second in the list?
> 
> Register vlan in the top level protocol hash then have that yank the header
> and feed the packets through the hash again.

Thats what it already does, if I understand correctly.  Of course, if VLAN
is loaded as a module, then it will be in the hash before IP, right?


-- 
Ben Greear (greearb@candelatech.com)  http://www.candelatech.com
Author of ScryMUD:  scry.wanfear.com 4444        (Released under GPL)
http://scry.wanfear.com               http://scry.wanfear.com/~greear
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
