Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261543AbVC3EcN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261543AbVC3EcN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 23:32:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVC3EcN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 23:32:13 -0500
Received: from sccrmhc12.comcast.net ([204.127.202.56]:57797 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S261543AbVC3EcH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 23:32:07 -0500
Message-ID: <424A2BD0.5010609@comcast.net>
Date: Tue, 29 Mar 2005 23:32:16 -0500
From: John Richard Moser <nigelenki@comcast.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050111)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Aligning file system data
X-Enigmail-Version: 0.90.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

How likely is it that I can actually align stuff to 31.5KiB on the
physical disk, i.e. have each block be a track?

Rather than leveraging the track cache, would it be less expensive for
me to simply read in blocks totaling about 16 or 32KiB all at once?


Let's say I have two situations...

A)
  My blocks are all 31.5KiB (512 bytes/sector * 63 sectors) and aligned
to tracks.  The track cache on the disk stores the entire block, so
repeted reads to the disk are 0mS seek.  I leverage this to read a
couple sectors at a time and seek as I care within the block while it's
cached, making several requests to the ATA device.

B)
  My blocks are all 32KiB and cross track boundaries.  All of them exist
in part in two separate tracks.  Upon reading a block, I request the
entire block and work with it in main memory.

Which situation has less overhead?

C)
  My blocks are all 31.5KiB and perfectly aligned within tracks.  I read
the entire block as in (B) and work with it in main memory.

How much more latency is involved in (B) than in (C)?  Does crossing a
track boundary incur anything expensive?


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

iD8DBQFCSivPhDd4aOud5P8RAszeAJ4wPonhpXas8IprMBUq8/NdM57aegCdEBva
24LXB3O+7GEE0XKxPBFr1L0=
=iTEm
-----END PGP SIGNATURE-----
