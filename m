Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266607AbUGPW2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266607AbUGPW2l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jul 2004 18:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUGPW2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jul 2004 18:28:41 -0400
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:33507 "EHLO
	gw02.mail.saunalahti.fi") by vger.kernel.org with ESMTP
	id S266627AbUGPW2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jul 2004 18:28:34 -0400
Message-ID: <40F8568B.2030101@sci.fi>
Date: Sat, 17 Jul 2004 01:28:27 +0300
From: =?UTF-8?B?TGFzc2UgS8Okcmtrw6RpbmVuIC8gVHJvbmlj?= <tronic2@sci.fi>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040314)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Silicon Image SATA woes
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig382E15DFFD5204BEB91C3543"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig382E15DFFD5204BEB91C3543
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Running 2.6.7-cko1 on Athlon64, VIA K8T800, Epox 8hda3+. All the SATA 
disks are Samsung SP1614C. There's a nine disk (5xSP1614C, 4xSP1614N) 
RAID-5, and ReiserFS on top of that.

Q-TEC SiI3112ATC144 two port PCI SATA card - shown as devices hde and 
hdg - works fine and never gives any errors in kernel log. Well, almost. 
The drawback is that it corrupts data randomly, about once in every ten 
gigabytes of data read. I don't know if this affects writes. Testing was 
done by repeatedly dd'ing a swap partition (that was not in use) to a 
file and then diffing it with the known contents. Initially it was found 
by unrar getting unexpected and random CRC errors, then PAR2 finding 
errors and md5sums not matching.

The on-board SiI3114 is having different kind on problem. After few 
minutes of heavy use I get the following in kernel log:
ata2: DMA timeout, stat 0x61

After this happens, trying to access the filesystem, /dev/md0, 
/proc/mdstat or /dev/sdX (where X is either a, b or c; this seems to 
vary from crash to crash) halts the accessing process. The log entry 
always seems to be about ata2. I have tried reordering the disks without 
help. However, this problem didn't surface with only one disk on the 
controller.

I tried 2.6.8-rc1, but that was so unstable (*) that I could hardly boot 
the system and couldn't keep running on it. However, I confirmed that 
the 3112 data corruption also occurs there.

*) for instance, running ifconfig (by the startup scripts) OOPSed the 
kernel and halted the system until ifconfig was killed; unfortunately, I 
didn't get the log of this one.

I need quick answer: are these hardware faults and should I take the 
hardware back for warranty? I could also get some other hardware instead 
of that 3112... Would that be wise?

- Tronic -


--------------enig382E15DFFD5204BEB91C3543
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFA+FaQOBbAI1NE8/ERAjVqAKCO2GQ7mIeCcYjcgszyYQGIJVeETQCdHKBG
bmKoUtLglf/JNryqGF4fYWU=
=//A7
-----END PGP SIGNATURE-----

--------------enig382E15DFFD5204BEB91C3543--
