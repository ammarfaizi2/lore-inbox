Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265285AbUFTSCm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265285AbUFTSCm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 14:02:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265802AbUFTSCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 14:02:41 -0400
Received: from mail1.kontent.de ([81.88.34.36]:3518 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S265285AbUFTSCi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 14:02:38 -0400
From: Oliver Neukum <oliver@neukum.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Subject: Re: DMA API issues
Date: Sun, 20 Jun 2004 20:02:39 +0200
User-Agent: KMail/1.6.2
Cc: Ian Molton <spyro@f2s.com>, rmk+lkml@arm.linux.org.uk, david-b@pacbell.net,
       Linux Kernel <linux-kernel@vger.kernel.org>, greg@kroah.com,
       tony@atomide.com, jamey.hicks@hp.com, joshua@joshuawise.com
References: <1087584769.2134.119.camel@mulgrave> <20040620165042.393f2756.spyro@f2s.com> <1087750024.11222.81.camel@mulgrave>
In-Reply-To: <1087750024.11222.81.camel@mulgrave>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <200406202002.47025.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


>        +-----+
>        | CPU |
>        +--+--+
>           |
>     <-----+-----+----------------------+-----> Central Bus
>                 |                      |
>           +-----+------+        +------+-----+
>           |   Memory   |        |    I/O     |
>           | Controller |        | Controller |
>           +-----+------+        +------+-----+
>                 |                      |
>             +---+-----+             +--+---+    +--------+
>             | Memory  |             | OHCI |----| Memory |
>             +---------+             +------+    +--------+
> 
> In order to access this OHCI memory, both the I/O controller and the
> OHCI have to respond to the memory access cycles, rather than the memory
> controller.  This is why such memory is termed "bus remote".

Why in an abstract API would we care how the memory is connected to
the system? Isn't the only relevant issue whether the memory is in the
CPU's normal address space?
 
> Even though ARM can programm the I/O controller and the OHCI device to
> access this memory as though it were behind the memory controller (i.e.
> using normal CPU memory cycles), you'll find that even on ARM there's
> probably special page table trickery involved (probably to do with cache
> coherency issues).  Next, you'll find that no other device can see this
> memory without some type of i2o support, so it can't be the target of a
> DMA transaction. So even on ARM, you can't treat it as "normal" memory.

How is it relevant whether memory can be DMAed to by devices other
than the device in question? Even on regular x86 there's the low 16MB,
isn't there?
 
> The DMA API is about allowing devices to transact directly with memory
> behind the memory controller, it's an API that essentially allows the
> I/O controller and memory controller to communicate without CPU
> intervention.  This is still possible through the hypervisor, so the
> iSeries currently fully implements the DMA API.

Then what's the problem?

	Regards
		Oliver
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA1dFEbuJ1a+1Sn8oRAiFKAKCJZ9mDNzeDRie7xyLAFD+nv1gpSwCfWQke
TISWtAZS6nw8J4dabkk+8lo=
=yTfH
-----END PGP SIGNATURE-----
