Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271867AbRH1SN0>; Tue, 28 Aug 2001 14:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271862AbRH1SNQ>; Tue, 28 Aug 2001 14:13:16 -0400
Received: from deimos.hpl.hp.com ([192.6.19.190]:46786 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S269229AbRH1SNG>;
	Tue, 28 Aug 2001 14:13:06 -0400
Date: Tue, 28 Aug 2001 11:13:21 -0700
To: "Clayton, Mark" <mark.clayton@netplane.com>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Multicast
Message-ID: <20010828111321.A8147@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
In-Reply-To: <87009604743AD411B1F600508BA0F95994CA68@XOVER.dedham.mindspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <87009604743AD411B1F600508BA0F95994CA68@XOVER.dedham.mindspeed.com>; from mark.clayton@netplane.com on Tue, Aug 28, 2001 at 01:45:35PM -0400
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@bougret.hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 28, 2001 at 01:45:35PM -0400, Clayton, Mark wrote:
> 
> Do you mind sharing your questions/thoughts?  This topic 
> interests me.  I'd be interested in hearing the dialog.
> 
> Thanks,
> Mark
> --
> [root@hjinc mclayton] /sbin/insmod stddisclaimer.o

	Ok, I'll try to be brief... I'm still not on the LKML...

	Linux 2.4.8, multiple network interfaces. I want to Rx/Tx
multicast junk on all interfaces or subset of them, on the same UDP
port.
	First, a bit of background : with multicast, packets are not
automatically sent on all interfaces. If you set a multicast route in
the routing table to an interface, they will be sent to this
interface, and only this one.
	The only way to bypass the routing table is to use the
IP_MULTICAST_IF option, but that select one specific outgoing
interface.
	Therefore, I'm trying to open a separate UDP multicast socket
on each interface active on the system (SIOCGIFCONF).


	I have a program that do (simplified) :
------------------------------------------
socket(AF_INET, SOCK_DGRAM, 0);
bind(sock, INADDR_ANY, MY_PORT);
setsockopt(IP_ADD_MEMBERSHIP, INADDR_ALLHOSTS_GROUP, ONE_INTERFACE);
setsockopt(IP_MULTICAST_IF, ONE_INTERFACE);
------------------------------------------
	First instance : work like a charm : multicast packet are
Tx/Rx on the selected interface without the need of explicit multicast
route.
        Second instance : "bind failed: Address already in use". In
other word, every time I try to bind a second socket on this port, it
fails...

	As "bind" is problematic, I tried as well :
------------------------------------------
bind(sock, INADDR_ALLHOSTS_GROUP, MY_PORT);
------------------------------------------
	This acts exactly as above, second bind fails.

	And finally, I tried :
------------------------------------------
bind(sock, ONE_INTERFACE, MY_PORT);
------------------------------------------
	First instance : Tx ok, doesn't Rx anything at all. I can
understand why, the Rx packet don't have a dest IP address matching
ONE_INTERFACE.


	That's it... As it's my first experiment with Multicast, I'm
probably missing something obvious...
	Thanks in advance...

	Jean
