Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267580AbSKSXNe>; Tue, 19 Nov 2002 18:13:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267588AbSKSXNb>; Tue, 19 Nov 2002 18:13:31 -0500
Received: from [144.135.24.137] ([144.135.24.137]:7619 "EHLO
	mta08bw.bigpond.com") by vger.kernel.org with ESMTP
	id <S267580AbSKSXN0>; Tue, 19 Nov 2002 18:13:26 -0500
From: Brad Hards <bhards@bigpond.net.au>
To: Oliver Neukum <oliver@neukum.name>,
       "Folkert van Heusden" <folkert@vanheusden.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: local link configuration daemon?
Date: Wed, 20 Nov 2002 10:10:09 +1100
User-Agent: KMail/1.4.5
References: <003b01c28fed$724a2c80$3640a8c0@boemboem> <200211200815.56896.bhards@bigpond.net.au> <200211192351.50618.oliver@neukum.name>
In-Reply-To: <200211192351.50618.oliver@neukum.name>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200211201010.16500.bhards@bigpond.net.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Wed, 20 Nov 2002 09:51, Oliver Neukum wrote:
> > It was originally done by Sebastian Kuzminsky. It basically uses the
> > kernel's packet filter (BPF) and socket code, via Libnet and libpcap. You
> > can get it from your friendly kernel.org mirror
> > (http://www.XX.kernel.org/pub/software/network/zcip/, where XX is your
> > country code).
> >
> > In the longer term, it might be appropriate to move some of it (the
> > defend part of the claim-and-defend sequence) into kernel space. I don't
> > think it makes sense to have it all in kernel space.
>
> Definitely, however you've never convinced me how you do the arp related
> part in user space at all. It seems to me that you cannot do that unless
> you take all arp handling into user space.
The approach is that there are really two different things happening:
1. Detecting when someone is trying to use our IP
2. Generating an ARP packet (which might be set to our IP, depending on 
whether we are claiming or defending)

The first part is easy, as long as you have BPF support. Consider that it is 
just a peer to tcpdump, only we don't want all the packets.

The second part is OK, you just need to generate raw packets. The real 
functionality is in net/packet/af_packet.c, although I use Libnet
http://www.packetfactory.net/projects/libnet/
in an attempt at portability.

It might help to think of it as generating a single ARP packet (or a packet 
that has the ARP format, on the wire), rather than performing the ARP 
functionality.

Brad
- -- 
http://linux.conf.au. 22-25Jan2003. Perth, Aust. I'm registered. Are you?
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE92sTYW6pHgIdAuOMRApPFAJ92t006oLBNNw8munGv6K0/aFAtSACeJr+e
A7QQlOwzkRhhhGK+EuyX+D8=
=vGOO
-----END PGP SIGNATURE-----

