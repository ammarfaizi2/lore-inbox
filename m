Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136471AbREJNPd>; Thu, 10 May 2001 09:15:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136478AbREJNPX>; Thu, 10 May 2001 09:15:23 -0400
Received: from gadget.lut.ac.uk ([158.125.96.50]:52235 "EHLO gadget.lut.ac.uk")
	by vger.kernel.org with ESMTP id <S136471AbREJNPG>;
	Thu, 10 May 2001 09:15:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
To: john slee <indigoid@higherplane.net>
Cc: Mart?n Marqu?s <martin@bugs.unl.edu.ar>, linux-kernel@vger.kernel.org
Subject: Re: reiserfs, xfs, ext2, ext3 
In-Reply-To: Message from john slee <indigoid@higherplane.net> 
   of "Thu, 10 May 2001 00:49:59 +1000." <20010510004959.B7653@higherplane.net> 
Date: Thu, 10 May 2001 14:14:27 +0100
From: Martin Hamilton <martin@net.lut.ac.uk>
Message-Id: <E14xqGx-0006Y6-00@gadget.lut.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

Just to pick up on this thread, to operate the JANET Web Cache Service
(proxy caching thingy used by a lot of ac.uk folk) we currently run
Squid on top of 2.2.18 + Linux Virtual Server 1.0.5 + ReiserFS 3.5.31
and the Magic-SysRq-over-serial-console patch.

In almost a year of operation (admittedly covering a couple of earlier
kernel/ReiserFS/... combos, and gradually migrated to our 40-odd cache
servers) we've only ever had a couple of wibbles which directly
implicated ReiserFS - and these on servers which later turned out to
have hardware problems. Lockups on the older 3c905 and eepro100
drivers have caused us some problems historically, though.

As the JANET backbone has migrated to 2.5Gbit/s we've seen our daily
transaction rate rise to over 100m URLs, with one peak of 120m. Moving
our cache filesystems from ext2 to ReiserFS almost tripled the number
of requests we could process per second before a cache box became
overloaded, and our fastest machines (6 x 10,000 RPM Ultra160 SCSI
cache disks) are now shipping some 230 requests/s with around 50ms
latency for a cache hit.

FWIW, we're currently using Squid 2.2.STABLE5-hno.20000202 and using
ReiserFS as a regular filesystem rather than raw, so there ought to be
quite a bit of scope for improvement.  Commercial caching systems have
demonstrated thoughput of thousands of requests/s with similar
hardware, but I suspect Tux-ification of Squid will be necessary to
catch up with them.  This (in the form of our old chum the proprietary
loadable kernel module :-) seems to be the direction the commercial
vendors are going in to get maximal performance out of their Linux
ports...

Cheers,

Martin



-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999 + martin

iD8DBQE6+pQyVw+hz3xBJfQRApYsAKCuy1yPe/KarPluSeTB6OKgmfQ+8wCfYPi2
li9nQT05bhlj7Us3fXf3+l8=
=biJi
-----END PGP SIGNATURE-----

