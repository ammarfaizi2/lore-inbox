Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265890AbSKBHDR>; Sat, 2 Nov 2002 02:03:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265892AbSKBHDR>; Sat, 2 Nov 2002 02:03:17 -0500
Received: from citi.umich.edu ([141.211.92.141]:4504 "HELO citi.umich.edu")
	by vger.kernel.org with SMTP id <S265890AbSKBHDQ>;
	Sat, 2 Nov 2002 02:03:16 -0500
Date: Sat, 2 Nov 2002 02:09:45 -0500
From: Niels Provos <provos@citi.umich.edu>
To: linux-kernel@vger.kernel.org
Subject: cryptographic acceleration [Re: What's left over.]
Message-ID: <20021102070944.GR15875@citi.citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

While discussing various topics related to Linux and the BSDs, this
thread was mentioned.

>The question I have is whether such external hardware is even worth it
>any more for any standard crypto work.  With a regular PCI bus
>fundamentally limiting throughput to something like a maximum of 66MB/s
>(copy-in and copy-out, and that's so theoretical that it's not even
The following paper

Performance Analysis of TLS Web Servers.
  C. Coarfa, P. Druschel, and D. Wallach.
  In Proceedings of NDSS '02, 2002.
  http://www.isoc.org/isoc/conferences/ndss/01/2001/papers/dean02.pdf

analyzes the performance benefits from off-loading various crypto
operations to cryptographic hardware accelerators in comparison to
software crypto.  This is in the context of web servers and TLS.

The paper concludes that hardware accelerators are useful for speeding
up public key cryptography, whereas symmetric encryption (RC4) does not
benefit from hardware acceleration very much.

For public-key cryptography, the used bus bandwidth is not significant
because data transfers are usually small.

On the other hand, there are some Ethernet cards that support inline
encryption so that not additional bus bandwidth is required to do both
public and symmetric key cryptography.

Things are slightly different for expensive symmetric encryption
algorithms like 3DES.  See

A Study of the Relative Costs of Network Security Protocols
  Stefan Miltchev, Sotiris Ioannidis, and Angelos D. Keromytis
  http://www.cs.columbia.edu/~angelos/Papers/ipsecspeed.pdf

>Chris is write that crypto api is misdesigned if we want to use hardware
>cryptocards 
Angelos Keromytis has designed an API for cryptographic services in
the kernel.  The implementation provides a good abstraction.

Anyway, now you have some numbers.

Niels.
