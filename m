Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030235AbWBCWal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030235AbWBCWal (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 17:30:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030249AbWBCWal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 17:30:41 -0500
Received: from cust8446.nsw01.dataco.com.au ([203.171.93.254]:14257 "EHLO
	cust8446.nsw01.dataco.com.au") by vger.kernel.org with ESMTP
	id S1030235AbWBCWak (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 17:30:40 -0500
From: Nigel Cunningham <ncunningham@cyclades.com>
Organization: Cyclades Corporation
To: linux-kernel@vger.kernel.org
Subject: Time to harpoon the "Suspend2 changes things lots of things" myth.
Date: Sat, 4 Feb 2006 07:31:12 +1000
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2711574.5FDcIlPa8U";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200602040731.16814.ncunningham@cyclades.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2711574.5FDcIlPa8U
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all.

Here's a diff stat of the core changes for Suspend2:

 Documentation/kernel-parameters.txt |    8=20
 Documentation/power/internals.txt   |  360 ++++++++++
 Documentation/power/suspend2.txt    |  631 ++++++++++++++++++
 arch/arm/mm/init.c                  |   15=20
 arch/x86_64/kernel/e820.c           |   17=20
 arch/x86_64/kernel/suspend.c        |    6=20
 arch/x86_64/mm/init.c               |   19=20
 block/ll_rw_blk.c                   |   19=20
 include/asm-arm/hw_irq.h            |    4=20
 include/asm-arm/suspend2.h          |  136 ++++
 include/asm-i386/suspend2.h         |  288 ++++++++
 include/asm-x86_64/page.h           |    2=20
 include/asm-x86_64/suspend.h        |    2=20
 include/linux/bio.h                 |    1=20
 include/linux/dyn_pageflags.h       |   66 +
 include/linux/kernel.h              |    2=20
 include/linux/netlink.h             |    2=20
 include/linux/suspend.h             |    9=20
 include/linux/suspend2.h            |  231 ++++++
 init/do_mounts.c                    |   28=20
 init/do_mounts_initrd.c             |    9=20
 init/main.c                         |    4=20
 kernel/fork.c                       |    9=20
 kernel/power/Kconfig                |   73 ++
 kernel/power/Makefile               |   25=20
 kernel/power/atomic_copy.c          |  473 ++++++++++++++
 kernel/power/atomic_copy.h          |    4=20
 kernel/power/block_io.h             |   76 ++
 kernel/power/checksum.h             |   11=20
 kernel/power/compression.c          |  638 ++++++++++++++++++
 kernel/power/debug_pagealloc.c      |  111 +++
 kernel/power/debug_pagealloc.h      |    3=20
 kernel/power/encryption.c           |  597 +++++++++++++++++
 kernel/power/extent.c               |  247 +++++++
 kernel/power/extent.h               |  105 +++
 kernel/power/io.c                   | 1026 ++++++++++++++++++++++++++++++
 kernel/power/io.h                   |   38 +
 kernel/power/modules.c              |  312 +++++++++
 kernel/power/modules.h              |  180 +++++
 kernel/power/netlink.c              |  365 ++++++++++
 kernel/power/netlink.h              |   43 +
 kernel/power/pagedir.c              |  370 ++++++++++
 kernel/power/pagedir.h              |   37 +
 kernel/power/pageflags.c            |  150 ++++
 kernel/power/pageflags.h            |   86 ++
 kernel/power/power.h                |    4=20
 kernel/power/power_off.c            |   79 ++
 kernel/power/power_off.h            |   13=20
 kernel/power/prepare_image.c        |  753 ++++++++++++++++++++++
 kernel/power/prepare_image.h        |   31=20
 kernel/power/proc.c                 |  305 +++++++++
 kernel/power/proc.h                 |   70 ++
 kernel/power/snapshot.c             |    2=20
 kernel/power/storage.c              |  323 +++++++++
 kernel/power/storage.h              |   21=20
 kernel/power/suspend.c              | 1133 +++++++++++++++++++++++++++++++=
++
 kernel/power/suspend.h              |   28=20
 kernel/power/suspend2.h             |   31=20
 kernel/power/suspend2_common.h      |   25=20
 kernel/power/suspend_block_io.c     | 1086 ++++++++++++++++++++++++++++++++
 kernel/power/suspend_checksums.c    |  509 +++++++++++++++
 kernel/power/suspend_file.c         | 1077 +++++++++++++++++++++++++++++++
 kernel/power/suspend_swap.c         | 1213 +++++++=3D=3D> (Trunc'd for wor=
d wrap)
 kernel/power/swsusp.c               |    4=20
 kernel/power/swsusp.h               |   24=20
 kernel/power/ui.c                   |  853 +++++++++++++++++++++++++
 kernel/power/ui.h                   |   44 +
 kernel/power/version.h              |    2=20
 lib/Kconfig                         |    3=20
 lib/Makefile                        |    2=20
 lib/dyn_pageflags.c                 |  330 +++++++++
 lib/vsprintf.c                      |   28=20
 mm/memory.c                         |    9=20
 73 files changed, 14823 insertions(+), 17 deletions(-)

As you can see, nearly everything is in the new kernel/power files and arch=
=20
specific code.

But, you might say, if I download a pacakage from suspend2.net, my diffstat=
=20
looks quite different. Yes. that's because that packaging also includes=20
related, noncore improvements such as refrigerator improvements, cryptoapi=
=20
lzf support and driver fixes that aren't upstream yet. The refrigerator=20
improvements especially cause a blowout in the number of files affected by=
=20
the patch.

I'm sure the above will also lead to the question "Why is it so big compare=
d=20
to swsusp?" That's because Suspend2 supports the following features the=20
swsusp currently lacks:

=2D Writing to more than one swap file/partition in an image.
=2D Writing to ordinary files instead of to swap.
=2D Asynchronous I/O
=2D Readahead for synchronous I/O
=2D Optional compression and encryption via cryptoapi
=2D An optional userspace user interface, controlled via a netlink socket.
=2D Reconfiguring without rebooting.
=2D Save a full image of memory (or...)
=2D Set an arbitrary soft upper limit on the size of the image
=2D Press escape to cancel suspending to disk at any time during writing th=
e=20
image.
=2D Disable cancelling via a proc entry if want to.
=2D Configure encryption anyway you want - all settings are simply passed=20
through.
=2D Testing settings that can be used to benchmark and issues
=2D Support for userui storage manager (eg for managing network connections=
 when=20
writing the image to the network)
=2D Documentation. Not perfect, but it adds to the size of the code too.

Regards,

Nigel

--nextPart2711574.5FDcIlPa8U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBD48ukN0y+n1M3mo0RAodyAKD0v0GEzjNX0sde9YfMpbFrBOY54QCfb4T6
5jCOrTIPtjatNaqO0nFD8YE=
=usZz
-----END PGP SIGNATURE-----

--nextPart2711574.5FDcIlPa8U--
