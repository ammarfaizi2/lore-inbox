Return-Path: <linux-kernel-owner+w=401wt.eu-S1161182AbXAMCAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161182AbXAMCAf (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 21:00:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161190AbXAMCAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 21:00:35 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:51666 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161182AbXAMCAe (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 21:00:34 -0500
Message-Id: <200701121608.l0CG8csY003712@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Andrew Morton <akpm@osdl.org>, Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3-mm1 - git-block.patch causes hard lockups
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168618117_3439P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 12 Jan 2007 11:08:38 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168618117_3439P
Content-Type: text/plain; charset=us-ascii

On , Valdis.Kletnieks@vt.edu said:
> On Thu, 04 Jan 2007 22:02:00 PST, Andrew Morton said:
> 
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc3/2.6.20-rc3-mm1/

Still seeing this in -rc4-mm1..

> With git-block.patch applied, my system locks up *hard* at system shutdown
> time - even alt-sysrq doesn't do anything.  Need to do the "power button for 5"
> stunt to get the system back.

And today's chef's special is wild crow, tastefully prepared in a stir-fry
with broccoli and mixed asiatic vegetables, served on a bed of steamed rice...

It doesn't look quite as locked up hard when you fix the ##$*&% script that
did an 'echo 0 > /proc/sys/kernel/sysrq' :)

Here's the hand-copied traceback:

__mutex_lock_slowpath+0x22/0xaa
mutex_lock+0xe/0x10
synchronize_rcu+0x23/0xc5
blk_sync_queue+0x1d/0x5a
blk_release_queue+0x19/0x65
kobject_cleanup+0x53/0x72
kobject_release+0x0/0xf
kobject_release+0xd/0xf
kref_put+0x5f/0x6b
kobject_put+0x19/0x1b
blk_put_queue+0x43/0x48
dm_put+0x11f/0x133
dev_remove+0xa3/0xb7
ctl_ioctl+0x24f/0x29f
dev_remove+0x0/0xb7
file_has_perm+0xa7/0xb6
do_ioctl+0x5e/0x77
vfs_ioctl+0x252/0x26f
sys_ioctl+0x5f/0x82
tracesys+0xdc/0xe1


> The system is Fedora Core 6/Rawhide, and the last command issued (from
> /etc/rc6.d/S01reboot) is "/sbin/cryptsetup remove swap".  It hits that,
> and *wham* we're dead.  Works fine if I revert git-block.patch.
> 
> The line from /etc/crypttab for the encrypted swap:
> 
> swap /dev/mapper/VolGroup00-swap /dev/urandom swap,cipher=aes-cbc-essiv:sha256

--==_Exmh_1168618117_3439P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFp7KFcC3lWbTT17ARAuVGAJwKts2e8WAVZP2V04cQ5kOQHL1KjACgu+hf
yXh+KNSLmzw8MaU5X6IY/LU=
=14yB
-----END PGP SIGNATURE-----

--==_Exmh_1168618117_3439P--
