Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129340AbQLOWHk>; Fri, 15 Dec 2000 17:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbQLOWHb>; Fri, 15 Dec 2000 17:07:31 -0500
Received: from [63.109.193.245] ([63.109.193.245]:48379 "EHLO
	ninigret.metatel.office") by vger.kernel.org with ESMTP
	id <S129340AbQLOWHS>; Fri, 15 Dec 2000 17:07:18 -0500
Message-Id: <200012152137.QAA04624@ninigret.metatel.office>
From: Rafal Boni <rafal.boni@eDial.com>
To: linux-kernel@vger.kernel.org
Subject: 2.2.16 Q: unexpected page/buffer cache behaviour
X-Mailer: NMH 1.0 / EXMH 2.1.1
Date: Fri, 15 Dec 2000 16:37:09 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Content-Type: text/plain; charset=us-ascii

[...please CC me on replies, as I generally only read the list via the
 archives...]

I've asked the list before on a similar topic and haven't gotten any
replies, but it's happening again with a different kernel version and
I'm still stumped.

I have a couple of boxes that are doing network serving, but don't 
generally do a lot of disk I/O.  I'm worried that on these boxes,
my page + buffer caches take up ~ 95% of memory [*] (the boxes in 
question both have 2Gb, but are running a redhat-supplied 2.2.16-3 RPM, 
which means they only see 1Gb "normally" and the rest as BigMem).

[*] Due to use of BigMem, they actually take up 41% of physical memory,
but 95% of non-BigMem memory.

Currently, here's what /proc/meminfo says:
MemTotal:   2074428 kB
MemFree:    1178500 kB
MemShared:     5492 kB
Buffers:     287264 kB
Cached:      571040 kB
BigTotal:   1179644 kB
BigFree:    1166052 kB
SwapTotal:  1028120 kB
SwapFree:   1027284 kB

Note: of the 894784kB of non-BigMem memory, 858304kB is buffers + cache!

This all would be wonderful, but at times when the boxes need a surplus of
memory, they end up hanging for multiple seconds while buffers are flushed
to disk.  

Since I'm running an HA setup with the Linux-HA heartbeat package, the 
several-second pause causes the node to throw its' hands up as it has not
seen even its' own heartbeat in a few seconds (since the machine is effec-
tively locked up flushing stuff to disk).  Now the backup node tends to do
the same thing at about the same time, and our HA solution has just shut
down the service 8-<

However bad this is, the above is just a symptom of the seemingly unchecked
buffer/page cache growth.  SHould I just set a real high limit for freepages,
(which seems like a hack and will fail later on), or is there a better way
out of this rathole?  

Should linux be caching stuff that aggresively even in situations where disk
I/O is at a minimum (the size of the buffer + page caches holds probably 2/3
of the contents of the disk, so I'm astounded that it's gotten that big 8-).

Thanks for any ideas,
- --rafal

- ----
Rafal Boni                                               rafal.boni@eDial.com
 PGP key C7D3024C, print EA49 160D F5E4 C46A 9E91  524E 11E0 7133 C7D3 024C
    Need to get a hold of me?  http://800.eDial.com/rafal.boni@eDial.com

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.0 (GNU/Linux)
Comment: Exmh version 2.1.1 10/15/1999

iD8DBQE6Oo8FEeBxM8fTAkwRAvXmAKC8U4IYV657wRp596Ie6FydO29bTQCcDWEZ
+tLZfXUhQhTpwUM7/vODCcA=
=k1Zi
-----END PGP SIGNATURE-----

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
