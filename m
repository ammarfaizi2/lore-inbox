Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263868AbUARVRr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jan 2004 16:17:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263893AbUARVRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jan 2004 16:17:47 -0500
Received: from fep03.swip.net ([130.244.199.131]:9436 "EHLO fep03-svc.swip.net")
	by vger.kernel.org with ESMTP id S263868AbUARVRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jan 2004 16:17:44 -0500
Message-ID: <400ABE5B.6090701@free.fr>
Date: Sun, 18 Jan 2004 18:11:55 +0100
From: Jean-Luc Fontaine <jfontain@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i586; en-US; rv:1.6b) Gecko/20031210
X-Accept-Language: en-us, ja
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kernel 2.6.1: erroneous statistics in /proc/diskstats?
X-Enigmail-Version: 0.82.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I would like to make sure /proc/diskstats is reliable or if I am totally
misunderstanding the significance of the milliseconds spent reading or
writing figures.
Copying a huge file from hdb to hdc, I get:

$ date; egrep 'hdb|hdc' /proc/diskstats
Sun Jan 18 17:52:51 CET 2004
3 64 hdb 12949 88 1335982 352530 8506 8009 132344 257702 1 102525 610631
3 65 hdb1 13034 1335950 16543 132344
22 0 hdc 260 0 2072 15180 3026 87831 727760 1232708 113 25415 1299749
22 1 hdc1 256 2040 90970 727760
$ date; egrep 'hdb|hdc' /proc/diskstats
Sun Jan 18 17:52:57 CET 2004
3 64 hdb 13162 88 1384702 356272 8506 8009 132344 257702 0 106045 614311
3 65 hdb1 13246 1384670 16543 132344
22 0 hdc 260 0 2072 15180 3725 109431 906136 1931270 111 31685 2000878
22 1 hdc1 256 2040 113267 906136

According to the above, hdc has spent writing (field #8):
~  1931270 - 1232708 = 698562 ms = 699 s
doing I/O (field #10):
~  31685 - 25415 = 6270 ms = 6.27 s
in about a 6 s interval (from date command).
It seems field #8 is incorrect.

As for hdb, it has spent reading (field #4):
~  356272 - 352530 = 3742 ms = 3.74 s
doing I/O:
~  106045 - 102525 = 3520 ms = 3.52 s
Looks correct.

Would somebody please enlighten me?

PS: from Documentation/iostats.txt:
Field  8 -- # of milliseconds spent writing
This is the total number of milliseconds spent by all writes (as
measured from __make_request() to end_that_request_last()).
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFACr5YkG/MMvcT1qQRAlbSAJ92pypJf/8unflGFdk1oZmwrTysZQCgoZS+
pCjP5LbPzUpRWSWcOtyU38E=
=E7/j
-----END PGP SIGNATURE-----

