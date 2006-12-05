Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936815AbWLEWhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936815AbWLEWhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 17:37:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936829AbWLEWhM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 17:37:12 -0500
Received: from quechua.inka.de ([193.197.184.2]:55594 "EHLO mail.inka.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936815AbWLEWhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 17:37:10 -0500
Date: Tue, 05 Dec 2006 23:32:08 +0100
From: Olaf Titz <Olaf.Titz@inka.de>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Neil Brown <neilb@suse.de>
CC: Olaf Titz <olaf@bigred.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19: OOPS in cat /proc/fs/nfs/exports
References: <E1GrJH9-0003Hr-00@bigred.inka.de> <17780.62607.544405.181452@cse.unsw.edu.au>
In-Reply-To: <17780.62607.544405.181452@cse.unsw.edu.au>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Message-ID: <E1Gripc-0004KC-00@bigred.inka.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> There is a place where a failed kstrdup could lead to this, but that
> is rather unlikely and wouldn't be as reproducible as this seems to
> be.
> If you boot up and then immediately shutdown does this error trigger,
> it does it have to be up for a while?

It happens right after booting.

I've since disabled the NFS server on that box, and just tried to
manually start it, and it gives me this:
# /usr/sbin/exportfs -r
bigred:/video/rec: Cannot allocate memory

That is the first and only export:

# cat /etc/exports
# /etc/exports: the access control list for filesystems which may be
exported
#               to NFS clients.  See exports(5).

/video/rec      bigred(rw,sync)

strace on exportfs shows this:nfsservctl(0x3, 0xbf875824, 0)          =
- -1 ENOMEM

After that, /proc/fs/nfs/export exists and gives the Oops, while
/proc/fs/nfsd/export doesn't exist.

I don't think however this box is particularly short on memory:

MemTotal:       248704 kB
MemFree:        102780 kB
Buffers:         20520 kB
Cached:          50692 kB
SwapCached:          0 kB
Active:          81712 kB
Inactive:        25160 kB
SwapTotal:           0 kB
SwapFree:            0 kB
Dirty:            1516 kB
Writeback:           0 kB
AnonPages:       35672 kB
Mapped:          13104 kB
Slab:             6960 kB
SReclaimable:     3104 kB
SUnreclaim:       3856 kB
PageTables:        692 kB
NFS_Unstable:        0 kB
Bounce:              0 kB
CommitLimit:    124352 kB
Committed_AS:   124528 kB
VmallocTotal:   786136 kB
VmallocUsed:      7568 kB
VmallocChunk:   778508 kB

(this is right after booting, DVB drivers loaded and VDR running.)

Will try your patch tomorrow.

Olaf

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFdfNoGPw4gdAdiZ0RAjDdAJ4yPltxWuJe21yB9nc2zBooLWJ2TwCaAg1I
tNsnDshD1gVpW/FYJ5P9J28=
=1zag
-----END PGP SIGNATURE-----
