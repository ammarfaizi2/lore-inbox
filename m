Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265057AbUF1Q2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265057AbUF1Q2b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 12:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbUF1Q2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 12:28:30 -0400
Received: from chilli.pcug.org.au ([203.10.76.44]:6819 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S265057AbUF1Q2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 12:28:16 -0400
Date: Tue, 29 Jun 2004 02:28:06 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       boutcher@us.ibm.com, katzj@redhat.com, ipseries-list@redhat.com,
       linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] 0/5 PPC64 - make iSeries virtual devices/drivers appear in
 sysfs
Message-Id: <20040629022806.4fda7605.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Tue__29_Jun_2004_02_28_06_+1000_ki/Hk+NbE_5dNu3i"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Tue__29_Jun_2004_02_28_06_+1000_ki/Hk+NbE_5dNu3i
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Andrew, Linus,

This is the patch I submitted for comment last week broken up a bit.

The purpose of the patch set is to integrate the iSeries virtual device
drivers in the driver infrastructure to allow for fairly reasonable user
mode probing for devices.

For each possible virtual device, there is an entry in /sys/devices/vio
and /sys/bus/vio/devices with the exception of the virtual ethernets where
there is an entry for each virtual lan that is actually configured.  When
the appropriate device driver is loaded (if it is a module), then entries
for actually configured devices appear in
/sys/bus/vio/drivers/<drivername>.  To only create entries for configured
devices in /sys/devices/vio (etc) would require some rework and moving of
the device probing code for each driver.  This may be done in the future.

This patch set is meant to be fairly minimal in order to get user mode
device enumeration.

The patches following are:
	1) update the vio infrastructure so that iSeries can use it. This
patch has only very small changes to the way pSeries works - and then only
internally to vio.c (apart from the renaminf of one routine).
	2) integrate iseries_veth
	3) viodasd
	4) viocd
	5) viotape

 arch/ppc64/kernel/vio.c             |  189 +++++++++++++++++++++++++-----------
 drivers/block/viodasd.c             |   87 ++++++++++------
 drivers/cdrom/viocd.c               |  185 +++++++++++++++++++++--------------
 drivers/char/viotape.c              |  119 ++++++++++++++--------
 drivers/net/iseries_veth.c          |  104 ++++++++++++-------
 drivers/net/iseries_veth.h          |    2 
 drivers/pci/hotplug/rpaphp_vio.c    |    4 
 include/asm-ppc64/iSeries/HvTypes.h |    4 
 include/asm-ppc64/vio.h             |    8 +
 9 files changed, 456 insertions(+), 246 deletions(-)

As I said, I posted this patch set as a single patch last week.

Unless we have objections, please apply.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Tue__29_Jun_2004_02_28_06_+1000_ki/Hk+NbE_5dNu3i
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA4Ece4CJfqux9a+8RAkaoAJ4o2W5xcYRLaPOIu71u6gOZ0hNJOQCfWVjX
9wvXcFWRhEgldXORLmnsSeo=
=j7Em
-----END PGP SIGNATURE-----

--Signature=_Tue__29_Jun_2004_02_28_06_+1000_ki/Hk+NbE_5dNu3i--
