Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317974AbSGPUjQ>; Tue, 16 Jul 2002 16:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317973AbSGPUjP>; Tue, 16 Jul 2002 16:39:15 -0400
Received: from ja.mac.ssi.bg ([212.95.166.194]:43012 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S317954AbSGPUjN>;
	Tue, 16 Jul 2002 16:39:13 -0400
Date: Tue, 16 Jul 2002 23:41:57 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
X-X-Sender: ja@u.domain.uli
To: Daniel Gryniewicz <dang@fprintf.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG?] unwanted proxy arp in 2.4.19-pre10
In-Reply-To: <1026849894.3520.5.camel@athena.fprintf.net>
Message-ID: <Pine.LNX.4.44.0207162312270.1816-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

On 16 Jul 2002, Daniel Gryniewicz wrote:

> Okay, I have no problem with this. What I have a problem with is Linux
> sending an ARP request out an interface and using the address of

	Please apply rp_filter_mask and be happy :) By this way
you can safely use rp_filter with hubs if that is your problem.

> *another interface* as the tell address.  This is just broken.

	From routing perspective it is not broken: ARP request is
built from data approved from routing and extracted from the
IP packet. If you provide different sender IP in the ARP request
you risk this probe to be answered on another target host's interface,
i.e. the remote host can answer it on eth0 and then our IP packet (with
different src IP) will be dropped on this device if it is allowed
on eth1 and the rp_filter_mask I mentioned in previous mail is not
supported/set (and it is usually not). This happens if the remote host
has 2 devices attached to the same hub we are connected and in such
case it usually accept one ARP probe on one interface (eth*/rp_filter=1).
This is the reason Linux ARP to use addresses from the IP packets.
You must not break this rule or you risk problems. Do you see the 
symmetry? If you lie in your ARP probe then you can receive wrong MAC for 
that target. Note that we resolve the path (SRCIP->DSTIP), not only DSTIP.
We ask "where should I send traffic from SRCIP to DSTIP?". The
question "where is DSTIP" is too ambiguous, you risk to receive
wrong answer (as usually happens). This is not mentioned in RFC826. 
Nor the word "hub" :)

Again, you are welcome on linux-net where we can find solution for
every setup which involves Linux ARP :)

Regards

--
Julian Anastasov <ja@ssi.bg>

