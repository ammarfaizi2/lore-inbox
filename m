Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261692AbUJ1QWu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261692AbUJ1QWu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 12:22:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbUJ1QUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 12:20:14 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:54688 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261757AbUJ1PwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:52:25 -0400
Message-Id: <200410281549.i9SFnOYt011916@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.1 10/11/2004 with nmh-1.1-RC3
To: Mathieu Segaud <matt@minas-morgul.org>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       jfannin1@columbus.rr.com, agk@redhat.com, christophe@saout.de,
       linux-kernel@vger.kernel.org, bzolnier@gmail.com
Subject: Re: 2.6.9-mm1: LVM stopped working (dio-handle-eof.patch) 
In-Reply-To: Your message of "Wed, 27 Oct 2004 17:36:14 +0200."
             <877jpcgolt.fsf@barad-dur.crans.org> 
From: Valdis.Kletnieks@vt.edu
References: <87oeitdogw.fsf@barad-dur.crans.org> <1098731002.14877.3.camel@leto.cs.pocnet.net> <20041026123651.GA2987@zion.rivenstone.net> <20041026135955.GA9937@agk.surrey.redhat.com> <20041026213703.GA6174@rivenstone.net> <20041026151559.041088f1.akpm@osdl.org> <87hdogvku7.fsf@barad-dur.crans.org> <20041026222650.596eddd8.akpm@osdl.org> <20041027054741.GB15910@suse.de> <20041027064146.GG15910@suse.de>
            <877jpcgolt.fsf@barad-dur.crans.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1592643225P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 28 Oct 2004 11:49:24 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1592643225P
Content-Type: text/plain; charset="us-ascii"
Content-Id: <16130.1098978563.1@turing-police.cc.vt.edu>

On Wed, 27 Oct 2004 17:36:14 +0200, Mathieu Segaud said:

> As 2.6.10-rc1-mm1 failed (as expected), I tried tour fix applied upon
> 2.6.10-rc1-mm1. This did not make any difference.
> The only workaround for now is backing out dio-handle-eof-fix.patch and
> dio-handle-eof.patch
> I am willing to test anything you could send :)

For what it's worth, I hit the exact same problem with 2.6.10-rc1-mm1
(failure to get the LVM together at boot, causing a wedge because
my / filesystem is on an LVM), and backing out those two patches has
me up and running.

# fdisk -l /dev/hda

Disk /dev/hda: 40.0 GB, 40007761920 bytes
255 heads, 63 sectors/track, 4864 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hda1               1          29      232911   84  OS/2 hidden C: drive
/dev/hda2              30        4864    38837137+   5  Extended
/dev/hda5   *          30          32       24066   83  Linux
/dev/hda6              33        2327    18434556   8e  Linux LVM
/dev/hda7            2328        2458     1052226   82  Linux swap
/dev/hda8            2459        4864    19326163+  8e  Linux LVM

(Basically, a 24M /boot, a swap, and *two* LVM partitions - I wonder if that
has anything to do with it - it found one and didn't find the other, and gave
up with much complaining). That OS/2 partition is a remnant of what the docs 2
years ago said was needed for suspend-to-disk...

Am also able to test patches if needed...

--==_Exmh_1592643225P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFBgRUDcC3lWbTT17ARAo3LAKDhIL/ydurZOWU7wKQWe0pTbRtZ9gCg1jPi
2vlLvdLvRUTwWaP8DDSobdI=
=hJUd
-----END PGP SIGNATURE-----

--==_Exmh_1592643225P--
