Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132696AbRDQWoZ>; Tue, 17 Apr 2001 18:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132852AbRDQWoP>; Tue, 17 Apr 2001 18:44:15 -0400
Received: from [212.95.166.64] ([212.95.166.64]:48132 "EHLO u.domain.uli")
	by vger.kernel.org with ESMTP id <S132829AbRDQWoG>;
	Tue, 17 Apr 2001 18:44:06 -0400
Date: Wed, 18 Apr 2001 01:44:19 +0000 (GMT)
From: Julian Anastasov <ja@ssi.bg>
To: Sampsa Ranta <sampsa@netsonic.fi>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Broken ARP (was Re: ARP responses broken!)
Message-ID: <Pine.LNX.4.30.0104180131330.7698-100000@u.domain.uli>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

Sampsa Ranta wrote:

> The code I used to do the trick at my network was as simple as this,
> in function arp_rcv, the problem is ip_dev_find that does know if there
> are other devices with same IP address.

	I don't think this is your problem. You patch is not correct.
In fact, you implement the same function as in "hidden" but you are
missing some things. Please, read the "hidden" flag description in
the kernel docs. You must solve the case where your ARP probes are sent
always through one device due to your routing (this is out traffic,
yes?). These probes soon or later will cause you problems because
they change the entry in the remote hosts' ARP tables. You so carefully
tried to advertise the address on specific interface and now the other
hosts again talk to one card only.

	who-has 194.29.192.1 tell 194.29.192.38

	and your are dead :)

	So, please try "hidden" before going into more problems with
these patches (I see two in this thread, and I saw so many before).


Regards

--
Julian Anastasov <ja@ssi.bg>

