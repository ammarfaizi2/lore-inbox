Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265805AbUBPUYN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 15:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265872AbUBPUYN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 15:24:13 -0500
Received: from main.gmane.org ([80.91.224.249]:41909 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265805AbUBPUWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 15:22:50 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Oopsing cryptoapi (or loop device?) on 2.6.*
Date: Mon, 16 Feb 2004 04:22:34 -0800
Message-ID: <m2k72n9pth.fsf@tnuctip.rychter.com>
References: <402A4B52.1080800@centrum.cz> <402A7765.FD5A7F9E@users.sourceforge.net>
 <m265e9oyrs.fsf@tnuctip.rychter.com>
 <402F877C.C9B693C1@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha1; protocol="application/pgp-signature"
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Reasonable Discussion,
 linux)
Cancel-Lock: sha1:QfIbpalRz7Ky2yscgVNr1ogeNqM=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=-=-=

>>>>> "Jari" == Jari Ruusu <jariruusu@users.sourceforge.net>:
 Jari> Jan Rychter wrote:
 >> FWIW, I've just tried loop-AES with 2.4.24, after using cryptoapi
 >> for a number of years. My machine froze dead in the midst of copying
 >> 2.8GB of data onto my file-backed reiserfs encrypted loopback mount.
 >>
 >> Since the system didn't ever freeze on me before and since I've had
 >> zero problems with cryptoapi, I attribute the freeze to loop-AES.
 >>
 >> Yes, I know this isn't a good bugreport...

 Jari> Is there any particular reason why you insist on using file
 Jari> backed loops?

Yes. They are much easier to use from a practical standpoint. They do
not require repartitioning of your drives. They are easy to back up
using rsync. They are reasonably easy to resize (by creating another
file-backed loop side by side and copying the data).

Probably the biggest reason is that repartitioning laptop drives is a
difficult task. You can't just connect a second drive to a laptop, so
when you have a laptop that's full of data, there is no easy way to
repartition.

All in all, it's not a strict requirement, it's a convenience thing,
especially for those of us who do not sit in front of huge desktops,
where you can easily add and replace drives.

 Jari> File backed loops have hard to fix re-entry problem: GFP_NOFS
 Jari> memory allocations that cause dirty pages to written out to file
 Jari> backed loop, will have to re-enter the file system anyway to
 Jari> complete the write. This causes deadlocks. Same deadlocks are
 Jari> there in mainline loop+cryptoloop combo.

I have used cryptoapi (as modules) for the last 2 years (or so) now,
without encountering any problems whatsoever. I therefore beg to differ:
if the same deadlocks are there, then for some reason they are not
triggered on my machine. Two years versus an hour, that's a rather
significant difference in terms of reliability.

 Jari> This is one of the reasons why this is in loop-AES README: "If
 Jari> you can choose between device backed and file backed, choose
 Jari> device backed even if it means that you have to re-partition your
 Jari> disks."

I would humbly suggest that this annotation be made more explicit. Had
it said "DO NOT use file backed loop devices, as these do not work and
cause deadlocks", I would have never even tried loop-AES. As it stands,
I did, and it took about an hour to get a deadlock.

--J.  
PS: just as a clarification: my setup consists of reiserfs on top of an
encrypted file-backed loop device, the file sits on an ext3 fs mounted
with data=ordered.

--=-=-=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBAMLYMLth4/7/QhDoRAmQ+AKCmD2DO0aooyr9lhLGT0leESFINkgCgl5Xo
D0KRBhI6XCMmxs0FZGQAqy0=
=Kwqt
-----END PGP SIGNATURE-----
--=-=-=--

