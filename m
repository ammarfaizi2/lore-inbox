Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267906AbRG0JlK>; Fri, 27 Jul 2001 05:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268794AbRG0JlB>; Fri, 27 Jul 2001 05:41:01 -0400
Received: from henry.uncarved.com ([195.157.139.125]:22400 "HELO
	a.mx.uncarved.com") by vger.kernel.org with SMTP id <S267906AbRG0Jko>;
	Fri, 27 Jul 2001 05:40:44 -0400
From: "Sean Hunter" <sean@uncarved.com>
Date: Fri, 27 Jul 2001 10:40:49 +0100
To: ext3-users@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Strane remount behaviour with ext3-2.4-0.9.4
Message-ID: <20010727104049.B6311@uncarved.com>
Mail-Followup-To: Sean Hunter <sean@uncarved.com>, ext3-users@redhat.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="gatW/ieO32f1wygP"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


--gatW/ieO32f1wygP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Following the announcement on lkml, I have started using ext3 on one of my
servers.  Since the server in question is a farily security-sensitive box, my
/usr partition is mounted read only except when I remount rw to install
packages.

I converted this partition to run ext3 with the mount options
"nodev,ro,data=writeback,defaults" figuring that when I need to install new
packages etc, that I could just mount rw as before and that metadata-only
journalling would be ok for this partition as it really sees very little write
activity.

When I try to remount it r/w I get a log message saying:
Jul 27 09:54:29 henry kernel: EXT3-fs: cannot change data mode on remount

...even if I give the full mount option list (including data=writeback) with
the remount instruction.

I can, however, remount it as ext2 read-write, but when I try to remount as
ext3 (even read only) I get the same problem.

Wierdly, "mount" lists it as being still an ext3 partition even though it has
been remounted as ext2.  I can't umount /usr because kjournald is currently
listed as using the partition.

The box in question is more-or-less RedHat 7.1, with ext3-2.4-0.9.4, kernel
2.4.7 and with the following relevant package versions:

mount-2.11g-4
util-linux-2.11f-3
e2fsprogs-1.22-2

...all from rawhide rpms.

I'm going to try one of the partitions mounted "data=ordered" to see if I see
the same sort of thing.

Sean


--gatW/ieO32f1wygP
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7YTcgAgJf0xrWsZwRAnFfAKCZ1QhBJeOeUo5E1ret9f5UacUIcQCeJCDn
jDFJxF/vyFDy+TSNMUlDtkM=
=LrBy
-----END PGP SIGNATURE-----

--gatW/ieO32f1wygP--
