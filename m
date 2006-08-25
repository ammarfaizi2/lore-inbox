Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422751AbWHYSfV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422751AbWHYSfV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422782AbWHYSfU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:35:20 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:43678 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1422751AbWHYSfT (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:35:19 -0400
Message-Id: <200608251835.k7PIZHZv016794@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc4-* LVM issues from initrd.
From: Valdis.Kletnieks@vt.edu
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1156530917_3038P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Fri, 25 Aug 2006 14:35:17 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1156530917_3038P
Content-Type: text/plain; charset=us-ascii

I never saw this under 2.6.18-rc3-mm*, and for a while -rc4-mm1 wasn't
doing it either. However, I'm now seeing a reproducible problem with -rc4
and later...

Setup:  1 disk, basically 2 partitions, an ext3 /boot and a LVM space that
/ and other filesystems live in.  Of late, the 'vgscan' command has been
consistently failing to find the volume group, so we end up falling off
the end of the initrd startup script when there's no init left.  It's not
a every-time thing - after 2 to 10 attempted boots, one will work. I was
suspecting hardware issues after some problems caused a motherboard swap
last week - but -rc3-mm2 is 100% able to boot every time.  It *seems* to
be a timing-related thing - adding 'loglevel=7' to the boot generates more
printk traffic, which seems to slow it down enough to improve chances.

My personal guess is that -rc4 is a few percent faster at booting, and
the initrd (running 'nash') used to take long enough that the hotplug event
that created /dev/sda1 and /dev/sda2 *used* to finish before vgscan got
started, but now vgscan is getting going faster and races the hotplug.

Any alternative hypothesis, or is it time to dive into the wonders of
nash scripting and figure out how to make it wait for hotplug?




--==_Exmh_1156530917_3038P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFE70LlcC3lWbTT17ARAoKqAKDN8iX6Sp1wrXxHh0d+kE9FBP0dEACg6Qk5
tYTlqxUuw94uv4cPZiFMagE=
=AhJg
-----END PGP SIGNATURE-----

--==_Exmh_1156530917_3038P--
