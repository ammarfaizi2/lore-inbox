Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262722AbVCJQff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262722AbVCJQff (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 11:35:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262677AbVCJQbi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 11:31:38 -0500
Received: from rwcrmhc13.comcast.net ([204.127.198.39]:34047 "EHLO
	rwcrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S262711AbVCJQ2X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 11:28:23 -0500
Message-ID: <423075B7.5080004@comcast.net>
Date: Thu, 10 Mar 2005 11:28:39 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: binary drivers and development
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I've been looking at the UDI project[1] and thinking about binary
drivers and the like, and wondering what most peoples' take on these are
and what impact that UDI support would have on the kernel's development.

I know the immediate first reactions are probably "Portable drivers are
slow" and "We don't support closed source crap."  I think benchmarks are
needed, and closed drivers can always be replaced by rewritten open
ones.  Really critical drivers that need the extra few microseconds can
always be low-level instead of abstracted.

The major considerations I come across mainly involve development focus
and kernel tree size.  UDI drivers would be separated from the kernel,
so their development would be focused; a driver fix would not warrent a
2.6, 2.4, and 2.2 patch, plus backports in 100 distributions (which
don't concern the LKML).  They'd also be in their own tarball, so the
kernel tree size would be a lot smaller if most drivers were UDI, though
by how much I'm not sure.

I'm aware that drivers would have to be loaded to the kernel like this,
being separated.  Aside from having the kernel build eat drivers from
some /lib/modules/udi/ directory, grub has a "module" command that can
load multiple modules.  If the kernel used that to load drivers (does it
now?), an initrd wouldn't be needed; a very straightforward bootloader
configuration would come in its place.

There is a 2.4 UDI reference model out with SCSI and NIC driver support.
 Perhaps some experimentation with these would be interesting, since the
disk and the network are performance focuses.  I don't think the UDI
reference model is ready quite yet for mainline, but it's ready for some
cross-examination by unbiased kernel developers.

[1] http://projectudi.sourceforge.net/

- --
All content of all messages exchanged herein are left in the
Public Domain, unless otherwise explicitly stated.

    Creative brains are a valuable, limited resource. They shouldn't be
    wasted on re-inventing the wheel when there are so many fascinating
    new problems waiting out there.
                                                 -- Eric Steven Raymond
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCMHW2hDd4aOud5P8RAnhSAJ9+8VdgR6EX0JwjUpysXsTMRl1ewwCeOWJR
g6mNs6NuEltgNS6qtVat5Mo=
=DrWO
-----END PGP SIGNATURE-----
